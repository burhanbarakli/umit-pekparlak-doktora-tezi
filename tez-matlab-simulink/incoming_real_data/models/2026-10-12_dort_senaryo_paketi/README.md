# Dört senaryo paketi (12.10.2026 teslimi)

Ümit Pekparlak'ın 12.10.2026'da gönderdiği Simulink modelleri ve ortak parametre
dosyası. Ham teslim `dosyalar/06_UMIT_ABIDEN_GELENLER/2026-10-12_senaryo3_senaryo4_modelleri/`
altındadır; buradaki kopyalar SHA-256 düzeyinde aynıdır. **Klasördeki dosyalar
değiştirilmez.** Düzeltilmiş, kalibre ve kapalı çevrim modeller `../../../runs/`
altındaki koşu klasörlerindedir (aşağıdaki "Tezde kullanılan modeller" tablosu).

MATLAB R2023b ile kaydedilmiştir; Simscape Electrical (Specialized Power Systems
ölçüm blokları dahil) gerekir. Modeller `inverter_common_parameters.m` dosyasını
**aynı klasörden** okur, bu yüzden dosyalar birlikte taşınır.

## Dosyalar

| Dosya | İçerik |
|---|---|
| `inverter_common_parameters.m` | Bütün senaryoların ortak fiziksel parametreleri, deney hedefleri, senaryo kazançları |
| `inverter_scenario1_parametric5_etiquetli.slx` | **S1 + S2**: iki bağımsız devre aynı modelde (üst devre S1, alt devre S2) |
| `inverter_senaryo3.slx` | **S3** |
| `inverter_senaryo4.slx` | **S4** olarak gönderildi, ancak S3 modelinin kopyasıdır; kapalı çevrim yoktur (D-02) |

## Senaryolar

| Senaryo | Yöntem | Nötr IGBT'ler (Q3, Q4) | İleri besleme | Akım denetimi |
|---|---|---|---|---|
| S1 | Komplement (klasik) anahtarlama | Anahtarlanır | — | Yok (açık çevrim) |
| S2 | Nötr anahtar susturma | Yarım periyotta biri kapalı | — | Yok |
| S3 | Susturma + Sin³ ileri besleme | Yarım periyotta biri kapalı | `K13·sin + K33·sin³` | Yok |
| S4 | S3 + L1 akım geri beslemesi | Yarım periyotta biri kapalı | S3 ile aynı | P / PI (tez: PI, 25 A) |

## Ortak devre parametreleri (`inverter_common_parameters.m`)

| Büyüklük | Değişken | Değer |
|---|---|---|
| Evirici tarafı endüktansı | `L1` / `L1r` | 600 µH / 0,03 Ω |
| L1 çekirdek kaybı eşdeğer direnci | `L1_core_Rp` (S4: `L1_core_Rp4`) | 600 Ω (S4: 1500 Ω) |
| Şebeke tarafı endüktansı (şebeke + varyak) | `L2` / `L2r` | 1000 µH / 0,01 Ω |
| Filtre kondansatörü | `C` / `Cr` | 8 µF / 0,01 Ω |
| DA bara kondansatörleri | `Cdc_pos`, `Cdc_neg` / `Cdc_esr` | 2 × 470 µF / 0,10 Ω (S4 tezde 2 × 5,6 mF, D-11) |
| DA kaynak direnci | `Rdc` | 1 mΩ |
| EMC süzgeci (iki kademe) | `EMC_Lw`, `EMC_M`, `EMC_Cx_each` | 400 µH, 398 µH (k = 0,995), 1 µF + 0,1 Ω |
| Anahtarlama frekansı | `fsw` | 10 kHz |
| Ölü zaman | `deadtime` | 1 µs |
| Şebeke frekansı | `f_grid` | 50 Hz |
| Kapı sürücüsü | `Vgate_on` / `Vgate_off` / `RG_total` | +15 V / −5 V / 15 Ω |
| Jonksiyon sıcaklığı | `Tj_operating` | 25 °C |
| Ölçüm ölçekleme kazancı | `measurement_gain` | 20 |
| Çözücü | `sim_max_step` / `sim_rel_tol` | 1 µs / 1e−6 |

## Yarı iletkenler

m-dosyasındaki `S12_*` / `S34_*` önekleri anahtar adıdır (S1–S4 anahtarları), senaryo
numarası değildir.

| Konum | Parça | Model özeti |
|---|---|---|
| Dış IGBT'ler (`S12_*`, Q1–Q2) | SEMIKRON SKM100GB12T4 | V_CE = 0,9 V + 11,5 mΩ·I_c; düşük akım E_on/E_off ara değerlemesi |
| İç (nötr) IGBT'ler (`S34_*`, Q3–Q4) | IXYS IXYN100N65C3H1 | V_CE(sat) 0,80 V (1 A) … 1,68 V (50 A) |
| DS1–DS2 | SKM100 iç diyot | V_f 1,50 V, r_F 10,2 mΩ, Q_rr 15,7 µC |
| DS3–DS4 | IXYN iç FRD | V_f 1,70 V, 6 mΩ, Q_rr 9,5 µC |
| Harici D1–D2 | IXYS DSEI2x61-12B | V_f 1,58 V, 8,5 mΩ, t_rr 190 ns, Q_rr 3 µC |

