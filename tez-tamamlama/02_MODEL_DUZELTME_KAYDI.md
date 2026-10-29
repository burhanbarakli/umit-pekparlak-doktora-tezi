# Model düzeltme kaydı — gelen dosyalardaki sorunlar ve tez kapsamına göre düzeltmeler

Bu kayıt, Ümit'ten gelen model ve parametre dosyalarında bulunan her sorunu ve
bu sorunun tez kapsamına (K-03 senaryo tanımları, T-tipi topoloji) uygun olarak
nasıl düzeltildiğini tutar. Ham paket hiç değiştirilmez (İ3). Düzeltmeler
`tez-matlab-simulink/runs/<tarih>_<konu>/model/` altındaki kopyada, tekrar
üretilebilir bir betikle yapılır.

Tezde bu kayıt Bölüm 3'teki "Benzetim modelinin doğrulanması ve düzeltilmesi"
alt kesiminde özetlenir (K-13).

## Kayıt biçimi

Her satır şu öğeleri içerir:

- **No**: D-xx
- **Dosya / blok**: sorunun bulunduğu dosya ve blok
- **Sınıf**:
  - *Topoloji*: güç devresi bağlantısı
  - *Kapı/denetim*: PWM, kapı yolu, denetleyici
  - *Parametre*
  - *Ölçüm*: ölçüm zinciri, işaret, pencere
  - *Paket*: eksik/kopya dosya, yükleme sırası
- **Sorun ve kanıt**: neyin yanlış olduğu, bunu gösteren koşu veya inceleme çıktısı
- **Tez kapsamındaki doğru durum**: hangi tanıma göre (K-xx)
- **Düzeltme**: ne değişti, hangi betikle
- **Etki**: düzeltme öncesi ve sonrası sayısal fark
- **Durum**: açık / düzeltildi / doğrulandı

## Özet tablo

| No | Dosya / blok | Sınıf | Sorun (kısa) | Durum |
|---|---|---|---|---|
| D-01 | `inverter_scenario1_parametric5_etiquetli.slx` · Gate Drive1–4 | Kapı/denetim | S2 devresinin kapı sürücüleri `g12…g42` etiketlerini okuyor, bu etiketleri üreten Goto yok; S2 IGBT'leri hiç anahtarlanmıyor | doğrulandı — S2 anahtarlıyor, η 94,07 % (hedef 94,2 %) |
| D-02 | `inverter_senaryo4.slx` | Paket | Dosya S3 modelinin kopyası; S4'ün L1 akım geri beslemeli denetleyicisi yok | doğrulandı — S4 kuruldu; 25 A'da PI −%2,1, PIR −%1,0 izleme hatası, doyum yok (İP-5) |
| D-03 | Dört modelin tümü · model geri çağrıları | Paket | Parametre dosyası yalnız InitFcn'de çalışıyor, PreLoadFcn yok; temiz oturumda Simscape diyotları "Qrr/didt … type string" hatasıyla derlenmiyor | doğrulandı (29.10.2026) — kalibre kopya modellerde PreLoadFcn parametre dosyasını yüklüyor; beş modelde temiz oturumda derleme başarılı (`runs/2026-10-28_kalibrasyon/inspection/hazirlik.txt`); koşu betikleri ayrıca yükleme öncesi çalıştırıyor. Ham paket modelleri değiştirilmedi |
| D-04 | S1+S2 ve S3 · sinyal kayıt adları | Ölçüm | Farklı hatlar aynı kayıt adını taşıyor (ör. `Idc_s1`); ada göre okunan değer yanlış hatta ait olabiliyor | doğrulandı (29.10.2026) — İP-4 kalibrasyonu ve İP-11 yeniden koşusu aynı eşlemeyle, son değerler 6 basamak aynı (`review/2026-10-29_TEZ_SEKILLERI.md`) |
| D-05 | `inverter_common_parameters.m` | Parametre | `Kp`, `K12`, `phase_deg2`, `L1_core_Rp4` tanımlı ama hiçbir blokta kullanılmıyor | kapandı — hepsi S2/S4 modellerinde bağlı |
| D-06 | S1, S3 · Power blokları | Ölçüm | Benzetimde Q pozitif (+33…+35 var), deney tablosunda Q negatif ya da sıfır; yön kuralı belgelenmemiş | kapandı — C noktasında üretici kuralı doğrulandı; deney Qo hesaplanmış, karşılaştırma \|Q\| ile (İP-3) |
| D-07 | Tüm modeller · IGBT eşlemesi | Topoloji | Ağustos incelemesindeki "bağlantısız IGBT" sorunu 12.10 modellerinde yok: 12/12 IGBT doğru tabloya bağlı, sarkık blok yok | denetlendi — uygun (diyotlar → D-08) |
| D-08 | Tüm modeller · Diode3/5/6/7 (S2 devresinde Diode4/8/10/11) | **Topoloji / cihaz** | Harici D1–D2 (faz–DA rayı) diyotlarıyla nötr IGBT ters paralel diyotlarının (DS3–DS4) parametre kümeleri **yer değiştirmiş**: D1–D2'de IXYN iç diyotu, DS3–DS4'te DSEI var | doğrulandı — etki S3'te −%0,15, S1'de −%0,9 P_ac; İP-4 tabanı `*_d08` |
| D-09 | Tüm modeller · Capacitor6/7 (EMC X kapasitörü) | Parametre | X kapasitörü `C_emc_aux` = 1 µF ile modellenmiş; m-dosyasının kendi tek faz eşdeğeri `EMC_Cx_eq` = 0,5 µF / `EMC_Rx_eq` = 0,2 Ω hiç kullanılmıyor | doğrulandı — S3'te ölçülen ΔQ₁ −2,5 var, ΔP_ac +%0,3 (İP-4) |
| D-10 | Tüm modeller · IGBT/diyot ısıl ve eşik parametreleri | Parametre (izlenebilirlik) | `Vth = 6`, ısıl ağ dizileri ve diyot `Tdevice = 25` değişken yerine sayı olarak yazılmış; m-dosyasındaki karşılıkları kullanılmıyor. Değerler aynı, sonuca etkisi yok | doğrulandı (29.10.2026) — değerler m-dosyasıyla aynı, sayısal etki yok; değişkene bağlama yapılmadı, tezde Kesim 3.8 izlenebilirlik notunda |
| D-12 | `inverter_s1s2_s2onarim_d08.slx` · iki bağımsız devre | Paket (koşu yöntemi) | İki fiziksel ağ aynı ode15s çözücüsünü paylaşıyor; 0,1 s koşu ~4 saat. Diğer devre `Commented = 'on'` yapılarak ayrık kopyalar koşturuldu | doğrulandı — fark P_ac ≤ %0,017, Q₁ ≤ 0,02 var; süre 22–69 dk. Tezde yer almaz |
| D-11 | `inverter_common_parameters.m` · `Cdc_pos/Cdc_neg` (S4) | **Parametre / topoloji boyutu** | 2 × 470 µF DC bara, 25 A'da orta noktayı ±120 V salındırıyor; S4 akımı hedefin %32 altında, modülasyon doyumda. Ümit'in "20 A civarı" tavanı bu | doğrulandı — 2 × 5,6 mF ile PI 25 A: −%31,9 → −%2,1, doyum %20,6 → %0, THD %57 → %9 |
| D-13 | 12.10 paketindeki üç model ve kopyaları · model CloseFcn | Paket | MathWorks Solar Power Inverter örneğinden kalma geri çağrı, model kapanınca taban çalışma alanından `C` (Cf) ve `L`'yi siliyor | doğrulandı — betik düzeltmesi bütün İP-5/İP-6 koşularında kullanıldı; koşu sonuçlarına etkisi yok, tezde yer almaz |
| D-14 | 12.10 modelleri ve kopyaları · ölçüm blokları, PWM Generator, nötr kapı sürücüleri, çözücü ayarları | Parametre (izlenebilirlik) | `Freq = 50`, `Ts = 1/fsw/100`, `uHigh = 4`/`uLow = 3`, `LocalSolverSampleTime = 1e-7`, powergui `SampleTime = 50e-6`, `MinStep = auto` değişken yerine sayı olarak yazılmış; değerler m-dosyasıyla aynı ya da etkisiz | doğrulandı (29.10.2026) — değerler m-dosyasıyla aynı ya da etkisiz, sayısal etki yok; değişkene bağlama yapılmadı, tezde Kesim 3.8 izlenebilirlik notunda |

