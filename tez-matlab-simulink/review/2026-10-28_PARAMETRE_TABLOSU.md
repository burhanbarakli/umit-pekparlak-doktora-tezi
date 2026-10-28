# Tek parametre tablosu: envanter ve tablo üretimi (İP-7)

Tarih: 28.10.2026 · MATLAB R2023b Update 7 · bu makine · İP-7 · jüri maddesi 9 · K-09
(dayanak kararlar: K-05, K-06a, K-08, K-14, K-17, K-18, K-19, K-20, K-21; düzeltmeler
D-07, D-08, D-09, D-10, D-11)

## Amaç ve kapsam

Bölüm 3'teki `tab:sistem-parametreleri` tablosu 12.10 paketinin parametre dosyasından
yeniden üretildi. Her satır değer, birim, kaynak ve tür taşır; tabloda "DOĞRULANACAK"
kalmadı. Her değerin yalnız m-dosyasında tanımlı olması yetmedi: sonuçların dayandığı
taban modellerde hangi blokta gerçekten kullanıldığı MATLAB ile tarandı.

Bu notta **benzetim sonucu yoktur**. Koşu yapılmadı, model kaydedilmedi; yalnız
`load_system` + `find_system`/`get_param` taraması yapıldı.

- Betik: `scripts/envanter_parametre_20261028.m`
  (proje kökünden `run('scripts/envanter_parametre_20261028.m')`, ~4 dk)
- Klasör: `runs/2026-10-28_parametre_tablosu/`
  - `model/ham/`: 12.10 paketinin üç modeli + m-dosyası (bayt bayt aynı; `ayni=1`)
  - `model/tez/`: sonuçların dayandığı dört taban model ve onların ek dosyaları
    (bayt bayt aynı kopyalar; git dışı)
