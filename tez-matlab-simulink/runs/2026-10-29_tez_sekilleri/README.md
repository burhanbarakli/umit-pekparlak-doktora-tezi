# 2026-10-29 · Tez şekilleri için kalibre S1–S3 yeniden koşusu

## Amaç

Kalibrasyon koşuları yalnız v_inv, v_ac ve i_ac dalga biçimlerini saklamıştı. Tezdeki düşük
çözünürlüklü L1 akımı ve kapı darbesi ekranlarının yerine vektör şekil üretmek için kalibre S1,
S2 ve S3 modelleri aynı K-20 değerleriyle yeniden koşturuldu; L1 akımı ve kapı işaretleri de
kaydedildi. Model ve parametre değişmedi.

- İş paketi: İP-11
- İlgili kayıtlar: K-20 (kalibre çalışma noktaları), K-25 (şekil çözünürlüğü); D-04
- Review notu: [2026-10-29_TEZ_SEKILLERI.md](../../review/2026-10-29_TEZ_SEKILLERI.md)
- Kayıt defterleri: [01_KARAR_DEFTERI.md](../../../tez-tamamlama/01_KARAR_DEFTERI.md),
  [02_MODEL_DUZELTME_KAYDI.md](../../../tez-tamamlama/02_MODEL_DUZELTME_KAYDI.md)

## Senaryolar ve modeller

Model kaynağı `runs/2026-10-28_parametre_tablosu/model/tez/` (kalibrasyon klasöründeki kalibre
modellerle bayt bayt aynı). Her senaryo ayrı klasörde koşar; paralel koşu güvenlidir.

| Klasör / model | Senaryo | Pakete göre değişiklik |
|---|---|---|
| `model_s1/inverter_s1_kal.slx` | S1 (tamamlayıcı anahtarlama) | D-01, D-03, D-08, D-09, D-12 (S2 devresi yorum satırında) |
| `model_s2/inverter_s2_kal.slx` | S2 (nötr susturma, K3 = 0) | D-01, D-03, D-08, D-09, D-12 (S1 devresi yorum satırında) |
| `model_s3/inverter_senaryo3_kal.slx` | S3 (susturma + Sin³ ileri besleme) | D-03, D-08, D-09 |
| `model_s*/<model>_kalibrasyon.m` | K-20 değerleri | `2026-10-28_kalibrasyon` son koşularının (s1_k4, s2_k4, s3_k6) dosyaları |
| `model_s*/inverter_common_parameters.m` | Ortak parametre dosyası | Yok (paketle aynı) |

## Parametreler

| Büyüklük | S1 | S2 | S3 |
|---|---|---|---|
| Vdc [V] | 431,5 | 395,0 | 427,5 |
| Şebeke Vac RMS [V] | 119,8 | 121,0 | 124,3 |
| K1x (kalibre; m-dosyası) | `K11` = 0,7865023595 (0,7865) | `K12` = 0,7679568 (0,794) | `K13` = 0,44343 (0,45) |
| K3x (kalibre; m-dosyası) | — | — (K3 = 0) | `K33` = 0,384306 (0,39) |
| Referans fazı [°] (kalibre; m-dosyası) | −0,36607 (−0,44) | +0,1121 (0) | +0,6575 (0) |
| L1 / L1r | 600 µH / 0,03 Ω | aynı | aynı |
| L1 çekirdek Rp | 600 Ω | aynı | aynı |
| Cf / Cr | 8 µF / 0,01 Ω | aynı | aynı |
| L2 / L2r | 1000 µH / 0,01 Ω | aynı | aynı |
| EMC X kapasitörü | 0,5 µF / 0,2 Ω (D-09) | aynı | aynı |
| fsw / ölü zaman | 10 kHz / 1 µs | aynı | aynı |
| DC bara | 2 × 470 µF | aynı | aynı |
| Çözücü / StopTime | ode15s, MaxStep 1 µs / 0,1 s | aynı | aynı |

Yeniden üretim denetimi: η ve THD son değerleri kalibrasyon koşularıyla 6 basamak aynıdır
(S1 η 0,911510; S2 0,939322; S3 0,942544).

## Nasıl çalıştırılır

Komutlar proje kökünden (`tez-matlab-simulink/`) verilir; üç süreç ayrı klasörlerde paralel koşabilir.

```powershell
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_tez_sekilleri_20261029('s1')"
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_tez_sekilleri_20261029('s2')"
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_tez_sekilleri_20261029('s3')"
```

Şekillerin üretimi (benzetim koşturmaz, `results/<s>/sekil_kayit.mat` dosyalarını okur; çıktı
`tez-latex-v2/figures/model_dogrulama/`):

```powershell
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "run('../tez-latex-v2/figures/model_dogrulama/uret_l1_kapi_sekilleri.m')"
```

Ön koşullar ve süreler:

- Kaynak modeller `2026-10-28_parametre_tablosu/model/tez/` altında bulunmalıdır.
- Parametre dosyası `load_system`'dan önce taban çalışma alanında çalıştırılır; modellerde
  PreLoadFcn de vardır (D-03).
- Accelerator, 0,1 s: S1 2342 s, S2 1954 s, S3 2039 s (~33–39 dk).
- Aynı model klasöründe eşzamanlı Accelerator derlemesi yapma.

## Çıktılar

| Dosya | İçerik |
|---|---|
| `results/<s>/sinyal_listesi.csv` | Kaydedilen sinyaller: alan adı, kaynak blok, kanal, örnek sayısı, tepe değer |
| `results/<s>/kosu_bilgisi.txt` | Model, başlangıç/bitiş, mod, duvar süresi, PS kayıt sayısı |
| `logs/<s>.log` | Konsol çıktıları |

Üretilen tez şekilleri (`tez-latex-v2/figures/model_dogrulama/`): `s1_kapi_isaretleri.pdf`,
`s1_s2_kalibre_l1.pdf`, `s3_kalibre_l1.pdf` ve `l1_metrikleri.csv`.

`.gitignore` gereği `results/<s>/sekil_kayit.mat` (t ≥ 0,075 s kaydı), `slprj/`, `*.slxc` ve
`*_acc.*` artıkları depoya girmez; koşu betiği yeniden çalıştırılarak üretilir. `model_s*/`
altındaki `.slx` ve `.m` dosyaları depoda tutulur.

## Uyarı

- Kalibre benzetim deneyin özet tablosunu belirtilen hatayla yeniden üretir; şekillerdeki dalga
  biçimleri benzetimdir, osiloskop kaydı yerine geçmez.
- L1 akımı S1 ve S3'te `PS-Simulink Converter3`, S2'de `PS-Simulink Converter5` çıkışından alınır.
  S1 modelinde kapı mantık kaydı yoktur; kapı sürücüsü çıkışları S2'deki eşlemeyle aynı sırada
  kullanılır (review notu, "İşaret eşlemesi").