## Ayrıntılı kayıtlar

### D-01 — S2 devresinde kapı sinyali yok

- **Dosya / blok:** `incoming_real_data/models/2026-10-12_dort_senaryo_paketi/inverter_scenario1_parametric5_etiquetli.slx`
  - Gate Drive1–4 (IGBT4–7, `Voltage Source1` = `Vdc2`, `Grid2`)
- **Sınıf:** Kapı/denetim
- **Sorun ve kanıt:**
  - Gate Drive1/2/3/4 içindeki `DeadTime_g*` From blokları `g32/g22/g12/g42`
    etiketlerini okuyor.
  - Modelde yalnız `Subsystem` (tek PWM, `Sine Wave1` → `K11`) çıkışlarından
    üretilen global `g11/g21/g31/g41` Goto blokları var.
  - 27.10.2026 değiştirilmemiş koşusunda S2 devresinin değerleri:
    - Idc = 2,9 mA
    - P_dc = 1,1 W
    - P_ac = −0,44 W
    - I_ac = 0,35 A (yalnız filtre kapasitörünün reaktif akımı, Q = 41,5 var)
  - Kanıt dosyaları:
    - `runs/2026-10-27_dort_senaryo_ilk_kosu/results/inverter_scenario1_parametric5_etiquetli/display_degerleri_eslesik.csv`
    - `review/2026-10-27_DORT_SENARYO_ILK_KOSU.md`
- **Teslim notuyla çelişki:**
  - 06.10 e-postası (`dosyalar/06_UMIT_ABIDEN_GELENLER/2026-10-06_tez_06102026_paketi/mail.txt`)
    S1 ve S2'nin aynı dosyada, parametreleri ayrılmış ve anahtarlamaları farklı
    olduğunu söylüyor. Aynı e-posta, parametrelerin m-dosyasından doğru okunup
    okunmadığının kontrol edilmesini istiyor.
  - Teslim edilen dosyada ise S2'ye ait farklı bir anahtarlama yolu yok ve `K12`
    ile `phase_deg2` okunmuyor.
  - S1+S2 modelinin tek bir sürümü teslim edildi (06.10, SHA-256 `4310758c…`). Ümit'in
    S2'yi koşturduğu sürüm büyük olasılıkla bu dosyaya kaydedilmemiş.
