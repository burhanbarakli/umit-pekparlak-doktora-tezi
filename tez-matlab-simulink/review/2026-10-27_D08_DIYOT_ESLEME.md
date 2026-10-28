# D-08 diyot eşlemesi düzeltmesi: uygulama ve etki

Tarih: 27.10.2026 · MATLAB R2023b Update 7 · bu makine · İP-2b

## Amaç ve kapsam

Topoloji denetimi (`review/2026-10-27_TOPOLOJI_DENETIMI.md`) faz–DA rayı
konumundaki harici D1–D2 diyotlarının IXYN iç FRD (`DS34_*`), nötr IGBT ters
paralel diyotlarının (DS3–DS4) ise DSEI2x61-12B (`D12_*`) parametreleriyle
modellendiğini gösterdi (D-08). K-18'e göre doğrusu tersidir. Bu not, düzeltmenin
nasıl uygulandığını ve S3 ile S1+S2 modellerindeki sayısal etkisini belgeler.
Buradaki sayılar **tez bulgusu değildir**; kalibrasyon (İP-4) öncesi model
durumunu belgeler.

- Betikler:
  - `scripts/fix_diode_mapping_20261027.m` (düzeltme + denetim)
  - `scripts/run_umit_dort_senaryo_20261027.m` (0,1 s koşu, Display kaydı)
  - `scripts/extract_umit_display_values_20261027.m`
  - `scripts/compare_umit_dort_senaryo_20261027.py` (yeni model adları eklendi)
  - `scripts/run_diode_losses_20261027.m` (yeni; blok bazında kayıp ayrıştırma)
