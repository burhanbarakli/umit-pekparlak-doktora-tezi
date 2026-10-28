# S1–S3 ortak parametre kalibrasyonu (İP-4)

Tarih: 28.10.2026 · MATLAB R2023b Update 7 · bu makine · İP-4 (K-01, K-02a, K-17, İ5)

## Amaç ve kapsam

D-01 + D-03 + D-08 uygulanmış taban modellere D-09 (K-17) eklendi ve her senaryoda
yalnız iki serbest değişken (modülasyon genlik ölçeği `s` ve referans fazı `φ`)
deney özet tablosuna göre ayarlandı. Devre parametreleri değişmedi. S3'te K13 ve
K33 aynı `s` ile ölçeklendi (K33/K13 = 0,8667 sabit). Hedef: P_ac ±%1 ve C
noktasında |Q₁| cosφ yuvarlama bandında; I_ac, verim, THD, P_dc ve cosφ₁ bağımsız
doğrulama ölçütüdür (kalibre edilmedi).

Buradaki sayılar **tez bulgusu değildir** (İ5). Kalibre benzetim, deney özet
tablosunun P_ac ve |Q₁| değerlerine ayarlanmıştır; diğer büyüklüklerde "model,
deneyin X'ini Y hata ile yeniden üretiyor" biçiminde okunur.

- Betik: `scripts/calibrate_s1s3_20261028.m` (proje kökünden, eylemler: `prepare`,
  `run`, `predict`, `predict_emp`, `predict_th`, `dcm`, `table`).
- Koşu klasörü: `runs/2026-10-28_kalibrasyon/`
  - `model_s3/`, `model_s1/`, `model_s2/`: model kopyaları (git dışı) ve her koşunun
    yazdığı `<model>_kalibrasyon.m` (yalnız K1x/K33/phase_deg*)
  - `inspection/hazirlik.txt`: D-09, ayırma ve derleme denetimi
  - `results/<koşu>/`: `metrikler.csv`, `fazorler.csv`, `kosu_bilgisi.txt`,
    `ozet.mat`, `dalga.mat` (v_inv, v_ac, i_ac; 0,06–0,10 s; git dışı)
  - `kalibrasyon_tablosu.csv`, `sureksiz_iletim.csv`, `logs/`
- Değerler, Display kaynaklarının (blok yolu + port, D-04) 0,1 s'deki son değeridir
  (bir şebeke periyodu ortalaması). Fazörler son periyottan (0,08–0,10 s), şebeke
  EMK'sına (E = V_C − Z₂·I_C) göre hesaplandı.

## Model hazırlığı

**D-09 (K-17).** `Capacitor6`/`Capacitor7`: `c = EMC_Cx_eq` (0,5 µF),
`r = EMC_Rx_eq` (0,2 Ω), `set_param` ile; önceki değer `C_emc_aux`/`R_emc_aux`
(1 µF / 0,01 Ω). Başka blok değişmedi.

**S1+S2 modelinin ayrılması.** Birleşik modelde iki devre aynı ode15s çözücüsünü
paylaştığı için bir koşu ~4 saat sürüyordu. Betik üst düzey blokları bağlantı
bileşenlerine ayırır (sinyal + fiziksel çizgiler ve global Goto/From etiketleri) ve
diğer devrenin bileşenini `Commented = 'on'` yapar; blok silinmez. Sonuç: 261 üst
düzey bloktan S1 devresi 128, S2 devresi 132 blok; bağımsız blok yalnız `powergui`.
Şebeke kaynakları ve Solver Configuration blokları doğru bileşene düştü, iki ayrık
model de derlendi (`inspection/hazirlik.txt`).

**Kalibrasyon kancası.** InitFcn, parametre dosyasından sonra model klasöründeki
`<model>_kalibrasyon.m` dosyasını çalıştırır. m-dosyası değişmez; her koşunun
değerleri kendi dosyasında ve `kosu_bilgisi.txt`'de kayıtlıdır.