- **Tez kapsamındaki doğru durum (K-03, K-04):** S2 = nötr IGBT'lerde tamamlayıcı
  anahtarlama iptal, alternans boyunca 1/0. Genlik `K12`, faz `phase_deg2` (m-dosyası
  yorumu: "K12 = Senaryo 2'nin K1'i").
- **Düzeltme:** S3 modelindeki susturmalı PWM alt sistemi S2 devresine kopyalanır.
  - Sin³ dalı K3 = 0 yapılır.
  - Girişine `phase_deg2` fazlı ayrı bir sinüs referansı ve `K12` kazancı bağlanır.
  - Çıkışlarına `g12/g22/g32/g42` global Goto blokları eklenir.
  - Betik: `scripts/fix_s2_gate_path_20261027.m`
  - Çıktı modeli: `runs/2026-10-27_s2_kapi_onarimi/model/inverter_s1s2_s2onarim.slx`
  - Eklenen üst düzey bloklar (11): `S2 Sine Wave`, `S2 K1` (= `K12`), `S2 K3` (= 0),
    `S2 sin2`, `S2 sin3`, `S2 Sum`, `S2 PWM susturma` (S3 modelinden kopya) ve
    `S2 Goto g12/g22/g32/g42`.
  - Mevcut bloklardan hiçbiri silinmedi ya da yeniden adlandırılmadı.
  - Modele PreLoadFcn eklendi (D-03).
- **Doğrulama:** Ayrıntı: `runs/2026-10-27_s2_kapi_onarimi/inspection/fix_s2_denetim.txt`
  ve `s2_kapi_mantik_testi.csv`.
  - Her etiket için tek Goto ve tek From var.
  - g12 → IGBT4 (S1, `S12`), g22 → IGBT5 (S2, `S12`), g32 → IGBT7 (S4, `S34`),
    g42 → IGBT6 (S3, `S34`). Eşleme A devresiyle aynı.
  - Derleme başarılı.
  - Kapı mantığı testi (0–40 ms):

    | Alternans | g12 | g22 | g32 | g42 |
    |---|---|---|---|---|
    | Pozitif | PWM (160 geçiş, ort. 0,596) | 0 | 0 | 1 |
    | Negatif | 0 | PWM | 1 | 0 |

  - Nötr IGBT'ler alternans boyunca sabit 1/0 kalıyor; bu, K-03'teki susturma tanımıdır.
  - Hiçbir kapı çiftinde örtüşme yok.
- **Etki** (D-01 + D-08 modeliyle, `review/2026-10-27_D08_DIYOT_ESLEME.md` Tablo 5):
  - S2 devresi ilk kez anahtarlıyor: P_dc 1,1 → 286,6 W, P_ac −0,4 → 269,6 W,
    I_ac 0,35 → 2,57 A.
  - Hedefe göre: η 94,07 % (hedef 94,2 %), kayıp P_dc − P_ac 16,99 W (hedef 16,98 W),
    THD %56,7 (hedef %47), |Q| 29,1 var (hedef bandı 24,1–26,7 var).
  - P_ac ve I_ac'deki +%6–10 fazlalık S1/S3'teki sistematik fazlalıkla aynı yönde;
    İP-4'te K12/phase_deg2 ile kalibre edilecek.
  - D-08'siz onarılmış modelin tam koşusu 15 saatte bitmedi ve durduruldu
    (28.10.2026); D-01'in doğrulaması D-08'li koşuya dayanır.
- **Durum:** doğrulandı

### D-02 — Senaryo 4 modeli teslim edilmemiş

- **Dosya:** `inverter_senaryo4.slx`
- **Sınıf:** Paket
- **Sorun ve kanıt:**
  - `inverter_senaryo3.slx` ile yalnız ModelUUID ve pencere bilgisi farklı.
  - İkisi de `Vdc3`, `Vac3_peak`, `K13`, `K33` ve `phase_deg3` kullanıyor.
  - Koşu çıktıları bayt bayt aynı.
  - Denetleyici bloğu yok.
  - Kaynak: `runs/2026-10-27_dort_senaryo_ilk_kosu/inspection/inverter_senaryo4.txt`
- **Teslim notuyla çelişki:**
  - 12.10 e-postası (`dosyalar/06_UMIT_ABIDEN_GELENLER/2026-10-12_senaryo3_senaryo4_modelleri/mail.txt`)
    S4'te S3'ün anahtarlama bloğuna giren bloklara ek olarak hata hesabı ve `Kp`
    bulunduğunu, sistemin bu yapıyla 20 A civarına çıktığını söylüyor.
  - Teslim edilen `inverter_senaryo4.slx` dosyasında bu bloklar yok. Büyük olasılıkla
    denetleyici eklenmeden önce kaydedilmiş bir kopya gönderilmiş.
  - Düzeltme, e-postadaki tarifi bire bir uygular.
- **Tez kapsamındaki doğru durum (K-03, K-05):** S4 = S3 + L1 akım geri beslemesi.
  - Önce oransal denetleyici (`Kp = 0.03`, 12.10 e-postası), ardından PI.
  - Çalışma noktası `Vdc4 = 427.5 V`, `Vac4 = 120 V`, hedef 25 A.
