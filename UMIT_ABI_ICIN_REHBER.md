# Ümit Abi için rehber

Bu sayfa, depoda neyin nerede olduğunu ve neye bakmanız gerektiğini anlatır.
Yazılımcı olmanız gerekmiyor. Tezi okumak için hiçbir şey kurmanız da gerekmiyor.

## 1. Önce bunları yapın

1. **Notlu PDF'i açın:**
   [Son tez, notlu sürüm](https://github.com/burhanbarakli/umit-pekparlak-doktora-tezi/releases/download/tez-2026-10-29/tez_guncel_2026-10-29_notlu.pdf)
   (230 sayfa, 75 MB). Depoya `upekparlak` hesabıyla giriş yapmış olmanız gerekir.
2. **Mavi kutuları okuyun.** "ÜMİT ABİ İÇİN NOT" yazan 5 kutu var; yerleri aşağıda
   [Bölüm 4](#4-mavi-notlar-çelişkiler)'te. Teslim sürümünde görünmezler.
3. **[Bölüm 5](#5-kararı-size-ait-olanlar)'teki kararlara bakın.** Teslimden önce sizden
   gelmesi gereken bilgiler orada.

İlk tezle farkı görmek isterseniz:
[ilk tez ↔ son tez karşılaştırması](tez-tamamlama/03_ILK_TEZ_YENI_TEZ_KARSILASTIRMA.md),
[şekil ve tablo eşlemesi](tez-tamamlama/05_SEKIL_TABLO_ESLEME.md).

| Belge | Ne için |
|---|---|
| [Notlu PDF](https://github.com/burhanbarakli/umit-pekparlak-doktora-tezi/releases/download/tez-2026-10-29/tez_guncel_2026-10-29_notlu.pdf) | Sizin için hazırlanan sürüm; mavi kutular açık |
| [Teslim PDF'i](https://github.com/burhanbarakli/umit-pekparlak-doktora-tezi/releases/download/tez-2026-10-29/tez_guncel_2026-10-29.pdf) | Mavi kutular kapalı, 226 sayfa |
| [İlk tez (Word)](https://github.com/burhanbarakli/umit-pekparlak-doktora-tezi/releases/download/tez-2026-10-29/ilk_tez_tez_tumu_8.docx) | Jüriye sunulan önceki sürüm |

## 2. Depoda ne var

Yalnız ilk üç satır sizi ilgilendirir, gerisine bakmanız gerekmez.

| Klasör | İçinde ne var | Size lazım mı |
|---|---|---|
| `tez-latex-v2/` | Son tezin kaynak metni (bölümler `chapters/` içinde) | Metne bakmak isterseniz; PDF yeterli |
| `tez-matlab-simulink/` | Simulink modelleri ve koşu sonuçları | Modelleri açmak isterseniz |
| `tez-tamamlama/` | Alınan kararlar ve modelde yapılan düzeltmeler | Bir kararın gerekçesini merak ederseniz |
| `dosyalar/` | Sizden gelen ham dosyaların listesi ve senaryo ekranları | Hayır |
| `tez-latex/` | Eski çalışma kopyası; son tez şekilleri buradan okunur | Hayır, silmeyin |
| `jüri istekleri/`, `tez-word/`, `matlab_ascii_work/` | Kaynak ve ara dosyalar | Hayır |
| `.claude/`, `CLAUDE.md`, `.gitignore` | Çalışma ortamı ayarları | Hayır |

Büyük dosyalar (ham arşivler, dalga kayıtları, PDF'ler) GitHub'da değil, Google Drive'dadır.
Bağlantılar [README](README.md#gite-girmeyenler-ve-google-drive) sonundaki tablolarda.
Drive klasörü ayrıca paylaşılır; açılmazsa Burhan'dan isteyin.

## 3. Bilgisayara indirme ve modelleri açma

### İndirme

1. Depo sayfasında yeşil **Code** düğmesine, sonra **Download ZIP** seçeneğine basın (yaklaşık 200 MB).
2. ZIP'i `C:\tez` gibi kısa bir klasöre açın. Windows yol sınırına takılmamak için uzun klasör
   adlarından kaçının.

Git kullanmanız gerekmez. Dosyaları GitHub'da değiştirmeyin; düzeltme isteğinizi Burhan'a iletin.

### S1, S2, S3 modelini açıp koşturma

Gereken: MATLAB R2023b, Simulink, Simscape Electrical.

1. MATLAB'ta **Current Folder** olarak şu klasöre geçin:
   `tez-matlab-simulink\runs\2026-10-28_parametre_tablosu\model\tez`
2. Senaryonun modeline çift tıklayın:

   | Senaryo | Ne | Model | Tezde |
   |---|---|---|---|
   | S1 | Klasik anahtarlama | `inverter_s1_kal.slx` | Bölüm 4 |
   | S2 | Nötr anahtar susturma | `inverter_s2_kal.slx` | Bölüm 4 |
   | S3 | Susturma + Sin³ | `inverter_senaryo3_kal.slx` | Bölüm 5 |

3. **Run** düğmesine basın.

Bilmeniz gerekenler:

- Parametreler kendiliğinden yüklenir, elle `.m` dosyası çalıştırmanız gerekmez.
- Kalibre değerler koşu başlarken gelir. Koşudan önce Workspace'te `K13 = 0.45` görürseniz
  sorun yoktur; koşu başlayınca `0.44343` olur.
- Koşu 0,1 s benzetim içindir ve Accelerator modunda yaklaşık 35 dakika sürer.
- Derleyici hatası alırsanız üst menüden Simulation Mode'u **Normal** yapın. Normal mod saatler sürer.
- "Port is not connected" uyarıları normaldir.

### S4 için ayrı durum

`inverter_senaryo4_kc.slx` çift tıklayıp koşturulursa tezdeki 25 A sonucunu vermez: dosya
2 × 470 µF DA bara ile açılır, tezdeki 2 × 5,6 mF ve kalibre değerler koşu betiğiyle verilir.
Tezdeki sonucu görmek için MATLAB'ta `tez-matlab-simulink` klasörüne geçip şunu yapıştırın
(yaklaşık 20 dakika):

```matlab
addpath('scripts'); run_s4_closed_loop_20261028('KC_PI_25A', 'PI', 25, 0.06, struct('Cdc', 5.6e-3, 'ust', struct('K14', 0.44343, 'K34', 0.384306, 'phase_deg4', 0.6575), 'model_kopya', 'model_a'))
```

Her senaryonun parametreleri:
[paket README'si](tez-matlab-simulink/incoming_real_data/models/2026-10-12_dort_senaryo_paketi/README.md).
Her koşunun ayrıntısı kendi klasöründeki README'dedir ([`runs/`](tez-matlab-simulink/runs/)).

## 4. Mavi notlar (çelişkiler)

Sayfa numaraları notlu PDF'in görüntüleyicide gösterdiği sayfadır.

| PDF sayfası | Not | Kısaca |
|---|---|---|
| 102 | S1 THD: deney %15, ilk tez %2,1, yeni tez %39,5 | Üç farklı değerin nereden geldiği |
| 103 | Tablodaki değerler ilk tezin benzetim değerleridir | Ekran tablosu kalibre değil; karşılaştırma kalibre modelden yapıldı |
| 111 | Karar: S1 karışıklığı tez iddiasını etkiler mi? | Ana iddialar etkilenmiyor; iki cümle için A/B seçimi burada |
| 127 | İstenen THD sınırına ulaşıldı mı? | Standart sınırlarıyla karşılaştırma; tezin metninde yok, yalnız bilgi için |
| 166 | S1 deney satırı: analizör ekranındaki çelişki | %15 THD ile aynı ekrandaki PF = 0,921 birbirini tutmuyor |

**En önemli çelişki S1 THD'sidir.** Deney tablosunda %15 yazıyor. Aynı analizör aynı anda
PF = 0,921 ve cosφ = 1,000 gösteriyor; bu ikisi ancak yaklaşık %42 THD ile mümkün. Model
%39,5 veriyor ve PF'yi deneye %0,8 yakın buluyor. Bu nedenle %15 tezde bulgu olarak kullanılmadı.
İlk tezdeki %2,1 ise desteklenmedi.

**Anlatı değişti:** "Klasik anahtarlamanın akım kalitesi iyi, susturma bozuyor" anlatısı
doğrulanmadı. Klasik anahtarlama da düşük güçte yüksek THD'lidir. Ters akım mekanizması ve
verim artışının yönü doğrulandı.

**Jüri sorusuna hazırlık:** "Model %40 veriyor, deney %15; model yanlış değil mi?" sorusunun
yanıtı sayfa 111'de yazılı.

## 5. Kararı size ait olanlar

- [ ] **Öğrenci numarası, savunma tarihi, onay sayfası jürisi.** Arşivde olmadığı için boş
      bırakıldı, uydurulmadı. Şu an yer tutucu olarak duruyor (PDF sayfa 3, 5, 7).
- [ ] **"%15'ten %47'ye" geçen iki cümle.** Seçenek A olduğu gibi kalır, seçenek B açıklamalı
      biçime çevrilir. Önerilen B. Metinler PDF sayfa 111'de.
- [ ] **Yapı önerileri.** Bağımsız bir okuma, ana metnin yaklaşık 166 sayfadan 145–150 sayfaya
      inebileceğini gösterdi (kalibrasyonu öne almak, uzun tabloları eke taşımak). Henüz uygulanmadı:
      [hakem raporu](tez-tamamlama/04_YAPI_HAKEM_RAPORU.md).
- [ ] **Tez başlığı.** "İleri beslemeli kontrol" ifadesi çıkarıldı. Yeni başlık danışman onayından
      geçmelidir (Karar K-11).

## 6. Sizin modellerde bulunup düzeltilenler

Sizin gönderdiğiniz dosyalar değiştirilmedi; düzeltmeler ayrı kopyalarda yapıldı.
Tam kayıt: [model düzeltme kaydı](tez-tamamlama/02_MODEL_DUZELTME_KAYDI.md).

| Kod | Sorun | Yapılan |
|---|---|---|
| D-01 | S1+S2 modelinde S2 devresinin kapı sinyali yoktu, IGBT'ler anahtarlanmıyordu | S3'ün susturmalı PWM'i K3 = 0 ile bağlandı |
| D-02 | `inverter_senaryo4.slx`, S3 modelinin kopyasıydı; L1 akım geri beslemesi yoktu | S4, S3 üzerine kuruldu |
| D-08 | Harici D1–D2 diyotlarıyla nötr IGBT diyotlarının parametreleri yer değiştirmişti | Yerlerine alındı (S1'de −%0,9, S3'te −%0,15 P_ac etkisi) |
| D-09 | EMC X kapasitörü dosyadaki eşdeğerle modellenmemişti | 0,5 µF / 0,2 Ω eşdeğeri kullanıldı |
| D-11 | 2 × 470 µF bara 25 A'da orta noktayı tutamıyordu; "20 A civarı" tavanının nedeni bu | Yalnız S4 benzetiminde 2 × 5,6 mF |

## 7. Savunmada sorulabilecek noktalar

Bunların hepsi tezde sınırlılık olarak yazılıdır; gizlenmedi.

| Konu | Durum | Bakılacak yer |
|---|---|---|
| S2 uyumu | Model deneyden %3,7 fazla akım, 9,7 puan fazla THD veriyor; kalibrasyonla kapanmıyor | Kesim 6.10 |
| S1 verimi | Model %91,15, deney %92,5; 24,0 W ile 19,7 W kayıp farkı açıklanamadı | Kesim 6.10 |
| Anma akımı DA barası | 25 A sonuçları 2 × 5,6 mF ile; deney donanımının 470 µF barası 25 A için yetersiz | D-11, Bölüm 8 |
| L2 değeri | Tezde 1000 µH (12.10 dosyası); 22.08 parametreleri ve senaryo ekranlarında 200 µH | Bölüm 3, Bölüm 8 |
| Sin³ anma akımında | 2,3 A'ya kalibre edildiği için 25 A'da 3. harmoniği artırıyor | PDF sayfa 127 |
| Sayısal gerçekleme | S4 analog eşdeğer olarak modellendi; bir periyot gecikmeli sayısal uygulamada L1 geri beslemesi kararsız, etkin sönümleme gerekir | K-19, Bölüm 8 |
| Anma gücünde deney | Deneyler yalnız yaklaşık 2,3 A'da; 25 A benzetimdir | K-08, Bölüm 8 |
| Ham kayıt | Deneyin ham kayıtları ve protokolü yok; özet tablo ve ekranlar kullanıldı | K-10, Bölüm 6 |
| GT-tipi mimari | Model paketi olmadığı için nitel; kanıt düzeyi "mimari tanım" | K-12, Bölüm 7 |
| Şekil çözünürlüğü | 42 fotoğraf ve ekran görüntüsü 300 dpi altında; özgünleri yok | K-25, Bölüm 6–7 |
| Ulusal tez örnekleri | Literatürde yabancı doktora tezleri var, YÖK kayıtlarına erişilemedi | K-26, Bölüm 2 |