- Kurallar: D-03 (parametre dosyası `load_system`'dan önce taban çalışma alanında),
  D-13 (her yüklemeden önce taban temizlenip parametreler yeniden yüklendi, model
  kapanınca silinen `C`/`L` sorun yaratmadı). Tek MATLAB süreci; iş bitince kapandı.

### Taranan modeller

| Etiket | Model | Ek dosya | Tezdeki rolü |
|---|---|---|---|
| ham_S1S2 | `inverter_scenario1_parametric5_etiquetli` | — | 12.10 ham |
| ham_S3 | `inverter_senaryo3` | — | 12.10 ham |
| ham_S4 | `inverter_senaryo4` | — | 12.10 ham (S3 kopyası, D-02) |
| tez_S1 | `inverter_s1_kal` (runs/2026-10-28_kalibrasyon/model_s1) | `inverter_s1_kal_kalibrasyon.m` | S1 kalibre (D-01, D-08, D-09, D-12) |
| tez_S2 | `inverter_s2_kal` (model_s2) | `inverter_s2_kal_kalibrasyon.m` | S2 kalibre |
| tez_S3 | `inverter_senaryo3_kal` (model_s3) | `inverter_senaryo3_kal_kalibrasyon.m` | S3 kalibre |
| tez_S4 | `inverter_senaryo4_kc` (runs/2026-10-28_s4_kapali_cevrim/model) | `s4_denetleyici_parametreleri.m` + `KC_PI_25A/kosu_bilgisi.txt` InitFcn eki | S4 kesin tarama (D-02, D-11, K-20) |

Yorum satırına alınmış bloklar (`Commented = on`, D-12 ayrık kopyaları) sayılmadı.

## Çıktılar

| Dosya | İçerik |
|---|---|
| `parametre_envanteri.csv` | 228 değişken (m-dosyası 206 + S4 dosyası 22) ve 7 kalibrasyon ataması: kaynak dosya, satır, ifade, değer, birim, yorum; model başına kullanım (blok parametresi sayısı / `dolaylı` / `-`) ve örnek blok yolu |
| `parametre_kullanim_uzun.csv` | 2273 satır: model, değişken, blok, parametre, ifade |
| `model_yapilandirma.csv` | çözücü, adım, toleranslar, geri çağrılar, powergui, Solver Configuration |
| `etkin_degerler.csv` | tez modellerinde senaryoya özgü etkin değerler (kalibrasyon dosyası, S4 dosyası, KC eki) ve S4 kip kazançları |
| `blok_parametreleri_tez.csv` | tez modellerinde denetim/ölçüm/PWM blok parametreleri (kitaplık iç blokları hariç) |
| `sabit_sayi_parametreleri.csv` | fiziksel bloklarda değişken yerine sayı yazılmış etkin alanlar (D-10) |
| `envanter_gunlugu.txt` | kopya denetimi, yükleme, kullanım özeti |

## Bulgular

### 1. Kullanım özeti

| Model | doğrudan | dolaylı | kullanılmayan |
|---|---|---|---|
| ham_S1S2 | 140 | 12 | 76 |
| ham_S3 / ham_S4 | 139 | 11 | 78 |
| tez_S1 / tez_S2 | 138 | 13 | 77 |
| tez_S3 | 139 | 13 | 76 |
| tez_S4 | 154 | 23 | 51 |

"Dolaylı" = başka bir kullanılan değişkenin tanımına giriyor (ör. `Vac_rms_target` →
`Vac3_peak`). Toplam 228; S4 dosyasının 22 değişkeni yalnız tez_S4'te sayılır.

### 2. Tez modellerinin hiçbirinde kullanılmayan değişkenler (tabloya alınmadı)

- **Deney hedefleri (sonuç, parametre değil):** `Idc_target`, `Pout_target`,
  `cosphi_target`, `THD_target_pct`, `Qout_target`, `Vout_target`, `eff_target`.
  `Vdc_target`, `Vac_rms_target` dolaylı kullanılıyor; `Ifaz_rms_target` yalnız S4'te
  (S4_Iref). Tabloda Vdc, V_g ve I_g "ölçülmüş" çalışma noktası olarak verildi; P, η,
  THD, cosφ, Q deney tablolarında kalır.
- **Toplu diziler:** `K_pwm`, `K3_pwm`, `phase_deg` (yalnız bilgi amaçlı).
- **Isıl ağ ve eşik değişkenleri (D-10):** `S12/S34_Vge_threshold`,
  `S12/S34_thermal_*` (6'şar), `DS12/DS34/D12_Tdevice`. Bloklarda aynı değerler sayı
  olarak yazılı: 32 blok alanında `Vth = 6`, 88'er alanda `Rth = [0, 10]`,
  `thermal_mass = [0, 1]`, `thermal_time_constant = [0, 10]`,
  `thermal_mass_initial_temperatures = [25, 25]`, 120 alanda `Tdevice = 25`
  (dört tez modeli toplamı). Sayısal fark yok; tabloda değerler verildi.
- **Eşdeğer/ara değişkenler:** `EMC_Ldm_stage` (4 µH), `EMC_Rdm_stage` (10 mΩ) yalnız
  bilgi; model CMC'yi karşılıklı endüktansla kuruyor. Tabloda diferansiyel eşdeğer
  açıklama olarak verildi.
- **D-09 ile devreden çıkanlar:** `C_emc_aux` (1 µF), `R_emc_aux` (0,01 Ω). Ham
  modellerde kullanılıyor, tez modellerinde yerini `EMC_Cx_eq`/`EMC_Rx_eq` aldı.
- **Diğer:** `EMC_Rref` (1 GΩ, "sayısal referans" yorumu; hiçbir blokta yok),
  `sim_min_step` (1 ns; model `MinStep = auto`), `parameter_file_path`.
- **S4 dosyasında tanımlı, blokta değil, koşu betiğinde kullanılan:** `S4_PI_fz`
  (60 Hz) ve `S4_PIR_Kr` (0,3). `run_s4_closed_loop_20261028.m` bunlardan
  `S4_Ki_c`, `S4_Kaw`, `S4_Kr` atıyor. Etkin değerler `etkin_degerler.csv`: Ki =
  11,3097 1/(A·s), Kaw = 376,99 1/s, Kr = 0,3 1/A. Bunlar tabloda var.

### 3. Model yapılandırması (R08 kapanışı)

Yedi modelin hepsinde: `Solver = ode15s` (değişken adımlı), `MaxStep = sim_max_step`
(1 µs), `RelTol = sim_rel_tol` (1e-6), `AbsTol = sim_abs_tol` (1e-6), `MinStep = auto`,
`ZeroCrossControl = UseLocalSettings`, `SimulationMode = accelerator`, kayıtlı
`StopTime = 0,1 s` (S4 koşuları betikle 0,06 / 0,2 s). Solver Configuration:
`UseLocalSolver = off`, `LocalSolverSampleTime = 1e-7` (**etkisiz**),
`ResidualTolerance = simscape_residual_tolerance` (1e-6), `DoDC = off`.
powergui: `Continuous` (kayıtlı `SampleTime = 50e-6` etkisiz).

İstek listesindeki "`Ts = 1e-7` çözücü mü, denetim mi?" sorusunun yanıtı modelden
okundu. 1e-7, Simscape yerel çözücüsünün örnekleme adımıdır ve yerel çözücü kapalı
olduğu için etkisizdir. Benzetim, en büyük adımı 1 µs olan ode15s ile koşar.

### 4. PWM, ölü zaman ve örnekleme

- `fsw` = 10 kHz: 4 PWM Generator (DC-DC) bloğunda `Fsw = fsw`, `Ts = 1/fsw/100`
  (= 1 µs, sabit formül; `pwm_ref_Ts` ile aynı değer ama bağlı değil).
- `deadtime` = 1 µs: 4 On Delay bloğunda. m-dosyası yorumu: "PIC32: DTR=ALTDTR=120,
  PTPER=12000 @ 10 kHz". 12000 sayım/periyot 120 MHz PWM saatine karşılık gelir,
  120 sayım da 1 µs eder. Ölü zaman bu yüzden **donanım yazmaç değerinden gelen tasarım
  değeri** olarak yazıldı. Tezde 04:134 satırındaki "parametre dosyası ölü zaman
  içermemektedir" ifadesi 12.10 dosyası için yanlıştır (İP-8).
- `pwm_ref_Ts` = 1 µs: sinüs referansı (S1–S3'te 1 blok), S4'te 9 blok (referans,
  ZOH'ler).
- Ölçüm blokları (Mean, RMS, THD) `Freq = 50` sabit yazılı (`f_grid` değil).
  S4 dışında `f_grid` yalnız iki blokta kullanılıyor.
- Nötr kapı sürücülerinin (elektrik girişli) eşikleri `uHigh = 4`, `uLow = 3` sabit;
  PS girişli dış sürücüler `gate_logic_high/low` (0,7/0,3) kullanıyor.
- `measurement_gain` = 20: yalnız `Gain1/Gain2` → `Bus Creator` → Scope yolunda,
  `i_ac` görüntüsünü ölçekliyor. Display/güç/THD hesaplarına girmiyor.

### 5. Etkin değerler (tez modelleri)

| Model | Değişken | Etkin | m-dosyası (ilk değer) | Kaynak |
|---|---|---|---|---|
| tez_S1 | K11 / phase_deg1 | 0,7865024 / −0,36607° | 0,7865 / −0,44° | kalibrasyon dosyası (K-20) |
| tez_S2 | K12 / phase_deg2 | 0,7679568 / +0,1121° | 0,794 / 0° | kalibrasyon dosyası |
| tez_S3 | K13 / K33 / phase_deg3 | 0,44343 / 0,384306 / +0,6575° | 0,45 / 0,39 / 0° | kalibrasyon dosyası |
| tez_S4 | K14 / K34 / phase_deg4 | 0,44343 / 0,384306 / +0,6575° | 0,45 / 0,39 / 0° | KC eki (K-20) |
| tez_S4 | Cdc_pos = Cdc_neg | 5,6 mF | 470 µF | KC eki (D-11) |
| tez_S4 | L1 çekirdek Rp | `L1_core_Rp4` = 1500 Ω | — | K-14 |
| tez_S1–S4 | X kapasitörü | `EMC_Cx_eq` 0,5 µF / `EMC_Rx_eq` 0,2 Ω | `C_emc_aux` 1 µF / 0,01 Ω | D-09 |
| tez_S4 | Kp / Ki / Kaw / Kr / ω_b | 0,03 / 11,31 / 377 / 0,3 / 12,57 rad/s | Kp 0,03 | K-19 |
| tez_S4 | süzgeç / Ts / |u| / integratör | 5 kHz / 1 µs / 1 / 1 | — | K-19 |

S1–S4'te diyot önekleri D-08'e göredir (D1–D2 `D12_*`, DS3–DS4 `DS34_*`; ham modellerde
takaslı).

## Tablo (tez-latex-v2/chapters/03-sistem-model-metodoloji.tex)

`tab:sistem-parametreleri`: 5 sütun (Parametre, Değer, Birim, Kaynak, Tür), 7 grup,
**75 satır**.

| Grup | Satır |
|---|---|
| Sistem tanımı ve çalışma noktaları | 14 |
| Ölçüm ve sayısal denetim donanımı | 6 |
| LCL filtre, EMC süzgeci ve DA bara | 16 |
| Yarı iletkenler ve kapı sürücüsü | 13 |
| Modülasyon ve PWM | 10 |
| S4 akım denetimi | 8 |
| Sayısal çözüm ve değerlendirme | 8 |

Tür dağılımı (satırın birincil türü): Tasarım 32, Benzetim seçimi 26, Veri sayfası 8
(ikisi "eşleme düzeltilmiş (D-08)" ekli), Kalibre 4, Ölçülmüş 3, Düzeltilmiş 2 (D-09,
D-11). "Sınırlılık" ibaresi 7 satırda: anma gücünde deney yok; PIC32 parça kodu ve
yazılım; L2 doğrudan ölçülmedi; ADC örnekleme ve güncelleme anı; susturma/Sin³
etkinleşme eşiği; sayısal gerçeklemede etkin sönümleme gereği (K-19 not 1). S4 Rp
notu (K-14) ayrıca var.

Tür adı: görev tanımındaki "m-dosyası (tasarım)" sınıfı, donanım tasarım belgelerinden
gelen satırları da (20 kVA, sensör, AMC1200, PIC32) kapsasın diye tezde **"Tasarım"**
olarak adlandırıldı. Kaynak sütunu "parametre dosyası" ile "donanım tasarım belgesi"ni
ayırır (K-22 önerisi).

### Eski tablodan yeni tabloya eşleme (eski 25 satırın hepsinin karşılığı var)

| Eski satır | Yeni karşılık | Değişiklik |
|---|---|---|
| Faz yapısı (üç faz, dört telli) | Prototip faz yapısı + Benzetim ve deney kapsamı | tek faz kapsamı ayrıldı |
| Tasarım güç aralığı 20–25 kW | aynı | K-08 sınırlılığı |
| Prototip anma gücü 20 kVA | Prototip anma görünür gücü | — |
| Şebeke frekansı | aynı | m-dosyası `f_grid` |
| Şebeke anma gerilimi 230/400 V | aynı | — |
| Deney faz–nötr gerilimi 120–130 V | Deney şebeke gerilimi S1/S2/S3 + S4 120 V | senaryo başına ölçülmüş değer |
| DA bara gerilimi (tanım DOĞRULANACAK) | DA bara gerilimi S1–S3, S4, DA bara tanımı | toplam bara, yarım bara Vdc/2 (modelden) |
| DA bara ölçüm aralığı 470 V | aynı | — |
| Faz RMS akım tasarımı / üst sınırı | birleştirildi (30; 36 A) | — |
| Aşırı akım eşiği | aynı | — |
| Akım sensörü / gerilim ölçümü | aynı | — |
| Sayısal denetleyici (parça kodu DOĞRULANACAK) | Sayısal denetleyici + PWM zamanlayıcı yapılandırması | sınırlılık; PTPER/DTR m-dosyası yorumundan |
| Anahtarlama frekansı (donanım DOĞRULANACAK) | Anahtarlama frekansı | PTPER = 12000 ile tutarlı |
| Örnekleme frekansı (DOĞRULANACAK) | Modülasyon referansı örnekleme adımı + S4 denetim adımı | benzetim seçimi + sınırlılık |
| Ölü zaman (DOĞRULANACAK) | Ölü zaman 1 µs | tasarım (DTR = 120) |
| L1, Cf, L2 = 600 µH, 8 µF, **200 µH** | L1, Cf, L2 ayrı satırlar | **L2 = 1000 µH** (İ1) |
| R1, RCf, R2 = **0,02**/0,01/**0,02** Ω | L1r 0,03, Cr 0,01, L2r 0,01 Ω | İ1; ESR yorumu m-dosyası açıklamasından |
| S1–S2 / S3–S4 / D1–D2 parça kodları | aynı + iletim, enerji, süre, diyot satırları | D1–D2 **Vf 1,58 V, trr 190 ns** (eski 1,35 V / 380 ns, 100 °C değeri) |
| Anahtar geçiş süreleri **165/400/600/600 ns** | S1–S2 200/600/60/110; S3–S4 200/50/100/1000 ns | İ1 |
| PR/akım denetleyici katsayıları (DOĞRULANACAK) | S4 akım denetimi grubu (8 satır) | K-19, K-21 |
| Sin³ kazancı ve etkinleşme eşiği (DOĞRULANACAK) | K3 kalibre + biçim + etkinleşme ölçütü | K-06a, K-20 + sınırlılık |

Yeni satırlar (eski tabloda yoktu): L1 çekirdek Rp, ortak kip bobinleri, X kapasitörü,
DA bara kapasitörleri (iki satır), ESR, dengeleme dirençleri, Rdc, DA ters akım diyotu,
modele katılmayan donanım öğeleri, diyot parametreleri, kapı sürücüsü, Tj, kalibre
modülasyon değerleri, taşıyıcı, çözücü ayarları, değerlendirme penceresi, ölçüm noktası,
görüntüleme kazancı.

### `\eksikistek` 03:505 — kaldırıldı

Barın dört maddesi tabloda şöyle karşılanıyor:

1. PWM/denetleyici kodu ve zamanlayıcı yapılandırması (örnekleme, ölü zaman,
   sınırlayıcılar): ölü zaman 1 µs (tasarım, PIC32 DTR = 120); örnekleme 1 µs (benzetim
   seçimi) + "ADC örnekleme ve güncelleme anı belgelenmemiştir" sınırlılığı; sınırlayıcı
   |u| ≤ 1 (benzetim seçimi); kod: İ2 + "denetim yazılımı belgelenmemiştir" sınırlılığı.
2. Toplam/yarım DA bara tanımı: "DA bara tanımı" satırı (modelden).
3. 20 kVA–25 kW anma ifadeleri: K-08, tasarım hedefi + "anma gücünde deney
   yapılmamıştır" sınırlılığı.
4. PR/PI katsayıları ve Sin³ kazanç/eşik değerleri: S4 grubu (K-19/K-21), K3 kalibre
   (K-20), etkinleşme eşiği sınırlılığı.

Bar sayısı 13 → 12. 03:406 ("gerçek denetim kodu ve kapı mantığı") bu İP'nin kapsamı
dışında kaldı. Metni R2025b ve "Senaryo 2–4 paketi yok" dayanağıyla yazılmıştır;
İP-8/İP-9'da İ2 ile kapanır.

## Derleme

**Yapılamadı.** Bu makinede Tectonic yok: `%USERPROFILE%\.local\bin\tectonic.exe`,
PATH ve `build.cmd`'nin üçüncü yolu boş; MiKTeX/TeX Live da yok. `build.cmd` "Tectonic
bulunamadi" ile çıktı. Kurulum dosya indirmeyi gerektirdiği için yapılmadı.
`tez-latex-v2/build/` içindeki son derleme 01.09.2026 tarihlidir.

Yerine statik denetim yapıldı: 75 veri satırının hepsinde 4 `&` var. Kesimde küme
parantezi ve `$` dengeli. Kullanılan `\ref` hedefleri (`chap:deney`, `chap:sin3`,
`chap:sonuc`, `tab:sistem-parametreleri`) mevcut. siunitx birimleri standarttır
(`\degree`, `\celsius`, `\coulomb`, `\radian`, `\per`). Sayfa sayısı ve `Undefined`
denetimi Tectonic kurulduktan sonra yapılmalıdır.

## Bölüm 3–6 metninde tabloyla çelişen değerler (İP-8'e)

| Yer | İfade | Tablo / doğru durum |
|---|---|---|
| 03:5, 03:75 | "üç fazlı dört telli güç katı" | Prototip doğru; benzetim ve deney tek faz kolu. Kapsam cümlesi gerekli |
| 03 "Üç Endüktans Değerinin Ayrıştırılması ve L2 Seçimi" alt kesimi, `tab:l2-aday-karsilastirma`, `fig:l2-aday-degerlendirme` | Nihai L2 = 200 µH; f_res 4,594 kHz; f_res/f_s = 0,459 | L2 = 1000 µH (şebeke + varyak eşdeğeri, İ1). Alt kesim yeniden yazılmalı ya da kaldırılmalı; tablo, parametre değerlerini yineliyor |
| 03 `tab:yariiletken-esleme` | D1–D2 = `Diode6`, `Diode7`; "R2025b çalışma kopyası" | D-08: D1–D2 = `Diode3`/`Diode5` (DSEI), DS3–DS4 = `Diode6`/`Diode7` (IXYN FRD). Parça kodları ana tabloyu yineliyor |
| 03 `eq:guc-ortalama-tanimlari` | P_ac üç faz toplamı | Model tek faz: P_ac = ⟨v_g·i_g⟩, C noktası, üretici kuralı (K-02a) |
| 03:96, 03:128 | "ölü zaman … kapı kodu doğrulamasında ayrıca ele alınacak" | t_d = 1 µs, modelde On Delay |
| 04:116 | "kesin kapı tablosu gerçek PWM koduyla kilitlenecektir" | İ2: model kapı mantığı (topoloji denetimi notu) |
| 04:134 | "Eldeki benzetim parametre dosyası ölü zaman içermemektedir" | **Yanlış**: `deadtime` = 1 µs |
| 04:138 bar | "R2025b … Senaryo 2–3 modeli yok" | 12.10 paketi + D-01 (İP-9) |
| 05:77, 05:117 | V_h = 215,75 V, V_m = 169,4 V, V_dc = 431,5 V, L = 600 µH "doğrulanmış parametre seti" | Değerler S1 ile tutarlı ama tabloyu yineliyor; tek-L analitik katman olduğu belirtilmeli, değerler tabloya atıfla verilmeli |
| 05:159 | Analitik aday (D1, D3) = (0,34; 0,40) | Kalibre K13 = 0,44343, K33 = 0,38431 (m = 0,7317 sin θ − 0,0961 sin 3θ). İki gösterim ayrı adlandırılmalı |
| 05:218 | toplam gecikme 150 µs, GM 9,09 dB, PM 64,16°, L_g 0–2 mH | K-21: PM 54° (3,4 kHz), GM +35 dB, gecikme marjı 44 µs. Eski geçici analiz çıkarılmalı |
| 05:299 | "R2025b çalışma kopyasında L1–Cf–L2 600 µH–8 µF–200 µH" | L2 = 1000 µH; 12.10 paketi R2023b'de koşuyor |
| 05:320–322 | 12 IGBT'li üç fazlı model, V_dc 400 V, L1 2 mH, L2 1 mH, 2 µs ölü zaman, K_sin3 = −2 V | Tablo dışı geçici değerler. Kaldırılmalı ya da "eski bağımsız deneme" diye ayrılmalı (üst-anlatı kuralına dikkat) |
| 05:349–373, `tab:senaryo4-pi-30a` | S4: R1 = 0,02 Ω, V_dc = 431 V, K_p = 3 V/A, K_i = 100 V/(A·s), 100 µs denetim periyodu, K3 = −2 V, "30 A" | Tablo: L1r 0,03 Ω, V_dc 427,5 V, Kp 0,03 1/A, Ki 11,31 1/(A·s), 1 µs analog eşdeğer, 25 A (K-05, K-19, K-21) |
| 06:139–147 | AMC1200, HLSR, 23 mV/A, 56,5 A, 30,4 A, 470 V düzyazıda | Tabloyla tutarlı; çelişki yok. Tek tablo ilkesi için düzyazıda tabloya atıf yeterli |
| 06 `tab:deney-metin-ekran-karsilastirma` | V_dc özet 430/395/427 V ↔ ekran 431,5/394,7/427,5 V | Tablo m-dosyasını (431,5/395/427,5) kullanır; deney tablosunda iki kaynak farkı zaten belirtilmiş |
| 08 AS3, `tab:senaryo4-pi-30a` atfı | "30 A akım döngüsü fizibilitesi" | S4 25 A (İP-5) |

## Önerilen kayıtlar

**K-22 (öneri): Parametre tablosunun tür sınıfları ve kapsamı.**

- Açık nokta: K-09'daki üç tür (ölçülmüş/veri sayfası/kalibre) donanım tasarım
  değerlerini, benzetim kararlarını ve düzeltmeleri karşılamıyor. Tabloya hangi
  m-dosyası değişkenlerinin gireceği de belirsiz.
- Seçilen:
  - Altı tür kullanılır: Ölçülmüş / Veri sayfası / Tasarım (parametre dosyası ya da
    donanım tasarım belgesi) / Kalibre (ilk değer parantezde) / Benzetim seçimi /
    Düzeltilmiş (D-n).
  - Taban modellerin hiçbirinde kullanılmayan değişkenler tabloya girmez: deney
    hedefleri, toplu diziler, yedek ısıl değişkenler, `EMC_Rref`, `sim_min_step`.
  - Ölü zaman 1 µs, m-dosyasındaki PIC32 yazmaç açıklamasına (DTR = ALTDTR = 120,
    PTPER = 12000) dayanarak "tasarım" türünde verilir.
  - Eski "Ts = 1e-7" değeri, Simscape yerel çözücüsünün etkisiz örnekleme adımı olarak
    açıklanır (R05 ölü zaman ve R08 kapanışı).
  - Donanımda belgelenmemiş büyüklük "sınırlılık" ibaresiyle kapatılır: denetim
    yazılımı, ADC örnekleme anı, etkinleşme eşiği, L2 ölçümü.
  - Kalibre değerlerin kaynağı tezde kalibrasyonun anlatıldığı bölümdür; tablo şimdilik
    Bölüm 6'ya (`chap:deney`) atıf yapar.
- Dayanak: İ1, İ2, İ4; bu notun envanteri.
- Tezde: Bölüm 3 tablo giriş paragrafı (yazıldı).
- Yeniden açılır: denetim yazılımı ya da donanım belgesi gelirse; kalibrasyon başka
  bölüme yazılırsa (yalnız atıf değişir).

**D-14 (öneri): model düzeyinde sabit yazılmış ölçüm ve çözücü ayarları (D-10'un
genişletilmesi).**

- Dosya / blok: 12.10 modelleri ve bütün kopyaları.
  - Mean/RMS/THD blokları `Freq = 50` (`f_grid` değil).
  - PWM Generator `Ts = 1/fsw/100` (`pwm_ref_Ts` değil).
  - Nötr kapı sürücüleri `uHigh = 4`, `uLow = 3` (`gate_logic_*` yerine sayı).
  - Solver Configuration `LocalSolverSampleTime = 1e-7` (etkisiz).
  - powergui `SampleTime = 50e-6` (sürekli kipte etkisiz).
  - `MinStep = auto` (`sim_min_step` = 1 ns kullanılmıyor).
- Sınıf: Parametre (izlenebilirlik).
- Sorun: değerler m-dosyasından izlenemiyor; `f_grid` ya da `fsw` değişirse ölçüm
  pencereleri ve PWM örneklemesi kendiliğinden güncellenmez.
- Doğru durum: tek kaynak (K-09).
- En küçük düzeltme: gerekmez; mevcut değerler m-dosyası değerleriyle aynı ya da
  etkisizdir. Tabloda "benzetim seçimi" olarak yazıldı.
- Etki: yok.
- Durum: açık, düşük öncelik (D-10 ile birlikte). Tezde yer almaz.

## Doğrulanmayan / yarım kalan

1. LaTeX derlemesi yapılamadı (Tectonic yok). Sayfa sayısı, `Output written` ve
   `Undefined` denetimi bekliyor. Longtable genişliği (sütun toplamı 0,925·textwidth
   + 4 pt aralık) PDF'te gözle denetlenmeli.
2. Kalibre satırlarının kaynak atfı `Bölüm~\ref{chap:deney}`. Kalibrasyon kesimi
   İP-8'de başka bölüme yazılırsa atıf değişmeli.
3. Donanım satırları önceki tablodan aktarıldı: 20 kVA, 30/36 A, 30,4 A, HLSR, AMC1200,
   PIC32MK, 470 V, 230/400 V. Ham tasarım belgesiyle bu oturumda yeniden
   karşılaştırılmadı; Bölüm 6 düzyazısıyla tutarlı.
4. "Modele katılmayan donanım öğeleri" (4 µF snubber, 26 nF Y kapasitörü, CM1 460 µH)
   topoloji denetimi notundan alındı; şema bu oturumda yeniden okunmadı.
5. D-n numaraları tez metninde ilk kez bu tabloda geçiyor. K-13 kesimi (İP-8) aynı
   numaralarla yazılmalı.
