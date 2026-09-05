# ══════════════════════════════════════════════════════════════════
# EKSPERIMEN 4 — Ekstensi: media sosial sebagai amplifier
# ══════════════════════════════════════════════════════════════════
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from epstein_model import EpsteinCivilViolence

OUT = os.path.join(os.path.dirname(__file__), '..', 'images')
os.makedirs(OUT, exist_ok=True)

STEPS, RUNS = 600, 5
L = 0.45  # zona abu-abu

def run_timeseries(medsos, seed):
    m = EpsteinCivilViolence(size=40, legitimacy=L, medsos=medsos,
                             medsos_strength=0.5, medsos_spike=0.02,
                             medsos_decay=0.02, seed=seed)
    h = m.run(STEPS)
    return np.array([x['active'] for x in h])

fig, ax = plt.subplots(figsize=(9, 5))
data = {}
for medsos, warna, label in [(False, '#2e7d32', 'Tanpa media sosial'),
                             (True,  '#e65100', 'Dengan media sosial')]:
    semua = np.vstack([run_timeseries(medsos, s) for s in range(RUNS)])
    mean, std = semua.mean(axis=0), semua.std(axis=0)
    data[label] = mean
    t = np.arange(STEPS)
    ax.plot(t, mean, color=warna, lw=2, label=label)
    ax.fill_between(t, mean - std, mean + std, color=warna, alpha=0.2)

ax.set_xlabel('waktu (step)')
ax.set_ylabel('jumlah warga yang berdemo')
ax.set_title('Efek Media Sosial di Zona Abu-abu (L=0,45)')
ax.legend()
ax.grid(alpha=0.3)
plt.tight_layout()
plt.savefig(f'{OUT}/exp4_medsos.png', dpi=150)
plt.close()

# ── bar chart: total hari-demonstran ──
total = {}
for medsos, nm in [(False, 'tanpa medsos'), (True, 'dengan medsos')]:
    vals = [run_timeseries(medsos, s).sum() for s in range(RUNS)]
    total[nm] = vals

fig, ax = plt.subplots(figsize=(6, 5))
labels = list(total.keys())
means = [np.mean(total[k]) for k in labels]
errs  = [np.std(total[k]) for k in labels]
bars = ax.bar(labels, means, yerr=errs, capsize=8,
              color=['#2e7d32', '#e65100'], alpha=0.85)
ax.set_ylabel('total "hari-demonstran" (600 step)')
ax.set_title('Total Aktivitas Demonstrasi — dengan vs tanpa Media Sosial')
for b, v in zip(bars, means):
    ax.text(b.get_x() + b.get_width()/2, v*1.02, f'{v:,.0f}',
            ha='center', fontweight='bold')
ax.grid(axis='y', alpha=0.3)
plt.tight_layout()
plt.savefig(f'{OUT}/exp4_bar.png', dpi=150)
plt.close()

print('OK — exp4 selesai')
