# Reaktif güç ve cosφ işareti: dalga biçiminden belirleme (İP-3, D-06)

Tarih: 27.10.2026 · MATLAB R2023b Update 7 · bu makine

## Amaç ve kapsam

Benzetimde Q her senaryoda pozitif (+33…+35 var), deney tablosunda ise S1 için 0,
S2/S3 için negatif (−25,42 / −21,83 var) görünüyordu (D-06). Bu not, işaretin ve
büyüklüğün nereden geldiğini ham dalga biçimiyle belirler, model Power bloğunun
işaret kuralını kesinleştirir ve K-02'nin (karşılaştırma büyüklük üzerinden)
İP-4'te nasıl uygulanacağını önerir.

Buradaki sayılar **tez bulgusu değildir**. Model kalibre edilmemiş 12.10 paketidir
(DENEME parametreleri); not yalnız ölçüm zincirini ve işaret kuralını belgeler.

- Model: `incoming_real_data/models/2026-10-12_dort_senaryo_paketi/inverter_senaryo3.slx`,
  kopyası `runs/2026-10-27_q_isaret_dalga/model_inverter_senaryo3/`. Devre, parametre
  ve çözücü değiştirilmedi; yalnız bellekte sinyal kaydı açıldı (model kaydedilmedi).
- Betikler:
  - `scripts/run_q_isaret_dalga_20261027.m` (ham dalga kaydı)
  - `scripts/analyze_q_sign_20261027.m` (fazör, ağ hesabı, duyarlılık, D-09)
