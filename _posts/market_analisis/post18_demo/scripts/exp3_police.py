# ══════════════════════════════════════════════════════════════════
# EKSPERIMEN 3 — Apakah menambah polisi menyelesaikan masalah?
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
L_TETAP = 0.45
cop_grid = [0.01, 0.03, 0.05, 0.08, 0.10, 0.15, 0.20]

def total_rebel_days(cop_density, legitimacy=L_TETAP):
    hasil = []
    for s in range(RUNS):
        m = EpsteinCivilViolence(size=40, legitimacy=legitimacy,
                                 cop_density=cop_density,
                                 medsos=False, seed=s)
        h = m.run(STEPS)
        hasil.append(sum(x['active'] for x in h))
    return np.array(hasil)

rata, std = [], []
for c in cop_grid:
    v = total_rebel_days(c)
    rata.append(v.mean()); std.append(v.std())
rata = np.array(rata); std = np.array(std)

fig, ax = plt.subplots(figsize=(9, 5))
ax.plot(cop_grid, rata, 'o-', color='#1565c0', lw=2, ms=6)
ax.fill_between(cop_grid, rata - std, rata + std, color='#1565c0', alpha=0.15)

# pembanding: menaikkan legitimasi 0.45 -> 0.55 (tanpa polisi tambahan)
v_legit = []
for s in range(RUNS):
    m = EpsteinCivilViolence(size=40, legitimacy=0.55, cop_density=0.04,
                             medsos=False, seed=s)
    h = m.run(STEPS)
    v_legit.append(sum(x['active'] for x in h))
garis_legit = np.mean(v_legit)

ax.axhline(garis_legit, color='#2e7d32', ls='--', lw=2,
           label='Menaikkan L 0,45 → 0,55 (tanpa polisi tambahan)')
ax.set_xlabel('kepadatan polisi (fraksi populasi)')
ax.set_ylabel('total "hari-demonstran" (600 step)')
ax.set_title('Menambah Polisi di Tengah Legitimasi Rendah (L=0,45)')
ax.legend()
ax.grid(alpha=0.3)
plt.tight_layout()
plt.savefig(f'{OUT}/exp3_polisi.png', dpi=150)
plt.close()

print('OK — exp3 selesai')
