**Konu:** Tez okuma notların: yapılan düzeltmeler

Ümit Abi merhaba,

07.11'de gönderdiğin notları ve docx'i tek tek inceledim ve teze işledim. Yeni
sürüm ekte: **tez_guncel_2026-11-07.pdf** (216 sayfa). Düzeltmelerle sayfalar
kaydı; aşağıdaki sayfa numaraları senin okuduğun 01.11 sürümüne göre.

**1. Proje ve 100 kW**

Haklısın. 100 kW, Nisan 2023 tarihli 1001 başvuru formunun 9. sürümünden
geliyordu; tez GT-tipini bu forma bağlamıştı. Proje katmanını tezden tamamen
çıkardım:

- Bölüm 7'den gereksinim tablosu, "100 kW Hedefli Proje Mimarisi" alt bölümü,
  başvuru formundan alınan üç şekil ve formun kaynak kaydı çıktı. Formdan gelen
  seri deşarj, bypass ve desülfasyon kipleri de çıktı.
- Bölüm 7'yi senin anlattığın gibi kurdum: 20–25 kW deney düzeneği GT-tipi
  olarak kurulmuştur. Şekil 3.2'deki röleler ve diyotlar kip değişimini sağlar,
  transformatörler BYS transformatörleridir. S1–S3 deneyleri evirici kipinde
  yapılmıştır; şarj yönü benzetim kayıtlarıyla gösterilmiştir. Mimari şekli, kip
  tablosu, durum makinesi, karşılaştırma ve doğrulama tabloları bu çerçeveye göre
  yeniden yazıldı.
- Özet, Summary, Bölüm 1 ve Bölüm 8 aynı çerçeveye getirildi.
- Teşekkürdeki 124E241 desteği ve patentler yerinde duruyor.

**2. Notların**

- **s. 3:** "ikinci daralma ekseni" yerine "ikinci odak noktası" yazıldı.
- **s. 3, 5, 6, L, S, T:** Girişte semboller yerine "çevrim kazancı ve
  duyarlılık fonksiyonları" yazıldı. Bölüm 5'te denklemlerden önce tanımlar
  eklendi: L çevrim kazancı, S = 1/(1+L), T = L/(1+L).
- **s. 5, GT-tipi kanıt cümlesi:** Şarj yönü için benzetim kayıtları
  bulunduğu, deneylerin evirici kipinde yapıldığı biçimde yeniden yazıldı.
- **s. 6, Tablo 1.1 başlığı:** SAÜ kılavuzunda tablo başlığı tablonun üstünde,
  şekil başlığı altında yer alır. Tablo 1.1 kurala uygun olduğu için
  değiştirilmedi.
- **s. 6, "54°, +35 dB":** "Sin³ terimi akım çevriminin dışında kaldığı için
  çevrimin kararlılığını değiştirmez (faz marjı 54°, kazanç marjı 35 dB)"
  biçiminde sadeleştirildi.
- **s. 7, "yeni deney yapılmamıştır":** Cümle kaldırıldı; deneylerin düşük
  güçte yapıldığı yazıldı.
- **120 V (s. 7, 51, 53, 75, 121):** Her yerde "güvenlik amacıyla varyak
  üzerinden yaklaşık 120 V ile sınırlandırılmıştır" yazıldı. Anma gücünde deney
  yapılmaması da güvenlik gerekçesine bağlandı. Tablo 3.3'teki ölçülen değerler
  aynen kaldı.
- **"Kesim":** Göndermelerde "Alt Bölüm" yazıldı; cümle başlarındaki "Kesim,
  tezin…" kalıpları yeniden yazıldı.
- **"Bitki":** "Denetlenen sistem" yazıldı.
- **s. 47, 49, 87, PI sıfırı 60 Hz:** Değer şebeke frekansıyla ilgili değil.
  Sıfır, akım çevriminin geçiş frekansının (yaklaşık 586 Hz) onda birine
  konmuştur; integral teriminin faz kaybını yaklaşık 6° ile sınırlar. Gerekçe
  Tablo 3.3'e ve Bölüm 5'e yazıldı, değer değişmedi.
- **s. 55–57 Tablo 3.6 ve s. 66'daki düzeltme cümleleri:** Metinden D-01…D-11
  kayıt numaraları ve "paket", "geri çağrı" gibi iş akışı dili çıktı. Teknik
  içerik kaldı: S2 kapı yolu, S4 modeli, DA bara kapasitansı, diyot
  parametreleri. Tablo kısaltıldı; yalnız yeniden koşturmayla ilgili satır
  silindi.