Veri sayfaları: `../../datasheets/`. Pakette D1–D2 ile DS3–DS4 parametre kümeleri yer
değiştirmiş durumdadır (D-08); düzeltilmiş modeller `runs/` altındadır.

## Senaryo parametreleri

### Paketteki değerler ve kalibre değerler

| | S1 | S2 | S3 | S4 |
|---|---|---|---|---|
| DA bara `Vdc` [V] | 431,50 | 395,00 | 427,50 | 427,50 |
| Şebeke `Vac_rms` [V] | 119,80 | 121,00 | 124,30 | 120,0 |
| Sinüs kazancı, paket | `K11` = 0,7865 | `K12` = 0,794 | `K13` = 0,45 | `K14` = `K13` |
| Sin³ kazancı, paket | — | — | `K33` = 0,39 | `K34` = `K33` |
| Faz, paket [°] | −0,44 | 0 | 0 | 0 |
| **Sinüs kazancı, kalibre** | **0,7865024** | **0,7679568** | **0,44343** | **0,44343** |
| **Sin³ kazancı, kalibre** | — | — | **0,384306** | **0,384306** |
| **Faz, kalibre [°]** | **−0,36607** | **0,1121** | **0,6575** | **0,6575** |
| Akım referansı | — | — | — | 25 A RMS (`Ifaz_rms_target(4)`) |
| Denetleyici | — | — | — | `Kp` = 0,03; tezde PI: `Ki` = 11,31, anti-windup 377 s⁻¹ |

Kalibre değerler: `runs/2026-10-28_kalibrasyon/kalibrasyon_tablosu.csv` ve
`runs/2026-10-28_parametre_tablosu/model/tez/*_kalibrasyon.m`. Kalibrasyonda yalnız
kazanç ve faz serbest bırakıldı; devre parametreleri sabit tutuldu (K-20). S4, kalibre
S3 ileri beslemesini kullanır.

### Deney hedefleri (m-dosyası, `*_target`)

| | S1 | S2 | S3 | S4 |
|---|---|---|---|---|
| `Idc` [A] | 0,624 | 0,684 | 0,697 | — |
| Faz akımı RMS [A] | 2,26 | 2,33 | 2,31 | 25,00 |
| `Pout` [W] | 249,60 | 253,20 | 281,20 | — |
| cos φ | 1,000 | −0,995 | −0,997 | 1,000 |
| Verim | 0,9250 | 0,9420 | 0,9450 | — |

Q, V_out ve diğer hedefler m-dosyasındadır. Q işareti kuralı için D-06 ve K-02'ye bakın.

## Tezde kullanılan modeller

Paket olduğu gibi koşturulmaz: S2 kapı yolu kopuktur (D-01) ve S4 eksiktir (D-02). Tez
sonuçları aşağıdaki modellere dayanır. Modellerin hepsi `runs/2026-10-28_parametre_tablosu/model/tez/`
altında da toplanmıştır.

| Senaryo | Model | Koşu klasörü | Uygulanan düzeltmeler |
|---|---|---|---|
| S1 | `inverter_s1_kal.slx` | `runs/2026-10-28_kalibrasyon/model_s1` | D-01, D-08, D-09, D-12 + kalibrasyon |
| S2 | `inverter_s2_kal.slx` | `runs/2026-10-28_kalibrasyon/model_s2` | D-01 (kapı yolu onarımı), D-08, D-09, D-12 + kalibrasyon |
| S3 | `inverter_senaryo3_kal.slx` | `runs/2026-10-28_kalibrasyon/model_s3` | D-08, D-09 + kalibrasyon |
| S4 | `inverter_senaryo4_kc.slx` | `runs/2026-10-28_s4_kapali_cevrim/model*` | D-02 (kapalı çevrim kuruldu), D-11 (2 × 5,6 mF) |

Düzeltme ayrıntıları: [`tez-tamamlama/02_MODEL_DUZELTME_KAYDI.md`](../../../../tez-tamamlama/02_MODEL_DUZELTME_KAYDI.md).

## Çalıştırma

Ham modeller buradan doğrudan açılmamalıdır: Simulink `slprj/` artığı bırakır. Koşu
betiği modeli `runs/<koşu>/model/` kopyasında çalıştırır. Proje kökünden (PowerShell):

```powershell
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_umit_dort_senaryo_20261027('inverter_senaryo3')"
```

Elle açmak için:

```matlab
cd runs/2026-10-27_dort_senaryo_ilk_kosu/model
run('inverter_common_parameters.m')   % load_system'dan ÖNCE (D-03)
load_system('inverter_senaryo3'); out = sim('inverter_senaryo3');
```

- Parametre dosyası `load_system`'dan önce taban çalışma alanında çalıştırılmazsa
  Simscape diyotları "Qrr/didt … type string" hatası verir (D-03).
- Model kapanınca CloseFcn taban çalışma alanından `C` ve `L`'yi siler; bir sonraki
  yüklemeden önce parametre dosyasını yeniden çalıştırın (D-13).
- Ham S1+S2 modeli LCC ile Accelerator'da bağlanamaz, Normal modda koşar (0,1 s ≈ 1,9 saat).
  S3 Accelerator'da 0,1 s ≈ 27 dakika sürer.
