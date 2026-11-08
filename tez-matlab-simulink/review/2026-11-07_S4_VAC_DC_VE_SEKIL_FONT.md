# S4 Şekil 5.5 v_ac "DC kayması" incelemesi ve Bölüm 5 şekil yazı tipi onarımı (07.11.2026)

Tetikleyen: tez sahibinin 07.11.2026 okuma notları, madde 20 ve 25
(`tez-tamamlama/06_UMIT_OKUMA_NOTLARI_2026-11-07.md`). Yeni benzetim koşturulmadı.

## Madde 20: yeşil eğri (v_ac) negatif DC içeriyor mu?

Betik: `scripts/analiz_s4_vac_dc_20261107.m`. Çıktı: `runs/2026-10-28_s4_kapali_cevrim/inceleme_vac_dc_20261107.csv`.
Pencere: şekildeki son iki tam şebeke periyodu.

| Durum | v_ac ortalaması [V] | 100 µs ortalamalı tepe +/− [V] | v_ac,1 tepe [V] |
|---|---|---|---|
| KC_P_25A | +0,010 / −0,025 | 173,3 / −173,4 | 170,9 |
| KC_PI_25A | +0,009 / −0,008 | 172,6 / −172,3 | 171,3 |
| KC_PIR_25A_02s | +0,006 / +0,003 | 170,7 / −170,4 | 170,5 |

- Ölçüm: `AC Voltage Sensor1`, L2'nin evirici ucu (C noktası) ile şebeke nötrü arası; nötr DA bara orta noktasına bağlı.
- Sonuç: gerçek DA bileşen yok (|ortalama| < 0,03 V). Görünen kayma, PI ve PIR panellerinde sol eksenin [−60, 40] A, sağ eksenin ±200 V seçilmesiyle eksen sıfırlarının hizasız olmasından geliyordu.
- Yan bulgu: P denetleyicide i_L1 ve i_ac periyot ortalaması yaklaşık −0,46 A (integral terimi yok); PI/PIR'de < 0,02 A.
- Tezde: Şekil 5.5 sıfırları hizalı sürümle değiştirildi (`tez-latex-v2/figures/s4/s4_akim_izleme_25A_KC.pdf`); altyazıya C noktası gerilimi, eksen hizası ve ortalama değer yazıldı.

## Madde 25: Türkçe karakter bozulması

- Şekil 5.5 ve 5.8–5.13 Helvetica ile aktarılmıştı ("ş, ı, ğ" → "#"). Betik `scripts/yeniden_ciz_bolum5_turkce_font_20261107.m` kayıtlı verilerden Arial ile yeniden çizdi.
- CSV'ler yedekle bayt düzeyinde aynı; eğri ve eksenler değişmedi.
- Yedekler: `runs/2026-10-28_kararlilik/_yedek_2026-11-07/`, `runs/2026-10-28_s4_kapali_cevrim/sekiller/_yedek_2026-11-07/`.
- Tez derlemesi 07.11.2026: 216 sayfa (notsuz), tanımsız referans ve taşma yok.
