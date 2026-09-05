# ══════════════════════════════════════════════════════════════════
# EKSPERIMEN 2 — Phase diagram: pengaruh legitimasi
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
L_grid = np.round(np.linspace(0.05, 0.95, 19), 2)

def total_rebel_days(legitimacy):
    hasil = []
    for s in range(RUNS):
        m = EpsteinCivilViolence(size=40, legitimacy=legitimacy,
                                 medsos=False, seed=s)
        h = m.run(STEPS)
        hasil.append(sum(x['active'] for x in h))
    return np.array(hasil)

rata, std = [], []
for L in L_grid:
    v = total_rebel_days(L)
    rata.append(v.mean()); std.append(v.std())
rata = np.array(rata); std = np.array(std)

fig, ax = plt.subplots(figsize=(9, 5))
ax.plot(L_grid, rata, 'o-', color='#c62828', lw=2, ms=6)
ax.fill_between(L_grid, rata - std, rata + std, color='#c62828', alpha=0.15)

# zona abu-abu: daerah transisi
ax.axvspan(0.42, 0.50, color='gray', alpha=0.15)
ax.annotate('zona abu-abu\n(sensitif terhadap guncangan kecil)',
            xy=(0.46, rata.max()*0.55), fontsize=9, ha='center',
            color='dimgray')

ax.set_xlabel('legitimasi pemerintah (L)')
ax.set_ylabel('total "hari-demonstran" (600 step)')
ax.set_title('Phase Diagram: Legitimasi vs Total Aktivitas Demonstrasi')
ax.grid(alpha=0.3)
plt.tight_layout()
plt.savefig(f'{OUT}/exp2_phase_diagram.png', dpi=150)
plt.close()

print('OK — exp2 selesai')