- Koşu klasörü: `runs/2026-10-27_diyot_esleme/`
  - `model/`: 12.10 paketinden `inverter_senaryo3.slx` ve
    `inverter_common_parameters.m` (SHA-256 paketle aynı), D-01 onarımlı
    `inverter_s1s2_s2onarim.slx` (onarım koşu klasöründekiyle aynı), üretilen
    `inverter_senaryo3_d08.slx` ve `inverter_s1s2_s2onarim_d08.slx`.
  - `inspection/<model>_diyot_esleme.{txt,csv}`: takas öncesi/sonrası tablo.
  - `results/<model>/`: Display değerleri, `kosu_bilgisi.txt`, `logsout.mat`
    (git'e girmez).
  - `kayip/`: kayıp ayrıştırma koşuları (ayrı klasör, Accelerator derlemesi
    ana koşuyla çakışmasın diye).
  - `karsilastirma.csv`, `regresyon_<baz koşu>.csv`.

## Düzeltme

Bağlantıya dokunulmadı, blok eklenmedi/silinmedi. Betik her `diode_thermal`
bloğunun rolünü bağlantı grafiğinden çıkarır:

- DA+ / DA− / dış orta düğüm: dış IGBT'lerin (S12 tablosu) C/E düğümleri;
- orta nokta: DA+–x ve x–DA− kapasitör çifti;
- ortak emetör ve faz düğümü: nötr IGBT'lerin (S34 tablosu) E ve orta noktada
  olmayan C düğümü.

Rolün beklediği önek (DS1/DS2 → `DS12`, DS3/DS4 → `DS34`, D1/D2 → `D12`) bloğun
kullandığıyla karşılaştırılır ve yalnız `DS34` ↔ `D12` farkı varsa o önekle
başlayan bütün diyalog parametreleri yeniden yazılır. Bulunan 18 parametre:
`ModelType, Vf, Ron, Goff, C_param, CJ, Q_param, iRM, iF, didt, trr, Qrr, Vr, Ls,
T_param, fidelity_level, thermal_network_parameterization, junction_thermal_mass`.
İki tablonun enum seçimleri (PWL, sabit kapasite, peaktime toparlanma, yük
dinamiği, dış ısıl ağ) ve `junction_thermal_mass` aynıdır; elektriksel fark
`Vf, Ron, CJ, iRM, iF, didt, trr, Qrr, Vr` değerlerindedir. Sayı olarak yazılmış
`CJ0 = 5`, `Tdevice = 25` ve `thermal_mass` değişmedi (D-10).

Ayrıca modele PreLoadFcn yazıldı (D-03; yeni model adına göre). Yeni model diskten
temiz taban çalışma alanında yeniden yüklendi: PreLoadFcn parametreleri tanımladı,
takas kalıcı, A/K düğümleri önce = sonra, derleme (`SimulationCommand update`)
başarılı. Kaynak `.slx` dosyalarının SHA-256'sı değişmedi.

**Tablo 1 — S3 takas öncesi/sonrası** (`inspection/inverter_senaryo3_d08_diyot_esleme.txt`)

| Blok | Rol | A → K | Önce | Sonra | Vf [V] | Qrr [µC] | trr [ns] | iRM [A] |
|---|---|---|---|---|---|---|---|---|
| Diode9 | DS1 (S1 ters p.) | dış orta → DA+ | DS12 | DS12 | 1,50 | 15,7 | 115 | −54 |
| Diode2 | DS2 (S2 ters p.) | DA− → dış orta | DS12 | DS12 | 1,50 | 15,7 | 115 | −54 |
| Diode6 | DS3 (S3 ters p.) | ortak E → orta nokta | **D12** | DS34 | 1,58 → 1,70 | 3,0 → 9,5 | 190 → 100 | −13 → −95 |
| Diode7 | DS4 (S4 ters p.) | ortak E → faz | **D12** | DS34 | 1,58 → 1,70 | 3,0 → 9,5 | 190 → 100 | −13 → −95 |
| Diode5 | D1 harici | faz → DA+ | **DS34** | D12 | 1,70 → 1,58 | 9,5 → 3,0 | 100 → 190 | −95 → −13 |
| Diode3 | D2 harici | DA− → faz | **DS34** | D12 | 1,70 → 1,58 | 9,5 → 3,0 | 100 → 190 | −95 → −13 |

S1+S2 modelinde aynı takas iki devrede yapıldı (8 blok):
A (S1) devresi Diode3/5 (D2/D1) ve Diode6/7 (DS3/DS4); B (S2) devresi Diode4/8
(D2/D1) ve Diode10/11 (DS3/DS4). DS1/DS2 (Diode9/2, Diode12/1) değişmedi
(`inspection/inverter_s1s2_s2onarim_d08_diyot_esleme.txt`).

## Koşu bilgisi

| Model | Mod | Duvar süresi | Durum |
|---|---|---|---|
| `inverter_senaryo3_d08` | Accelerator | 10 455 s | tamamlandı |
| `inverter_s1s2_s2onarim_d08` | Accelerator | 14 579 s | tamamlandı |
| `inverter_senaryo3` (kayıp ayrıştırma) | Accelerator | 10 263 s | tamamlandı |
| `inverter_senaryo3_d08` (kayıp ayrıştırma) | Accelerator | 1 884 s | tamamlandı |

StopTime 0,1 s; çözücü ayarları modelde kayıtlı haliyle. Duvar süreleri makinede
aynı anda 4–6 MATLAB süreci koştuğu için ilk koşudakinden (S3: 1624 s) uzundur;
yük azalınca aynı S3 koşusu 1884 s sürdü.

S1+S2 D-08 koşusunda çözücü altı anda (t ≈ 2,8 / 8,6 / 20,9 / 34,3 / 45,2 / 50,7 ms)
en küçük adım sınırına takıldığını bildirdi ("Solver is encountering difficulty",
toplam 9 uyarı) ve koşuya devam etti. Uyarıların hepsi ilk 51 ms'deki geçici
rejimdedir; Display değerlerinin alındığı 0,08–0,10 s penceresinde uyarı yoktur.

Aynı onarılmış S1+S2 modelinin D-08'siz koşusu (İP-1,
`runs/2026-10-27_s2_kapi_onarimi/`) 18:57'de başlatıldı ve 15 saatte bitmedi
(ilerleme kaydı yok); 28.10.2026 09:58'de durduruldu. D-08'li model aynı yük
altında 4 saatte tamamlandığından, D-01'in doğrulaması bu notun D-01 + D-08
koşusuyla yapılır (aşağıda). D-08'siz koşunun neden bu kadar yavaşladığı
incelenmedi; İP-4 taban modeli D-08'li olduğundan o modele yeniden dönülmez.

