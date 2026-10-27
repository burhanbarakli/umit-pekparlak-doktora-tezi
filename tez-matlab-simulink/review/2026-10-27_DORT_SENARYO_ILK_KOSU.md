# 12.10.2026 dört senaryo paketi: değiştirilmemiş ilk koşu

Tarih: 27.10.2026 · MATLAB R2023b Update 7 · bu makine

## Amaç ve kapsam

Ümit'in 12.10.2026 paketindeki modeller devreye, parametreye ve çözücüye
dokunulmadan koşturuldu ve sonuçlar deney hedef tablosuyla karşılaştırıldı
(Faz 1). Kalibrasyon yapılmadı. Buradaki sayılar **tez bulgusu değildir**; modelin
şu anki durumunu ve hedeften sapmasını belgeler.

- Girdi paketi: `incoming_real_data/models/2026-10-12_dort_senaryo_paketi/`
  (koşu kopyası `runs/2026-10-27_dort_senaryo_ilk_kosu/model/`, bayt bayt aynı).
- Betikler:
  - `scripts/inspect_umit_dort_senaryo_20261027.m`
  - `scripts/run_umit_dort_senaryo_20261027.m`
  - `scripts/extract_umit_display_values_20261027.m`
  - `scripts/compare_umit_dort_senaryo_20261027.py`
- Çıktılar:
  - `runs/2026-10-27_dort_senaryo_ilk_kosu/results/<model>/`
  - `runs/2026-10-27_dort_senaryo_ilk_kosu/karsilastirma.csv`
  - `logsout.mat` diskte kalır, git'e girmez.
- Değerler, Display bloklarının 0,1 s'deki son değeridir. Bu bloklar Mean/RMS/THD
  blokları üzerinden bir şebeke periyodu boyunca ortalanmıştır. Display ile kayıt
  arasındaki eşleme ada göre değil, blok yolu ve port numarasına göre yapıldı.
  Bunun nedeni, modelde farklı hatların aynı kayıt adını taşımasıdır (ör. `Idc_s1`).

## Koşu bilgisi

| Model | Mod | Duvar süresi | Durum |
|---|---|---|---|
| `inverter_scenario1_parametric5_etiquetli` (S1+S2) | Normal | 6906 s (~1,9 sa) | tamamlandı |
| `inverter_senaryo3` | Accelerator | 1624 s | tamamlandı |
| `inverter_senaryo4` | Accelerator | 1615 s | tamamlandı |

StopTime 0,1 s, ode15s, MaxStep `sim_max_step` = 1e-6 s, modelde kayıtlı haliyle.

S1+S2 için Accelerator derlemesi, üç modelin aynı klasörde eşzamanlı derlenmesi
sırasında "Problem creating Accelerator MEX file" hatası verdi. Bu model Normal
modda yeniden koşturuldu. Yürütme biçimi dışında hiçbir ayar değişmedi.

## Modelle ilgili bulgular

1. **`inverter_senaryo4.slx`, `inverter_senaryo3.slx` ile işlevsel olarak aynıdır.**
   - Yalnız ModelUUID ve pencere bilgisi farklıdır.
   - İkisi de `Vdc3`, `Vac3_peak`, `K13`, `K33` ve `phase_deg3` kullanır.
   - Akım denetleyicisi ya da `Kp` bloğu yoktur (`Kp` m-dosyasında tanımlı, hiçbir
     blokta kullanılmıyor).
   - Koşu çıktıları bayt bayt aynıdır.
   - Senaryo 4 (nominal akımda kapalı çevrim) bu pakette **teslim edilmemiştir**.
2. **S1+S2 modelinde ikinci devre (S2) hiç anahtarlanmıyor.**
   - Gate Drive1–4 (IGBT4–7, `Voltage Source1` = `Vdc2`) içindeki From blokları
     `g12`, `g22`, `g32` ve `g42` etiketlerini okur.
   - Modelde yalnız tek PWM alt sisteminin (`Subsystem`, `Sine Wave1` → `K11`)
     ürettiği `g11`, `g21`, `g31` ve `g41` Goto etiketleri vardır.
   - `g12…g42` etiketleri için Goto yoktur.
   - Sonuç olarak S2 devresinde DA akım 2,9 mA, DA güç 1,1 W, AA aktif güç
     −0,44 W ve AA akım 0,35 A'dır. Bu akım yalnız filtre kapasitörünün reaktif
     akımıdır: Q = 41,5 var ≈ V²ωC ≈ 44 var.
   - `K12` ve `phase_deg2` modelde kullanılmıyor.
   - Paketteki S2 benzetim sonucu bu modelden üretilmiş olamaz. Ümit'in S2'yi
     hangi dosyayla koşturduğu sorulmalı.