- **Düzeltme:** S3 kopyasından betikle S4 kurulur.
  - L1 akım ölçümü ve referans `Ifaz_rms_target(4)·√2·sin θ` eklenir.
  - Hata → Kp (sonra PI) → modülasyon toplamı; Sin³ ileri beslemesi aynı toplama dış giriş olarak bağlanır.
  - Betik: `scripts/build_s4_closed_loop_20261028.m`; çıktı
    `runs/2026-10-28_s4_kapali_cevrim/model/inverter_senaryo4_kc.slx` (taban S3 `*_d08`
    + D-09). Denetleyici K-19 (analog eşdeğeri, 5 kHz ölçüm süzgeci).
- **Etki (28.10.2026, özgün Cdc):**
  - 2,3 A'da S4 çalışıyor:
    - P: I_L1,1 = 2,41 A (+%4,8), THD %8,1, η %97,2
    - PI: 2,38 A (+%3,6), THD %9,9, η %97,3
  - 10 A ve 25 A'da akım hedefin %22–32 altında kalıyor ve modülasyon doyuyor.
    Neden DC bara orta noktası (D-11).
- **Doğrulama (28.10.2026, `KC_*` = D-11 + K-20):**
  - 25 A, doyum yok:
    - PI: 24,47 A (−%2,1), THD %9,2
    - PIR (0,2 s): 24,75 A (−%1,0, +0,2°), THD %8,5
  - 10 → 25 A basamağı: son kararlı zarfa göre aşım %0,2, yerleşme ≈ 0,4 ms
    (İP-6 yeniden tanımı, K-21). İP-5'teki "%7,3" i_L1 tepesinin referans tepesine
    oranıdır; fark kararlı durumdaki 3. harmonikten gelir.
  - 10 A'da P/PI genlik hatası −%23/−%11; PIR −%2,2. THD %20, kaynağı susturmanın
    süreksiz iletimi.
  - Kaynak: `review/2026-10-28_S4_KAPALI_CEVRIM.md`
- **Durum:** doğrulandı

### D-03 — Parametre dosyası yükleme sırası

- **Sınıf:** Paket
- **Sorun ve kanıt:**
  - Simscape diyot parametre türleri InitFcn'den önce çözülüyor.
  - Temiz MATLAB oturumunda "Invalid parameter type set at Qrr/didt … Got type string" hatası alınıyor.
  - Ümit'in oturumunda değişkenler çalışma alanında kaldığı için hata görünmemiş olabilir.
- **Doğru durum:** Model, temiz oturumda tek komutla koşabilmeli.
- **Düzeltme:** Koşu betikleri `inverter_common_parameters.m`'yi `load_system`'dan önce
  taban çalışma alanında çalıştırıyor. Model kopyalarına `PreLoadFcn` eklenmesi
  D-01/D-02 betiklerinde yapılacak.
  - Betik: `scripts/run_umit_dort_senaryo_20261027.m`
- **Etki:** Devre sonucuna etkisi yok; yalnız tekrar üretilebilirlik.
- **Durum:** doğrulandı (29.10.2026) — kalibre kopya modellerde PreLoadFcn var, temiz oturumda derleme başarılı (`runs/2026-10-28_kalibrasyon/inspection/hazirlik.txt`)

### D-04 — Çakışan sinyal kayıt adları

- **Sınıf:** Ölçüm
- **Sorun:** Aynı `DataLoggingName` birden çok hatta kullanılıyor (ör. `Idc_s1`).
- **Düzeltme:** Display ↔ kayıt eşlemesi ada göre değil, kaynak blok yolu ve port
  numarasına göre yapılıyor.
  - Betik: `scripts/extract_umit_display_values_20261027.m`
- **Durum:** doğrulandı (29.10.2026) — aynı eşlemeyle yinelenen koşu, kalibrasyon değerlerini 6 basamak aynı verdi

### D-05 — Kullanılmayan parametreler

- **Sınıf:** Parametre
- **Sorun:** `Kp = 0.03`, `K12 = 0.794`, `phase_deg2 = 0` ve `L1_core_Rp4 = 1500` m-dosyasında
  tanımlı, hiçbir blokta kullanılmıyor (inceleme betiğinin diyalog parametresi taraması).
- **Düzeltme:**
  - `K12` ve `phase_deg2` D-01 ile bağlanır.
  - `Kp` D-02 ile bağlanır.
  - `L1_core_Rp4` S4 yüksek akım çekirdek kaybı için D-02'de değerlendirilir (K-14).
- **Uygulama (28.10.2026, İP-5):** `Kp` S4 denetleyicisine bağlandı; `L1_core_Rp4`
  = 1500 Ω S4'te `L1 Core Loss Rp`'ye bağlandı; `K14`, `K34`, `phase_deg4`, `Vdc4`,
  `Vac4_peak` S4'te kullanılıyor (`scripts/build_s4_closed_loop_20261028.m`).
  `K12` ve `phase_deg2` D-01 ile bağlıydı.
- **Durum:** kapandı

### D-06 — Reaktif güç işareti

- **Sınıf:** Ölçüm
- **Sorun:**
  - Benzetimde S1 için Q = +34,7 var, S3 için +33,0 var.
  - Deney tablosunda S1 için Q = 0, S3 için −21,83 var; cosφ değerleri −0,995 / −0,997.
  - Benzetimdeki büyüklük, filtre kapasitörünün 120 V'taki reaktif gücüne (~43 var) yakın.
