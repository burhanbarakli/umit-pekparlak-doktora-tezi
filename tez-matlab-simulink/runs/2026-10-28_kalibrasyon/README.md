# 2026-10-28 · S1–S3 ortak parametre kalibrasyonu

## Amaç

D-01 + D-03 + D-08 uygulanmış taban modellere D-09 eklendi; her senaryoda yalnız iki serbest
değişken (modülasyon genlik ölçeği `s` ve referans fazı `φ`) deney özet tablosunun P_ac (±%1)
ve |Q₁| (cosφ okuma bandı) değerlerine ayarlandı. Devre parametreleri değişmedi. I_ac, verim,
THD, P_dc ve cosφ₁ kalibre edilmedi; bağımsız doğrulama ölçütüdür.

- İş paketi: İP-4
- İlgili kayıtlar: D-09 (uygulandı ve ölçüldü), D-12 (S1+S2 modelinin ayrık kopyalarla koşturulması),
  D-01, D-03, D-04, D-08; K-01, K-02a, K-02b, K-17, K-20 (kalibre çalışma noktaları)
- Review notu: [2026-10-28_KALIBRASYON_S1_S3.md](../../review/2026-10-28_KALIBRASYON_S1_S3.md)
- Kayıt defterleri: [01_KARAR_DEFTERI.md](../../../tez-tamamlama/01_KARAR_DEFTERI.md),
  [02_MODEL_DUZELTME_KAYDI.md](../../../tez-tamamlama/02_MODEL_DUZELTME_KAYDI.md)

## Senaryolar ve modeller

Taban modeller: `runs/2026-10-27_diyot_esleme/model/inverter_senaryo3_d08.slx` ve
`inverter_s1s2_s2onarim_d08.slx`.

| Klasör / model | Senaryo | Tabana göre değişiklik |
|---|---|---|
| `model_s1/inverter_s1_kal.slx` | S1 (tamamlayıcı) | D-12: S2 devresinin bağlantı bileşeni `Commented = 'on'` (132 blok, silinmedi); D-09; InitFcn kalibrasyon kancası |
| `model_s1/inverter_s1_esd.slx` | S1 | Aynı ayırma, D-09'suz (birleşik modelle eşdeğerlik denetimi) |
| `model_s2/inverter_s2_kal.slx` | S2 (nötr susturma, K3 = 0) | D-12: S1 devresi yorum satırında (128 blok); D-09; kalibrasyon kancası |
| `model_s2/inverter_s2_esd.slx` | S2 | Aynı ayırma, D-09'suz |
| `model_s3/inverter_senaryo3_kal.slx` | S3 (susturma + Sin³ ileri besleme) | D-09; kalibrasyon kancası |
| `model_s*/inverter_common_parameters.m` | Ortak parametre dosyası | Yok (paketle aynı) |
| `model_s*/<model>_kalibrasyon.m` | Senaryoya özgü K1x/K33/faz | Her `run` eylemi yeniden yazar |

D-09: `Capacitor6`/`Capacitor7` `c = EMC_Cx_eq`, `r = EMC_Rx_eq`. Kalibrasyon kancası: InitFcn,
parametre dosyasından sonra model klasöründeki `<model>_kalibrasyon.m` dosyasını çalıştırır;
m-dosyası değişmez. Kalibre modellerin (`*_kal`) aynı kopyaları `2026-10-28_parametre_tablosu/model/tez/`
ve `2026-10-29_tez_sekilleri/model_s*/` altında da bulunur.

## Parametreler

Serbest değişkenler, kalibrasyon öncesi (m-dosyası) ve sonrası (`<model>_kalibrasyon.m`):

| Senaryo | Değişken | Öncesi | Sonrası | Genlik ölçeği s | Koşu (önce → sonra) |
|---|---|---|---|---|---|
| S1 | `K11` | 0,7865 | 0,7865023595 | 1,000003 | s1_esd → s1_k4 |
| S1 | `phase_deg1` [°] | −0,44 | −0,36607 | | |
| S2 | `K12` | 0,794 | 0,7679568 | 0,9672 | s2_esd → s2_k4 |
| S2 | `phase_deg2` [°] | 0 | +0,1121 | | |
| S3 | `K13` | 0,45 | 0,44343 | 0,9854 | s3_k0 → s3_k6 |
| S3 | `K33` | 0,39 | 0,384306 | (K33/K13 sabit) | |
| S3 | `phase_deg3` [°] | 0 | +0,6575 | | |

Sabit kalan devre parametreleri (`inverter_common_parameters.m`):

| Büyüklük | S1 | S2 | S3 |
|---|---|---|---|
| Vdc [V] | 431,5 | 395,0 | 427,5 |
| Şebeke Vac RMS [V] | 119,8 | 121,0 | 124,3 |
| L1 / L1r | 600 µH / 0,03 Ω | aynı | aynı |
| L1 çekirdek Rp | 600 Ω | 600 Ω | 600 Ω |
| Cf / Cr | 8 µF / 0,01 Ω | aynı | aynı |
| L2 / L2r | 1000 µH / 0,01 Ω | aynı | aynı |
| EMC X kapasitörü (`*_kal`) | 0,5 µF / 0,2 Ω (D-09) | aynı | aynı |
| EMC X kapasitörü (`*_esd`) | 1 µF / 0,01 Ω | 1 µF / 0,01 Ω | — |
| fsw / ölü zaman | 10 kHz / 1 µs | aynı | aynı |
| DC bara | 2 × 470 µF | aynı | aynı |
| Diyot eşlemesi | D-08 sonrası (D1–D2 `D12_*`, DS3–DS4 `DS34_*`) | aynı | aynı |

Kalibrasyon öncesi ve sonrası başlıca metrikler (`kalibrasyon_tablosu.csv`, Display son değeri):

