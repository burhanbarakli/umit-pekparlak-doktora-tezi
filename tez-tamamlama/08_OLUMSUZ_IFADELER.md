# Tezdeki olumsuz / kendini zayıflatan ifadeler

Tarih: 16.11.2026. Kaynak: `yeni_tez/` (Bölüm 1 sadeleştirmesinden sonraki hâl, ce16aaa).
Tez sahibinin isteği: "Şu iddiayı sağlamıyoruz, şunlar geçerli değildir" türündeki olumsuz
ifadeler teze konmayacak. Bu dosya yalnız **listedir**; tez metninde henüz hiçbir şey değişmedi.

Bütün dosyalar baştan sona okundu (üç ayrı okuyucu ajan, salt okuma). Satır numaraları örnekleme
ile dosyada denetlendi. Fiziksel olguyu anlatan olağan olumsuzluklar ("nötr anahtar akım
taşımamaktadır") ve `%` yorumları / `\umitnot` iç notları listeye alınmadı.

## Türler

| Kod | Tür | Örnek kalıp |
|---|---|---|
| A | İddia reddi | "iddia edilmemektedir", "anlamına gelmez", "kanıtlamaz", "üstünlük iddiası kurulmamıştır" |
| B | Doğrulanmamışlık / kanıt eksikliği | "doğrulanmamıştır", "ölçülmemiştir", "deney yoktur", "yalnız benzetim", "kayıtlarda yer almamaktadır" |
| C | Geçersizlik / genellenemezlik | "geçerli değildir", "genellenemez", "doğrudan karşılaştırılmaz", "atfedilemez" |
| D | Kapsam dışı / yapılmayan iş | "yapılmamıştır", "incelenmemiştir", "kapsam dışında", "gelecek çalışma" |
| E | Sınırlılık / belirsizlik itirafı | "yaklaşık", "sınırlılık", "kararsızdır", "iyimser gösterir", "sınırlıdır" |
| sınırda | Tona bağlı; kalabilir ya da olumlu dille yeniden yazılabilir | |

`\eksikistek` (turuncu bar) tezin hiçbir dosyasında yok.

## Sayılar

| Dosya | Bulgu | Kesin (A–E) | Sınırda |
|---|---|---|---|
| onkisim/ozet.tex | 7 | 2 | 5 |
| onkisim/summary.tex | 18 | 10 | 8 |
| 01-giris.tex | 24 | 12 | 12 |
| 02-literatur.tex | 20 | 10 | 10 |
| 03-sistem-model-metodoloji.tex | 57 | 32 | 25 |
| 04-dusuk-guc-anahtarlama.tex | 20 | 9 | 11 |
| 05-sin3-kompanzasyon.tex | 48 | 31 | 17 |
| 06-deneysel-dogrulama.tex | 61 | 43 | 18 |
| 07-gt-tipi-mimari.tex | 34 | 20 | 14 |
| 08-sonuc.tex | 50 | 39 | 11 |
| ekler.tex | 0 | 0 | 0 |
| **Toplam** | **339** | **208** | **131** |

## Ayıklamadan önce birlikte karar verilmesi gerekenler

1. **Bölüm 8 "Çalışmanın Sınırlılıkları" kesimi (08:81–101) tamamen olumsuz.** 13 madde, giriş ve
   kapanış cümlesi var. Kesim kaldırılırsa şu çapraz atıflar boşa düşer: 02:321, 03:436, 03:549,
   03:686, 04:204, 06:6, 06:578 ("Bölüm~\ref{chap:sonuc} içinde sınırlılık olarak yer alır").
   SAÜ FBE kılavuzunun sonuç bölümünde sınırlılık isteyip istemediği ayrıca kontrol edilmeli.
2. **Olumsuz hücreleriyle anlam taşıyan tablolar:** `tab:deney-juri-durum` (06:463–465, "Deney
   yapılmamıştır"), `tab:gt-dogrulama-matrisi` (07:362–370, "Gelecek çalışma"), Bölüm 8 araştırma
   soruları tablosunun "Geçerlilik sınırı" sütunu (08:14–27), Bölüm 3 kanıt sınırları tablosunun
   "Tek başına kanıtlamadığı konu" sütunu (03:56–66) ve parametre tablosundaki "sınırlılık:"
   ibareleri (03:440 tanımı; 461, 479, 488, 519, 525, 535). Hücre hücre silmek yerine tablo
   yeniden kurulmalı ya da kaldırılmalı.
3. **Sayısal gerçekleme kararsızlığı zinciri:** 05:264, 05:431, 05:440, 05:542, 08:26, 08:48,
   08:93, summary:19, ozet:5 ve kararlılık tablolarının B/B2 satırları ile Nyquist şekli aynı
   bulguya dayanıyor. Zincirin bir kısmı silinirse S4'ün neden analog eşdeğer olarak sunulduğu
   gerekçesiz kalır.
4. **Model düzeltme tablosu (03:675–680) ve 03:684–690 paragrafları** birbirine dayanıyor.
5. **Özet ile Summary aynı biçimde ayıklanmalı.** Summary'de Özet'te bulunmayan çok sayıda olumsuz
   ayrıntı var (S1 THD %39,5 sapması, S2 akım/THD fazlası, 10 A başarımı, 25 A'de Sin³ etkisi,
   |z|=1,18, ham veri ve tekrar yokluğu, model hataları).
6. **Çıkarılması önerilmeyenler (yöntemin gerekçesi):** THD'nin %15'ten %47'ye çıkması
   (ozet:5, 01:73, 04:55) susturmanın bedelidir ve Sin³ katkısının gerekçesidir. Silinirse Bölüm 5'in
   motivasyonu kopar. Olumlu dille ("bedel", "ödünleşim") kalması önerilir.
7. **Silmek yerine düzeltilmesi gereken çelişkiler:**
   - summary:23 GT-tipi prototipi gelecek iş sayıyor; summary:21, ozet:5, 01:21, 01:158, 03:75 deney
     düzeneğinin zaten GT-tipi kurulduğunu söylüyor.
   - 04:33 "kayıtlar yalnız kutup gerilimi ve şebeke akımını içerir" diyor; 04:183 L1 akımının
     yeniden kaydedildiğini söylüyor. 04:33 eskimiş görünüyor.
   - 06:389 "S2–S3 verim farkı (0,3 puan) belirsizlik alt sınırının içindedir" diyor; 06:347, 08:34,
     08:119 verimin "%94,5'e taşındığını" söylüyor.
   - 04:80 "σ=1" ve 04:33 eşik/histerezis cümleleri silinirse, tanımlanan etkinleştirme kuralı
     (Eş. 65–80) uygulanmış gibi görünür; kural ya da cümleler birlikte ele alınmalı.
8. **Tekrarlar** (en azından kısaltılabilir): 03:485 = 03:697; 03:436 = 03:519 = 03:549;
   02:227 içindeki iki cümle; 05:243 = 05:356; 05:502 = 05:534; 05:266 = 05:534; 06:4 = 06:389 =
   06:584 = 07:370 = 08:88; 06:316 = 06:383 = 08:87; 06:6 = 08:92.

---

## onkisim/ozet.tex

| dosya:satır | tür | ifade | not |
|---|---|---|---|
| ozet:5 | sınırda | "karşılığında akımı süreksiz iletime zorlayarak şebeke akımı THD'sini deneyde yüzde 15'ten yüzde 47'ye çıkarmıştır" | Yöntemin bedeli; Sin³ gerekçesi. Kalması önerilir. |
| ozet:5 | sınırda (E) | "yapılan tarama, katsayıların çalışma noktasına bağlı olduğunu göstermiş" | Çıkarılabilir. |
| ozet:5 | sınırda (E) | "bir periyot gecikmeli sayısal gerçekleme ise aktif sönümleme gerektirir" | Çıkarılırsa Bölüm 5 ile ton farkı. |
| ozet:5 | sınırda (B) | "şarj yönünün işlevsel bütünlüğü benzetim kayıtlarıyla gösterilmiş" | |
| ozet:7 | sınırda (E) | "Benzetim modelleri tez tanımına göre denetlenip düzeltilmiş" | Model hatası ima ediyor. |
| ozet:7 | B/E | "deneyler düşük güçte yapılmış, orta ve anma akımı sonuçları benzetime dayanmaktadır" | |
| ozet:7 | B/D | "GT-tipi mimarinin şarj yönü ve kip geçişi donanım deneyiyle sınanmamıştır." | 3. katkıyı zayıflatıyor. |

## onkisim/summary.tex

| dosya:satır | tür | ifade | not |
|---|---|---|---|
| summary:9 | sınırda (E) | "the problems found, such as an EMC capacitor not matching its single-phase equivalent and mis-mapped diodes, were corrected" | Özet'te yok; asimetri. |
| summary:13 | E | "the larger model gain stems from a −1.35 point deviation of the S1 efficiency" | |
| summary:13 | E | "...in S1 the model gives an approximate THD of 39.5 %" | Deney %15. |
| summary:13 | E | "In S2 the model overestimates the AC current by 3.7 % and the THD by 9.7 points, and the source of this gap is reported as a limitation." | Özet'te yok. |
| summary:15 | sınırda (C) | "simplified derivations are shown to lie outside their validity range..." | Kimin türetmesi olduğu belirsiz. |
| summary:15 | sınırda (E) | "and the coefficients depend on the operating point" | |
| summary:17 | sınırda (E) | "The enlargement is needed because ... the midpoint would swing by about 120 V at 25 A" | Donanım barası anma akımına yetmiyor. |
| summary:17 | C/E | "At 10 A, however, the suppressed bridge is in discontinuous conduction ... THD is 19.6–22.6 % ... −23 % and −11 % amplitude error. Suppression is therefore a low-power method." | Özet'te yok. |
| summary:17 | E | "At 25 A the Sin³ gain calibrated at 2.3 A increases the third harmonic..." | |
| summary:19 | sınırda | "in the switched model the differences remain at the level of measurement uncertainty" | |
| summary:19 | E | "A digital implementation ... is unstable in this LCL filter ... |z|=1.18 ... needs active damping or grid-current feedback." | Güçlü aleyhte. |
| summary:21 | sınırda (B) | "the charging chain ... is shown in simulation" | |
| summary:21 | A/B | "Cost, volume and loss advantages ... are stated as potential, because the charging direction and the mode transition have not been tested in hardware." | |
| summary:23 | sınırda (E) | "Conclusions and limitations. ... The main limitations are the following." | |
| summary:23 | B/E | "the experiments were carried out only at about 2.3 A and are available as screen records ... without raw data or repetitions" | En güçlü kanıt zaafı. |
| summary:23 | B | "The medium- and rated-current results rely on simulation with an enlarged DC bus and analogue-equivalent control." | |
| summary:23 | B/D | "L2 is an equivalent ... that was not measured directly, and L1 saturation is not modelled." | |
| summary:23 | D | "... a digital controller with active damping and a GT-type prototype are proposed as future work." | **Çelişki:** düzenek zaten GT-tipi (summary:21). |

## bolumler/01-giris.tex

| dosya:satır | tür | ifade | not |
|---|---|---|---|
| 01:17 | sınırda | "Verimdeki olası iyileşmenin karşılığında, özellikle üçüncü harmonik bileşeninde artış ortaya çıkabilmektedir." | "olası" kazancı belirsizleştiriyor. |
| 01:35 | sınırda (E) | "uygulanabilirliğini mevcut kanıtlarla değerlendirmek" | |
| 01:56 | sınırda (E) | "Katkı, klasik ayrık mimariyle ... nitel olarak karşılaştırılmaktadır." | |
| 01:56 | sınırda (B) | "şarj yönünün işlevsel bütünlüğü benzetim kayıtlarıyla gösterilmiştir" | |
| 01:56 | B/D | "Şarj yönünde donanım deneyi yapılmadığından ve kip geçişi sınanmadığından katkı, mimari öneri düzeyindedir." | 3. katkıyı "öneri"ye indiriyor. |
| 01:73 | sınırda | "Bedeli süreksiz iletim ve üçüncü harmoniktir: akım THD'si deneyde %15'ten %47'ye, benzetimde %39,5'ten %56,7'ye çıkar." | Bedel; benzetim–deney S1 farkı görünür. |
| 01:73 | C/E | "10 A'de süreksiz iletim şebeke periyodunun büyük kısmını kaplar ve THD %20 düzeyindedir. Dolayısıyla susturma, düşük güç bölgesine özgü bir yöntemdir." | |
| 01:79 | B | "Düşük güçte deney ve benzetim, anma akımı ve kararlılıkta yalnız benzetim" | Tablo hücresi. |
| 01:83 | B | "Kayıp, maliyet ve hacim üstünlüğü sayısal olarak gösterilmemiştir." | Tablo hücresi. |
| 01:84 | B/E | "Mimari öneri düzeyi: evirici kipinde deney, şarj yönünde nitel benzetim kaydı" | Tablo hücresi. |
| 01:89 | sınırda (A) | "Fikrî mülkiyet çıktıları, bilimsel doğrulamanın yerine kullanılmamaktadır." | |
| 01:91 | sınırda | Alt bölüm başlığı "Kapsam ve Sınırlar" | |
| 01:94 | A | "Terimin bağımsız bir kapalı çevrim kontrol yasası veya genel amaçlı aktif harmonik filtre yöntemi olduğu iddia edilmemektedir." | |
| 01:96 | D | "Anma gücünde geri beslemeli deney ve GT-tipi şarj yönü deneyi yapılmamıştır." | |
| 01:96 | C | "Sonuçlar kullanılan DA bara gerilimi, ... ve incelenen güç seviyeleri için geçerlidir." | |
| 01:96 | B/C | "Deneyle doğrulanmamış çalışma bölgelerine ilişkin ifadeler genellenmemektedir." | |
| 01:96 | sınırda (E) | "Donanımın anma gücü değerleri tasarım hedefi olarak verilmektedir." | |
| 01:96 | D | "... sınırlandırıldığından tam anma gücünde deney yapılmamıştır." | |
| 01:96 | sınırda (B) | "Anma akımı koşulu, 25 A hedefli kapalı çevrim benzetimiyle incelenmiştir." | |
| 01:96 | A/E | "GT-tipi mimarinin maliyet, hacim ve eleman sayısı bakımından sağladığı yararlar ``potansiyel'' olarak ifade edilmektedir." | |
| 01:96 | D | "Ayrıntılı yaşam döngüsü maliyeti veya seri üretim güvenilirlik çalışması yapılmamıştır." | |
| 01:146 | sınırda | TikZ düğümü: "Araştırma sorularının yanıtları,\\sınırlılıklar (Bölüm~\ref{chap:sonuc})" | Şekil 1.1 metni. |
| 01:156 | B/E | "Bölüm, tam anma gücünde deney bulunmadığını sınırlılık olarak belirtmektedir." | |
| 01:158 | sınırda (E) | "araştırma soruları kanıt sınırları içinde yanıtlanmakta" | |

## bolumler/02-literatur.tex

| dosya:satır | tür | ifade | not |
|---|---|---|---|
| 02:74 | A | "Tablo, ... araştırma sorusu olduğunu gösterir; tek başına maliyet azalımını kanıtlamaz." | |
| 02:76 | sınırda (C) | "... temsilî ilişkileri gösterdiğinden tasarım sınırı olarak kullanılmamalıdır." | |
| 02:148 | sınırda (A) | "Sayısal ömür artışı ancak hücre kimyası, görev profili, sıcaklık ve yaşlanma testi birlikte verildiğinde ileri sürülebilir." | |
| 02:186 | sınırda (A) | "... birini genel olarak en iyi ilan etmek yerine ..." | |
| 02:188 | sınırda | "Bütünleştirme, yalnızca eleman sayısını azaltma iddiasıyla değerlendirilemez; ... kayıp ve doğrulama düzeyi birlikte verilmelidir." | Tezin GT için karşılamadığı ölçüt (01:83). |
| 02:211 | B | "... profiller ölçülmüş saha verisi değil, temsilî profil olarak adlandırılmıştır." | |
| 02:225 | B | "Eşitlik~\eqref{...} ölçülmüş bir saha modeli değil, iki normalize dizinin çarpımıdır." | |
| 02:227 | C | "%23,6 oranı gerçek yıllık çalışma süresini değil, kullanılan temsilî örnekleme düzeninin dağılımını ifade etmektedir." | |
| 02:227 | C | "Sonuç olarak %23,6 değeri evrensel bir yıllık oran olarak değil, ... temsilî örneklem sonucu olarak kullanılmaktadır." | Önceki cümlenin tekrarı. |
| 02:275 | B | "... belirli bir ürünün veri sayfası ya da tezin deney sonucu değildir. Paneller (b) ve (d) ... tez katkısının performans kanıtı olarak kullanılmamaktadır." | |
| 02:286 | sınırda (B) | "belirli harmoniklerin T-tipi nötr kol mekanizmasından kaynaklandığını tek başına kanıtlamaz" | |
| 02:288 | B | "... gözlem kaydı olarak kullanılmış, tezin deney kanıtı sayılmamıştır." | |
| 02:292 | sınırda (E) | Tablo başlığı: "(motivasyon amaçlı gözlem kaydı)" | |
| 02:315 | sınırda (E) | Şekil başlığı: "veri motivasyon amaçlı gözlem kaydıdır" | |
| 02:319 | A/B | "bir gözlem kaydı olarak önerilen anahtarlama yönteminin başarısını kanıtlamaz" | |
| 02:321 | E | "Temsilî FV profili ile ticari evirici kaydının tezdeki rolü motivasyonla sınırlıdır." | |
| 02:321 | B | "... PVGIS ham çıktısına, ... ise cihaz modeli, analizör ve ölçüm penceresi belgelenmiş bir ham kayda dayanmamaktadır." | |
| 02:321 | B | "... tezin verim ve THD bulgularına sayısal girdi oluşturmaz. Saha profilinin ölçülmüş olmaması Bölüm~\ref{chap:sonuc} sınırlılıklarına alınmıştır." | Bölüm 8'e çapraz atıf. |
| 02:383 | sınırda (E) | "karşılığında katsayının akım düzeyiyle değişmesi gerekir" | |
| 02:445 | sınırda (E) | "erişilebilir benzetim/deney kanıtı üzerinden sınanacaktır" | |

## bolumler/03-sistem-model-metodoloji.tex

| dosya:satır | tür | ifade | not |
|---|---|---|---|
| 03:5 | D | "anma gücünde deney de aynı güvenlik gerekçesiyle yapılmamıştır" | |
| 03:52 | sınırda | "Tek bir modelin bütün iddiaları aynı doğrulukla desteklediği varsayılmamıştır." | |
| 03:56–66 | sınırda (C) | Tablo başlığı "... kanıt sınırları", sütun "Tek başına kanıtlamadığı konu", 66: "Test edilmeyen çalışma bölgesine genelleme" | Bütün sütun sınırlılık. |
| 03:107 | D/E | "minimum darbe sınırı ve nötr nokta dengeleme müdahalesi modelde yoktur" | |
| 03:355 | sınırda (B) | "yalnızca ideal LCL ifadesinden çizilen Bode grafiği nihai kanıt sayılmamıştır" | |
| 03:364 | D/E | "Laboratuvar deneylerinde (S1--S3) akım denetleyicisi kullanılmamış, modülasyon referansı açık çevrimde uygulanmıştır." | |
| 03:434 | B/D | "Donanımın PWM ve denetim kaynak kodu tezde kullanılmamıştır." | |
| 03:436 | E | "Model tabanlı tanımın iki sınırı vardır. İlk olarak, donanımın ADC örnekleme anı, görev oranı güncelleme anı ve hesaplama gecikmesi benzetim modelinde temsil edilmemiştir." | |
| 03:436 | E | "İkinci olarak, susturma ve Sin³ teriminin donanımdaki etkinleşme eşiği ile histerezisi bilinmediğinden ... İki sınır Bölüm~\ref{chap:sonuc} içinde sınırlılık olarak değerlendirilir." | Bölüm 8'e çapraz atıf. |
| 03:440 | sınırda (B) | "\emph{Tasarım} değeri, ... ve ayrıca ölçülmemiş büyüklüktür." | Tablodaki tasarım değerlerinin hepsini "ölçülmemiş" yapıyor. |
| 03:440 | E | "Donanımdaki karşılığı bilinmeyen büyüklükler tahminle doldurulmamış, ilgili satırda ``sınırlılık'' olarak işaretlenmiştir." | Tablodaki "sınırlılık:" ibarelerinin tanımı. |
| 03:461 | D/E | "Tasarım; sınırlılık: anma gücünde deney güvenlik gerekçesiyle yapılmamıştır" | Tablo hücresi. |
| 03:479 | E/B | "sınırlılık: tam parça kodu bilinmemektedir, denetim yazılımı tezde kullanılmamıştır" | Tablo hücresi. |
| 03:485 | C | "S4 verimi S1--S3 verimiyle doğrudan karşılaştırılmaz" | 03:697 ile aynı. |
| 03:488 | B | "sınırlılık: doğrudan empedans ölçümü yoktur" | Tablo hücresi. |
| 03:491, 493 | sınırda (E) | Tür sütununda "Düzeltilmiş" | |
| 03:498 | sınırda (D) | "Modele katılmayan donanım öğeleri" satırı | |
| 03:503 | sınırda (E) | "veri sayfası eğilimine dayalı düşük akım ara değerlemesi" | |
| 03:504 | sınırda (E) | "(2--3 A bölgesi için başlangıç değeri)" | |
| 03:507 | sınırda (E) | "düşük akım bölgesi ara değerleme" | |
| 03:513 | sınırda (D) | "25, sabit; ısıl model etkisiz" | |
| 03:519 | E | "sınırlılık: donanımın ADC örnekleme ve görev oranı güncelleme anı modelde temsil edilmemiştir" | 03:436 tekrarı. |
| 03:525 | E | "Senaryo boyunca sürekli etkin; akım eşiği ve histerezis tanımlı değil ... sınırlılık: donanımdaki etkinleşme eşiği modelde temsil edilmemiştir" | |
| 03:529 | sınırda | "ideal faz bilgisi" | |
| 03:535 | E | "gecikme yok (analog eşdeğer) ... sınırlılık: periyot başında tek örnekli sayısal gerçekleme aktif sönümleme gerektirir" | |
| 03:549 | E | "Tablo~\ref{...} içindeki sınırlılıklar üç kümede toplanır. Birinci küme ...: anma gücü ifadeleri tasarım hedefi olarak kalmakta, deneyler ... 2,3 A düzeyinde yürütülmüştür." | Paragrafın tamamı sınırlılık özeti. |
| 03:549 | E | "... donanımın denetim yazılımı, ADC örnekleme anı ve susturma ile Sin³ teriminin etkinleşme eşiği modele aktarılmamıştır." | |
| 03:549 | E | "L2 doğrudan ölçülmemiş bir eşdeğerdir ...; S4 orta ve anma akımı benzetimlerinin DA bara kapasitörleri deney donanımındaki değerden büyüktür." | |
| 03:554 | B | "Değer doğrudan empedans ölçümüyle doğrulanmamıştır." | |
| 03:554 | sınırda (E) | "Kaynak belgelerde görülen 200 µH ve 400 µH değerleri ... çelişen kaynaklar arasında ..." | |
| 03:556 | E | "L2 değerindeki belirsizliğin iki sonucu vardır. ... sayısal akım denetiminin kararlılığı L2'ye duyarlıdır" | |
| 03:561 | sınırda (E) | "Harici diyotlar ile nötr IGBT ters paralel diyotlarının parametre kümeleri ise yer değiştirmiş bulunmuş ..." | |
| 03:585 | D | "Isıl model etkisizdir ...; sıcaklığa bağlı kayıp artışı sonuçlara dâhil değildir." | |
| 03:590 | B | "Dördüncü kol (S4) ... yalnız benzetimde yer alır." | |
| 03:592 | B | "Deneyler güvenlik gerekçesiyle yalnız düşük güç noktasında yürütülmüştür; orta ve anma akımı bölgesi ile geçici rejim, ... S4 benzetimiyle incelenmiştir." | |
| 03:604–608 | sınırda (B) | Doğrulama matrisinde beş satır "Benzetim." | |
| 03:636 | B/E | "analizörün pencere uzunluğu ve harmonik üst sınırı özet kayıtta yer almaz" | |
| 03:649 | B/E | "Haberleşme kayıtları ... geçici rejim değerlendirmesi için yetersizdir; tezde geçici rejim yalnız benzetimle incelenmiştir." | |
| 03:651 | B | "ham analizör kaydı, deney protokolü ve tekrar sayısı deney kanıtında yer almaz. Deney kanıtının kapsamı ve sınırlılığı ... ayrıca değerlendirilir." | En güçlü kanıt zaafı. |
| 03:658 | sınırda | "Bulunan her uyumsuzluk, ... en küçük değişiklikle düzeltilmiştir." | |
| 03:675 | sınırda (E) | "S2 devresinin dört kapı işaretini üreten PWM bağlantısı tanımlı değil; kapı yolu olmadan P_ac=−0,4 W ..." | Model düzeltme tablosu; 03:684'e dayanak. |
| 03:677 | sınırda | "Benzetimde Q=+33...+35 var, deney özetinde 0 ya da negatif" | |
| 03:678 | sınırda (E) | "harici D1--D2 ile DS3--DS4 diyotlarının parametre kümeleri yer değiştirmiş" | |
| 03:679 | sınırda (E) | "X kapasitörü 1 µF/0,01 Ω ile modellenmiş" | |
| 03:680 | E | "2×470 µF DA bara 25 A'de orta noktayı yaklaşık ±120 V ... salındırıyor; S4 akımı hedefin %32 altında, modülasyon doyumda" | |
| 03:684 | E | "aktif güç ve akımdaki %6--10 fazlalık S1 ile S3'teki sistematik fazlalıkla aynı yöndedir ve kalibrasyonla giderilmiştir" | |
| 03:686 | E/C | "25 A'de ise faz başına modelde evirici gereken gerilimi üretemez. Anma akımı sonuçlarının deney donanımından daha büyük bir DA bara ile elde edildiği Bölüm~\ref{chap:sonuc} içinde sınırlılık olarak yer alır." | Bölüm 8'e çapraz atıf. |
| 03:688 | B | "Deney özetindeki reaktif güç doğrudan ölçülmemiş, aktif güç ve cos φ değerinden hesaplanmıştır; analizörün işaret kuralı özet kayıtta yer almadığından ..." | |
| 03:695 | sınırda (E) | "Cihaz modellerinin veri sayfası noktaları ise 50--100 A bölgesindedir. Düşük akım bölgesinde modelin doğruluğunu dört etki belirler" | |
| 03:697 | sınırda (E) | "ara değerlemedeki bir belirsizlik verimi ancak aynı oranda etkiler" | |
| 03:697 | C | "S4 verimi S1--S3 verimiyle doğrudan karşılaştırılmaz." | 03:485 tekrarı. |
| 03:699 | C/D | "... parazitik endüktanslar modellenmediğinden fiziksel genlik taşımaz ve cihaz zorlanması değerlendirmesinde kullanılmamıştır." | |
| 03:726 | sınırda | "kapı sürücüsünün ek yayılım gecikmesi ise sıfır alınmıştır" | |
| 03:726 | B | "Yorum bir varsayımdır ve donanım kaydıyla doğrulanmamıştır." | |
| 03:726 | C | "S2 ve S3'ün kalibre fazları faz belirsizliği içindedir ve fiziksel bir gecikme olarak yorumlanmamalıdır." | |
| 03:728 | E/D | "Düşük akımda modelin temsil etmediği etkiler sınırlılık olarak kaydedilmiştir: IGBT çıkış kapasitesi ..., yüksek akımda L1 doyumu. ..." | |
| 03:734 | sınırda | "Benzetim modelinin doğrulanmasında bulunan uyumsuzluklar ... düzeltilmiş" | |

## bolumler/04-dusuk-guc-anahtarlama.tex

| dosya:satır | tür | ifade | not |
|---|---|---|---|
| 04:24 | sınırda (E) | "...tek başına kayıp enerjisi veya gücü vermez, farklı anahtarlama yöntemlerindeki dolaşımı karşılaştırmak için kullanılır." | Tanımın parçası. |
| 04:29 | sınırda (E) | "Eşitlik~\eqref{eq:iletim-kaybi-yaklasik} anahtarlama enerjisini ve sıcaklık bağımlılığını içermeyen ilk mertebe bir iletim modelidir." | |
| 04:31 | D | "Klasik anahtarlama için blok bazında ayrıştırma yapılmamıştır; S1 ile S2 arasındaki kayıp farkı DA ve AA güçlerinin farkından değerlendirilmiştir" | 04:168 ile birlikte. |
| 04:33 | B/D | "Benzetimde susturma senaryo boyunca sürekli etkin tutulmuş, eşik ve histerezis için sayısal değer varsayılmamıştır; donanımdaki eşik değerleri kayıtlarda yer almamaktadır." | 04:80 ile birlikte. |
| 04:33 | sınırda (E) | "...kalibre benzetimlerin kayıtları kutup gerilimi ile şebeke akımını içerdiğinden susturmanın etkisi tezde ara seviye zaman oranı, DA ve AA güç farkı ve THD üzerinden ölçülmüştür" | 04:183 ile çelişiyor; eskimiş. |
| 04:39 | C/D | "Yöntemin uzay vektör PWM veya başka modülasyon tekniklerine genellenmesi, tezdeki kanıtın dışında kalan ayrı bir doğrulama konusudur." | |
| 04:55 | sınırda (E) | Tablo: "Üçüncü harmonik ve THD belirgin biçimde artabilir." | Sin³ gerekçesi; kalması önerilir. |
| 04:80 | sınırda (D) | "Benzetimde ve deneylerde σ=1 alınmıştır ..." | |
| 04:155 | B | "Donanımdaki gerçek ölü zaman ve sürücü yayılım gecikmesi ölçülmemiştir; ..." | |
| 04:157 | sınırda (A) | "Önerilen anahtarlama, ortaya çıkan harmonik ceza nedeniyle tek başına nihai yöntem değildir; ..." | Sin³'e köprü; olumlu dille yazılabilir. |
| 04:161 | sınırda (D) | "S1--S3 senaryolarında akım denetleyicisi kullanılmamıştır; modülasyon referansı açık çevrimde uygulanmış ..." | |
| 04:168 | E | "Modelin artışı fazla göstermesinin kaynağı S1 verimindeki −1,35 puanlık sapmadır: S1 kaybı benzetimde 24,0 W, deneyde 19,7 W'tır." | |
| 04:168 | E/D | "S1 kayıp farkı açıklanamamıştır; klasik anahtarlama için blok bazında kayıp ayrıştırması yapılmamıştır ve fark diyot toparlanma parametrelerine duyarlıdır" | En güçlü olanlardan. |
| 04:168 | sınırda (E) | "Verim farkının belirsizliği, 0,1 saniyedeki oturma farkı nedeniyle S2 için yaklaşık 0,1 puandır." | |
| 04:170 | E/C | "Benzetimin mutlak THD değerleri yaklaşık değerlerdir: ... S2'de 9,7 puan, S1'de 24,5 puan yüksek değer verir. ... Farklar iki serbest değişkenli kalibrasyonla kapanmaz; ..." | |
| 04:181 | sınırda (E) | "Kalibre S2 genliğinin parametre dosyasındaki ilk değerden %3,3 düşük olması da aynı davranışın sonucudur." | |
| 04:202 | B/E | "...deneyde güç analizörünün haberleşme kayıtları kullanılmıştır, pencere uzunluğu kayıtlarda yer almamaktadır." | |
| 04:204 | sınırda (E) | "Anma güç ifadeleri tasarım hedefi olarak kullanılmıştır." | |
| 04:204 | D/E | "Anma gücünde deney yapılmaması da güvenlik gerekçelidir ve Bölüm~\ref{chap:sonuc} içinde sınırlılık olarak yer alır." | Bölüm 8'e çapraz atıf. |
| 04:210 | E | "Mutlak değerlerde model yaklaşıktır: S1 verimini 1,35 puan düşük, S1 ve S2 THD'sini 24,5 ve 9,7 puan yüksek vermektedir; farklar sınırlılık olarak raporlanmıştır." | |

## bolumler/05-sin3-kompanzasyon.tex

| dosya:satır | tür | ifade | not |
|---|---|---|---|
| 05:28 | sınırda (C) | "...analitik aday ile kalibre model değeri farklı model katmanlarına aittir ve birbirinin yerine kullanılmamaktadır." | |
| 05:32 | sınırda (C) | "Kompanzasyon katsayılarının tek bir cebirsel iptal koşulundan, örneğin sabit bir k1/k3 oranından türetilmesi anahtarlamalı dönüştürücüde geçerli değildir." | |
| 05:41 | sınırda (D) | "Kompanzasyon katsayıları HTF çerçevesinde ya ... doğrusallaştırılmış model üzerinden ya da küçük işaretli harmonik enjeksiyon ölçümleriyle belirlenmelidir" | Tezin böyle yapmadığını ima ediyor. |
| 05:43 | C | "Düşük akımda süreksiz iletim ... aynı sonuç 2,3 A noktasına genellenmemektedir." | |
| 05:74 | sınırda (E) | "Benzetim zarfındaki iki tepe arasındaki asimetri, analitik modelde bulunmayan Cf--L2 dinamiği ve ... ilişkilendirilebilir." | |
| 05:90 | sınırda (E) | "Sıfır geçişte vg→0 olduğundan ideal ifadenin tek başına kullanılması uygun değildir; ..." | |
| 05:97 | sınırda (C) | "Analitik modelden bulunan (k1,k3) değerleri tek endüktanslı kayıpsız modele aittir ve benzetim modelindeki K1x, K3x değerlerine bire bir eşit değildir." | 05:28 ile aynı. |
| 05:130 | E/A | "Kanıt sınırı açıktır: tarama, ... analitik/ortalama katmandır; ölü zaman, denetleyici, Cf--L2 dinamiği ve kayıplar içermez, verim sonucu üretmez." | |
| 05:132 | sınırda (E) | "...ideal tam-DCM modelinin geçerlilik sınırını işaretler." | |
| 05:154 | C | "...elle seçilmiş (k1,k3) çiftleri, ... S1 çalışma noktasına taşınamamaktadır. ... tek bir (k1,k3) çifti bütün çalışma noktalarına genellenemez." | "Üç bulgu" sayımı buna dayanıyor. |
| 05:166 | E | "...kalıntı, yöntemin yapısal sınırıdır." | |
| 05:175 | A | "Eşitlik~\eqref{eq:sin3-duzeltilmis-optimum} ile verilen çift, uygulanan kazanç değil, tek endüktanslı analitik katmanın adayıdır." | |
| 05:175 | A/B | "İki katsayı takımının karşılaştırması bir doğrulama değil, analitik katmanın ... tutarlılık gözlemidir." | |
| 05:213 | A | Altyazı: "Şekil, akım komutu öncesindeki başlangıç durumunun ideal çözümüdür; kapalı çevrim izleme başarımını göstermez." | |
| 05:217 | A/B | "Denetleyicinin devre dışı bırakılıp ... benzetim koşulu ... ancak kapalı çevrim başarımı ya da kararlılık kanıtı değildir." | |
| 05:222 | sınırda | "Kompanzasyon süreksiz iletimi ortadan kaldırmaz; ..." | Teknik olgu. |
| 05:231 | C/E | "...ancak üç yöntem birbirinden farklı gerilimlerde çalıştığı için yöntemler arası karşılaştırma tek değişkenli değildir." | |
| 05:236 | sınırda | "Model çiziminde geri besleme oransal kazançla gösterilmiştir; tezdeki S4 benzetimlerinde denetleyici S3 tabanına betikle eklenmiş ..." | |
| 05:243 | B | "S4 için donanım deneyi yoktur; Alt Bölüm~\ref{sec:s4-kapali-cevrim} içindeki bütün sayılar benzetim sonucudur ..." | 05:356 ile aynı. |
| 05:264 | E | "Denetim, modelde analog eşdeğeri olarak gerçeklenmiştir: ... hesaplama gecikmesi yoktur. Analog eşdeğerin seçilme gerekçesi, ... sayısal gerçeklemenin LCL rezonansında kararsız olmasıdır; ..." | Kararsızlık zinciri. |
| 05:264 | D | "L1 doyumu modellenmemiştir." | |
| 05:266 | E | "Faz payı kapasitansla yapılan PI benzetiminde ... modülasyon zamanın %20,6'sında doyuma girmiş ve kararlı durum oluşmamıştır: temel akım genlik hatası −%31,9, THD %57,4'tür." | |
| 05:266 | B | "...büyütülmüş kapasitans değeri donanımda doğrulanmamıştır." | |
| 05:270 | C | "...S4 verimi yalnız S4 içinde karşılaştırılır; ... farkın yaklaşık 7,2 W'lık kayıp karşılığı yalnız çekirdek kaybı parametresinden gelir." | |
| 05:320 | E | "İzleme hatası akımla monoton değişmemektedir: 10 A noktası 25 A noktasından kötüdür. ... aynı terim 10 A noktasına uymamaktadır." | |
| 05:320 | E | "...ancak THD %19,6'da kalır, çünkü rezonans terimi yalnız 50 Hz'te etkilidir ..." | |
| 05:320 | D | "Nötr susturma bir düşük güç yöntemidir: orta ve anma akımında tamamlayıcı anahtarlamaya dönüş ya da ... ileri besleme gerekir. Kip geçişi tezin kapsamı dışındadır ..." | |
| 05:324 | sınırda (E) | "Kararlı durumda bile L1 akımının tepesi, Sin³ kaynaklı üçüncü harmonik nedeniyle referans tepesinden %7,3 yüksektir; ..." | |
| 05:356 | B | "Bütün sonuçlar benzetim modelinin kendi içindeki kararlılık kanıtıdır; S4 için donanım deneyi yoktur." | 05:243 tekrarı. |
| 05:377 | sınırda | "...doyumsuz çalışmada doğrusal ayrım çalışma noktalarında geçerlidir." | |
| 05:431 | E | "Periyotta iki güncelleme (B2) de yetmez (|z|=1,085): ... L1 akımı geri beslemesi, sayısal gecikmeyle birlikte aktif sönümleme olmadan kararsızdır" | Kararsızlık zinciri. |
| 05:431 | E | "S4, sayısal gerçeklemenin kararsızlığı göz önünde tutularak analog eşdeğer olarak sunulmuştur; sayısal gerçekleme için ... aktif sönümleme yöntemi ya da şebeke akımı geri beslemesi gereklidir." | |
| 05:440 | E | "Bedeli izleme bant genişliğidir ... Gerçekleme (B) her Lg değerinde kararsızdır ve kötüleşir." | |
| 05:493 | sınırda (E) | "K34 açık ve kapalı ölçümler arasındaki fark 0,02--0,9 dB ve 1--8°'dir; fark her noktada iki ölçümün birleşik belirsizliği içinde ya da sınırındadır ..." | "K34 marjı değiştirmez" iddiasını gölgeliyor. |
| 05:502 | E/C | "...çevrim yavaş ama kararlıdır. Ortalama model düşük akımda izleme başarımını gerçekte olduğundan iyi gösterir; ..." | 05:534 ile aynı. |
| 05:504 | E | "...anma akımında bozulma küçük olduğundan terim fazla gelir ve çevrim onu ... bastırır ama sıfırlamaz." | |
| 05:504 | D | "Kapalı çevrimde ileri besleme genliğinin akım düzeyine göre ayarlanması önerilir; öneri tezde uygulanmamıştır." | |
| 05:532 | E | `\subsection{Kararlılık analizinin sınırları}` | Alt bölümün tamamı sınırlılık. |
| 05:534 | E | "...orta ve düşük akımda köprünün etkin kazancı frekansa bağlı değiştiğinden ortalama model izleme başarımını iyimser gösterir." | |
| 05:534 | B | "2,3 A'de enjeksiyon ölçümü 212--1037 Hz aralığını kapsar; 2--3,4 kHz bölgesi ölçülmemiştir." | |
| 05:534 | sınırda (B) | "Anahtarlamalı modelde enjeksiyon ölçümü PI denetleyiciyle yapılmıştır; ..." | |
| 05:534 | sınırda | "Gecikme Td=2 µs bir üst sınırdır; ..." | |
| 05:534 | B | "Donanımın örnekleme yapısına ilişkin veri yoktur." | |
| 05:534 | D | "...düşük akım için Eşitlik~\eqref{eq:htf-matris-iliskisi} çerçevesinde bir HTF ya da harmonik durum uzayı modeli kurulmamıştır" | |
| 05:534 | E | "Faz payı bara kapasitansıyla 25 A'de kararlı durum oluşmadığından kararlılık analizi, ... büyütülmüş bara kapasitansıyla yapılmıştır." | 05:266 tekrarı. |
| 05:538 | sınırda (C) | "...katsayı seçimi çalışma noktasına bağlıdır." | |
| 05:540 | E | "Anma akımı sonuçlarının önkoşulu, ... bara kapasitansıdır. Orta akımda (10 A) nötr susturmanın yarattığı süreksiz iletim THD'yi %20 düzeyine çıkarmakta ve yöntemin düşük güç kapsamını sınırlamaktadır." | |
| 05:542 | E | "Bir periyot gecikmeli sayısal gerçekleme ise aktif sönümleme olmadan kararsızdır; donanım uygulaması için aktif sönümleme gereklidir." | Bölüm olumsuz notla kapanıyor. |

## bolumler/06-deneysel-dogrulama.tex

| dosya:satır | tür | ifade | not |
|---|---|---|---|
| 06:4 | D | "anma gücünde geri beslemeli (S4) deney ve GT-tipi şarj yönü deneyi yapılmamıştır." | 06:389, 06:584, 07:370, 08:88'de tekrar. |
| 06:6 | B/E | "Deney protokolü (...), ham PC/Modbus ve osiloskop kayıtları, tekrar sayısı ve analizör kalibrasyon belgeleri kayıtlarda yer almadığından deney sonuçları ekran ve özet tablosu düzeyinde destekleyici kanıt olarak kullanılmaktadır." | En ağır itiraf; "Deneysel kanıtın kapsamı" başlığı buna dayanıyor. |
| 06:6 | E | "Ölçüm belirsizliği üretici toleransları ve okuma çözünürlüğünden kestirilmiş, istatistiksel yayılım hesaplanmamıştır." | 08:92 ile çift. |
| 06:6 | E | "Protokol ve ham kayıt eksikliği Bölüm~\ref{chap:sonuc} içinde sınırlılık olarak yer almaktadır." | Bölüm 8'e çapraz atıf. |
| 06:12 | B | "eşik ve açma süreleri kaynak kayıtlarda yer almamaktadır." | |
| 06:125 | B | "minimum darbe süresi ve çıkış gecikmeleri ölçülmediğinden zincirin zamanlama performansı ayrıca doğrulanmamıştır." | |
| 06:145 | B | "Hesaplar nominal direnç değerlerine dayanır; gerçek direnç toleransları, ADC kalibrasyonu ve sensör sıcaklık sapmasıyla doğrulanmamıştır." | |
| 06:156 | sınırda (B) | "Kayıt, koruma mantığının işlevsel örneğidir; gecikme süresi ve gerçek kısa devre kesme enerjisi aynı görüntüden çıkarılamaz." | İlk yarı kalabilir. |
| 06:223 | sınırda (C/E) | "Yapı kararlı durum eğilimleri için kullanılabilir; hızlı geçici rejimlerin tam eşzamanlı karşılaştırılması için yeterli değildir." | |
| 06:225 | sınırda (E) | "Osiloskop kanal adlarında ``kontrolör çıkışı'' ifadesi geçmektedir. ... modülasyon komutu olarak okunmuştur." | |
| 06:234 | sınırda (E) | "Üç deneyde gerçekleşen DA bara gerilimleri (...) ve şebeke gerilimleri (...) birbirinden farklıdır" | |
| 06:240 | sınırda (E) | "THDi eğrisi yaklaşık 100 saniyelik kayıt boyunca %5--22 arasında dalgalanmaktadır; ..." | %11,1 / %15 farkını açıklıyor. |
| 06:287 | C | "Klasik yönteme göre farklı DA bara gerilimi kullanıldığından verim değişiminin tamamı yalnız anahtarlama yöntemine atfedilemez." | Ana verim kazancını zayıflatıyor. |
| 06:298 | E | "deneydeki uygulamanın aynı biçimde olduğu kabul edilmiştir." | |
| 06:316 | A/C | "Klasik ve Sin³ deneyleri farklı DA bara ve faz gerilimlerinde yapıldığından tek değişkenli nedensel üstünlük sonucu çıkarılmamıştır." | 06:383, 08:87 ile aynı. |
| 06:347 | E | "Benzetim verim ve THD sıralamasını deneyle aynı vermekte, mutlak değerlerde yaklaşık kalmaktadır." | İlk yarı kalabilir. |
| 06:381 | sınırda (E) | "Kayıtlarda AcuDC240 için geçen ``Class 0,1'' ifadesi veri sayfasındaki yüzde hata değerleriyle aynı büyüklük olarak kabul edilmemiş" | |
| 06:383 | A/C | "DA bara ve şebeke gerilimleri deneyden deneye değiştiğinden deneyler arasındaki verim sıralaması tek değişkenli bir yöntem karşılaştırması değildir." | |
| 06:385 | B | "Verim farklarının kaynağı ham kayıtlar olmadan ayrılamaz." | |
| 06:385 | sınırda | "Tablo bir hata düzeltme tablosu değil, kayıtların kendi içindeki tutarlılık denetimidir." | |
| 06:389 | D/B | "Orta ve anma gücünde deney, ... yapılmamıştır; anma gücü ifadeleri donanımın tasarım hedefi olarak kalmakta, ... benzetim bulgusu olarak raporlanmaktadır." | |
| 06:389 | E | "Deneysel verimin belirsizliği için yalnız bir alt sınır verilebilir: ..." | |
| 06:389 | C/E | "S2 ile S3 arasındaki 0,3 puanlık deneysel verim farkı belirsizlik alt sınırının içindedir." | 06:347, 08:34, 08:119 ile gerilim. |
| 06:400 | B | Tablo: "Analizörün kalibrasyon belgesi yoktur." | |
| 06:402 | B | Tablo: "prob oranı ham kayıt olmadığından ayrıca doğrulanmamıştır." | |
| 06:403 | B | Tablo: "kanal zayıflatması ve ortak mod sınırı ham kayıt olmadığından ayrıca doğrulanmamıştır." | |
| 06:405 | B | Tablo: "ADC ölçekleme katsayıları ayrıca doğrulanmamıştır." | |
| 06:406 | B | Tablo: "direnç oranı ve kanal kalibrasyonu ayrıca doğrulanmamıştır." | |
| 06:421 | sınırda (E) | Tablo: "Deneyler arasında gerilim farkı vardır." | |
| 06:422 | sınırda (E) | Tablo: "Deneyler arasında bara gerilimi farkı vardır." | |
| 06:463 | D | Tablo: "Deney yapılmamıştır" (orta güç) | Tablo bu hücrelerle anlam taşıyor. |
| 06:464 | D | Tablo: "Deney yapılmamıştır" (anma) | |
| 06:465 | D | Tablo: "Deney yapılmamıştır" (geçici rejim) | |
| 06:472 | B | "ham zaman serisi ve tekrar deneyi çalışma kitabında yer almaz." | |
| 06:490 | B | "Farkların yuvarlama, farklı ortalama penceresi veya ek kayıp teriminden kaynaklanıp kaynaklanmadığı ham güç örnekleri olmadan çözülemez." | |
| 06:490 | C | "Çalışma kitabındaki benzetim satırları deney sayılarını tekrar ettiğinden tablo yalnız deneysel özet olarak kullanılmıştır" | |
| 06:495 | E | "Hesap ekran görüntüsünden yapıldığından (yaklaşık 0,1 A düşey çözünürlük) değerler yaklaşık okunmalıdır; ..." | |
| 06:513 | sınırda (E) | "Analizörün güç faktörü göstergesi tek bir anlık okumadır; ... THD değerlendirmesine alınmamıştır." | Jüri sorusuna karşı savunma. |
| 06:524 | B | "Deney özetindeki reaktif güç ölçülmemiş, Q_o=P_o tan(arccos cos φ) ile hesaplanmıştır" | |
| 06:524 | B | "Analizörün yön ve öncü/artçı kuralı kayıtlarda yer almadığından işaret yorumlanmamış" | |
| 06:524 | sınırda (A) | "|Q_g,1| uyumsuzluğu tek başına modeli reddettirmez." | |
| 06:524 | E | "Deney iki işaret dalını ayırt edemediğinden her senaryoda kalibrasyonsuz modelin dalı (Q_g,1>0) korunmuştur." | |
| 06:530 | sınırda | "S2 ve S3 fazları faz belirsizliğinin içindedir ve fiziksel bir gecikme olarak yorumlanmamıştır." | |
| 06:530 | B | "değer, modelde bulunmayan sürücü ve anahtar gecikmelerinin ... Yorum bir varsayımdır ve donanım kaydıyla doğrulanmamıştır." | |
| 06:559 | A | "ilk iki satırdaki uyum bir doğrulama değildir; doğrulama yalnız kalibre edilmeyen satırlardadır." | |
| 06:563 | E | "AA akımı ise +%3,7, THD +9,7 puan yüksektir. ... fark kalibrasyonla kapanmaz." | |
| 06:563 | D | "...modelde bulunmayan IGBT çıkış kapasitesi ile sürücü gecikmeleri, ...; kaynak ayrıştırılmamıştır." | |
| 06:565 | D | "Verim farkı, ... ve S1 için kayıp ayrıştırması yapılmamıştır." | |
| 06:565 | E/C | "Akım THD'si modelde %39,5'tir ve deneyin %15 değerinin üzerindedir; S1 THD'si yaklaşık bir benzetim değeri olarak okunmalıdır." | |
| 06:565 | D | "dalga biçiminin güç hedefleriyle birlikte tutturulması iki serbest değişkenli kalibrasyonun kapsamı dışında kalmıştır." | |
| 06:567 | E | "düşük akımdaki mutlak THD karşılaştırmasında ihmal edilemeyecek düzeydedir ve modelde yer almamaktadır." | |
| 06:576 | sınırda | "Fark esas olarak S1 verimindeki −1,35 puanlık sapmadan gelmektedir." | |
| 06:578 | E | "S2 ve S3'te son periyot ile 0,08--0,10 s ortalaması arasında ... fark vardır; fark, verim karşılaştırmasının benzetim tarafı belirsizliğidir." | |
| 06:578 | B | "Kalibre benzetim sonuçları deney bulgusu değildir; ..." | |
| 06:578 | E | "S1 ve S2'nin THD farkları, S2'nin AA akımı farkı ve S1 verim farkı Bölüm~\ref{chap:sonuc} içinde sınırlılık olarak yer almaktadır." | Bölüm 8'e çapraz atıf. |
| 06:582 | sınırda (E) | "Kanıt düzeyi bölüm girişinde tanımlanmıştır: deney sonuçları ekran ve özet tablosu düzeyinde raporlanmıştır." | 06:6'ya bağlı. |
| 06:584 | E | "Mutlak değerlerde model yaklaşıktır: S1 ve S2'de akım THD'sini yüksek, S1'de verimi düşük vermektedir." | |
| 06:584 | sınırda (E) | "Özet ile ekran değerleri arasındaki farklar, ... açıkça gösterilmiştir." | |
| 06:584 | D | "anma gücünde geri beslemeli (S4) deney güvenlik gerekçesiyle yapılmamıştır." | |

## bolumler/07-gt-tipi-mimari.tex

| dosya:satır | tür | ifade | not |
|---|---|---|---|
| 07:6 | sınırda (A) | "literatürde standartlaşmış bağımsız bir çok seviyeli dönüştürücü ailesi değildir." | |
| 07:8 | E | "çalışma kipleri, geçiş kuralları ve koruma işlevleri ise tasarım tanımı düzeyindedir." | |
| 07:121 | B | "şarj yönü için deney kaydı bulunmadığından mimari tanımın hemen ardından verilmektedir." | Bölüm sırasının gerekçesi. |
| 07:121 | E | "Kayıtlar ekran görüntüsü olarak korunduğundan nitel gösterim düzeyinde kullanılmaktadır." | |
| 07:132 | E/B | "Görsel, PFC işlevinin çalıştığına ilişkin nitel kanıt olarak kullanılmıştır; THD ve güç faktörü grafikten sayısal olarak çıkarılmamıştır." | |
| 07:141 | sınırda (E) | "Grafik, PFC katının DA bara regülasyon davranışını nitel olarak destekler." | |
| 07:150 | D | "Transformatör kaybı ve verimi, sarım ve manyetik parametreler gerektirdiğinden hesaplanmamıştır." | |
| 07:166 | D | "Primer--sekonder genlikleri üzerinden verim hesabı, dönüş oranı ve kaçak endüktans gerektirdiğinden yapılmamıştır." | |
| 07:182 | B | "değerler fiziksel deney sonucu olarak yorumlanmamıştır." | |
| 07:191 | E | "GT-tipi donanımın iki yönü farklı kanıt düzeyindedir: ... şarj yönü ise ... nitel olarak gösterilmiştir." | |
| 07:191 | B | "Şarj yönü kayıtları ekran görüntüsü olduğundan THD, güç faktörü, verim ve SoC için sayısal sonuç verilmemiştir." | |
| 07:191 | D | "RL1 kip geçişi, şarj yönünün donanım deneyi ve batarya başına denetimin donanımda sınanması ... doğrulama matrisinin sonraki adımlarıdır." | |
| 07:229 | sınırda (D) | "Sayısal sınırlar batarya kimyası ve üretici veri sayfasından alınarak atanır." | |
| 07:237 | sınırda (D) | "yalnız Coulomb sayımı uzun süreli kullanımda sürüklenebilir; ... ayrıca tanımlanmalıdır." | |
| 07:255 | sınırda (D) | "Sayısal eşikler röle kontak değerleri, ... ve ölçüm belirsizliğiyle belirlenmelidir." | |
| 07:294 | sınırda (D) | "Yazılımın hata algılama hızı, röle ve kontaktör açma süresi ve DA bara boşalma süresi aynı güvenlik zaman çizelgesinde değerlendirilmelidir." | |
| 07:317 | sınırda (A) | "IEC standartları tek başına belirli bir devrenin güvenli olduğunu kanıtlamaz. ... nihai uygunluk değerlendirmesi yetkili test, ... gerektirir" | |
| 07:339 | sınırda (E) | Tablo: "Evirici kipinde düşük güç deneyi; şarj yönünde benzetim kayıtları" | |
| 07:344 | A | "GT-tipi yapının üstünlüğünü peşinen ilan etmek yerine sınanabilir hipotezleri belirlemektedir." | Katkıyı "hipotez"e indiriyor. |
| 07:344 | sınırda | "Başlıca bedeller ise çok sayıda yalıtılmış kanal, sürücü ve algılayıcı; ... üretilebilirliğidir." | |
| 07:346 | D | "Mimari karşılaştırmanın sayısal hâle gelebilmesi için ... hesaplanmalıdır." | |
| 07:351 | E/A | "İki kanıt grubuyla bölümün nihai çıktısı bir \emph{mimari tanım, kanıt kaydı ve doğrulama yöntemi} olarak sınırlandırılmıştır" | |
| 07:362 | D | Tablo: "kapı tablosu ve denetim kodu gelecek çalışma." | Doğrulama matrisi. |
| 07:364 | D | Tablo: "donanım deneyi gelecek çalışma." | |
| 07:365 | sınırda (E) | Tablo: "Nitel benzetim kayıtları" | |
| 07:366 | D | Tablo: "kimya, kapasite ve eşikler gelecek çalışma." | |
| 07:367 | D | Tablo: "Gelecek çalışma." (kayıp/termal analiz) | |
| 07:368 | sınırda (D) | Tablo: "Test planı tanımlandı." | |
| 07:369 | D | Tablo: "Gelecek çalışma." (şarj yönü deneyi) | |
| 07:370 | D | Tablo: "Güvenlik gerekçesiyle tez kapsamında yapılmadı." | |
| 07:375 | sınırda (D) | "Şarj ve deşarj yönündeki dönüştürme verimleri ayrı ölçülürse gidiş--dönüş verimi ... tanımlanabilir." | |
| 07:386 | sınırda (E) | "şarj zinciri benzetim kayıtlarıyla nitel olarak gösterilmiştir." | |
| 07:390 | D/A | "Şarj yönünün donanım deneyi, RL1 geçişinin sınanması ve anma gücünde çalışma tez kapsamı dışında kalmıştır; şarj verimi, termal yeterlilik, EMC ve gidiş--dönüş verimi için sonuç ileri sürülmemiştir." | Bölümün son paragrafı tamamen olumsuz. |
| 07:390 | A/D | "Ortak donanım kullanımının kayıp ve maliyet üstünlüğü, ayrı dönüştürücülü bir eşdeğerle aynı güç tabanında hesaplanarak gösterilmelidir." | |

## bolumler/08-sonuc.tex

| dosya:satır | tür | ifade | not |
|---|---|---|---|
| 08:4 | E | "Eldeki kanıtlar aynı olgunluk düzeyinde değildir" | Bölüm kanıt zayıflığıyla açılıyor. |
| 08:4 | B | "...analitik sonuç ve henüz sınanmamış mimari öneri olarak sınıflandırılmıştır." | |
| 08:8 | B/E | "``kısmen yanıtlandı'' ifadesi ise sayısal genelleme için ham model, ortak koşullu deney ya da donanım doğrulaması bulunmadığını göstermektedir." | 08:25 ile bağlı. |
| 08:14/19 | sınırda | Sütun başlığı "Geçerlilik sınırı" | Sütunun tamamı (08:24–27) sınırlılık. |
| 08:24 | B | "Ters akımın kayıplara sayısal katkısı ham yarı iletken dalga biçimleri ve ortak DA/AA güç kaydı olmadan ayrıştırılamamıştır." | |
| 08:25 | E/D | "Düşük güçte (...) yanıtlandı; güç aralığı kısmen yanıtlandı." / "... yalnız düşük güçte karşılaştırılmıştır; verim kazancının sona erdiği akım belirlenmemiştir." | |
| 08:26 | B/C | "anma akımında kapalı çevrim yalnız benzetimle gösterildi." / "Analitik katsayılar tek-L ortalama modelde geçerlidir. Kararlılık sonucu analog eşdeğer denetim içindir; sayısal gerçekleme aktif sönümleme gerektirir. S4 için deney yoktur ve anma akımı benzetimleri büyütülmüş DA bara ile yapılmıştır." | |
| 08:27 | B | "Ortak donanımın kayıp, maliyet, termal davranış, arıza toleransı ve güvenlik üstünlüğü prototip ve deney kayıtları olmadan doğrulanmamıştır." | |
| 08:30 | B | "Kayıp artışının mutlak değeri; anahtar gerilim--akım çarpımları, sıcaklık ve parça modelleri bulunmadığından sonuçlandırılmamıştır." | |
| 08:32 | sınırda (E) | "benzetimdeki fazla artış S1 verimindeki −1,35 puanlık sapmadan gelmektedir." | |
| 08:32 | D | "verim kazancının sona erdiği akım, klasik anahtarlama ile orta akımda karşılaştırma yapılmadığından belirlenmemiştir." | |
| 08:34 | sınırda (C) | "uygun katsayılar çalışma noktasıyla değişir" | |
| 08:34 | B | "Sonuçlar benzetim bulgusudur; S4 için donanım deneyi yoktur." | |
| 08:36 | B/A | "Ortak yapı teknik olarak tanımlanmış olsa da ayrı güç katlarına göre sayısal üstünlüğü henüz gösterilmemiştir." | |
| 08:44 | B/E | "Deney protokolü ve ham güç kayıtları bulunmadığından deneydeki yüzde artış tek ölçüm noktasının raporlanmış değeri olarak okunmalıdır." | Ana katkıyı zayıflatıyor. |
| 08:44 | C | "Katkının sınırı da aynı kanıtla belirlenmiştir: susturma 10 A'de ... düşük güce özgü bir yöntemdir ve orta akımda kip geçişi gerektirir." | |
| 08:48 | E | "analog eşdeğer çevrimin 44 µs gecikme marjı, bir periyot gecikmeli sayısal gerçeklemede ise aktif sönümleme gereksinimi katkının uygulama sınırını belirler." | |
| 08:48 | E | "Kalibre kazanç 25 A'de üçüncü harmoniği artırdığından ileri besleme genliğinin akımla ayarlanması gerekir." | |
| 08:48 | A | "Hesaplama yükü ve donanımda ölçülmüş kararlılık marjı bulunmadığından PLL/PR tabanlı yapılara karşı genel üstünlük iddiası kurulmamıştır." | |
| 08:52 | A/E | "...aynı tabanda hesaplanmadığından ortak kullanımın yararları potansiyel düzeyindedir." | |
| 08:54 | sınırda | "ana eksen, Sin³ kontrol teriminden ziyade T-tipi donanımın iki ölçekte yeniden kullanılmasıdır." | Başlıktaki Sin³ katkısını küçültüyor. |
| 08:79 | A | "Patent veya başvuru kaydı ... verim, THD, kararlılık, güvenlik veya endüstriyel uygulanabilirlik için bilimsel performans kanıtı değildir." | |
| 08:79 | D | "Ulusal patentlerin bülten tarihinden sonraki yürürlük durumu ve istemlerin tezin teknik katkılarıyla ayrıntılı eşleşmesi tezde incelenmemiştir." | |
| 08:79 | A | "ulusal aşamaya giriş ve tescil bilgisi bulunmadığından ``uluslararası patent'' ifadesi kullanılmamıştır." | |

### Bölüm 8, "Çalışmanın Sınırlılıkları" kesimi (08:81–101, tamamı)

| dosya:satır | tür | ifade | not |
|---|---|---|---|
| 08:83 | E | "Sonuçların yorumlanmasında aşağıdaki sınırlılıklar geçerlidir:" | Giriş cümlesi. |
| 08:86 | B/E (1) | "donanımın denetim yazılımı, ADC örnekleme anı ve susturma ile Sin³ teriminin etkinleşme eşiği belgelenmemiştir ve benzetim modeli uygulamanın tek yürütülebilir tanımı kabul edilmiştir." | |
| 08:87 | C/A (2) | "...DA bara, şebeke gerilimi, güç noktası, denetleyici ve analiz penceresinin bütünüyle aynı olduğu kanıtlanamamıştır. Yöntemler arasındaki yüzdesel verim farkı nedensel üstünlük olarak yorumlanmamıştır." | |
| 08:88 | D/B (3) | "Deneyler yalnız yaklaşık 2,3 A faz akımında yapılmıştır; orta ve anma akımı sonuçları yalnız S4 benzetimine dayanır ve S4 için donanım deneyi yoktur. ... anma gücünde deney yapılmamıştır." | |
| 08:89 | B (4) | "S4 anma akımı benzetimleri ... büyütülmüş DA bara ile yapılmıştır; büyütülmüş bara donanımda doğrulanmamıştır." | |
| 08:90 | C/D (5) | "Nötr susturma 10 A'de ... −%11--23 genlik hatası bırakmaktadır. Yöntem düşük güçle sınırlıdır; ... kip geçişi tezde incelenmemiştir." | |
| 08:91 | E/D (6) | "Sin³ kazancı 2,3 A noktasına kalibre edildiğinden 25 A'de üçüncü harmoniği artırmaktadır (...). İleri besleme genliğinin akım düzeyine göre ayarlanması uygulanmamıştır." | |
| 08:92 | B/E (7) | "Ham PC/Modbus ve osiloskop kayıtları, zaman eşleme bilgisi, FFT penceresi, kalibrasyon zinciri ve tekrar deneyleri eksiktir. Ölçüm belirsizliği ve istatistiksel yayılım hesaplanamamıştır." | |
| 08:93 | C/E (8) | "...sayısal gerçekleme ... LCL filtrede kararsızdır (|z|=1,18), periyotta iki güncelleme de yetmez (|z|=1,085); ... HTF modeli kurulmamıştır." | En ağırlarından. |
| 08:94 | B (9) | "L2 ... doğrudan empedans ölçümüyle doğrulanmamıştır. L1 doğrusal modellenmiştir; doyumu modelde yoktur ..." | |
| 08:95 | E/B (10) | "Kalibre model ... mutlak THD'de yaklaşık değerler vermektedir: S1'de %39,5 (deney %15), S2'de %56,7 (deney %47). ... S1 verim farkı (−1,35 puan) açıklanmamıştır. ..." | |
| 08:96 | C (11) | "...sonuçları tek-L, ölü zamansız, denetleyicisiz ortalama modelde geçerlidir; ..." | |
| 08:97 | D (12) | "şarj yönü, RL1 kip geçişi ve batarya başına şarj denetimi donanımda sınanmamış, kayıp, termal ve güvenlik testleri yapılmamıştır." | |
| 08:98 | C (13) | "Bulgular incelenen T-tipi topoloji, filtre, şebeke, anahtarlama ve kontrol koşullarıyla sınırlıdır. ... doğrudan genelleme yapılmamıştır." | |
| 08:101 | sınırda (A) | "Sınırlılıklar tezin fiziksel mekanizma, yöntem ve mimari öneri katkılarını geçersiz kılmamakta; ..." | Kapanış cümlesi. |

### Gelecek çalışmalar ve genel sonuç

| dosya:satır | tür | ifade | not |
|---|---|---|---|
| 08:105 | sınırda (D) | "Öncelikli gelecek çalışma, S4 akım denetiminin sayısal gerçeklemesidir: ..." | Gelecek çalışma için olağan. |
| 08:107 | sınırda (D) | "...ortak karşılaştırma yapılmalıdır. ... en az üç tekrarla raporlanmalıdır." | |
| 08:109 | sınırda (E) | "Sin³ katsayıları yalnız düşük güç THD minimumuna göre değil; ... yinelenmelidir." | |
| 08:115 | E | "...yapay zekâ veya adaptif optimizasyon gibi ilave yöntemler temel model ve deney boşluklarının yerine kullanılmamalıdır." | "deney boşlukları" açık kabul. |
| 08:119 | sınırda | "...ancak verim kazancı ile harmonik kalite arasında açık bir ödünleşim bulunduğudur." | |
| 08:119 | E | "S1 ve S2 THD'sinde yaklaşık değer vermektedir." | |
| 08:119 | B | "Anma akımı sonuçları büyütülmüş DA bara ve analog eşdeğer denetimle elde edilmiş, donanımda doğrulanmamıştır." | |
| 08:119 | D | "...sayısal üstünlük ve tam ölçekli uygulanabilirlik doğrulamasını gelecek prototip çalışmasına bırakmıştır." | |
| 08:119 | E | "Olumlu ve olumsuz sonuçlar birlikte korunmuş; kanıt sınırları, ... açık hâle getirilmiştir." | Tezin son cümlesi. |