### Ayırma eşdeğerlik denetimi (D-08, D-09'suz, kalibrasyonsuz)

Ayrık modeller (`*_esd`), birleşik D-08 koşusuyla
(`runs/2026-10-27_diyot_esleme/results/inverter_s1s2_s2onarim_d08/`) aynı devre ve
parametrelerle karşılaştırıldı.

**Tablo 1 — ayrık ve birleşik model**

| Büyüklük | S1 birleşik | S1 ayrık | Fark | S2 birleşik | S2 ayrık | Fark |
|---|---|---|---|---|---|---|
| P_ac [W] | 258,491 | 258,490 | −0,001 (−%0,0005) | 269,649 | 269,602 | −0,047 (−%0,017) |
| Q₁ [var] | +33,174 | +33,194 | +0,020 | +27,648 | +27,656 | +0,008 |
| I_ac RMS [A] | 2,31687 | 2,31684 | −%0,001 | 2,56865 | 2,56815 | −%0,019 |
| P_dc [W] | 282,528 | 282,526 | −0,002 | 286,642 | 286,595 | −0,047 |
| η [%] | 91,492 | 91,493 | +0,001 puan | 94,072 | 94,071 | −0,001 puan |
| THD_I [%] | 36,93 | 36,93 | ≈0 | 56,73 | 56,72 | −0,01 puan |
| Duvar süresi | 4 sa 3 dk (iki devre) | 67 dk | | | 41 dk | |

Fark çözücü adım yolundan gelir ve kalibrasyon toleranslarının (P ±%1, |Q| bandı
2,6–7,9 var) iki-üç basamak altındadır. Kalibrasyon ayrık modellerle yapıldı.

## D-09 etkisi (ölçülen, S3)

Kalibrasyonsuz S3 (m-dosyası değerleri) D-09 ile koşturuldu (`s3_k0`) ve D-08
koşusuyla (`runs/2026-10-27_diyot_esleme/results/inverter_senaryo3_d08/`)
karşılaştırıldı.

**Tablo 2 — D-09'un S3'e etkisi**

| Büyüklük | D-08 | D-08 + D-09 | Fark | İP-3 ağ hesabı (V_A sabit) |
|---|---|---|---|---|
| P_ac [W] | 298,485 | 299,396 | +0,91 (+%0,31) | +0,08 |
| Q₁ (C) [var] | +32,889 | +30,388 | −2,50 | −0,92 (akım sabit üst sınırı −2,43) |
| I_ac RMS [A] | 2,4284 | 2,4335 | +0,0051 (+%0,21) | — |
| P_dc [W] | 316,282 | 317,228 | +0,95 | — |
| η [%] | 94,373 | 94,379 | +0,006 puan | — |
| THD_I [%] | 10,90 | 10,92 | +0,02 puan | — |
| \|V_A\| [V] | 124,51 | 124,504 | ≈ −0,006 | 0 |

D-09'un Q₁ etkisi ağ hesabının "modülasyon sabit" tahmininden büyük, "evirici akımı
sabit" üst sınırına yakındır. Nedeni aşağıdaki bulgudur: susturmalı köprünün temel
gerilimi modülasyonla sabitlenmez, şebeke tarafına göre kendini ayarlar. S1 ve S2
için D-09 ayrıca ölçülmedi; kalibrasyon D-09'lu modellerde yapıldığından etkisi
kalibre değerlerin içindedir.

## Bulgu: köprü sert bir gerilim kaynağı değil

İP-3 duyarlılıkları (faz +0,1° → P +53 W; genlik +%0,1 → Q +30 var) evirici
temel geriliminin (V_A) modülasyonla bire bir kaydığı varsayımına dayanıyordu. İlk
kalibrasyon adımları bu varsayımın tam modelde geçmediğini gösterdi:

- S3, `s3_k0` → `s3_k1`: genlik −%0,035, faz −0,032°. Ağ modeli P −18 W, Q −9 var
  öngörüyordu. Ölçülen P −0,13 W, Q +0,40 var. V_A'nın açısı yalnız −0,0003°,
  genliği +1,6 mV değişti.
- S1, `s1_k1` → `s1_k2`: genlik −%0,66 (faz ≈ sabit). V_A genliği değişmedi
  (+%0,04), açısı −0,14° kaydı; P 250 → 184 W, I_ac −%24.

Ağ (LCL + EMC) hesabı her koşuda doğru kaldı: ölçülen V_C, I_C fazörlerinden geri
yayılan V_A, dalga biçimindeki V_A ile 0,2 mV ve 0,0001° içinde örtüşüyor
(`fazorler.csv`). Yumuşak olan, (s, φ) → V_A geçişidir. Bunu açıklayan iki
mekanizma koşulardan ölçüldü:

1. **S2/S3 süreksiz iletim.** Kutup gerilimi üç seviyeden hiçbirinde değilken köprü
   akımı sıfırdır ve kutup filtre kapasitörü gerilimini izler. Bu durumun zaman oranı
   (`sureksiz_iletim.csv`, 0,08–0,10 s): S1 %0,5 (yalnız ölü zaman geçişleri), S2
   %12,4, S3 %22,6 (kalibre noktada ~%26). Bu, tezin senkron olmayan buck eşdeğeriyle
   aynı davranıştır: susturmalı çalışmada köprü düşük akımda akım kaynağına
   yaklaşır, V_A şebeke tarafından belirlenir.
2. **S1 ölü zaman.** Tamamlayıcı anahtarlamada akım dalgalanması her periyotta sıfırı
   kestiği için 1 µs ölü zamanın gerilim hatası akıma bağlıdır ve köprüye seri
   eşdeğer bir empedans gibi davranır.

Bu davranış koşulardan Thevenin eşdeğeriyle ölçüldü (`predict_th`): iç gerilim
V_int = s·V₀∠φ, V_A = V_int − Z_th·I_L1, Z_th son iki koşudan.

| Senaryo | Z_th [Ω] | \|Z_th\| [Ω] | Kaynak koşular |
|---|---|---|---|
| S1 | 1,18 − j1,18 | 1,67 | s1_k2, s1_k3 |
| S2 | 23,3 + j16,7 | 28,7 | s2_k1, s2_k2 |
| S3 | 13,5 − j2,2 | 13,7 | s3_k3, s3_k4 |