- **Düzeltme (K-02):**
  - Q ve cosφ, kayıtlı `v_ac`/`i_ac` dalga biçimlerinden (0,06–0,10 s, temel bileşen
    fazörü) yeniden hesaplandı.
  - Model blokları C noktasında (evirici çıkış uçları, EMC sonrası, L2 öncesi)
    üretici kuralını kullanıyor:
    - akım sensörü dönüş iletkeninde, pozitif yön Grid− → evirici;
    - ⟨v·i⟩ = +298,9 W;
    - Power3 Q = Im{V·I*} (dalgadan +32,90 var, blok +32,89 var).
  - Benzetimdeki +Q, akımın gerilimin 6,3° gerisinde olduğu durumdur. Kaynağı filtre
    kapasitörleridir (Cf ≈ 39 var, X kapasitörü ≈ 5 var). Köprü çıkışında (A noktası)
    Q ≈ −6…−10 var.
  - Deney tablosundaki Qo ölçülmemiş, Po·tan(arccos cosfi) ile hesaplanmıştır. Eksi
    işaret analizörün cosφ göstergesinden gelir; analizörün kuralı belgede olmadığı
    için işaret yorumlanmaz.
  - Deneydeki cosfi temel bileşen yer değiştirme faktörüdür (cosφ₁); S2'de
    cosφ₁/√(1+THD²) = P/(V·I) ile tutarlı.
  - Karşılaştırma C noktasında |Q| ve |cosφ₁| üzerinden, cosfi yuvarlama bandıyla
    yapılır: S1 0–7,9 var, S2 24,1–26,7 var, S3 19,9–23,6 var.
  - Tezde cosφ₁ (yer değiştirme) ile PF = P/S ayrı adlandırılır.
- **Etki:**
  - Model değişikliği yok; sayısal sonuç değişmiyor.
  - Kalibrasyonsuz benzetim–deney |Q| farkı S1'de ~26 var, S3'te ~10 var. Bu fark
    %0,04–0,12 genlik farkına karşılık gelir; bu tahmin sert kaynak varsayımına
    dayanıyordu.
  - İP-4'te |Q| farkı kapandı, ancak genlikle değil, **fazla** (K-02b): S1 1,93 var,
    S2 24,43 var, S3 21,41 var; üçü de bant içinde.
  - Kanıt: `review/2026-10-27_Q_ISARET_ANALIZI.md`, `runs/2026-10-27_q_isaret_dalga/`,
    `review/2026-10-28_KALIBRASYON_S1_S3.md`.
- **Durum:** kapandı (ölçüm kuralı); sayısal uyum İP-4'te sağlandı.

### D-08 — Harici diyotlarla nötr kol diyotlarının parametreleri yer değiştirmiş

- **Dosya / blok:** 12.10 paketinin üç modeli.
  - S1+S2 A devresi, S3 ve S4: `Diode5` (faz → DA+), `Diode3` (DA− → faz),
    `Diode6`/`Diode7` (S3/S4 nötr IGBT ters paralel).
  - S1+S2 B (S2) devresi: `Diode8`/`Diode4` ve `Diode10`/`Diode11`.
- **Sınıf:** Topoloji / cihaz eşlemesi
- **Sorun ve kanıt:**
  - `Diode3` (A = DA−, K = faz) ve `Diode5` (A = faz, K = DA+), D1–D2 harici diyot
    konumunda; ikisi de `DS34_*` (IXYN100N65C3H1 iç FRD) parametrelerini kullanıyor.
  - `Diode6` (A = nötr ortak emetör, K = orta nokta) ve `Diode7` (A = ortak emetör,
    K = faz), S3/S4 ters paralel konumunda; ikisi de `D12_*` (DSEI2x61-12B)
    parametrelerini kullanıyor.
  - Kanıt dosyaları:
    - `tez-matlab-simulink/runs/2026-10-27_topoloji_denetimi/*_bacak_eslemesi.txt`
      (bağlantı grafiğinden otomatik çıkarım)
    - `*_cihaz_eslemesi.csv`
    - `tez-matlab-simulink/review/2026-10-27_TOPOLOJI_DENETIMI.md`
  - Bu eşleme üç kaynakla çelişiyor:
    - m-dosyasının kendi başlıkları ("HARICI D1-D2 DIYOTLARI" = DSEI;
      "S3-S4 PARALEL DIYOTLARI" = IXYN FRD)
    - tam topoloji şeması (D1–D2 DSEI faz–ray konumunda)
    - gerilim sınıfı: faz–ray diyotları tam Vdc'yi keser ve 1200 V DSEI gerekir;
      nötr kol diyotları en çok Vdc/2'yi keser ve 650 V IXYN yeterlidir
- **Kaynağa ilişkin not:**
  - Aynı yanlış eşleme bizim 26.08.2026 notumuzda da var
    (`review/2026-08-26_R2025B_SENARYO1_DOGRULAMA.md`: "D1-D2 … modelde Diode6 ve Diode7").
  - `tez-latex-v2/chapters/03-sistem-model-metodoloji.tex` satır 497'deki
    `tab:yariiletken-esleme` tablosunda da aynı eşleme var.
  - Ümit DSEI parametrelerini bu eşlemeye göre girmiş olabilir. Hata yalnız
    gelen dosyaya ait değil; tezdeki tablo da düzeltilecek (İP-8).
- **Tez kapsamındaki doğru durum:** D1–D2 = DSEI2x61-12B (`D12_*`) faz–ray konumunda;
  DS3–DS4 = IXYN iç FRD (`DS34_*`).