- Çıktılar (`runs/2026-10-27_q_isaret_dalga/`):
  - `q_isaret_ozet.csv`: Display tabanlı özet ve deney karşılaştırması
  - `q_isaret_noktalar.csv`: ölçüm noktalarına göre fazör ve güç
  - `q_isaret_dogrulama.csv`: dalga fazörü ↔ ağ hesabı ↔ Power3 bloğu
  - `q_isaret_duyarlilik.csv`: V_A genlik/faz ve şebeke gerilimi duyarlılığı
  - `q_isaret_d09.csv`: X kapasitörü 1 µF → 0,5 µF etkisi
  - `q_isaret_S3.png`: v_ac, i_ac, i_L1 (0,06–0,10 s)
  - `analiz_log.txt`: analiz betiğinin tam konsol çıktısı
  - `results/inverter_senaryo3/dalga_0p05_0p1.mat` (257 MB, git'e girmez)
- Pencere: 0,06–0,10 s (iki tam 50 Hz periyodu). Fazörler ham çözücü örnekleri
  üzerinde trapez Fourier integraliyle, RMS ölçekli ve v_ac temel bileşeni 0°
  alınarak hesaplandı.

## Koşu bilgisi

| Model | Mod | Duvar süresi | Durum |
|---|---|---|---|
| `inverter_senaryo3` (S3, ham dalga kaydı) | Accelerator | 9415 s (~2,6 sa) | tamamlandı |

- StopTime 0,1 s, ode15s, MaxStep 1e-6 s, modelde kayıtlı haliyle.
- Süre ilk koşunun (1624 s) yaklaşık altı katı. Nedeni dört ham sinyalin her çözücü
  adımında kaydı ve aynı anda koşan diğer MATLAB süreçleridir.
- Kayıt sonucu değiştirmedi: Power3 P1/Q1 bu koşuda 298,942 W / +32,892 var, ilk
  koşuda (`runs/2026-10-27_dort_senaryo_ilk_kosu`) aynı.
- **S1 için dalga koşusu yapılmadı.** Gerekçe:
  - S1 ile S3 aynı ölçüm zincirini kullanır: aynı sensör blokları, aynı LCL + EMC
    ağı, aynı Power3/Power Measurement blokları (`2026-10-27_TOPOLOJI_DENETIMI.md`,
    Bölüm 3).
  - S3'te Display değerlerinden geri yayılan ağ hesabı, dalga biçimiyle
    0,001 A / 0,01° / 0,01 V düzeyinde örtüşüyor (aşağıdaki doğrulama tablosu).
  - Ağ doğrusal ve pasiftir; temel bileşen hesabı senaryodan bağımsızdır. Bu
    yüzden S1 için Display + ağ hesabı yeterlidir.
  - Ham S1+S2 modeli LCC ile Accelerator'da bağlanamıyor (`rt_InitInfAndNaN`);
    Normal modda ~2 saat sürer ve yeni bilgi getirmez.

## Ölçüm noktaları ve modelin işaret kuralı

Düğümler (bağlantı grafiğinden, `2026-10-27_TOPOLOJI_DENETIMI.md`):

| Nokta | Konum | Modelde ölçüm |
|---|---|---|
| A | Evirici faz düğümü, L1 girişi (kutup gerilimi, DA orta noktasına göre) | `v_inv` (AC Voltage Sensor2), `i_L1` (Current Sensor1, faz → L1) |
| B | L1 çıkışı, Cf (8 µF) girişi | — (hesap) |
| B+ | Cf sonrası, EMC girişi | — (hesap) |
| C | EMC çıkışı, L2 girişi = evirici kabin çıkış uçları | `v_ac` (AC Voltage Sensor1), `i_ac` (AC Current Sensor1); **Power3, Power Measurement, RMS, THD bu noktadan beslenir** |
| G | Şebeke kaynağı (`Grid1`) uçları, L2 = 1 mH (şebeke + varyak) arkası | — (hesap) |

**İşaret kuralı (kesinleşti):**

1. `AC Current Sensor1` dönüş iletkenindedir ve pozitif yönü `Grid−` → evirici
   dönüşüdür. Bu, evirici fazından çıkıp şebekenin + ucuna giren akıma eşittir.
2. Dalga biçiminden doğrudan güç: ⟨v_ac·i_ac⟩ = +298,87 W. Bu güç DA kaynağından
   gelir (P_dc ≈ 317 W). Pozitif işaret, i_ac'nin evirici → şebeke yönünde pozitif
   olduğunu bağımsız olarak doğrular.
3. Power3 bloğu Q'yu φ = θ_v − θ_i ile hesaplar. Dalga fazöründen
   Im{V_C·I_C*} = +32,90 var bulundu. Power3 değeri +32,89 var, yani blok
   standart tanımı kullanır.
4. **Sonuç: modelin raporladığı P ve Q, C noktasında üretici (evirici → şebeke)
   kuralındadır.**
   - P > 0: şebekeye verilen etkin güç.
   - Q > 0: akım uç gerilimine göre geride; evirici + filtre şebekeye reaktif güç
     veriyor. Şebekeden bakınca evirici kapasitif görünür.
   - Şekilde de i_ac sıfır geçişi v_ac'nin yaklaşık 0,35 ms (6,3°) gerisindedir.

## Fazör tablosu

Üretici kuralı; açılar v_ac(C) temel bileşenine göre; φ = θ_V − θ_I.
"Ağ" = Display'den (C) geri yayılan LCL + EMC ağ hesabı. "Dalga" = ham dalga
biçiminden. PF yalnız gerçek RMS değerlerin bulunduğu noktada verilmiştir.

**S1 (ağ hesabı, Display tabanlı)**

| Nokta | \|V\| [V] | \|I₁\| [A] | φ [°] | P₁ [W] | Q₁ [var] | cosφ₁ | PF |
|---|---|---|---|---|---|---|---|
| A evirici çıkışı | 120,01 | 2,176 | −1,26 | 261,1 | −5,8 | 0,9998 | — |
| B L1 sonrası | 119,95 | 2,176 | −1,46 | 261,0 | −6,7 | 0,9997 | — |
| B+ Cf sonrası | 119,95 | 2,190 | +6,45 | 261,0 | +29,5 | 0,9937 | — |
| **C model ölçüm noktası** | 119,91 | 2,194 | **+7,43** | 260,9 | **+34,0** | **0,9916** | **0,926** |
| G şebeke kaynağı | 119,80 | 2,194 | +7,10 | 260,8 | +32,5 | 0,9923 | — |

**S3 (ağ hesabı ve dalga biçimi)**

| Nokta | Kaynak | \|V\| [V] | \|I₁\| [A] | φ [°] | P₁ [W] | Q₁ [var] | cosφ₁ | PF |
|---|---|---|---|---|---|---|---|---|
| A evirici çıkışı | ağ | 124,51 | 2,405 | −1,87 | 299,2 | −9,79 | 0,9995 | — |
| A evirici çıkışı | dalga | 124,51 | 2,404 | −1,87 | 299,2 | −9,79 | 0,9995 | (0,698)¹ |
| B L1 sonrası | dalga | 124,45 | 2,404 | −2,08 | 299,0 | −10,9 | 0,9993 | — |
| B+ Cf sonrası | dalga | 124,45 | 2,413 | +5,36 | 299,0 | +28,0 | 0,9956 | — |
| **C model ölçüm noktası** | ağ | 124,40 | 2,418 | +6,28 | 298,9 | +32,89 | 0,9940 | 0,9877 |
| **C model ölçüm noktası** | dalga | 124,40 | 2,417 | **+6,28** | 298,9 | **+32,90** | **0,9940** | **0,9878** |
| G şebeke kaynağı | dalga | 124,30 | 2,417 | +5,94 | 298,8 | +31,1 | 0,9946 | — |

¹ A noktasında PF anlamsızdır: v_inv bir PWM kutup gerilimidir (RMS'i anahtarlama
bileşenlerini içerir).

**Doğrulama (`q_isaret_dogrulama.csv`, S3)**

| Büyüklük | Dalga biçimi | Ağ hesabı / model bloğu |
|---|---|---|
| \|I_L1\| | 2,4040 A ∠2,084° | 2,4040 A ∠2,084° (ağ) |
| \|V_A\| | 124,51 V ∠0,210° | 124,51 V ∠0,210° (ağ) |
| Q_A | −9,790 var | −9,786 var (ağ) |
| P₁ / Q₁ (C) | 298,87 W / +32,90 var | 298,94 W / +32,89 var (Power3, son periyot) |
| Gerçek P (C), ⟨v·i⟩ | 298,87 W | 298,91 W (Mean9, 0–50. harmonik) |
| Şebeke EMK, \|V_C − Z₂I_C\| | 124,300 V | 124,300 V (parametre `Vac3_rms`) |
| THD_I (C) | %10,87 (tüm bant), %10,67 (2–50. h.) | %10,86 (THD bloğu) |

Ağ hesabı dalga biçimini dört anlamlı basamakta yeniden üretiyor. Bu nedenle S1 ağ
hesabı da güvenilirdir. A noktasında ⟨v_inv·i_L1⟩ = 310,8 W, P₁ = 299,2 W. Aradaki
~11,7 W anahtarlama frekanslı dalgalanmanın L1 çekirdek kaybı (Rp) ve dirençlerde
harcadığı güçtür.

## Reaktif gücün kaynağı

Değerler S3 içindir (S1'de aynı yapı).

- **Evirici köprüsü (A).** Q₁ ≈ −10 var; akım hafifçe önde. Açık çevrim modülasyonda
  köprü neredeyse yalnız etkin güç verir.
- **L1.** Tüketilen reaktif güç ≈ +1,1 var (I²ωL1).
- **Cf (8 µF).** Sağlanan reaktif güç 38,9 var. V²ωC = 124,45² · 2π50 · 8 µF.
- **EMC X kapasitörü (1 µF).** ≈ 4,9 var.
- **Toplam.** Köprü ile C arasındaki şönt elemanlar i_L1 − i_ac farkıyla 43,8 var
  sağlar. Bu nedenle Q işaret değiştirir: A'da ≈ −10 var, C'de ≈ +33 var.
- **Sonuç.** Q'nun işareti ve büyüklüğü ölçüm noktasına bağlıdır. "Q" ölçüm noktası
  ve yön kuralı belirtilmeden raporlanamaz. C ile G arasındaki fark (L2'nin
  I²ωL2 ≈ 1,8 var tüketimi) küçüktür. A ile C arasındaki fark (~43 var) ise
  deneydeki büyüklükten büyüktür.

## Deney tarafı: işaret bilgisi nereden geliyor?

`degerler_senaryo_ozeti_2026-08-17.xlsx` sütunları iki gruptur:

- "Ölçülen büyüklükler": Vdc, Idc, VACrms, Ifaz, Po, cosfi, THD
- "Hesaplanan büyüklükler": Qo, Vout, Verim, …

Bulgular:

1. **Qo ölçülmemiştir, hesaplanmıştır.** Formül Qo = Po · tan(arccos(cosfi)).
   - Değerler birebir tutar: 253,2 · tan(arccos(−0,995)) = −25,415 var ve
     281,2 · tan(arccos(−0,997)) = −21,831 var.
   - Qo'nun eksi işareti yalnız cosfi'nin eksi işaretinden gelir.
   - arccos'un ikinci çeyreğe düşmesi bu işareti Q'ya taşır. Oysa dört çeyrek
     kuralında cosφ < 0, P < 0 demektir. Tabloda ise Po > 0'dır.
   - Yani cosfi'deki "−", analizörün öncü/artçı (lead/lag) ya da yön göstergesidir.
     Hangisi olduğu ve analizörün akım yönü belgede yoktur (K-02 dayanağı).
2. **18.07 e-postası** (`gercek_uygulama_ozeti_eposta_2026-07-18.csv`) aynı
   değerleri işaretsiz verir: cosφ 1,000 / 0,995 / 0,997; Q 0 / 25,42 / 21,83.
3. **cosfi temel bileşen yer değiştirme faktörüdür (cosφ₁), toplam PF değildir.**
   - S3: P/(V·I) = 281,2/(124,3·2,31) = 0,979 ≠ 0,997.
   - S2: P/(V·I) = 0,898. cosφ₁/√(1+THD²) = 0,995/√(1+0,47²) = 0,900 (tutarlı).
   - S3: 0,997/√(1+0,14²) = 0,987, P/(V·I) ile %0,8 içinde. Bu, K-01'in %14 THD
     seçimini destekler; %4 THD ile fark %1,8 olurdu.
4. **Yuvarlama bandı.** cosfi üç basamaklıdır (±0,0005), bu yüzden |Q| bir aralıktır:

| Senaryo | P [W] | \|cosφ₁\| | \|Q\| bandı [var] | φ₁ [°] |
|---|---|---|---|---|
| S1 | 249,6 | 1,000 | 0 … 7,9 | 0 … 1,8 |
| S2 | 253,2 | 0,995 | 24,1 … 26,7 | 5,5 … 6,0 |
| S3 | 281,2 | 0,997 | 19,9 … 23,6 | 4,1 … 4,8 |

5. **Analizörün konumu.** Ölçülen VACrms (119,8 / 121,0 / 124,3 V), modelde şebeke
   EMK'sı olarak kullanılmıştır. Fiziksel olarak analizör 120 V tarafında, evirici
   ile varyak arasındadır. Bu konum model C noktasına (ya da L2 içindeki varyak
   kaçak endüktansının bölünüşüne göre C ile G arasına) karşılık gelir.
   - C ile G arasındaki Q farkı 1,8 var olduğundan bu belirsizlik önemsizdir.
   - Analizör A noktasında olamaz: A, kutup gerilimidir ve filtre öncesindedir.

6. **S1 yan gözlemi (K-01 için not).**
   - S1'de P/(V·I) = 0,922'dir.
   - cosφ₁ = 1 ile bunu açıklamak için THD_I ≈ %42 gerekir. Tablodaki %15 ile
     0,989 çıkar.
   - Benzetimin S1 THD_I değeri %37,3'tür.
   - S1 deney satırı iç tutarlılıkta S2/S3'ten zayıftır. Bu not THD hedefini
     değiştirmez, yalnız kaydeder.

## Benzetim ile deney: büyüklük karşılaştırması (C noktası)

| | S1 benzetim | S1 deney | S3 benzetim | S3 deney |
|---|---|---|---|---|
| P₁ [W] | 260,9 | 249,6 | 298,9 | 281,2 |
| Q₁ [var] (üretici) | +34,0 | \|Q\| ≤ 7,9 | +32,9 | \|Q\| = 19,9 … 23,6 |
| cosφ₁ | 0,9916 | ≥ 0,9995 | 0,9940 | 0,9965 … 0,9975 |
| φ₁ [°] | +7,43 (akım geride) | \|φ\| ≤ 1,8 | +6,28 (akım geride) | \|φ\| = 4,1 … 4,8 |
| PF = P/(V·I) | 0,926 | 0,922 | 0,988 | 0,979 |

Büyüklük farkı S1'de ~26 var, S3'te ~10 var. Bu fark kalibrasyonsuz modelin
çalışma noktası farkıdır. Aşağıdaki duyarlılık, farkın modülasyon genliğinde
binde birden küçük bir değişikliğe karşılık geldiğini gösterir.

## Duyarlılık: Q neden kırılgan bir büyüklük?

Duyarlılık ağ hesabıyla bulundu (`q_isaret_duyarlilik.csv`): şebeke EMK'sı E sabit,
evirici temel gerilimi V_A değiştirildi. Doğrulamaya göre ağ hesabı dalga biçimini
yeniden ürettiğinden bu doğrusal hesap geçerlidir.

| Değişim (S3) | ΔP_C [W] | ΔQ_C [var] |
|---|---|---|
| V_A fazı +0,1° | +52,7 | −6,1 |
| V_A genliği +%0,1 (≈ 0,12 V) | +3,9 | +30,4 |
| Şebeke EMK'sı E +0,05 V (okuma çözünürlüğünün yarısı) | −1,3 | −12,2 |

- **P esas olarak faza bağlıdır**: 0,1° → ~53 W, S1'de ~49 W.
- **Q esas olarak genlik farkına bağlıdır** (|V_A| − |E|): %0,1 → ~30 var.
- Yalnız şebeke gerilimi okumasının 0,1 V çözünürlüğü, Q'da ±12 var belirsizlik
  doğurur. Ölçülen 0,1 V'luk bir değişim bile S3 deney değerinin yarısı kadar Q
  değiştirir.
- Açık çevrim, gerilim kaynaklı bir eviricide Q şu ayrıntılarla belirlenir: ölü zaman
  gerilim kaybı, iletim düşümleri, DA bara dalgalanması ve şebeke geriliminin
  anlık değeri. Model Q'yu birinci ilkelerden ±10 var'dan iyi öngöremez. Deneyin Q
  işareti de aynı nedenle sistematik bir fiziksel bilgi taşımaz.

**Deney |Q|'suna ulaşmak için gereken genlik/faz değişimi** (P_C benzetimdeki
değerinde tutularak):

| Hedef | Genlik değişimi | \|V_A\| [V] | Faz değişimi [°] | Q_A [var] | Q_C [var] |
|---|---|---|---|---|---|
| S1: Q_C = 0 | −%0,119 | 119,87 | +0,009 | −39,7 | 0 |
| S3: Q_C = +21,83 (akım geride) | −%0,036 | 124,47 | +0,003 | −20,8 | +21,83 |
| S3: Q_C = −21,83 (akım önde) | −%0,178 | 124,29 | +0,013 | −64,4 | −21,83 |
| S3: Q_A = −21,83 | −%0,039 | 124,46 | +0,003 | −21,83 | +20,8 |

- İki işaret dalı arasındaki fark yalnız %0,14 genliktir (0,18 V); P ve I_ac
  pratikte aynı kalır.
- Deney verisindeki I_ac, P ya da verim iki dalı ayırt edemez. Örnek: S3'te
  |Q| = 22 var'ın I₁'e katkısı %0,3'tür.
- A noktasındaki −21,8 var ile C noktasındaki +20,8 var aynı çalışma noktasıdır.
  Ölçüm noktası belirtilmeden işaret yorumu yapılamaz.

## D-09 (K-17): X kapasitörünün 1 µF → 0,5 µF eşdeğerle değiştirilmesi

`q_isaret_d09.csv`, analitik ağ hesabı:

| Senaryo | Koşul | Q_C 1 µF [var] | Q_C 0,5 µF [var] | ΔQ_C [var] | ΔP_C [W] | Q_A değişimi [var] |
|---|---|---|---|---|---|---|
| S1 | modülasyon sabit (V_A, E sabit) | +34,02 | +33,16 | **−0,86** | +0,07 | −5,76 → −4,36 |
| S3 | modülasyon sabit (V_A, E sabit) | +32,90 | +31,98 | **−0,92** | +0,08 | −9,79 → −8,28 |
| S1 / S3 | evirici akımı sabit (üst sınır, −V²ωΔC) | — | — | −2,26 / −2,43 | ≈ 0 | — |

- Kapasitörün kendi reaktif gücü ~2,3–2,4 var azalır. Açık çevrim modülasyonda bu
  değişimin yalnız ~%38'i C noktasına yansır (≈ −0,9 var). Kalanı köprü tarafına
  gider, çünkü pay L1 ile L2 empedanslarının oranına göre bölüşülür.
- −2,3 var değeri, evirici akımı sabit tutulduğunda (akım denetimli S4 ya da
  yeniden kalibre edilmiş genlik) geçerli olan üst sınırdır.
- Etki, deney–benzetim farkından (10–26 var) ve okuma belirsizliğinden (±12 var)
  küçüktür. İP-4'te genlik yeniden ayarlanacağı için D-09 yalnız gereken genlik
  düzeltmesini ~%0,003 kaydırır.

## Sonuç

1. Modelin P/Q/cosφ değerleri C noktasında (evirici kabin çıkışı, EMC sonrası,
   L2 öncesi) ve üretici kuralındadır. +33 var, akımın gerilimden 6,3° geride
   olduğu, evirici + filtrenin şebekeye reaktif güç verdiği durumdur. Bu sonuç ham
   dalga biçimiyle doğrulandı.
2. Benzetimdeki +Q'nun kaynağı filtre kapasitörüdür (Cf ≈ 39 var + X kap. ≈ 5 var).
   Köprü çıkışında Q ≈ −6…−10 var'dır.
3. Deneydeki eksi işaret ölçülmüş bir Q değildir. cosfi'nin işaret göstergesinin
   Q = P·tan(arccos cosφ) formülüyle Q'ya taşınmasından doğar. Analizörün yön ve
   öncü/artçı kuralı belgede olmadığından işaret yorumlanamaz. K-02 (büyüklük
   karşılaştırması) doğrulanmıştır.
4. Deneydeki "cosfi" temel bileşen yer değiştirme faktörüdür (cosφ₁). Toplam güç
   faktörü (PF = P/S) ayrı bir büyüklüktür; ikisi tezde ayrı adlandırılmalıdır.
5. D-09'un Q'ya etkisi açık çevrimde −0,9 var, akım sabit üst sınırında −2,3/−2,4 var'dır.

## K-02 uygulama önerisi (ana oturumun kararına)

**Tezde raporlama:**

- Nokta: C, yani evirici çıkış uçları (EMC filtresi sonrası, şebeke/varyak öncesi).
  Bu, analizörün bağlı olduğu 120 V tarafıdır.
- Kural: üretici kuralı, evirici → şebeke yönü pozitif. P > 0 şebekeye verilen güçtür.
  Q > 0 akımın gerilimden geride olduğu, eviricinin şebekeye reaktif güç verdiği
  durumdur.
- İki ayrı büyüklük raporlanır:
  - cosφ₁ (temel bileşen yer değiştirme faktörü) = P₁/√(P₁² + Q₁²)
  - PF (toplam güç faktörü) = P/(V_rms·I_rms)
- Deney değerleri |cosφ₁| ve |Q| olarak, yuvarlama bandıyla verilir. Deney
  tablosundaki işaretin analizör göstergesinden türediği ve yön kuralının
  belgelenmediği sınırlılık olarak yazılır.

**İP-4 kalibrasyonu:**

- Serbest değişkenler senaryo başına iki tanedir: faz (`phase_deg*`) ve genlik
  (`K1x`; S3'te K33/K13 oranı sabit).
- Birincil hedef P_ac'dir ve fazla ayarlanır.
- Genlik ikinci hedefle sabitlenir. Bu hedef **C noktasında |Q₁|**'dir, yuvarlama
  bandıyla:
  - S1: 0–7,9 var
  - S2: 24,1–26,7 var
  - S3: 19,9–23,6 var
- İşaret dalı seçimi: deney iki dalı ayırt edemez. Kalibrasyonsuz modele en yakın
  dal (en küçük genlik değişimi) seçilir; S3 için bu Q_C > 0 (akım geride) dalıdır.
  Seçim kalibrasyon tablosunda açıkça yazılır.
- I_ac, verim ve THD bağımsız doğrulama ölçütleri olarak kalır. Q'nun I_ac'ye
  katkısı %0,3 düzeyindedir.
- Faz ile genlik birbirini etkiler (P–Q eşleşmesi):
  - +0,1° faz: P +53 W, Q −6 var
  - +%0,1 genlik: P +4 W, Q +30 var
  - Bu yüzden ikisi tek tek değil, birlikte (2×2 Newton ya da `fminsearch`) çözülür.
  - Genlik çözünürlüğü %0,005'ten iyi olmalıdır; dört basamaklı `K1x` yetmez.
- Kabul toleransı:
  - P için ±%1.
  - |Q| için yuvarlama bandı. Okuma belirsizliği (±12 var) nedeniyle |Q|
    uyumsuzluğu tek başına modeli reddettirmez.

## Açık kalanlar

- Analizörün marka/model ve işaret kuralı belgede yok. İşaret bu nedenle
  doğrulanamaz; K-02 kapsamında sınırlılık olarak yazılır.
- S1 dalga koşusu yapılmadı (gerekçe yukarıda). S1 değerleri Display + ağ hesabıdır.
- S2 bu notta yok. İP-1'in onarılmış S2 koşusu aynı ağ hesabıyla
  (`analyze_q_sign_20261027.m`, `cases` tablosuna satır eklenerek) işlenebilir.
- Kalibre modelde Q yeniden hesaplanmalı (İP-4). Bu nottaki benzetim Q değerleri
  kalibrasyonsuzdur.
