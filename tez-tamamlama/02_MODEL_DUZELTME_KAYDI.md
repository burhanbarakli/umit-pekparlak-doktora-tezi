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
| D-01 | `inverter_scenario1_parametric5_etiquetli.slx` · Gate Drive1–4 | Kapı/denetim | S2 devresinin kapı sürücüleri `g12…g42` etiketlerini okuyor, bu etiketleri üreten Goto yok; S2 IGBT'leri hiç anahtarlanmıyor | açık — betik hazırlanıyor |
| D-02 | `inverter_senaryo4.slx` | Paket | Dosya S3 modelinin kopyası; S4'ün L1 akım geri beslemeli denetleyicisi yok | açık |
| D-03 | Dört modelin tümü · model geri çağrıları | Paket | Parametre dosyası yalnız InitFcn'de çalışıyor, PreLoadFcn yok; temiz oturumda Simscape diyotları "Qrr/didt … type string" hatasıyla derlenmiyor | düzeltildi (koşu betiğinde) |
| D-04 | S1+S2 ve S3 · sinyal kayıt adları | Ölçüm | Farklı hatlar aynı kayıt adını taşıyor (ör. `Idc_s1`); ada göre okunan değer yanlış hatta ait olabiliyor | düzeltildi (çıkarım betiğinde) |
| D-05 | `inverter_common_parameters.m` | Parametre | `Kp`, `K12`, `phase_deg2`, `L1_core_Rp4` tanımlı ama hiçbir blokta kullanılmıyor | açık — D-01 ve D-02 ile kapanacak |
| D-06 | S1, S3 · Power blokları | Ölçüm | Benzetimde Q pozitif (+33…+35 var), deney tablosunda Q negatif ya da sıfır; yön kuralı belgelenmemiş | açık — K-02'ye göre işaret dalga biçiminden belirlenecek |
| D-07 | Tüm modeller · cihaz eşlemesi | Topoloji | Ağustos incelemesinde veri sayfası parametreli IGBT bloklarının bir kısmının etkin devreye bağlı olmadığı görülmüştü. 12.10 modellerinde S1–S2 SKM100, S3–S4 IXYN ve D1–D2 DSEI eşlemesi henüz denetlenmedi. | açık — topoloji denetimi (İP-2) |

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
- **Tez kapsamındaki doğru durum (K-03, K-04):** S2 = nötr IGBT'lerde tamamlayıcı
  anahtarlama iptal, alternans boyunca 1/0. Genlik `K12`, faz `phase_deg2` (m-dosyası
  yorumu: "K12 = Senaryo 2'nin K1'i").
- **Düzeltme:** S3 modelindeki susturmalı PWM alt sistemi S2 devresine kopyalanır.
  - Sin³ dalı K3 = 0 yapılır.
  - Girişine `phase_deg2` fazlı ayrı bir sinüs referansı ve `K12` kazancı bağlanır.
  - Çıkışlarına `g12/g22/g32/g42` global Goto blokları eklenir.
  - Betik: `scripts/fix_s2_gate_path_20261027.m` (hazırlanıyor).
- **Etki:** — (onarılmış koşudan sonra doldurulacak)
- **Durum:** açık

### D-02 — Senaryo 4 modeli teslim edilmemiş

- **Dosya:** `inverter_senaryo4.slx`
- **Sınıf:** Paket
- **Sorun ve kanıt:**
  - `inverter_senaryo3.slx` ile yalnız ModelUUID ve pencere bilgisi farklı.
  - İkisi de `Vdc3`, `Vac3_peak`, `K13`, `K33` ve `phase_deg3` kullanıyor.
  - Koşu çıktıları bayt bayt aynı.
  - Denetleyici bloğu yok.
  - Kaynak: `runs/2026-10-27_dort_senaryo_ilk_kosu/inspection/inverter_senaryo4.txt`
- **Tez kapsamındaki doğru durum (K-03, K-05):** S4 = S3 + L1 akım geri beslemesi.
  - Önce oransal denetleyici (`Kp = 0.03`, 12.10 e-postası), ardından PI.
  - Çalışma noktası `Vdc4 = 427.5 V`, `Vac4 = 120 V`, hedef 25 A.
- **Düzeltme:** S3 kopyasından betikle S4 kurulur.
  - L1 akım ölçümü ve referans `Ifaz_rms_target(4)·√2·sin θ` eklenir.
  - Hata → Kp (sonra PI) → modülasyon toplamı; Sin³ ileri beslemesi aynı toplama dış giriş olarak bağlanır.
  - Betik: `scripts/build_s4_closed_loop_20261027.m` (planlandı).
- **Etki:** —
- **Durum:** açık

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
- **Durum:** düzeltildi (koşu betiği), kopya modellerde açık

### D-04 — Çakışan sinyal kayıt adları

- **Sınıf:** Ölçüm
- **Sorun:** Aynı `DataLoggingName` birden çok hatta kullanılıyor (ör. `Idc_s1`).
- **Düzeltme:** Display ↔ kayıt eşlemesi ada göre değil, kaynak blok yolu ve port
  numarasına göre yapılıyor.
  - Betik: `scripts/extract_umit_display_values_20261027.m`
- **Durum:** düzeltildi

### D-05 — Kullanılmayan parametreler

- **Sınıf:** Parametre
- **Sorun:** `Kp = 0.03`, `K12 = 0.794`, `phase_deg2 = 0` ve `L1_core_Rp4 = 1500` m-dosyasında
  tanımlı, hiçbir blokta kullanılmıyor (inceleme betiğinin diyalog parametresi taraması).
- **Düzeltme:**
  - `K12` ve `phase_deg2` D-01 ile bağlanır.
  - `Kp` D-02 ile bağlanır.
  - `L1_core_Rp4` S4 yüksek akım çekirdek kaybı için D-02'de değerlendirilir (K-14).
- **Durum:** açık

### D-06 — Reaktif güç işareti

- **Sınıf:** Ölçüm
- **Sorun:**
  - Benzetimde S1 için Q = +34,7 var, S3 için +33,0 var.
  - Deney tablosunda S1 için Q = 0, S3 için −21,83 var; cosφ değerleri −0,995 / −0,997.
  - Benzetimdeki büyüklük, filtre kapasitörünün 120 V'taki reaktif gücüne (~43 var) yakın.
- **Düzeltme (K-02):**
  - Q ve cosφ, kayıtlı `v_ac`/`i_ac` dalga biçimlerinden temel bileşen faz açısıyla
    yeniden hesaplanır.
  - Tezde üretici kuralı açıkça yazılır.
  - Karşılaştırma büyüklük üzerinden yapılır.
- **Durum:** açık

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
- **Durum:** açık