## Etki — S3 (Display değerleri, 0,08–0,10 s ortalaması)

Baz: değiştirilmemiş ilk koşu (`runs/2026-10-27_dort_senaryo_ilk_kosu/`, aynı
model eksi D-08). Kaynak: `runs/2026-10-27_diyot_esleme/regresyon_2026-10-27_dort_senaryo_ilk_kosu.csv`.

| Büyüklük | İlk koşu | D-08 sonrası | Fark | Deney hedefi |
|---|---|---|---|---|
| Vdc [V] | 427,449 | 427,449 | 0 | 427,5 |
| Idc [A] | 0,7407 | 0,7399 | −0,0008 (−%0,11) | 0,697 |
| P_dc [W] | 316,63 | 316,28 | −0,35 (−%0,11) | 297,97 |
| P_ac [W] | 298,94 | 298,48 | −0,46 (−%0,15) | 281,2 |
| P_dc − P_ac [W] | 17,69 | 17,80 | +0,11 | 16,77 |
| η [%] | 94,414 | 94,373 | −0,041 puan | 94,5 |
| I_ac RMS [A] | 2,4318 | 2,4284 | −0,0033 (−%0,14) | 2,31 |
| THD [%] | 10,862 | 10,904 | +0,042 puan | 14 |
| Q [var] | +33,011 | +32,998 | −0,013 | −21,83 (D-06) |
| cos φ | 0,99396 | 0,99395 | ≈0 | −0,997 |

Sonuç: D-08 S3'ün çalışma noktasını değiştirmiyor; verimi 0,04 puan düşürüyor,
kayıp 0,11 W artıyor. Hedefle aradaki fark (P_dc +18 W, I_ac +0,12 A) D-08'den
gelmiyor; İP-4 kalibrasyonunun konusudur.

## Kayıp ayrıştırması — S3 (son 20 ms, `ee_getPowerLossSummary`)

`run_diode_losses_20261027.m`: Simscape kaydı bellekte açılır (tüm bloklar, son
1,2 milyon adım = 0,065–0,100 s), son tam şebeke periyodu 0,08–0,10 s ortalanır.
Kaynak: `runs/2026-10-27_diyot_esleme/kayip/results/<model>/kayip_ozeti.csv` ve
`diyot_akimlari.csv`.

**Tablo 2 — blok kayıpları [W]**

| Blok (rol) | İlk model | D-08 sonrası | Fark |
|---|---|---|---|
| Diode6 (DS3) | 0,588 | 0,628 | +0,039 |
| Diode7 (DS4) | 0,588 | 0,627 | +0,039 |
| Diode5 / Diode3 (D1 / D2) | ≈0 (µA sızıntı) | ≈0 | 0 |
| Diode9 / Diode2 (DS1 / DS2) | ≈0 | ≈0 | 0 |
| N-Channel IGBT (S1), iletim + anahtarlama | 1,372 + 0,660 | 1,371 + 0,660 | −0,001 |
| N-Channel IGBT1 (S2), iletim + anahtarlama | 1,373 + 0,660 | 1,372 + 0,645 | −0,016 |
| N-Channel IGBT2 / IGBT3 (S3 / S4), iletim | 0,413 / 0,414 | 0,413 / 0,413 | −0,001 |
| L1 çekirdek kaybı (Rp) | 11,549 | 11,556 | +0,007 |
| Diğer (L1r, Rbleed, Cdc, CMC, CL1, Cf, DC Blocking Diode, …) | 1,25 | 1,25 | ≈0 |
| **Toplam** | **18,873** | **18,939** | **+0,066** |

**Tablo 3 — diyot akımları (0,08–0,10 s)**

| Blok (rol) | i_ort [A] | i_RMS [A] | i_min [A] önce → sonra |
|---|---|---|---|
| Diode6 (DS3) | 0,364 → 0,363 | 1,167 → 1,166 | −0,79 → −3,38 |
| Diode7 (DS4) | 0,364 → 0,363 | 1,167 → 1,165 | −0,78 → −3,31 |
| Diode5 / Diode3 (D1 / D2) | ≈0 | 2,6 µA → 4,8 mA | ±11 µA → ±0,31 A |

