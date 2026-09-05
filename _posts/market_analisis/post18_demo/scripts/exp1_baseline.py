# ══════════════════════════════════════════════════════════════════
# EKSPERIMEN 1 — Baseline: legitimasi tinggi vs legitimasi rendah
# ══════════════════════════════════════════════════════════════════
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from epstein_model import EpsteinCivilViolence

OUT = os.path.join(os.path.dirname(__file__), '..', 'images')
os.makedirs(OUT, exist_ok=True)

STEPS = 600

def run_timeseries(legitimacy, seed):
    m = EpsteinCivilViolence(size=40, legitimacy=legitimacy,
                             medsos=False, seed=seed)
    h = m.run(STEPS)
    return np.array([x['active'] for x in h])

# ── time series: 3 run per skenario, dengan smoothing ──
fig, ax = plt.subplots(figsize=(9, 4.5))
for L, warna, label in [(0.82, '#2e7d32', 'Legitimasi tinggi (0.82)'),
                        (0.20, '#c62828', 'Legitimasi rendah (0.20)')]:
    semua = np.vstack([run_timeseries(L, s) for s in range(3)])
    mean = semua.mean(axis=0)
    std  = semua.std(axis=0)
    t = np.arange(STEPS)
    ax.plot(t, mean, color=warna, lw=2, label=label)
    ax.fill_between(t, mean - std, mean + std, color=warna, alpha=0.2)

ax.set_xlabel('waktu (step)')
ax.set_ylabel('jumlah warga yang berdemo')
ax.set_title('Jumlah Demonstran Aktif — Legitimasi Tinggi vs Rendah')
ax.legend()
ax.grid(alpha=0.3)
plt.tight_layout()
plt.savefig(f'{OUT}/exp1_timeseries.png', dpi=150)
plt.close()

# ── snapshot akhir (t=600): legitimasi rendah ──
m = EpsteinCivilViolence(size=40, legitimacy=0.20, medsos=False, seed=7)
for _ in range(STEPS):
    m.step()
img = m.snapshot()
fig, ax = plt.subplots(figsize=(5.5, 5.5))
ax.imshow(img)
ax.set_title('Snapshot t=600 — Legitimasi rendah (0.20)\nmerah: demo, biru: polisi, hitam: tahanan')
ax.axis('off')
plt.tight_layout()
plt.savefig(f'{OUT}/exp1_snapshot.png', dpi=150)
plt.close()

# ── GIF animasi 1 frame per 10 step ──
m = EpsteinCivilViolence(size=40, legitimacy=0.20, medsos=False, seed=7)
frames = []
for t in range(STEPS):
    m.step()
    if t % 10 == 0 or t == STEPS - 1:
        frames.append(m.snapshot())

fig, ax = plt.subplots(figsize=(5, 5))
im = ax.imshow(frames[0])
ax.set_title('Simulasi kerusuhan — legitimasi rendah')
ax.axis('off')

def update(i):
    im.set_array(frames[i])
    return [im]

anim = FuncAnimation(fig, update, frames=len(frames), interval=120)
anim.save(f'{OUT}/exp1_animasi.gif', writer='pillow', dpi=100)
plt.close()

print('OK — exp1 selesai')