- **Düzeltme:** Bağlantıya dokunmadan yalnız diyot parametre önekleri takas edilir.
  - `Diode3`, `Diode5`, `Diode4`, `Diode8`: `DS34_*` → `D12_*`
  - `Diode6`, `Diode7`, `Diode10`, `Diode11`: `D12_*` → `DS34_*`
  - Betik: `scripts/fix_diode_mapping_20261027.m`. Her diyodun rolü bağlantı
    grafiğinden çıkarılır, yalnız yanlış önekli 18 diyalog parametresi yeniden
    yazılır. Modele PreLoadFcn eklenir (D-03).
  - Çıktılar: `runs/2026-10-27_diyot_esleme/model/inverter_senaryo3_d08.slx` ve
    `inverter_s1s2_s2onarim_d08.slx`.
- **Etki** (`review/2026-10-27_D08_DIYOT_ESLEME.md`):
  - S3: P_ac −0,46 W (−%0,15), η −0,04 puan; DS3/DS4 kaybı diyot başına
    0,59 → 0,63 W. Çalışma noktası pratikte değişmiyor.
  - S1: P_ac −2,40 W (−%0,9), I_ac −%1,3, η +0,07 puan. Etki S3'tekinin yaklaşık on
    katı; S1'de nötr kol tamamlayıcı anahtarlandığından DS3/DS4 her periyotta
    toparlanmaya giriyor.
  - Kararlı çalışmada D1–D2 iletime girmiyor (yalnız bağlantı kapasitesi akımı).
  - Hedeften sapmanın kaynağı D-08 değil; İP-4'te kapanacak.
- **Durum:** doğrulandı — İP-4 taban modeli `*_d08` modelleridir

### D-09 — EMC X kapasitörü m-dosyasındaki eşdeğerle modellenmemiş

- **Sınıf:** Parametre
- **Sorun:** `Capacitor6`/`Capacitor7` (iki ortak kip bobini arasındaki hat–dönüş
  kapasitörü) `C_emc_aux` = 1 µF ve `R_emc_aux` = 0,01 Ω kullanıyor. Oysa m-dosyası
  X2 ağını "iki adet 1 µF/0,1 Ω seri kol, yüzer orta nokta" diye tanımlıyor ve tek faz
  eşdeğerini `EMC_Cx_eq` = 0,5 µF, `EMC_Rx_eq` = 0,2 Ω olarak hesaplıyor. Bu iki
  değişken hiçbir blokta kullanılmıyor.
- **Doğru durum (K-17):** Tek faz modelde X ağı `EMC_Cx_eq`/`EMC_Rx_eq` ile temsil edilir.
- **Düzeltme:** `Capacitor6`/`Capacitor7`: `c = EMC_Cx_eq`, `r = EMC_Rx_eq`.
- **Etki (hesap, İP-3 ağ modeli):**
  - Açık çevrimde (modülasyon ve şebeke gerilimi sabit) C noktasında ΔQ ≈ −0,9 var
    (S1 −0,86, S3 −0,92); ΔP ≈ +0,07 W.
  - Farkın kalanı köprü tarafına gider: S3'te Q_A −9,79 → −8,28 var.
  - Evirici akımı sabit tutulduğunda üst sınır ΔQ ≈ −2,3/−2,4 var.
  - P'ye etkisi ihmal edilebilir.
- **Ölçülen etki (İP-4, 28.10.2026):** S3, kalibrasyonsuz; `runs/2026-10-28_kalibrasyon/results/s3_k0`
  ile D-08 koşusu karşılaştırıldı.
  - P_ac +0,91 W (+%0,31), Q₁ −2,50 var, I_ac +%0,21, η +0,006 puan, THD +0,02 puan.
  - Q₁ etkisi açık çevrim ağ hesabının (−0,92 var) değil, "evirici akımı sabit"
    üst sınırının (−2,43 var) düzeyinde. Nedeni, susturmalı köprünün sert bir gerilim
    kaynağı olmaması (K-02b).
  - S1/S2'de ayrıca ölçülmedi; kalibrasyon D-09'lu modellerle yapıldı.
  - Kaynak: `review/2026-10-28_KALIBRASYON_S1_S3.md`
- **Durum:** doğrulandı

### D-10 — Sabit yazılmış eşdeğer değerler

- **Sınıf:** Parametre (izlenebilirlik)
- **Sorun:**
  - IGBT `Vth = 6`, ısıl ağ dizileri ve diyot `Tdevice = 25` değişken yerine sayı
    olarak yazılmış; m-dosyasının `S12/S34_Vge_threshold` ve `S*_thermal_*`
    değişkenleri kullanılmıyor.
  - Dış kol orta düğümü ile faz arasındaki seri `Resistor` (donanımdaki RL2 röle
    kontağı), DA kaynak direnciyle aynı `Rdc` değişkenini paylaşıyor.
- **Düzeltme:** İP-7 parametre tablosunun tek kaynaklı olması için değişkenlere
  bağlanır. Değerler aynı olduğundan sonuç değişmez.
- **Durum:** doğrulandı (29.10.2026) — değer eşitliği; sayısal etki yok, değişkene bağlama yapılmadı

### D-11 — DC bara kapasitörleri anma akımında orta noktayı tutamıyor

- **Dosya / blok:** `inverter_common_parameters.m` · `Cdc_pos`, `Cdc_neg` (= 470 µF);
  S4 modeli `inverter_senaryo4_kc.slx` (S3 devresi)
