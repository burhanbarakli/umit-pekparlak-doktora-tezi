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
| D-01 | `inverter_scenario1_parametric5_etiquetli.slx` · Gate Drive1–4 | Kapı/denetim | S2 devresinin kapı sürücüleri `g12…g42` etiketlerini okuyor, bu etiketleri üreten Goto yok; S2 IGBT'leri hiç anahtarlanmıyor | düzeltildi, kapı mantığı doğrulandı — tam koşu sürüyor |
| D-02 | `inverter_senaryo4.slx` | Paket | Dosya S3 modelinin kopyası; S4'ün L1 akım geri beslemeli denetleyicisi yok | açık |
| D-03 | Dört modelin tümü · model geri çağrıları | Paket | Parametre dosyası yalnız InitFcn'de çalışıyor, PreLoadFcn yok; temiz oturumda Simscape diyotları "Qrr/didt … type string" hatasıyla derlenmiyor | düzeltildi (koşu betiğinde) |
| D-04 | S1+S2 ve S3 · sinyal kayıt adları | Ölçüm | Farklı hatlar aynı kayıt adını taşıyor (ör. `Idc_s1`); ada göre okunan değer yanlış hatta ait olabiliyor | düzeltildi (çıkarım betiğinde) |
| D-05 | `inverter_common_parameters.m` | Parametre | `Kp`, `K12`, `phase_deg2`, `L1_core_Rp4` tanımlı ama hiçbir blokta kullanılmıyor | açık — D-01 ve D-02 ile kapanacak |
| D-06 | S1, S3 · Power blokları | Ölçüm | Benzetimde Q pozitif (+33…+35 var), deney tablosunda Q negatif ya da sıfır; yön kuralı belgelenmemiş | açık — K-02'ye göre işaret dalga biçiminden belirlenecek |
| D-07 | Tüm modeller · IGBT eşlemesi | Topoloji | Ağustos incelemesindeki "bağlantısız IGBT" sorunu 12.10 modellerinde yok: 12/12 IGBT doğru tabloya bağlı, sarkık blok yok | denetlendi — uygun (diyotlar → D-08) |
| D-08 | Tüm modeller · Diode3/5/6/7 (S2 devresinde Diode4/8/10/11) | **Topoloji / cihaz** | Harici D1–D2 (faz–DA rayı) diyotlarıyla nötr IGBT ters paralel diyotlarının (DS3–DS4) parametre kümeleri **yer değiştirmiş**: D1–D2'de IXYN iç diyotu, DS3–DS4'te DSEI var | açık — **yüksek öncelik**, kalibrasyondan önce |
| D-09 | Tüm modeller · Capacitor6/7 (EMC X kapasitörü) | Parametre | X kapasitörü `C_emc_aux` = 1 µF ile modellenmiş; m-dosyasının kendi tek faz eşdeğeri `EMC_Cx_eq` = 0,5 µF / `EMC_Rx_eq` = 0,2 Ω hiç kullanılmıyor | açık — K-17 |
| D-10 | Tüm modeller · IGBT/diyot ısıl ve eşik parametreleri | Parametre (izlenebilirlik) | `Vth = 6`, ısıl ağ dizileri ve diyot `Tdevice = 25` değişken yerine sayı olarak yazılmış; m-dosyasındaki karşılıkları kullanılmıyor. Değerler aynı, sonuca etkisi yok | açık — düşük öncelik |

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
- **Etki:** — (tam koşu sürüyor)
- **Durum:** düzeltildi; tam koşu bekleniyor

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
  - Betik: `scripts/fix_diode_mapping_20261027.m` (planlandı)
- **Etki:** Henüz ölçülmedi. Beklenti: sıfır durumunun serbest dolaşım akımı her
  senaryoda DS3/DS4'ten geçer. Bu diyotların Qrr değeri (DSEI ≈ 3 µC, IXYN ≈ 9,5 µC)
  S1/S2'nin açılma kaybını değiştirir; dolayısıyla verim ve P_dc da değişir.
- **Durum:** açık — İP-4 kalibrasyonundan önce uygulanacak

### D-09 — EMC X kapasitörü m-dosyasındaki eşdeğerle modellenmemiş

- **Sınıf:** Parametre
- **Sorun:** `Capacitor6`/`Capacitor7` (iki ortak kip bobini arasındaki hat–dönüş
  kapasitörü) `C_emc_aux` = 1 µF ve `R_emc_aux` = 0,01 Ω kullanıyor. Oysa m-dosyası
  X2 ağını "iki adet 1 µF/0,1 Ω seri kol, yüzer orta nokta" diye tanımlıyor ve tek faz
  eşdeğerini `EMC_Cx_eq` = 0,5 µF, `EMC_Rx_eq` = 0,2 Ω olarak hesaplıyor. Bu iki
  değişken hiçbir blokta kullanılmıyor.
- **Doğru durum (K-17):** Tek faz modelde X ağı `EMC_Cx_eq`/`EMC_Rx_eq` ile temsil edilir.
- **Düzeltme:** `Capacitor6`/`Capacitor7`: `c = EMC_Cx_eq`, `r = EMC_Rx_eq`.
- **Etki (hesap):** ΔQ ≈ −V²ω·0,5 µF ≈ −2,3 var; P'ye etkisi ihmal edilebilir.
- **Durum:** açık — İP-4 kalibrasyon taban modelinde uygulanacak

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
- **Durum:** açık — düşük öncelik

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