Yorum:

- Kararlı çalışmada D1–D2 (faz–ray diyotları) iletime girmez: faz gerilimi DA
  raylarını aşmıyor. D-08 sonrası görülen ±0,31 A tepeler `D12_Cj` = 31 pF
  bağlantı kapasitesinin anahtarlama kenarlarındaki yer değiştirme akımıdır;
  güç katkısı yoktur. Bu diyotlar yalnız başlangıçta (DA bara ön şarjı, ilk
  2 ms'de 2 kA'e varan tepe, deneme koşusu) ve hata/aşırı gerilim durumlarında
  etkindir.
- Sıfır durumunun serbest dolaşım akımını DS3/DS4 taşır (ortalama 0,36 A, RMS
  1,17 A). IXYN iç FRD'nin daha yüksek Vf (1,70 V / 1,58 V) değeri iletim kaybını
  diyot başına ~0,04 W artırır; toparlanma tepe akımı `iRM` −13 A → −95 A
  değiştiği için ters toparlanma tepe akımı −0,8 A'den −3,4 A'e çıkar (düşük
  akımda toparlanma enerjisine katkısı küçük).
- Nötr IGBT'ler S3'te alternans boyunca sürekli iletimde olduğundan (susturma)
  DS3/DS4 akımı bir nötr IGBT ile paylaşılır; S1/S2 dış anahtarlarının
  anahtarlama kaybı DS3/DS4 Qrr değişiminden pratikte etkilenmez
  (−0,015 W, IGBT1).
- Display üzerinden P_dc − P_ac farkı +0,11 W, blok toplamı +0,066 W; ikisi de
  aynı yönde ve aynı büyüklük düzeyinde. Mutlak düzeyde ise 17,69 W (Display) ile
  18,87 W (blok toplamı) arasında ~1,2 W fark var. Ölçüm noktasının dışında kalan
  bloklar (DC Blocking Diode + DC Source R, P_dc sensörünün kaynak tarafı) yalnız
  0,04 W açıklıyor; kalan fark bu notta **açıklanmadı** (olası kaynaklar: Display
  ortalama bloklarının pencere/örnekleme biçimi, `ee_getPowerLossSummary`'nin
  kapasitör/endüktör için ani güç ortalaması). Fark D-08'den bağımsızdır; İP-4'te
  kayıp bütçesi kurulurken ayrıca ele alınmalıdır.

## Etki — S1+S2 (onarılmış model, D-01 + D-08)

Kaynak: `runs/2026-10-27_diyot_esleme/karsilastirma.csv` ve
`regresyon_2026-10-27_dort_senaryo_ilk_kosu.csv`. Baz yine değiştirilmemiş ilk
koşudur. D-01 yalnız S2 devresine kapı sinyali ekler; S1 devresinin bağlantısı ve
kapıları aynı kaldığı için S1 sütunundaki fark D-08'in etkisidir.

**Tablo 4 — S1 (A devresi)**

| Büyüklük | İlk koşu | D-08 sonrası | Fark | Deney hedefi |
|---|---|---|---|---|
| Vdc [V] | 431,478 | 431,478 | 0 | 431,5 |
| Idc [A] | 0,6614 | 0,6548 | −0,0066 (−%1,0) | 0,624 |
| P_dc [W] | 285,37 | 282,53 | −2,84 (−%1,0) | 269,26 |
| P_ac [W] | 260,89 | 258,49 | −2,40 (−%0,9) | 249,6 |
| P_dc − P_ac [W] | 24,48 | 24,04 | −0,44 | 19,66 |
| η [%] | 91,422 | 91,492 | +0,070 puan | 92,5 |
| I_ac RMS [A] | 2,3463 | 2,3169 | −0,0294 (−%1,3) | 2,26 |
| THD [%] | 37,38 | 36,93 | −0,45 puan | 15 |
| Q [var] | +34,69 | +33,84 | −0,85 | 0 (D-06) |
| cos φ | 0,99127 | 0,99154 | +0,0003 | 1 |

