# Ümit Abi'nin okuma notları (07.11.2026): değerlendirme raporu

Kaynak: `dosyalar/06_UMIT_ABIDEN_GELENLER/2026-11-07_tez_okuma_notlari_bolum7/`
(`mail.txt`, `son_tez_sorular_.docx`). Ümit Abi tezi Bölüm 7'ye kadar okumuş;
sayfa numaraları **teslim sürümü** `tez-latex-v2/tez_guncel_2026-11-01.pdf`
(222 sayfa, notsuz) ile birebir örtüşüyor (basılı sayfa = PDF sayfası − 30).

Rapor yazıldığında tez metninde değişiklik yapılmamıştı; notlar 07.11.2026'da K-30 kararıyla teze işlendi (İP-16). Her not PDF metninde ve LaTeX kaynağında
doğrulandı; gereken yerde kaynak dosyalara ve modele bakıldı.

## 1. Kısa sonuç

- **Bölüm 7'deki "100 kW proje" katmanı tezden çıkarılmalı.** Kaynağı, Temmuz
  2026'da gelen `1001_basvuru_formu_versiyon_9.docx` (Nisan 2023). Tez, GT-tipi
  mimariyi bu başvuru formuna bağlamış. Ümit Abi'ye göre projede 100 kW yok ve
  GT-tipi zaten 20–25 kW deney düzeneğinde kurulu. Öneri aşağıda (Bölüm 2).
- Docx'teki 40 civarı notun **büyük çoğunluğu haklı** ve düzeltilebilir.
  Yalnız ikisi tezdeki bir yanlış anlaşılmadan çıkıyor (s. 86 "tek değişkenli",
  Şekil 2.5 Q3–Q4); ikisinde de cümle ya da şekil açıklaması netleştirilmeli.
- Dosyanın ikinci yarısı Ümit Abi'nin başka bir yapay zekâya (Codex) yaptırdığı
  denetim. Bu denetimin bulduğu **Türkçe karakter bozulması doğrulandı:**
  7 şekil (Şekil 5.5 ve 5.8–5.13) yeniden üretilmeli.

## 2. Bölüm 7: "100 kW referans tasarım" ve proje meselesi

### 2.1 100 kW nereden geldi

- Dosya: `dosyalar/05_sonradan_gelenler/1001_basvuru_formu_versiyon_9.docx`
  (TÜBİTAK 1001 başvuru formu, sürüm 9, oluşturma 02.04.2023). 13.07.2026'da
  "sonradan gelenler" paketiyle geldi; `00_INDEX.md` içinde "100 kW hedef,
  1000 V DA bara, 34,5/0,69 kV, AB/BC/CA konteyner" diye kaydedilmiş.
- Form metninde 100 kW **en az altı kez** geçiyor: "100 kW gücünde elektrik
  depolamalı tesisin prototipini gerçekleştirmek", "690 V AA şebeke gerilimi ve
  100 kW gücünde tasarlanacak", "100 kW değerinde kademeli yük" vb.