| Büyüklük | S1 öncesi | S1 sonrası | S2 öncesi | S2 sonrası | S3 öncesi | S3 sonrası |
|---|---|---|---|---|---|---|
| P_ac [W] (hedef 249,6 / 253,2 / 281,2) | 258,49 | 247,21 | 269,60 | 253,80 | 299,40 | 279,90 |
| \|Q₁\| [var] | 33,19 | 1,93 | 27,66 | 24,43 | 30,39 | 21,41 |
| I_ac RMS [A] | 2,3168 | 2,2183 | 2,5681 | 2,4162 | 2,4335 | 2,2786 |
| η [%] | 91,49 | 91,15 | 94,07 | 93,93 | 94,38 | 94,25 |
| THD_I [%] | 36,93 | 39,51 | 56,72 | 56,72 | 10,92 | 14,78 |
| P_dc [W] | 282,53 | 271,21 | 286,59 | 270,19 | 317,23 | 296,97 |

## Nasıl çalıştırılır

Komutlar proje kökünden (`tez-matlab-simulink/`) verilir; her MATLAB süreci tek eylem yürütür.

```powershell
# 1) Model kopyaları, ayırma (D-12), D-09 ve kalibrasyon kancası (inspection/hazirlik.txt)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); calibrate_s1s3_20261028('prepare')"

# 2) Kalibre noktaların koşuları: run, case_id, etiket, s, faz [°]
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); calibrate_s1s3_20261028('run', 's1', 's1_k4', 1.000003, -0.36607)"
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); calibrate_s1s3_20261028('run', 's2', 's2_k4', 0.9672, 0.1121)"
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); calibrate_s1s3_20261028('run', 's3', 's3_k6', 0.9854, 0.6575)"

# 3) Kalibrasyonsuz baz koşular
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); calibrate_s1s3_20261028('run', 's1_esd', 's1_esd', 1, -0.44)"
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); calibrate_s1s3_20261028('run', 's2_esd', 's2_esd', 1, 0)"
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); calibrate_s1s3_20261028('run', 's3', 's3_k0', 1, 0)"

# 4) Süreksiz iletim oranı ve özet tablo
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); calibrate_s1s3_20261028('dcm', {'s1_esd','s1_k4','s2_esd','s2_k4','s3_k0','s3_k6'})"
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); calibrate_s1s3_20261028('table')"
```

Ara koşuların (s1_k1…k3, s2_k1…k3, s3_k1…k5) `s` ve faz değerleri her
`results/<koşu>/kosu_bilgisi.txt` dosyasındadır. Bir sonraki adım önerisi `predict`,
`predict_emp` (ampirik Jacobian) ya da `predict_th` (Thevenin köprü modeli) eylemleriyle
hesaplanır; çağrı biçimi betiğin başındaki açıklamadadır.

Ön koşullar ve süreler:

- `prepare` taban modelleri `2026-10-27_diyot_esleme/model/` klasöründen okur.
- Parametre dosyası `load_system`'dan önce taban çalışma alanında çalıştırılır; kalibre
  modellerde PreLoadFcn de vardır (D-03, `inspection/hazirlik.txt`).
- Koşular Accelerator modunda 0,1 s'dir; duvar süresi koşu başına 22–69 dk (aynı anda en çok
  iki kalibrasyon süreci). Accelerator hata verirse betik Normal modda yineler.
- Senaryolar ayrı model klasöründe derlenir; aynı klasörde eşzamanlı iki koşu başlatma.

## Çıktılar

| Dosya | İçerik |
|---|---|
| `kalibrasyon_tablosu.csv` | Senaryo başına serbest değişkenler, hedef / kalibrasyonsuz / kalibre değerler, hedefe fark ve durum (önce/sonra koşuları `tablo_secimi.json`) |
| `tablo_secimi.json` | Tabloya giren önce/sonra koşu etiketleri |
| `sureksiz_iletim.csv` | Kutup geriliminin ara seviyede (süreksiz iletim) ve sıfır seviyede kaldığı süre oranı |
| `results/<koşu>/metrikler.csv` | Display metrikleri: son değer ve 0,08–0,10 s ortalaması |
| `results/<koşu>/fazorler.csv` | Son periyot fazörleri (v_inv, v_ac, i_ac; şebeke EMK'sına göre) |
| `results/<koşu>/kosu_bilgisi.txt` | Model, `s`, faz, K1x/K33, mod, süre |
| `inspection/hazirlik.txt` | D-09, ayırma ve temiz oturumda derleme denetimi |
| `logs/<koşu>.log` | Konsol çıktıları |

`.gitignore` gereği `results/<koşu>/dalga.mat`, `ozet.mat`, `oneri*.mat`, `slprj/`, `*.slxc` ve
`*_acc.*` artıkları depoya girmez; `run` eylemi yeniden koşturularak üretilir. `model_s*/`
altındaki `.slx` ve `.m` dosyaları depoda tutulur.

## Uyarı

- Her `run` eylemi ilgili `<model>_kalibrasyon.m` dosyasını o koşunun değerleriyle yeniden yazar.
  Ara bir koşu yinelenirse K-20 değerlerine dönmek için son koşu (s1_k4, s2_k4, s3_k6) yeniden
  çalıştırılmalıdır.
- P_ac ve |Q₁| uyumu kalibrasyonun kendisidir, doğrulama değildir. Kalibre benzetim deneyin
  özet tablosunu belirtilen hatayla yeniden üretir; sayılar deney sonucu yerine geçmez.
- S2 ve faz kaydırılmış S3 koşularında 0,1 s'de oturma tam değildir (son periyot ile 0,08–0,10 s
  ortalaması arasında P_dc'de 0,3–0,5 W fark); tablolarda son değer verilmiştir.
