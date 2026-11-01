# 2026-11-01 · Osilogramlardan faz akımı THD'si

İlk tezin Şekil 5.18, 5.21 ve 5.24 osilogramlarındaki faz akımı izi (kanal 4) sayısallaştırılıp
25. harmoniğe kadar THD hesaplandı. MATLAB koşusu yoktur; yalnız Python ve Pillow gerekir.

Proje kökünden:

```bash
python tez-matlab-simulink/runs/2026-11-01_osiloskop_thd/osiloskop_thd.py
```

Çıktı: `osiloskop_thd.csv`. Sonuçlar S1 yaklaşık %21, S2 yaklaşık %47, S3 yaklaşık %12.

- Karar: K-29
- Review notu: [2026-11-01_S1_THD_TEZ_SAHIBI_DEGERLENDIRMESI.md](../../review/2026-11-01_S1_THD_TEZ_SAHIBI_DEGERLENDIRMESI.md)