- Tez bu formu `Arifoglu2023Basvuru` kaynağıyla ("TÜBİTAK 1001 proje başvuru
  formu, sürüm 9, yayımlanmamış") ve formdaki üç şemayla kullanmış.
- **Microchip referans tasarımı değil.** Microchip kaynağı (30 kW Vienna PFC)
  tezde ayrı ve yalnız harici örnek olarak geçiyor (07:39).

**Ümit Abi'nin itirazıyla çelişki:** Elimizdeki sürüm 9 formu 100 kW diyor.
Teşekkür sayfasındaki destekli proje ise **124E241** numaralı 1001 projesi
(2024 numaralandırması). Büyük olasılıkla desteklenen proje, 2023 tarihli sürüm
9'dan farklı ve gücü 20–25 kW civarında olan sonraki bir başvuru. Ümit Abi'ye
form sürümü sorulmadan da karar verilebilir: projeyi tezden çıkarınca bu
çelişkinin bir önemi kalmaz.

### 2.2 Tezde projenin geçtiği yerler

| Yer | İçerik |
|---|---|
| `frontmatter/ozet.tex:15` | "100 kW hedefli proje katmanı tanımlanmıştır" |
| `frontmatter/abstract.tex:31` | "A 100 kW project layer extends the concept…" |
| `chapters/01-giris.tex:82` | Katkı tablosunda "100 kW proje şemaları" |
| `chapters/07-gt-tipi-mimari.tex:4–8` | Bölüm girişi: "proje başvuru formunda tanımlanan 100 kW hedefli…"; "GT-tipi … proje içi bir adlandırmadır"; "proje hedefi / prototip kaydı" ayrımı |
| `07:15–40` | Proje kaynağından gereksinim tablosu (100 kW, 1000 V, 690 V, 34,5 kV) |
| `07:46` | "İkinci katman … 100 kW hedefli … proje mimarisidir" |
| `07:52` | "100 kW başvuru şemasındaki değiştirilmiş PFC katı" |
| `07:106–133` | Alt bölüm "100 kW Hedefli Proje Mimarisi" ve iki başvuru şekli (Şekil 7.7, 7.8) |
| `07:308–317` | Başvuru kaynağındaki IGBT–SiC tetikleme şekli ve yorumu |
| `07:409, 448–449, 465–469` | Karşılaştırma ve doğrulama tablolarında "proje önerisi / başvuru formu" satırları |
| `chapters/08-sonuc.tex:4, 27, 36, 52` | "100 kW proje şemaları", "proje katmanı" |

Kalması gerekenler (proje anlatısı sayılmaz):

- `frontmatter/tesekkur.tex:16`: 124E241 numaralı 1001 projesine teşekkür.
  TÜBİTAK destekli tezde zorunlu sayılır, kalmalı.
- `08-sonuc.tex:58–79`, EK-B, EK-C, özgeçmiş: patentler ve PCT başvuruları.
  Bunlar tez sahibinin fikrî mülkiyet çıktıları, projeyle ilgisi yok; kalmalı.

### 2.3 Önerilen yeniden kurgu (uygulanmadı)

Ümit Abi'nin anlattığı durum: 20–25 kW deney düzeneği, röleler ve boost
diyotlarıyla GT-tipi olarak kuruldu. Tezde de bunu destekleyen bir kanıt var:
Ümit Abi'ye göre **Şekil 3.2'deki "gerilim algılama transformatörleri" aslında
GT-tipi şarj yönündeki BMS transformatörleri.** Yani Şekil 3.2 GT-tipi
düzenlenmiş donanımın kendisi.

Bölüm 7 bu nedenle şöyle kurulabilir:

1. GT-tipi = aynı 20–25 kW deney donanımının, röle (RL1) ve boost
   diyotlarıyla evirici / Vienna PFC / BMS kiplerine yeniden görevlendirilmiş
   düzeni. Şekil 3.2'ye göndermeyle.
2. Mevcut ilk katman korunur: Vienna PFC, çok sekonderli BYS, RL1'li ana
   topoloji, üç çalışma yolu (Şekil 7.1–7.6) ve şarj yönü benzetim kayıtları
   (Şekil 7.10–7.17).
3. Çıkarılacaklar: Tablo 7.1 (proje gereksinimleri), "100 kW Hedefli Proje
   Mimarisi" alt bölümü, Şekil 7.7, 7.8 ve tetikleme şekli, 690 V / 1000 V /
   34,5 kV / AB–BC–CA konteyner anlatısı, `Arifoglu2023Basvuru` kaynağı, özet,
   abstract, Bölüm 1 ve Bölüm 8'deki "proje katmanı" ifadeleri.
4. "GT-tipi adı proje içi adlandırmadır" cümlesi "tezde kullanılan ad" olarak
   kalır.
5. Durum makinesi, güvenlik standartları ve karşılaştırma tablosu korunur;
   "proje önerisi" sütun adları "GT-tipi mimari" olur.

Etki: Bölüm 7 yaklaşık 3 şekil ve 1 tablo kısalır. Bölüm 8 sonuç tablosunda AS3
satırının kanıt sütunu sadeleşir. Ayrıca s. 5'teki "GT-tipi için yeniden
üretilebilir benzetim yok" cümlesi düzeltilmeli (madde 3).

## 3. Docx'teki notlar: tek tek değerlendirme

Durum: **Doğru** = not haklı, düzeltilmeli · **Kısmen** = not haklı ama
gerekçe farklı · **Netleşmeli** = tezde yanlış anlaşılan cümle ya da belirsiz not.

| # | Sayfa | Not | Durum | Bulgu ve önerilen düzeltme |
|---|---|---|---|---|
| 1 | 3 | "İkinci daralma ekseni" → "ikinci odak noktası" | Doğru | Tek yer; değiştirilmeli. |
| 2 | 3, 5, 6 | L, S, T nedir? | Doğru | Semboller ancak Kesim 5.8'de tanımlanıyor (L çevrim kazancı, S duyarlılık, T tamamlayıcı duyarlılık). Giriş ve özette tanımsız kullanılıyor. Girişte sembol yerine düz ad kullanılmalı. |
| 3 | 5 | "GT-tipi için yeniden üretilebilir benzetim ve deney kanıtı bulunmadığından…" | Doğru | Şarj yönü benzetim kayıtları var (Şekil 7.10–7.17). Eksik olan model dosyası, deşarj yönü ve donanım deneyi. Cümle bu ayrımla yeniden yazılmalı. |
| 4 | 6 | Tablo 1.1 başlığı üstte mi altta mı? | Sorun yok | SAÜ kılavuzunda tablo başlığı tablonun üstünde, şekil başlığı altında. Tezde Tablo 1.1 başlığı üstte, kurala uygun. |
| 5 | 6 | "Terim L, S, T'yi değiştirmez; faz marjı 54°, kazanç marjı +35 dB" ne demek? | Doğru | Giriş için fazla teknik. Önerilen biçim: "Sin³ terimi akım çevriminin dışında kaldığı için çevrimin kararlılığını değiştirmez; çevrimin kararlılık payları yeterlidir (faz payı 54°, kazanç payı 35 dB)." |
| 6 | 7 | "Tez kapsamında yeni deney yapılmamıştır" | Doğru | Yanlış anlaşılıyor; deneyler tezin kendi deneyleri. Önerilen biçim: "Deneyler düşük güç noktasında yapılmıştır; anma gücünde geri beslemeli deney ve GT-tipi şarj yönü deneyi yapılmamıştır." |
| 7 | 7, 51, 53, 75, 121 | 120 V sınırı laboratuvar sınırı değil, güvenlik sınırı | Doğru | Anma gücünde deney yapılmaması da güvenlik gerekçeli. Bütün yerlerde "güvenlik amacıyla varyak üzerinden yaklaşık 120 V ile sınırlandırılmıştır" denmeli. Tablo 3.3'teki ölçülen değerler (119,8 / 121,0 / 124,3 V) aynen kalır. |
| 8 | 16, 24, 71, 86 | "Kesim" anlamsız; "bölüm" olsun | Doğru | Bölüm metinlerinde 76 yerde geçiyor. Özellikle cümle başındaki "Kesim, tezin…" kalıbı bozuk. Göndermelerde "Alt Bölüm 3.9", cümle başında konuyu adıyla anan yeni bir cümle kullanılmalı. Codex'in önerdiği "Bu alt bölüm" biçimi tezin "bu" kuralına aykırı; o biçim kullanılmamalı. |
| 9 | 17 | Şekil 2.5: Q3–Q4 | Netleşmeli | Şekil 2.5'te Q3 orta nokta tarafında, Q4 faz tarafında, ortak emetörlü. Ümit Abi'nin "doğru" dediği s. 37 çizimiyle ve Bölüm 3'teki Simscape blok eşleme tablosuyla aynı. Notun ne kastettiği belirsiz; görüşmede sorulmalı. |
| 10 | 24, 39, 40, 78, 91, 92, 95, 98 | "Bitki" → "sistem" | Doğru | 10 yerde geçiyor. "Denetlenen sistem" ya da "sistem dinamiği" olmalı. |
| 11 | 34 | Şekil 3.2: eksik nötr bağlantısı; "gerilim algılama transformatörleri" aslında GT-tipi BMS transformatörleri | Doğru | Altyazı ve `03:75` metni düzeltilmeli. Şekil Proteus çıktısı (JPG); nötr bağlantısı için ya Ümit Abi'nin düzeltilmiş çıktısı ya da yeniden çizim gerekiyor. Bölüm 7 kurgusunun dayanağı da olacak (Bölüm 2.3). |
| 12 | 47, 49, 87 | PI sıfırı neden 60 Hz? | Doğru (gerekçe yazılmamış) | Tasarımda sıfır, geçiş frekansının (586 Hz) yaklaşık onda birine konmuş (`s4_denetleyici_parametreleri_20261028.m`: "geçiş frekansının ~1/10'u"). 60 Hz'in şebeke frekansıyla ilgisi yok; 50 Hz'lik tezde akla 60 Hz şebekeyi getiriyor. Gerekçe Tablo 3.3 ve Kesim 5.7'ye yazılmalı. Değerin değiştirilmesi gerekmiyor. |
| 13 | 55–57 | Düzeltmeler ve sonuçları tezde kalacak mı? (Tablo 3.6) | Kısmen | Tezde 28 yerde (s. 46–75) iç kayıt numarası (D-01…D-11) geçiyor. Bu numaralar çalışma defterimizin numaraları, tez okuyucusu için anlamsız. Öneri: model düzeltmelerinin teknik içeriği kalsın (S2 kapı yolunun onarımı, S4'ün kurulması, DA bara kapasitansı, diyot parametre eşlemesi). D-numaraları, "paket", "başlatma geri çağrısı" gibi iş akışı dili ve yalnız yeniden koşturmayla ilgili satırlar (D-03) çıkarılsın. Tablo "Benzetim modelinde yapılan düzenlemeler" olarak kısaltılsın. |
| 14 | 58 | IGBT açılma gecikmesi modelde gerçekten yok mu? | Doğru ifade, netleşmeli | **Düzeltme (07.11, uygulama sırasında):** IGBT bloklarında (`igbt_event_based_thermal`) açılma gecikmesi `t_on = S12_tondly` = 200 ns, kapanma gecikmesi, yükselme (60 ns) ve düşme (110 ns) süreleri tanımlı. Sıfır olan yalnız kapı sürücüsünün ek gecikmesi (`gate_driver_ton = gate_driver_toff = 0`). Bölüm 3'teki cümle buna göre yazıldı; 0,7–1,6 µs farkın sürücü yayılım süresi ile düşük akımdaki gerçek gecikme farkından geldiği varsayım olarak işaretli. |
| 15 | 66 (PDF s. 68) | "S2 devresinin kapı yolu…" türü cümleler kalacak mı? | Kısmen | Madde 13 ile aynı. Teknik bilgi kalsın ("S2 kapı yolu tezdeki tanıma göre kuruldu"); "ortak model dosyasında eksik olduğu için onarıldı (D-01)" gibi iş akışı dili çıksın. |
| 16 | 83–84 | D1, D3 / A1–A3 / K1, K2 etiketleri karışık; dm1, dm3 önerisi | Doğru | Aynı görev oranı katsayıları için üç farklı ad kullanılıyor. Tek ad seçilmeli. Dikkat: s. 83'te `dm` zaten başka bir büyüklük için kullanılıyor; Ümit Abi'nin önerisi uygulanacaksa o kullanım yeniden adlandırılmalı. |
| 17 | 86 | "Deneylerin DA bara ve faz gerilimleri aynı olmadığından karşılaştırma tek değişkenli değildir" | Netleşmeli | Ümit Abi deney ile benzetimin aynı değerlerde yapıldığını söylüyor; bu doğru. Cümle ise üç deneyin **birbirinden** farklı olduğunu söylüyor: DA bara 431,5 / 395 / 427,5 V, şebeke 119,8 / 121 / 124,3 V. Cümle "S1, S2 ve S3 deneylerinin DA bara gerilimleri birbirinden farklıdır; her benzetim kendi deneyinin değerleriyle yapılmıştır" diye açılmalı. |
| 18 | 87 | DA bara kapasitörleri gerçekte yetersiz değildi; üç fazlı yapıda toplam değer üç katı | Doğru | Metin "deney donanımının barası 25 A için yetersizdir" diyor. Bu sonuç, faz payına düşen kapasitansın kullanıldığı faz başına modelden çıkıyor. Cümle "faz başına modelde 25 A'de orta nokta salınımı büyüdüğü için S4 benzetiminde kapasitans 2×5,6 mF alınmıştır; üç fazlı donanımda toplam kapasitans faz payının üç katıdır" diye düzeltilmeli. |
| 19 | 88, 126 | "Yer değiştirme faktörü" nedir? cos φ | Doğru | 3 yerde geçiyor. "Temel bileşen güç faktörü (cos φ₁)" olmalı. |
| 20 | 89 | Şekil 5.5: yeşil dalga neden negatif DC içeriyor? | Doğru gözlem, incelenmeli | Yeşil eğri C noktası gerilimi `v_ac`. P panelinde simetrik (±170 V). PI ve PIR panellerinde pozitif tepe yaklaşık 130 V, negatif tepe yaklaşık −170 V; sıfır geçişlerinde çentik var. Ölçümün DA bara orta noktasına göre alınması ya da orta nokta kayması olası neden. `runs/2026-10-28_s4_kapali_cevrim/results/KC_PI_25A/dalga.mat` kaydından DC bileşen hesaplanıp şekil açıklamasına ya da metne yazılmalı. Bu makinede SciPy olmadığından hesap henüz yapılmadı (MATLAB ile yapılabilir). |
| 21 | 91, 92, 95 | Antirezonans nedir? | Doğru | İlk kullanımda tanım gerekli: LCL filtrede eviriciden akıma giden yolun kazancının çöktüğü frekans, yaklaşık 1/(2π√(L₂C_f)). |
| 22 | 91 | Denklem 5.18–5.20: L, S, T nedir? | Doğru | Denklemlerin önüne tanım cümlesi gerekli: L çevrim kazancı, S = 1/(1+L), T = L/(1+L), sözlü anlamlarıyla. |
| 23 | 92 | Tablo 5.4 nasıl yorumlanır? | Doğru | Tablonun ardından iki-üç cümlelik okuma rehberi gerekli: hangi sütun hangi ölçüt, kararlılık sınırı ne, satırlar neyi karşılaştırıyor. |
| 24 | 97 | "Faz önü" | Doğru | 3 yerde geçiyor. "Faz öndeliği" olmalı. |
| 25 | 89, 93–99 | Şekil 5.5 ve 5.8–5.13'te Türkçe karakter hatası | Doğru | Doğrulandı: 7 şeklin hepsinde "ş, ı, ğ" yerine "#" var (`#ebeke`, `aç#k`, `basama##` vb.). Neden: MATLAB çizimleri Helvetica ile gömülmüş, Helvetica bu harflerin glifini içermiyor. Diğer şekiller temiz. Çizim betikleri `runs/2026-10-28_kararlilik/` ve `scripts/summarize_s4_20261028.m`; Arial yazı tipiyle yeniden dışa aktarılmalı. Yeniden koşturma gerekmez. |
| 26 | 121 | Cümle tablolarla bölünmüş | Doğru | Tablo yerleşimi düzeltilmeli; tablolar paragraf sonuna alınmalı. |
| 27 | 121 | Osiloskopla ilgili "300 Hz" nerede geçiyor? | Doğru | Kaynağı Ümit Abi'nin önceki tez dosyası (`tez_tumu_8.docx`: "DPO 3034 300 Hz, 2,5 GS/s"). 1001 formunda aynı cihaz "300 MHz" yazıyor; DPO3034'ün bant genişliği 300 MHz. Düzeltilip "doğrulanamadı" notu kaldırılmalı. |
| 28 | 121–122 | Doğrulama kanıtı sütunu çok olumsuz | Doğru | Genel olarak 21 yerde "belgelenmemiş / bulunamadı / belirtilmemiş" geçiyor. Önce neyin doğrulandığı yazılmalı, eksik tek cümleyle verilmeli. Madde 13'teki sadeleştirmeyle birlikte ele alınmalı. |
| 29 | genel | "Etkin güç" → "aktif güç" | Doğru | 20 yerde geçiyor. Değiştirilebilir. |

## 4. Codex denetimi (dosyanın ikinci yarısı)

| Bulgu | Değerlendirme |
|---|---|
| Şekil 5.5 ve 5.8–5.13 yazı tipi bozulması | Doğrulandı (madde 25). |
| Şekil 3.2 çok küçük ve soluk | Doğru. Madde 11 ile birlikte: düzeltilmiş çıktı yatay sayfada ya da tam çizim ekte verilebilir. |
| Şekil 4.4 (Simscape modeli) okunmuyor | Doğru. İki alt şekle bölünebilir. |
| Şekil 7.8 iç yazıları küçük | Bölüm 2.3 önerisiyle şekil zaten çıkıyor (başvuru şekli). |
| Terim önerileri tablosu (sürmesiz, doyumsuz, koşu, gerçekleme, K34 açık/kapalı, ton, ızgara noktası…) | Çoğu yerinde. "Koşu" 105 yerde geçiyor; benzetim bağlamında "benzetim" olmalı. "Bu alt bölüm" ile başlayan öneriler tezin "bu" kuralına aykırı; o biçim kullanılmamalı. |
| "Sınırlılık vurgusu çok sık tekrarlanıyor" | Önceki tekrar taramasının 15. maddesiyle aynı (120 V cümlesi beş yerde). Madde 7 düzeltilirken birlikte kısaltılmalı. |
| Kapak/onay sayfasındaki köşeli parantezler | Biliniyor: öğrenci no, savunma tarihi, jüri hâlâ yer tutucu; tez sahibi dolduracak. |

## 5. Görüşmede ele alınacaklar

Ümit Abi notları "birlikte değerlendirelim" diye gönderdi. Görüşmede yalnız
şunlar gerekiyor:

1. **Bölüm 7 kurgusu:** proje katmanının çıkarılması ve GT-tipinin 20–25 kW
   deney donanımına bağlanması (Bölüm 2.3). Ümit Abi'nin anlatımıyla zaten
   örtüşüyor.
2. **Şekil 3.2:** düzeltilmiş (nötr bağlantılı) Proteus çıktısı Ümit Abi'den
   mi gelecek, yoksa şekil yeniden mi çizilecek?
3. **Şekil 2.5 Q3–Q4 notu:** neyin yanlış olduğu.

Geri kalan maddeler görüşmeyi beklemeden düzeltilebilir.
