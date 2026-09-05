# ══════════════════════════════════════════════════════════════════
# AGENT-BASED MODEL — Civil Violence (Epstein, PNAS 2002)
# Replikasi sederhana + ekstensi media sosial
# ══════════════════════════════════════════════════════════════════
# 3 entitas: warga, polisi, penjara
# Setiap warga punya: grievance (G), risk aversion (R), dan merasakan
# legitimacy rezim (L, global).
# Aturan aktivasi (satu baris "psikologi"):
#   warga ikut demo jika  hardship - net_risk > threshold
#   hardship = G * (1 - L)
#   net_risk = R * P(arrest)
#   P(arrest) = 1 - exp(-k * cops_lokal / (rebels_lokal + 1))
#
# Ekstensi media sosial:
#   penangkapan bisa "viral" -> grievance warga naik sementara
#   lalu grievance meluruh (decay) kembali ke baseline.

import numpy as np

class EpsteinCivilViolence:
    def __init__(self, size=40,
                 citizen_density=0.70, cop_density=0.04,
                 legitimacy=0.82,
                 grievance_mean=0.10, risk_aversion=0.10,
                 k=2.3, threshold=0.10,
                 jail_time=30, active_lifetime=(10, 40),
                 medsos=False, medsos_strength=0.30,
                 medsos_spike=0.02, medsos_decay=0.02,
                 seed=None):
        rng = np.random.default_rng(seed)

        self.size = size
        self.legitimacy = legitimacy
        self.k = k
        self.threshold = threshold
        self.jail_time = jail_time
        self.active_lifetime = active_lifetime
        self.medsos = medsos
        self.medsos_strength = medsos_strength
        self.medsos_spike = medsos_spike
        self.medsos_decay = medsos_decay
        self.grievance_base = grievance_mean

        N = size * size
        n_citizen = int(N * citizen_density)
        n_cop     = int(N * cop_density)

        # grid status
        self.citizen = np.zeros((size, size), dtype=bool)
        self.cop     = np.zeros((size, size), dtype=bool)
        self.active  = np.zeros((size, size), dtype=bool)
        self.jail    = np.zeros((size, size), dtype=int)

        # atribut per warga
        self.grievance = np.zeros((size, size), dtype=float)
        self.risk      = np.zeros((size, size), dtype=float)
        self.active_left = np.zeros((size, size), dtype=int)

        # tempatkan entitas secara acak
        flat = rng.permutation(N)
        idx_citizen = flat[:n_citizen]
        idx_cop     = flat[n_citizen:n_citizen + n_cop]
        for idx in idx_citizen:
            r, c = divmod(idx, size)
            self.citizen[r, c] = True
            # grievance mayoritas warga kecil, 5% warga "sangat kecewa"
            g = rng.uniform(0, 1) * grievance_mean * 2
            if rng.random() < 0.05:
                g += rng.uniform(0, grievance_mean * 2)
            self.grievance[r, c] = min(0.5, g)
            self.risk[r, c] = rng.uniform(0, 1) * risk_aversion * 2
        for idx in idx_cop:
            r, c = divmod(idx, size)
            self.cop[r, c] = True

    # ── jumlah tetangga (8 arah) dengan zero-padding (batas kota) ──
    def _neighbor_sum(self, A):
        Ap = np.pad(A, 1)
        s = np.zeros_like(A)
        s += Ap[:-2, :-2] + Ap[:-2, 1:-1] + Ap[:-2, 2:]
        s += Ap[1:-1, :-2] + Ap[1:-1, 2:]
        s += Ap[2:, :-2] + Ap[2:, 1:-1] + Ap[2:, 2:]
        return s

    def step(self):
        rng = np.random.default_rng()
        size = self.size

        # 1. bebas dari penjara
        self.jail = np.maximum(0, self.jail - 1)
        baru_bebas = (self.jail == 0)
        # reset atribut warga yang baru bebas (dihitung ulang di bawah)

        # 2. hitung variabel lokal
        rebels_local = self._neighbor_sum(self.active.astype(float))
        cops_local   = self._neighbor_sum(self.cop.astype(float))

        # 3. perceived risk of arrest
        with np.errstate(divide='ignore', invalid='ignore'):
            ratio = cops_local / (rebels_local + 1.0)
            p_arrest = 1.0 - np.exp(-self.k * ratio)

        # 4. keputusan warga (yang tidak di penjara)
        hardship = self.grievance * (1.0 - self.legitimacy)
        net_risk = self.risk * p_arrest
        keputusan = (hardship - net_risk) > self.threshold

        eligible = self.citizen & (self.jail == 0)

        # aktivasi baru
        jadi_rebel = eligible & keputusan & ~self.active
        self.active[jadi_rebel] = True
        lo, hi = self.active_lifetime
        self.active_left[jadi_rebel] = rng.integers(lo, hi + 1,
                                                    size=jadi_rebel.sum())

        # rebel yang "kelelahan" (masa aktif habis) berhenti
        self.active_left = np.maximum(0, self.active_left - 1)
        berhenti = self.active & (self.active_left == 0)
        self.active[berhenti] = False

        # 5. polisi menangkap rebel di sekitarnya
        #    probabilitas tertangkap ~ p_arrest di lokasi rebel
        target = self.active & eligible
        tertangkap = target & (rng.random((size, size)) < p_arrest)
        self.active[tertangkap] = False
        self.jail[tertangkap] = self.jail_time
        n_arrest = int(tertangkap.sum())

        # 6. ekstensi media sosial: penangkapan bisa "viral"
        if self.medsos and n_arrest > 0:
            if rng.random() < self.medsos_strength:
                # informasi penangkapan menyebar -> grievance naik
                self.grievance = np.minimum(0.5,
                    self.grievance + self.medsos_spike)
            # grievance meluruh perlahan menuju baseline
            self.grievance = self.grievance + \
                (self.grievance_base - self.grievance) * self.medsos_decay

        return dict(active=int(self.active.sum()),
                    arrested=n_arrest,
                    jailed=int((self.jail > 0).sum()))

    def run(self, steps, record_every=1):
        history = []
        for t in range(steps):
            info = self.step()
            if record_every == 1 or t % record_every == 0:
                info['t'] = t
                history.append(info)
        return history

    def snapshot(self):
        # warna: citizen=abu, rebel=merah, cop=biru, jailed=hitam
        img = np.zeros((self.size, self.size, 3))
        img[self.citizen & ~self.active & (self.jail == 0)] = (0.75, 0.75, 0.75)
        img[self.active] = (0.85, 0.15, 0.10)
        img[self.cop] = (0.10, 0.30, 0.85)
        img[self.jail > 0] = (0.10, 0.10, 0.10)
        return img