S1'de D-08 etkisi S3'tekinin yaklaşık on katıdır (P −%1, η +0,07 puan). Beklendiği
gibi: S1'de nötr IGBT'ler tamamlayıcı anahtarlandığından DS3/DS4 her anahtarlama
periyodunda ters toparlanmaya girer ve D-08 bu diyotların toparlanma karakteristiğini
değiştirir. Kayıp ayrıştırması S1 için yapılmadı.

**Tablo 5 — S2 (B devresi, D-01 onarımı ilk kez anahtarlamada)**

| Büyüklük | İlk koşu (kapı yok) | D-01 + D-08 | Deney hedefi | Fark (hedefe göre) |
|---|---|---|---|---|
| Vdc [V] | 394,95 | 394,95 | 395,0 | 0 |
| Idc [A] | 0,0029 | 0,7258 | 0,684 | +%6,1 |
| P_dc [W] | 1,1 | 286,64 | 270,18 | +%6,1 |
| P_ac [W] | −0,4 | 269,65 | 253,2 | +%6,5 |
| P_dc − P_ac [W] | — | 16,99 | 16,98 | ≈0 |
| η [%] | — | 94,07 | 94,2 | −0,13 puan |
| I_ac RMS [A] | 0,347 | 2,569 | 2,33 | +%10,2 |
| THD [%] | (17,6) | 56,73 | 47 | +9,7 puan |
| Q [var] | +41,5 | +29,15 | \|−25,42\| | \|Q\| +3,7 var |
| cos φ | −0,011 | 0,9942 | \|−0,995\| | ≈0 |

S2 onarımı (D-01) doğrulandı: devre anahtarlanıyor ve güç aktarıyor; verim hedefin
0,13 puan, kayıp (P_dc − P_ac) hedefin 0,01 W içinde. |Q| hedef yuvarlama bandına
(24,1–26,7 var, K-02a) 2,5 var uzaklıkta. P_ac ve I_ac'deki +%6–10 fazlalık S1 ve
S3'teki sistematik fazlalıkla aynı yöndedir ve İP-4 kalibrasyonunun (K12,
phase_deg2) konusudur. S2'nin yüksek THD'si (susturmalı PWM'in düşük akımda
süreksiz iletimi) deneyle niteliksel olarak uyumludur: S2 hedefi de üç senaryonun
en yüksek THD'sidir.

## Değerlendirme

- D-08 bir cihaz eşleme hatasıdır ve K-18'e göre düzeltilmesi gerekir; ancak
  S3 çalışma noktasındaki sayısal etkisi küçüktür (η −0,04 puan, kayıp +0,1 W).
  Etki, DS3/DS4 iletim kaybındaki artıştan gelir.
- Düşük güçte nötr kolda dolaşan akımın kaybı (tezin ana sorunu) DS3/DS4 ve
  nötr IGBT'ler üzerinden akar; doğru eşlemeyle DS3/DS4 kaybı 2 × 0,63 W'tır.
  İP-4 kalibrasyonu ve tezdeki kayıp ayrıştırması D-08 sonrası modelle yapılmalıdır.
- S1'de etki daha büyüktür (P_ac −%0,9, η +0,07 puan), çünkü nötr kol tamamlayıcı
  anahtarlanır.
- Hedef tablosundan sapmanın (P_dc, I_ac, THD, Q işareti) kaynağı D-08 değildir.
- D-01 (S2 kapı onarımı) bu koşuyla doğrulandı: S2 verimi 94,07 % (hedef 94,2 %),
  kayıp hedefle eşit.

## Açık noktalar

- S1+S2 kayıp ayrıştırması yapılmadı (yalnız S3). S1'de nötr IGBT'ler
  tamamlayıcı anahtarlandığından DS3/DS4 Qrr'ının S1/S2 açılma kaybına etkisi
  S3'tekinden büyük olabilir; S1+S2 Display farkı bunu dolaylı olarak gösterir.
- Kayıp ayrıştırma `SimscapeLogType = all` ile yapıldı (yalnız bellekte; model
  kaydedilmedi). Blok bazında seçmeli kayıt programatik olarak açılamadı.
- `tez-latex-v2/chapters/03-sistem-model-metodoloji.tex` içindeki
  `tab:yariiletken-esleme` tablosu hâlâ eski eşlemeyi gösteriyor (İP-8).