- **s. 58, IGBT gecikmesi:** Haklıymışsın. Modelde IGBT açılma gecikmesi
  200 ns olarak tanımlı; kapanma gecikmesi, 60 ns yükselme ve 110 ns düşme
  süreleri de var. Sıfır olan yalnız kapı sürücüsünün ek gecikmesi. Cümle buna
  göre düzeltildi.
- **s. 83–84, katsayı adları:** Tez boyunca tek ad kullanılıyor: (D₁, D₃). Model
  parametresi olarak geçtiği yerlerde K₁₃, K₃₃ (S3) ve K₁₄, K₃₄ (S4) adları,
  D₁ ve D₃ ile eşlemesiyle birlikte veriliyor. A₁/A₃ adları kaldırıldı. dm1/dm3
  yerine D₁, D₃'ü seçtim, çünkü s. 83'te "dm" başka bir büyüklük için
  kullanılıyordu.
- **s. 86, "tek değişkenli değildir":** Cümle, S1, S2 ve S3 deneylerinin
  birbirinden farklı DA bara ve şebeke gerilimlerinde yapıldığını
  söylüyordu. Şimdi ayrıca her benzetimin kendi deneyinin değerleriyle
  yapıldığı açıkça yazıyor.
- **s. 87, DA bara kapasitörleri:** "Donanım yetersiz" ifadesi kalktı. 25 A'deki
  orta nokta salınımı faz başına modelden geliyor; üç fazlı donanımda toplam
  kapasitansın faz payının üç katı olduğu yazıldı.
- **s. 88, 126, yer değiştirme faktörü:** "Temel bileşen güç faktörü
  (cos φ₁)" yazıldı.
- **s. 89, Şekil 5.5'teki yeşil eğri:** Kayıttan hesapladım. C noktası
  geriliminin (v_ac) periyot ortalaması üç denetleyicide de 0,03 V'un altında;
  gerçek bir DC bileşen yok. Görüntü, soldaki akım ekseniyle sağdaki gerilim
  ekseninin sıfırlarının hizasız olmasından geliyordu. Şekli, eksen sıfırları
  hizalanmış hâliyle değiştirdim; altyazıya ortalama değeri yazdım.
- **s. 91–92, antirezonans:** İlk geçtiği yerde tanımı eklendi: LCL filtrede
  evirici geriliminden L₁ akımına giden yolun kazancının çöktüğü frekans,
  yaklaşık 1/(2π√(L₂C_f)).
- **s. 92, Tablo 5.4:** Tablonun ardından okuma rehberi eklendi: hangi sütunun
  neyi gösterdiği, yaygın tasarım ölçütleri, kararlılık hükmünün hangi sütundan
  okunduğu.
- **s. 97:** "Faz önü" yerine "faz öndeliği" yazıldı.
- **Şekil 5.5 ve 5.8–5.13, Türkçe karakterler:** Yedi şekil kayıtlı verilerden
  Arial yazı tipiyle yeniden çizildi. Eğriler aynı kaldı, yalnız yazılar düzeldi.
- **s. 121, tablolarla bölünen cümle:** Tablolar paragrafın arkasına alındı.
- **s. 121, osiloskop:** 300 MHz olarak düzeltildi.
- **s. 121–122, doğrulama sütunu:** Önce doğrulanan bilgi yazılıyor, eksik
  kalan tek cümleyle veriliyor.
- **Genel:** "Etkin güç" yerine "aktif güç", benzetim anlamındaki "koşu"
  yerine "benzetim" yazıldı.

Codex denetiminden Türkçe karakter bulgusu düzeltildi. Şekil 7.8 proje şekli
olduğu için tezden çıktı.

**3. Henüz yapılmayanlar**

- **Şekil 3.2:** Altyazı ve metin düzeltildi; transformatörler artık GT-tipi
  BYS transformatörleri olarak geçiyor. Nötr bağlantısı ise şekilde hâlâ yok.
  Şekil küçük ve soluk olduğu için yeniden çizilecek.
- **Şekil 4.4 (Simscape modeli):** Okunurluğu henüz düzeltilmedi.
- **Şekil 2.5, Q3–Q4:** Şekli s. 37'deki çizimle ve Bölüm 3'teki Simscape blok
  eşlemesiyle karşılaştırdım. Q3 orta nokta tarafında, Q4 faz tarafında; üçü
  tutarlı olduğu için şekli değiştirmedim.
- **Kapak ve onay sayfası:** Öğrenci numarası, savunma tarihi ve jüri bilgileri
  hâlâ yer tutucu. Teslimden önce bu alanları senin doldurman gerekiyor.

Kolay gelsin,
Burhan