- **Sınıf:** Parametre (topoloji boyutlandırması)
- **Sorun ve kanıt:**
  - Tek faz T-tipi bacakta şebeke dönüş akımı DC bara orta noktasına girer. Bu yüzden
    50 Hz faz akımının tamamı iki kapasitörün paralel eşdeğerinden geçer:
    ΔV_orta,tepe ≈ Î/(ω·(C₊ + C₋)).
  - 2 × 470 µF ile orta nokta salınımı şöyle:

    | Faz akımı | Orta nokta salınımı (tepe) | Vdc/2'ye oranı |
    |---|---|---|
    | 2,3 A | ≈ 11 V | %5 |
    | 10 A | ≈ 48 V | %22 |
    | 25 A | ≈ 120 V | %56 |

  - 28.10.2026 S4 taraması (`runs/2026-10-28_s4_kapali_cevrim/results/`, özgün Cdc):
    - 2,3 A'da izleme iyi: P %4,8, PI %3,6 genlik hatası; THD %8–10.
    - 10 A'da hata büyüyor: P −%22, PI −%28.
    - 25 A'da PI −%32; modülasyon %21 oranında doyumda (u_top tepe 2,1), THD %57.
  - Dalga biçiminde evirici darbe yüksekliği pozitif alternans boyunca ~270 V'tan
    ~100 V'a iniyor: üst kapasitör boşalıyor, alttaki doluyor.
  - Evirici bu durumda gereken gerilimi üretemiyor; denetleyici doyuma gidiyor.
  - Bu tavan, 12.10 e-postasındaki "sistem 20 A civarına çıkıyor" gözlemiyle uyumlu.
- **Tez kapsamındaki doğru durum (K-05):**
  - Jüri maddesi 8, 25 A anma noktasında kapalı çevrimin gösterilmesini istiyor.
  - Laboratuvar deneyleri yalnız ~2,3 A'da yapıldı (470 µF orada yeterli).
  - Anma akımı benzetimi, orta noktayı tutabilen bir DC bara ile yapılmalı. Yarım
    köprü tipi bacakta orta nokta salınımı genellikle Vdc/2'nin ≲ %5'inde tutulur.
- **Düzeltme:**
  - Yalnız S4 koşularında: `Cdc_pos = Cdc_neg = 5,6 mF`.
  - Hesap: C₊ + C₋ ≥ 35,4 A / (314 rad/s · 10,7 V) = 10,5 mF. 25 A'da ≈ 10 V
    salınım, Vdc/2'nin %4,7'si.
  - Uygulama: `run_s4_closed_loop_20261028.m` içinde `opts.Cdc` değeri, bellekteki
    modelin InitFcn'inin sonuna eklenir. m-dosyası ve ham paket değişmez.
  - İlk deneme (`Cb_*`, 14:35–16:07) geçersiz. Değer yalnız taban çalışma alanına
    yazılmıştı; InitFcn parametre dosyasını yeniden çalıştırıp 470 µF'a döndürdü.
    Sonuçlar özgün koşularla bayt bayt aynı çıktı. Bu koşular
    `results/_gecersiz_Cb_InitFcn_ezdi/` altında, `OKU.txt` notuyla saklanıyor.
  - Kesin koşular `KC_*` adlarını taşır: D-11 ile K-20'nin kalibre S3 ileri beslemesi
    birlikte uygulanır. Üç paralel kuyruk, ayrı `model_a|b|c` kopyalarında çalışır.
  - Özgün Cdc'li koşular sınırlılık kanıtı olarak saklanır.
- **Tezde:**
  - Bölüm 3 model düzeltme kesimi ve Bölüm 8 sınırlılık: "anma akımı sonuçları
    boyutlandırılmış DC bara ile; deney donanımının 470 µF barası 25 A için yetersiz".
- **Etki** (`review/2026-10-28_S4_KAPALI_CEVRIM.md`, Tablo 1 ↔ Tablo 3):

  | PI denetleyici | 2 × 470 µF | 2 × 5,6 mF |
  |---|---|---|
  | 25 A genlik hatası | −%31,9 | −%2,1 |
  | 25 A doyum oranı | %20,6 | %0 |
  | 25 A THD | %57,4 | %9,2 |
  | 25 A oturma (dP_ac/periyot) | −%31 | +%0,06 |
  | 2,3 A genlik hatası | +%3,6 | +%1,2 (K-20 ile birlikte) |

- **Durum:** doğrulandı

### D-12 — S1+S2 birleşik modelinin ayrık kopyalarla koşturulması

- **Dosya / blok:** `runs/2026-10-27_diyot_esleme/model/inverter_s1s2_s2onarim_d08.slx`
- **Sınıf:** Paket (koşu yöntemi)
- **Sorun:** İki bağımsız fiziksel ağ (S1 ve S2 devreleri) aynı ode15s çözücüsünü
  paylaşıyor. Bir 0,1 s koşusu ~4 saat sürüyor; D-08'siz koşu 15 saatte bitmedi.
- **Düzeltme:** `calibrate_s1s3_20261028('prepare')`, diğer devrenin bağlantı bileşenini
  (çizgiler + global Goto/From) `Commented = 'on'` yapar; blok silinmez.
  - Çıktı: `runs/2026-10-28_kalibrasyon/model_s1|model_s2/`
  - Kalan blok sayısı: S1 tarafında 128, S2 tarafında 132.
