"""Osiloskop ekran görüntülerindeki faz akımı izini (kanal 4) sayısallaştırıp THD hesaplar.

Girdi: tez-latex/figures/deneysel altındaki üç PNG (800x480).
Yalnız Pillow gerekir. Proje kökünden: python tez-matlab-simulink/runs/2026-11-01_osiloskop_thd/osiloskop_thd.py
"""
import cmath
import csv
import math
import os
import sys

from PIL import Image

sys.stdout.reconfigure(encoding="utf-8")
BURASI = os.path.dirname(os.path.abspath(__file__))
KOK = os.path.dirname(os.path.dirname(os.path.dirname(BURASI)))
SEKIL = os.path.join(KOK, "tez-latex", "figures", "deneysel")
GIRDI = [
    ("S1", "onceki_tez_sekil_5_18_klasik_faz.png"),
    ("S2", "onceki_tez_sekil_5_21_susturma_faz.png"),
    ("S3", "onceki_tez_sekil_5_24_sin3_faz.png"),
]
X0, X1 = 24, 760        # ızgara sütunları; sağdaki kanal işareti dışarıda
Y0, Y1 = 205, 288       # kanal 4 bandı; bandın altındaki yeşil işaretler dışarıda
PERIYOT_PX = 150        # 10 ms/bölme, 75 piksel/bölme: 20 ms = 150 piksel
H_UST = 25              # 150 piksel/periyotta anlamlı üst harmonik


def yesil(p):
    return p[1] > p[0] + 40 and p[1] > p[2] + 40 and p[1] > 80


def iz(dosya):
    px = Image.open(dosya).convert("RGB").load()
    nokta = {}
    for x in range(X0, X1):
        ys = sorted(y for y in range(Y0, Y1) if yesil(px[x, y]))
        if ys:
            nokta[x] = ys[len(ys) // 2]
    xs = sorted(nokta)
    y = []
    for x in range(xs[0], xs[-1] + 1):
        if x in nokta:
            y.append(float(nokta[x]))
        else:
            a = max(k for k in xs if k < x)
            b = min(k for k in xs if k > x)
            y.append(nokta[a] + (nokta[b] - nokta[a]) * (x - a) / (b - a))
    # dokuz noktalı medyan: ızgara ve imleç lekelerini temizler
    return [sorted(y[max(0, i - 4):i + 5])[len(y[max(0, i - 4):i + 5]) // 2] for i in range(len(y))]


def harmonikler(seg, k):
    L = len(seg)
    ort = sum(seg) / L
    seg = [v - ort for v in seg]
    return [0.0] + [abs(sum(seg[i] * cmath.exp(-2j * math.pi * h * k * i / L) for i in range(L)) * 2 / L)
                    for h in range(1, H_UST + 1)]


def analiz(y, k):
    L = PERIYOT_PX * k
    sonuc = []
    for s in range(0, len(y) - L + 1, 5):
        H = harmonikler(y[s:s + L], k)
        sonuc.append((100 * math.sqrt(sum(a * a for a in H[2:])) / H[1],
                      100 * H[3] / H[1], 100 * H[5] / H[1], 100 * H[7] / H[1]))
    n = len(sonuc)
    return {
        "THD_ort": sum(r[0] for r in sonuc) / n, "THD_min": min(r[0] for r in sonuc),
        "THD_max": max(r[0] for r in sonuc), "h3": sum(r[1] for r in sonuc) / n,
        "h5": sum(r[2] for r in sonuc) / n, "h7": sum(r[3] for r in sonuc) / n, "pencere": n,
    }


with open(os.path.join(BURASI, "osiloskop_thd.csv"), "w", newline="", encoding="utf-8") as f:
    w = csv.writer(f)
    w.writerow(["senaryo", "periyot", "THD_ort", "THD_min", "THD_max", "h3", "h5", "h7", "pencere"])
    for ad, dosya in GIRDI:
        y = [-v for v in iz(os.path.join(SEKIL, dosya))]
        for k in (2, 3, 4):
            r = analiz(y, k)
            w.writerow([ad, k] + [round(r[a], 2) for a in ("THD_ort", "THD_min", "THD_max", "h3", "h5", "h7")] + [r["pencere"]])
            print(ad, k, {a: round(b, 1) for a, b in r.items()})