3. **Parametre dosyası yükleme sırası.**
   - Simscape diyot parametrelerinin türü InitFcn'den önce çözülür.
   - Temiz oturumda `inverter_common_parameters.m` önceden çalıştırılmazsa model
     "Invalid parameter type set at Qrr/didt … Got type string" hatasıyla derlenmez.
   - Ümit'in oturumunda değişkenler çalışma alanında hazır olduğundan bu hata
     görünmemiş olabilir.
   - Modele `PreLoadFcn` eklenmesi önerilir.
4. **Kayıt adları çakışıyor.** Kayıt adları birden çok hatta aynıdır (ör. `Idc_s1`).
   Bu nedenle ada göre okunan sonuç yanlış hatta ait olabilir.

## Hedef tablosuyla karşılaştırma

Hedefler `inverter_common_parameters.m` (12.10.2026) ile `değerler.xlsx`
(17.08.2026) dosyalarından alındı. P_dc hedefi Vdc·Idc olarak hesaplandı. THD ve
verim yüzde olarak verilmiştir.

| Büyüklük | S1 hedef | S1 benzetim | S2 hedef | S2 benzetim | S3 hedef | S3 benzetim |
|---|---|---|---|---|---|---|
| Vdc [V] | 431,5 | 431,48 | 395,0 | 394,95 | 427,5 | 427,45 |
| Idc [A] | 0,624 | 0,661 | 0,684 | 0,003 | 0,697 | 0,741 |
| P_dc [W] | 269,3 | 285,4 | 270,2 | 1,1 | 298,0 | 316,6 |
| I_ac RMS [A] | 2,26 | 2,346 | 2,33 | 0,347 | 2,31 | 2,432 |
| P_ac [W] | 249,6 | 260,9 | 253,2 | −0,4 | 281,2 | 298,9 |
| Q [var] | 0 | +34,7 | −25,42 | +41,5 | −21,83 | +33,0 |
| cosφ | 1,000 | 0,991 | −0,995 | −0,011 | −0,997 | 0,994 |
| THD_I [%] | 15 | 37,4 | 47 | (17,6) | 14 | 10,9 |
| Verim [%] | 92,5 | 91,4 | 94,2 | — | 94,5 | 94,4 |
| THD_V şebeke [%] | — | 3,45 | — | 0,52 | — | 2,59 |

S2'nin benzetim sütunu anahtarlanmayan devreye aittir ve hedefle
karşılaştırılamaz. S4 sütunu S3 ile aynı olduğundan tabloya alınmadı.

## Değerlendirme

- **Güç ve akım.** S1 ve S3'te benzetim, hedefi sistematik olarak aşıyor:
  P_ac S1'de %4,5, S3'te %6,3 yüksek; AA akım %3,8 ve %5,3 yüksek. DA gerilim tam
  oturuyor. Sapma modülasyon kazancı (`K11`, `K13`) ve faz ayarıyla
  kapatılabilecek büyüklükte görünüyor (Faz 2).
- **Verim.** S3'te verim hedefe çok yakın: %94,4'e karşı %94,5. S1'de 1,1 puan düşük.
- **Q işareti.** Benzetimde Q her senaryoda pozitif (+33…+35 var). Hedeflerde
  ise Q 0 ya da negatif ve cosφ negatif.
  - Değerin büyüklüğü, filtre kapasitörünün 120 V'taki reaktif gücüne
    (~43 var) yakın.
  - Ümit'in ölçüm işaret kuralı ile modeldeki Power bloğunun yön kuralı
    eşleştirilmeden bu fark yorumlanmamalı.
- **THD.** S1 akım THD'si %37,4 ile hedefin (%15; e-postada %5) çok üstünde. S3
  ise %10,9 ile hedefin (%14) altında. THD hedefinin hangisi olduğu (xlsx 15/47/14
  mi, e-posta 5/–/4 mü) Faz 2 kalibrasyonundan önce netleşmeli.

## Açık noktaların kapanışı

27.10.2026 kararıyla Ümit'e soru sorulmuyor. Açık noktalar
`tez-tamamlama/01_KARAR_DEFTERI.md` dosyasında şöyle kapatıldı:

| Açık nokta | Karar | Düzeltme kaydı |
|---|---|---|
| S2 kapı sinyali yok | K-04 | D-01 |
| S4 teslim edilmedi | K-05 | D-02 |
| THD hedefi | K-01 (15/47/14) | — |
| Q/cosφ işareti | K-02 | D-06 |
| CMC kütüphanesi notu | K-15 | — |

## Sonraki adım

1. İP-1: S2 kapı yolunun onarımı ve S2 koşusu.
2. İP-2: Topoloji/cihaz eşlemesi denetimi.
3. İP-3: Q işaretinin dalga biçiminden belirlenmesi.
4. İP-4: S1–S3 kalibrasyonu (İP-1 ve İP-3'e bağlı).

İş paketleri `tez-tamamlama/00_TAMAMLAMA_PLANI.md` dosyasındadır.