- **Etki:** ayrık ve birleşik model farkı P_ac'da ≤ %0,017, Q₁'de ≤ 0,02 var, η'da ≤ 0,001 puan.
  Süre 4 sa → 22–69 dk. Kaynak: `review/2026-10-28_KALIBRASYON_S1_S3.md` Tablo 1.
- **Tezde:** yer almaz (yalnız yöntem).
- **Durum:** doğrulandı

### D-13 — Model CloseFcn'i taban çalışma alanından `C` ve `L`'yi siliyor

- **Dosya / blok:** 12.10 paketindeki `inverter_scenario1_parametric5_etiquetli`,
  `inverter_senaryo3`, `inverter_senaryo4` ve bunlardan türetilen bütün kopyaların model
  CloseFcn'i: `try,close(h1_SolarPowerInverter),end … clear C L efficiency f_pwm …`
  (MathWorks "Solar Power Inverter" örneğinden kalma).
- **Sınıf:** Paket
- **Sorun ve kanıt:** Model kapanınca taban çalışma alanındaki `C` (= Cf, 8 µF) ve `L`
  silinir. İP-6'da S4 modelinden blok kopyalayıp modeli kapattıktan sonra yeni modelin
  derlemesi "Unrecognized function or variable 'C'" hatası verdi
  (`ortalama_model_kararlilik_20261028.m`, `kur`). Geri çağrının ham pakette de olduğu
  `blockdiagram.xml` taramasıyla doğrulandı (üç dosyada 4'er eşleşme).
- **Tez kapsamındaki doğru durum:** Model kapanışı parametreleri değiştirmemeli (D-03'teki
  tekrar üretilebilirlik ilkesi).
- **Düzeltme:** Model değiştirilmez; betikler model kapandıktan sonra parametre dosyasını
  yeniden çalıştırır (`taban()`).
- **Etki:** Koşu sonuçlarına etkisi yok; koşu betikleri modeli en sonda kapatır.
  Kaynak: `review/2026-10-28_KARARLILIK_BODE.md`, "Önerilen kayıtlar".
- **Tezde:** yer almaz.
- **Durum:** doğrulandı — betik düzeltmesi bütün koşularda kullanıldı, sonuca etkisi yok

### D-14 — Model düzeyinde sabit yazılmış ölçüm ve çözücü ayarları (D-10'un genişletilmesi)

- **Dosya / blok:** 12.10 modelleri ve bütün kopyaları:
  - Mean/RMS/THD blokları `Freq = 50` (`f_grid` değil);
  - PWM Generator `Ts = 1/fsw/100` (`pwm_ref_Ts` değil);
  - nötr kapı sürücüleri `uHigh = 4`, `uLow = 3` (`gate_logic_*` yerine sayı);
  - Solver Configuration `LocalSolverSampleTime = 1e-7` (yerel çözücü kapalı, etkisiz);
  - powergui `SampleTime = 50e-6` (sürekli kipte etkisiz);
  - `MinStep = auto` (`sim_min_step` = 1 ns kullanılmıyor).
- **Sınıf:** Parametre (izlenebilirlik)
- **Sorun:** Değerler m-dosyasından izlenemiyor; `f_grid` ya da `fsw` değişirse ölçüm
  pencereleri ve PWM örneklemesi kendiliğinden güncellenmez.
- **Tez kapsamındaki doğru durum:** Tek parametre kaynağı (K-09, K-22).
- **Düzeltme:** Gerekmez; mevcut değerler m-dosyası değerleriyle aynı ya da etkisiz.
  Tabloda "benzetim seçimi" olarak yazıldı.
- **Etki:** yok. Kaynak: `review/2026-10-28_PARAMETRE_TABLOSU.md`,
  `runs/2026-10-28_parametre_tablosu/sabit_sayi_parametreleri.csv`.
- **Tezde:** yer almaz.
- **Durum:** doğrulandı (29.10.2026) — değer eşitliği ya da etkisizlik; sayısal etki yok, değişkene bağlama yapılmadı

### D-07 — Cihaz eşlemesi denetimi

- **Sınıf:** Topoloji
- **Doğru durum:** Tez ve tam topoloji şemasına göre cihaz eşlemesi:
  - Dış anahtarlar S1–S2: SKM100GB12T4
  - Nötr anahtarlar S3–S4: IXYN100N65C3H1
  - Harici diyotlar D1–D2: DSEI2x61-12B
  - Filtre: L1 = 600 µH, Cf = 8 µF, L2 = 1000 µH (12.10 m-dosyası)
- **Yapılacak:** 12.10 modellerinde her IGBT/diyot bloğunun parametre kaynağını
  (S12 ya da S34 tabloları) ve bağlantısını betikle çıkarıp bu eşlemeyle karşılaştırmak.
  Uymayan her blok ayrı D-xx kaydı alır.
- **Sonuç (27.10.2026, İP-2):**
  - 12 IGBT'nin tamamı doğru tabloya bağlı: dış kollar `S12`, nötr kollar `S34`.
  - Sarkık blok yok.
  - T-tipi bacak bağlantısı tam topoloji şemasıyla örtüşüyor.
  - Diyot eşlemesindeki sorun D-08'e taşındı.
  - Kaynak: `review/2026-10-27_TOPOLOJI_DENETIMI.md`
- **Durum:** denetlendi — IGBT'ler uygun