S1 için kaba ölü zaman tahmini Vdc·t_d·f_sw/ΔI_dalgalanma ≈ 431·1 µs·10 kHz/2,6 A ≈
1,7 Ω'dur; ölçülen 1,67 Ω ile aynı düzeydedir. Z_th, LCL'nin 50 Hz empedansından
(~0,5 Ω) büyük olduğu için etkin gücü esas olarak genlik (s), reaktif gücü esas
olarak faz (φ) belirler. K-02a'daki "P faz ile, |Q| genlik ile" eşlemesi bu
modelde tersine döner; 2×2 birlikte çözüm kuralı geçerli kaldı. Z_th işletme
noktasına bağlıdır (S3'te P–s ilişkisi belirgin dışbükey); bu yüzden Newton
adımları her senaryoda ampirik Jacobian ile (sekant/düzlem, `predict_emp`) yinelendi.

## Koşular

**Tablo 3 — bütün koşular** (Accelerator, 0,1 s, aynı anda en çok iki kalibrasyon
süreci; S4 çalışması da bir süreçle koşuyordu)

| Koşu | s | φ [°] | P_ac [W] | Q₁ [var] | I_ac [A] | η [%] | THD [%] | Süre [dk] |
|---|---|---|---|---|---|---|---|---|
| s1_esd (D-09'suz) | 1 | −0,44 | 258,49 | +33,19 | 2,3168 | 91,49 | 36,93 | 67 |
| s1_k1 | 0,998968 | −0,4507 | 250,27 | +29,31 | 2,2508 | 91,23 | 38,35 | 69 |
| s1_k2 | 0,992412 | −0,4473 | 184,10 | +47,74 | 1,7194 | 88,55 | 41,91 | 41 |
| s1_k3 | 0,999600 | −0,3171 | 239,21 | −7,79 | 2,1631 | 90,90 | 41,51 | 34 |
| **s1_k4** | **1,000003** | **−0,3661** | **247,21** | **+1,93** | **2,2183** | **91,15** | **39,51** | 29 |
| s2_esd (D-09'suz) | 1 | 0 | 269,60 | +27,66 | 2,5681 | 94,07 | 56,72 | 41 |
| s2_k1 | 0,97337 | +0,0090 | 257,22 | +27,13 | 2,4502 | 93,96 | 56,65 | 34 |
| s2_k2 | 0,96687 | +0,1906 | 253,69 | +23,08 | 2,4136 | 93,94 | 56,69 | 28 |
| s2_k3 | 0,96750 | +0,0400 | 253,78 | +27,53 | 2,4172 | 93,93 | 56,55 | 23 |
| **s2_k4** | **0,96720** | **+0,1121** | **253,80** | **+24,43** | **2,4162** | **93,93** | **56,72** | 22 |
| s3_k0 | 1 | 0 | 299,40 | +30,39 | 2,4335 | 94,38 | 10,92 | 63 |
| s3_k1 | 0,999650 | −0,0320 | 299,27 | +30,79 | 2,4325 | 94,37 | 10,75 | 39 |
| s3_k2 | 0,9511 | +1,2000 | 259,34 | +16,21 | 2,1101 | 94,13 | 15,49 | 59 |
| s3_k3 | 0,978396 | +0,7224 | 275,79 | +21,72 | 2,2452 | 94,25 | 14,89 | 33 |
| s3_k4 | 0,998161 | +0,6981 | 303,68 | +19,46 | 2,4622 | 94,46 | 11,41 | 38 |
| s3_k5 | 0,98228 | +0,6975 | 277,96 | +20,72 | 2,2624 | 94,26 | 14,90 | 23 |
| **s3_k6** | **0,98540** | **+0,6575** | **279,90** | **+21,41** | **2,2786** | **94,25** | **14,78** | 23 |

Kalın satırlar kalibre noktalardır. Senaryo başına hedeflenen 2–3 koşu aşıldı
(S1 4, S2 4, S3 6 kalibrasyon koşusu); nedeni yukarıdaki yumuşak köprü davranışıdır:
ilk adımlar İP-3'ün sert kaynak duyarlılıklarıyla atıldı ve Jacobian ancak koşulardan
öğrenildi.

İlk iki koşu (s3_k0, s1_esd) 63–67 dk sürdü; bu, verilen "S3 ~30 dk (tek başına)"
süresinin iki katını aştı. Koşular durdurulmadı: makinede aynı anda üç MATLAB süreci
vardı (biri S4 çalışması), CPU kullanımı sürekliydi ve sonraki koşular 23–41 dk'da
bitti. Takılma yoktu.

## Kalibrasyon sonucu

**Tablo 4 — hedef / kalibrasyonsuz / kalibre** (`kalibrasyon_tablosu.csv`).
Kalibrasyonsuz: m-dosyası değerleri; S3'te D-09'lu (`s3_k0`), S1/S2'de D-09'suz
ayrık model (`*_esd`).

**Serbest değişkenler**

| Senaryo | Değişken | m-dosyası | Kalibre | Değişim |
|---|---|---|---|---|
| S1 | K11 | 0,7865 | 0,786502 | +%0,0003 (s = 1,000003) |
| S1 | phase_deg1 | −0,44° | −0,3661° | +0,0739° (4,1 µs) |
| S2 | K12 | 0,794 | 0,767957 | −%3,28 |
| S2 | phase_deg2 | 0° | +0,1121° | +0,1121° (6,2 µs) |
| S3 | K13 / K33 | 0,45 / 0,39 | 0,44343 / 0,38431 | −%1,46 (oran sabit) |
| S3 | phase_deg3 | 0° | +0,6575° | +0,6575° (36,5 µs) |

**Kalibrasyon hedefleri**

| Senaryo | Büyüklük | Hedef | Kalibrasyonsuz | Kalibre | Fark (hedefe) | Durum |
|---|---|---|---|---|---|---|
| S1 | P_ac [W] | 249,6 | 258,49 | 247,21 | −2,39 (−%0,96) | ±%1 içinde |
| S1 | \|Q₁\| [var] | 0 … 7,9 | 33,19 | 1,93 | — | bant içinde, Q₁ > 0 |
| S2 | P_ac [W] | 253,2 | 269,60 | 253,80 | +0,60 (+%0,24) | ±%1 içinde |
| S2 | \|Q₁\| [var] | 24,1 … 26,7 | 27,66 | 24,43 | — | bant içinde, Q₁ > 0 |
| S3 | P_ac [W] | 281,2 | 299,40 | 279,90 | −1,30 (−%0,46) | ±%1 içinde |
| S3 | \|Q₁\| [var] | 19,9 … 23,6 | 30,39 | 21,41 | — | bant içinde, Q₁ > 0 |

**Bağımsız doğrulama (kalibre edilmedi)**

| Büyüklük | S1 hedef | S1 kalibre | Fark | S2 hedef | S2 kalibre | Fark | S3 hedef | S3 kalibre | Fark |
|---|---|---|---|---|---|---|---|---|---|
| I_ac RMS [A] | 2,26 | 2,2183 | −%1,8 | 2,33 | 2,4162 | +%3,7 | 2,31 | 2,2786 | −%1,4 |
| η [%] | 92,5 | 91,15 | −1,35 puan | 94,2 | 93,93 | −0,27 puan | 94,5 | 94,25 | −0,25 puan |
| P_dc [W] | 269,26 | 271,21 | +%0,7 | 270,18 | 270,19 | +%0,004 | 297,97 | 296,97 | −%0,34 |
| I_dc [A] | 0,624 | 0,6286 | +%0,7 | 0,684 | 0,6841 | +%0,02 | 0,697 | 0,6947 | −%0,32 |
| THD_I [%] | 15 | 39,5 | +24,5 puan | 47 | 56,7 | +9,7 puan | 14 | 14,8 | +0,8 puan |
| \|cosφ₁\| | 1,000 | 0,99997 | ≈0 | 0,995 | 0,99538 | +0,0004 | 0,997 | 0,99708 | +0,0001 |
| PF = P/(V·I) | 0,922 | 0,929 | +%0,8 | 0,898 | 0,867 | −%3,4 | 0,979 | 0,987 | +%0,8 |

Kalibrasyon öncesi → sonrası doğrulama ölçütleri (I_ac, η, THD): S1 2,317 → 2,218 A,
%91,49 → %91,15, %36,9 → %39,5; S2 2,568 → 2,416 A, %94,07 → %93,93, %56,7 → %56,7;
S3 2,434 → 2,279 A, %94,38 → %94,25, %10,9 → %14,8.

Okuma (İ5 dili):

- **S3:** Kalibre model, deneyin I_ac'sini −%1,4, verimini −0,25 puan, akım THD'sini
  +0,8 puan, P_dc'sini −%0,3 hata ile yeniden üretiyor. THD kalibre edilmedi: kalibrasyon
  öncesi %10,9 iken (hedef %14) kalibrasyon sonrası %14,8 oldu. Bu, susturmalı
  çalışmanın düşük akımdaki dalga biçimi bozulmasının modelde doğru büyüklükte
  olduğunu gösteren en güçlü bağımsız kanıttır.
- **S2:** Kalibre model P_dc ve I_dc'yi %0,02 içinde, verimi −0,27 puan hata ile
  yeniden üretiyor. I_ac +%3,7 ve THD +9,7 puan fazladır; PF'deki −%3,4 aynı farkın
  sonucudur. Model S2'de deneyden daha bozuk bir akım veriyor. Bu fark kalibrasyonla
  kapanmaz (iki serbest değişken P ve |Q|'ya harcandı); sınırlılık olarak yazılmalıdır.
- **S1:** Kalibre model I_ac'yi −%1,8, verimi −1,35 puan, P_dc'yi +%0,7 hata ile
  yeniden üretiyor. THD farkı (+24,5 puan) deney satırının iç tutarsızlığıyla birlikte
  okunmalıdır: deneyin P/(V·I) = 0,922 değeri cosφ₁ = 1 ile ancak THD ≈ %42 olduğunda
  tutarlıdır (İP-3). Modelin PF'si (0,929) deneyle %0,8 içinde, THD'si %39,5'tir.
  Model deney satırındaki P, V ve I ile tutarlıdır, %15 THD girdisiyle değil.
- **Senaryo sıralaması:** Verim sıralaması S1 < S2 < S3 deneyle aynıdır. S1 → S3
  verim artışı modelde +3,10 puan, deneyde +2,0 puandır; S1 → S2 artışı modelde +2,78,
  deneyde +1,7 puandır. Fark esas olarak S1 verimindeki −1,35 puanlık sapmadan gelir
  (S1 kaybı modelde 24,0 W, deneyde 19,7 W).

## Serbest değişkenlerin fiziksel yorumu

Değerlerin fiziksel karşılığı belirsizlikleriyle birlikte okunmalıdır. Belirsizlik,
deney toleransının (P ±%1; |Q| okuma belirsizliği ±12 var, İP-3) koşulardan ölçülen
duyarlılıklara bölünmesiyle bulundu.

| Senaryo | dP/d ln s [W] | dQ/dφ [var/°] | Genlik belirsizliği | Faz belirsizliği |
|---|---|---|---|---|
| S1 | ≈ 10 000 | ≈ −260 | ±%0,025 | ±0,05° |
| S2 | ≈ 660 | ≈ −30 | ±%0,4 | ±0,4° |
| S3 | ≈ 1 400 (yerel) | ≈ −12 … −25 | ±%0,2 | ±0,5 … 1° |

- **S1'de genlik değişmedi** (s = 1,000003). m-dosyasındaki K11 = 0,7865 deneyin
  P_ac'ını zaten %0,96 içinde veriyor. Faz farkı +0,074° (4,1 µs); bu, 1 µs ölü zaman
  ve sürücü yayılım gecikmeleri düzeyindedir. Bu fark Q'yu 33 var'dan 2 var'a taşır;
  yani S1'de kalibrasyonun bütün etkisi |Q| üzerindedir. m-dosyasındaki −0,44° de elle
  ayarlanmış bir değerdir (yorum satırı: "−0,007 rad").
- **S2'de genlik −%3,3, S3'te −%1,5 düştü.** Susturmalı çalışmada köprü akım kaynağına
  yaklaştığı için P genliğe duyarlıdır. Ortalama iletim süresi ~50 µs olduğundan
  %1,5–3,3'lük genlik farkı darbe başına ~0,7–1,6 µs'lik bir kısalmaya eşdeğerdir. Bu,
  gerçek donanımda IGBT açılma gecikmesi ve sürücü yayılım süresinin darbe
  genişliğinden yediği süre düzeyindedir. Modelde ölü zaman var, ama sürücü/anahtar
  gecikmeleri ve en küçük darbe etkileri yok; kalibre genlik bu eksikliği toplu olarak
  temsil eder. Bu yorum bir varsayımdır, donanım kaydıyla doğrulanmadı.
- **S2/S3 fazı** (+0,11° / +0,66°) yalnız |Q|'yu bant içine taşır ve faz
  belirsizliğinin (±0,4° / ±0,5–1°) içindedir. Fiziksel bir gecikme diye
  yorumlanmamalıdır. Deneyde PWM referansının şebekeye göre faz konumu belgelenmemiştir.
- **İşaret dalı:** Üç senaryoda da Q₁ > 0 dalı korundu (K-02a).

## Belirsizlik ve sınırlar

- **Oturma.** S2 ve faz kaydırılmış S3 koşularında 0,1 s'de son periyot ile
  0,08–0,10 s ortalaması arasında P_dc'de 0,4–0,5 W, η'da 0,1 puan fark var (S1'de
  yok). Tabloda son periyot değeri verildi; bu fark verim karşılaştırmasının
  belirsizliğidir.
- **Deney tarafı.** |Q| bandı cosφ'nin üç basamaklı okunmasından gelir; şebeke
  gerilimi okumasının 0,1 V çözünürlüğü |Q|'da ±12 var belirsizlik verir (İP-3).
  Kalibre |Q₁| bu nedenle yalnız bant içinde olup olmadığıyla değerlendirilir.
- **Tekillik.** İki hedefe iki serbest değişken ayarlandığı için P_ac ve |Q₁| uyumu
  doğrulama değildir. Doğrulama yalnız kalibre edilmeyen büyüklüklerdedir.
- **İşaret dalı.** Her senaryoda kalibrasyonsuz modelin dalı (Q₁ > 0, akım C
  noktasında gerilimin gerisinde) korundu. S1'de s1_k3 ters dala düştü
  (Q₁ = −7,79 var, |Q| bant içinde) ve kural gereği kabul edilmedi.

## Önerilen karar ve kayıt metinleri (ana oturuma)

**D-09 (güncelleme).** Durum: *doğrulandı*. Ölçülen etki (S3, kalibrasyonsuz,
`runs/2026-10-28_kalibrasyon/results/s3_k0` ile D-08 koşusu): P_ac +0,91 W (+%0,31),
Q₁ −2,50 var, I_ac +%0,21, η +0,006 puan, THD +0,02 puan. Q₁ etkisi açık çevrim ağ
hesabının (−0,92 var) değil, "evirici akımı sabit" üst sınırının (−2,43 var)
düzeyindedir; nedeni susturmalı köprünün sert gerilim kaynağı olmamasıdır. S1 ve
S2'de ayrıca ölçülmedi; kalibrasyon D-09'lu modellerle yapıldı.

**D-12 (öneri; sınıf: Paket / koşu yöntemi; ana oturumda D-11 dolu olduğu için D-12 olarak kaydedildi).** *Dosya/blok:* `inverter_s1s2_s2onarim_d08.slx`,
iki bağımsız devre. *Sorun:* iki fiziksel ağ aynı ode15s çözücüsünü paylaşıyor; bir
0,1 s koşusu ~4 saat sürüyor. *Düzeltme:* `calibrate_s1s3_20261028('prepare')`
diğer devrenin bağlantı bileşenini (çizgi + global Goto/From) `Commented = 'on'`
yapar, blok silinmez (`inverter_s1_*`, `inverter_s2_*`). *Etki:* ayrık ve birleşik
model farkı P_ac'da ≤ %0,017, Q₁'de ≤ 0,02 var, η'da ≤ 0,001 puan (Tablo 1); süre
4 sa → 22–69 dk. *Durum:* doğrulandı. Tezde yer almaz (yalnız yöntem).

**K-02b (öneri; K-02a'nın İP-4 uygulamasını günceller).** *Açık nokta:* K-02a, P'yi
faz, |Q|'yu genlik ile ayarlamayı öngörüyordu (İP-3 sert kaynak duyarlılıkları).
*Karar:* serbest değişkenler ve hedefler aynı kalır (s ve φ; P_ac ±%1, |Q₁| bandı,
2×2 birlikte çözüm, işaret dalı Q₁ > 0). Kalibrasyon ampirik Jacobian ile yapılır;
modelde P esas olarak genliğe, |Q| esas olarak faza bağlıdır. *Dayanak:* bu not;
köprünün Thevenin eşdeğeri S1'de |Z_th| = 1,7 Ω (ölü zaman), S2/S3'te 14–29 Ω
(süreksiz iletim). İP-3'ün V_A'ya göre duyarlılıkları pasif ağ için geçerlidir.
*Tezde:* "Benzetim modeli, senaryo başına modülasyon genliği ve referans fazı ile
deneyin etkin gücüne (±%1) ve reaktif güç büyüklüğüne (cosφ okuma bandı) kalibre
edilmiştir; diğer büyüklükler bağımsız doğrulamadır."

**K-20 (öneri; kalibre çalışma noktaları; K-19 S4 denetimine ayrıldığı için K-20 olarak kaydedildi).** *Açık nokta:* tezde ve S4'te hangi
K/faz değerleri kullanılacak? *Karar:* S1–S3 benzetim sonuçları kalibre noktalardan
verilir: S1 K11 = 0,7865, φ₁ = −0,3661°; S2 K12 = 0,76796, φ₂ = +0,1121°; S3
K13 = 0,44343, K33 = 0,38431, φ₃ = +0,6575°. K-09 parametre tablosunda bu altı değer
"kalibre" türüyle yer alır; m-dosyası değerleri "ilk değer" olarak not edilir. S4
(İP-5), S3 tabanını kalibre K13/K33/φ₃ ile alır (kapalı çevrimde ileri besleme terimi
aynı kalır). *Tezde:* bağımsız doğrulama satırları İ5 diliyle verilir; S2 THD/I_ac
farkı ve S1 deney satırının THD tutarsızlığı Bölüm 8'de sınırlılık olur.
*Yeniden açılır:* ham analizör kaydı ya da donanım gecikme ölçümü gelirse.

**Plan:** İP-4 ☑. Çıktı: bu not ve `runs/2026-10-28_kalibrasyon/kalibrasyon_tablosu.csv`.

## Açık noktalar

- S1 ve S2'de D-09'un ayrı etkisi ölçülmedi (yalnız S3). S1/S2'nin "kalibrasyonsuz"
  sütunu D-09'suz ayrık modeldir; bu yüzden D-09 etkisini (S3'te +0,9 W, −2,5 var
  düzeyinde) içermez.
- 0,1 s'de oturma tam değil: S2 ve S3'te son periyot ile 0,08–0,10 s ortalaması
  arasında P_dc'de 0,3–0,4 W, η'da 0,06–0,14 puan fark var. StopTime uzatılmadı.
- S2'deki I_ac (+%3,7) ve THD (+9,7 puan) farkı açıklanmadı. Olası kaynaklar: sıfır
  geçişi çevresindeki süreksiz iletim ayrıntısı (IGBT çıkış kapasitesi ve sürücü
  gecikmeleri modelde yok) ve diyot toparlanma parametreleri. Kalibrasyonla kapanmaz.
- S1 verim farkı (−1,35 puan, kayıp +4,3 W) açıklanmadı; S1 için kayıp ayrıştırması
  yapılmadı (D-08 notundaki açık nokta sürüyor).
- Genlik ve faz farklarının fiziksel yorumu (sürücü gecikmesi, darbe kısalması)
  donanım kaydıyla doğrulanmadı. S2/S3 fazları |Q| okuma belirsizliği içindedir.
- Senaryo başına hesap bütçesi (2–3 koşu) aşıldı: S1 4, S2 4, S3 6 kalibrasyon
  koşusu ve 2 eşdeğerlik koşusu, toplam 16 koşu (~10 saat süreç zamanı).
