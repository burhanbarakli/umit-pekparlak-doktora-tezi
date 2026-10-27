# Eski tez bağımsız sorun tespiti

Tarih: 1 Eylül 2026
Kaynak: `dosyalar/01_TAM_TEZ/tez_tumu_8.docx` (metin çıkarımı: 2.972 paragraf, ~355 bin karakter)
Yöntem: Tam metin bağımsız tarandı; bulgular jüri isteği matrisi
(`dosyalar/03_INCELEME_VE_PLANLAMA/JURI_ISTEKLERI_EYLEM_MATRISI.md`) ve 12.07.2026
ön inceleme raporuyla sonradan çapraz karşılaştırıldı. Aşağıda her bulgu,
(J) jürinin de işaret ettiği, (Ö) önceki iç incelemede zaten kayıtlı, (Y) bu
taramada yeni tespit edilen olarak işaretlenmiştir.

## 1. Yapısal sorunlar

1. **(J/Ö) Başlık ile içerik uyuşmuyor.** Başlıktaki "ileri beslemeli kontrol
   stratejisi" ifadesi, Sin³ teriminin bağımsız bir kontrolcü olduğu algısını
   yaratmış; savunmada jüri bu yüzden kararlılık kanıtı istemiş. Oysa metnin
   kendi anlatımında Sin³ hata sinyalinden üretilmeyen, modülasyona eklenen bir
   kompanzasyon terimidir (Ümit abinin savunma sonrası yorumları da bunu
   doğruluyor: `jüri istekleri/ümit pekparlak yorumları.txt`).
2. **(J/Ö) Bölüm 1 bir "Giriş" değil.** 1. bölüm baştan sona batarya
   yaşlanması / hücre dengesizliği / BYS literatürü (1.1–1.8). Araştırma sorusu,
   katkı listesi, kapsam-sınırlılık ve tez organizasyonu yok. Üç katkı ancak
   sonuç bölümünde açıkça sıralanıyor.
3. **(J/Ö) Genelden özele akış kopuk.** Bölüm 1 batarya → Bölüm 2 FV evirici →
   Bölüm 3–5 T-tipi/anahtarlama/deney → Bölüm 6'da birdenbire GT-tipi mimari.
   GT-tipi ana katkılardan biri olmasına rağmen ilk beş bölümde hazırlanmıyor.
4. **(Y) Bölüm 5 alt yapısı bozuk.** Donanım alt birim listeleri
   ("1. LCL filtrelerin L1'leri … 14. Deşarj fonksiyonu lambası") başlık stiliyle
   değil düz numaralı paragraf olarak yazılmış; İçindekiler'e ve numaralandırma
   düzenine karışıyor.

## 2. Kanıt zinciri sorunları

5. **(J/Ö) Kararlılık kanıtı tamamen yok.** Tüm metinde "Bode" 0 kez,
   "kararlılık" 2 kez geçiyor. Jürinin 7 no.lu isteği (kapalı çevrim + Bode)
   mevcut sürümde hiç karşılanmamış.
6. **(Y) Sin³ türetim zinciri (4.2–4.26) matematiksel olarak geçersiz.**
   Bağımsız kontrolde dört ayrı kusur doğrulandı: (a) belirli bir çalışma
   noktasının genlik oranları girişten bağımsız "sistem transfer fonksiyonu"
   gibi kullanılmış; (b) doğrusal olmayan/anahtarlamalı sisteme süperpozisyon
   uygulanmış; (c) 4.21'de akım büyüklüğü fiziksel gerekçesiz gerilime dönüşmüş
   (boyut tutarsızlığı) ve 4.20'deki 3ω çarpanı 4.22'de kaybolmuş; (d) tekrarlı
   kutuplu terim atılarak K1=9K3 "iptal koşulu" eksik terimden çıkarılmış.
   Ayrıca 4.14 denklem numarası iki kez kullanılmış.
7. **(Y) Katsayı taraması kendi içinde çelişiyor.** Tablo 4.3 en iyi noktayı
   (V1m, V3m)=(0,45, 0,37) → %1,60 verirken Şekil 4.28 yüzeyi (0,41, 0,41) →
   %1,08'i minimum gösteriyor. Hangisinin nihai olduğu belirtilmemiş.
8. **(Y) Yöntemler eşit koşulda karşılaştırılmamış.** Üç deney farklı DA bara
   gerilimlerinde koşmuş (klasik 430 V, susturma 395 V, Sin³ 427 V; faz-nötr
   120/120/124 V). %92,5 → %94,2 → %94,5 verim dizisi bu yüzden tek değişkenli
   bir üstünlük kanıtı değil.
9. **(Y) Metin içi çelişki: "kontrolör kullanılmamıştır" (Bölüm 4 benzetim
   açıklaması) ile osiloskop kanal adı "kontrolör çıkışı" (Bölüm 5) aynı anda
   var. Kapalı çevrimin var olup olmadığı metinden çıkarılamıyor.
10. **(Y) Güç anma değeri tutarsız.** Aynı metinde "20-25 kW" (deney düzeneği),
    "25 kW" (benzetim), "20 kVA" (sensör hesabı; 6.667/220 ≈ 30 A) ifadeleri
    birlikte geçiyor; kVA/kW ayrımı yapılmamış.
11. **(Ö) %23,6 düşük güç oranı** temsili 144 noktalı örneklemden geliyor ama
    metinde "gerçeğinden yola çıkılarak" diye saha bulgusu gibi sunulmuş; kaynak
    PVGIS sorgusu ve konum yok. Tablo 2.1 ile Şekil 2.4 sayıları da uyuşmuyor.
12. **(Ö) Deneysel izlenebilirlik yok.** Ham osiloskop/Modbus kayıtları, FFT
    penceresi tanımı, kalibrasyon belgeleri ve tekrar sayısı verilmemiş; sonuç
    tablosu 5.4'ün simülasyon sütunu boş bırakılmış.
13. **(Ö) Patentler bilimsel kanıt yerine kullanılmış.** "Literatüre katkı"
    bölümü performans doğrulaması yerine tescil numaralarına yaslanıyor.

## 3. Dil ve biçim sorunları

14. **(Y) Terminoloji tutarsız ve İngilizce ağırlıklı.** "feedforward" 39 kez
    geçerken "ileri besleme" 0 kez; aynı kavram "sinküp" (8), "Sin3" (9),
    "sin3" (9), "Sin³" (6) yazımlarıyla dolaşıyor. "Complement anahtarlama",
    "single-ended", "buffer", "driver" gibi terimler Türkçe karşılık ve ilk
    geçişte parantez içi İngilizce kuralı olmadan kullanılmış.
15. **(Y) Kırık çapraz referanslar.** Bölüm 5'te bir paragrafta üç kez "Şekil
    39" (bozuk Word alanı; "Şekil 39ve", "Şekil 39şeklinde" bitişik yazımıyla);
    EMK-01 analizör şekli "Şekil 14.a/14.b" diye bölüm numarasız verilmiş
    (doğrusu 5.14). Metinde ayrıca serbest duran "2.21 A" satırı var (kopuk
    tablo/paragraf artığı).
16. **(Ö) Başlık numaralandırması bozuk.** 4.6 İçindekiler'de görünmüyor; 4.8
    başlık stiliyle işaretlenmemiş; 3.8 başlığı iki paragrafa bölünmüş
    ("…Arasındaki" + devamı); 1.6.1–1.6.3 ve 1.7'de numara sonu noktası yok
    (1.2.1. biçimindeki diğerleriyle tutarsız).
17. **(Y) "Şekilde verilmiştir" üslubu baskın.** "verilmiştir" 36 +
    "gösterilmiştir" 21 kez; birçok şekil/tablo metin içinde amaç-bulgu-sınır
    yorumu yapılmadan yalnızca ilan ediliyor (jüri isteği 11 ile ilişkili).
    Paragraf başı "Bu …" kalıbı 47 kez, "bu nedenle" 69 kez geçiyor; mekanik
    bağlaç tekrarları belirgin.
18. **(Ö) Şekil kalitesi.** 57 kaynak görselin 27'si baskı için riskli; Bölüm
    4'ün beş simülasyon TIFF'i 560×396 piksel. 129 gömülü görselin çoğunun
    kaynak dosyası yok.
19. **(Ö) Nihai dosyada 164 izlenen değişiklik (track changes) açık kalmış.**

## 4. Fiziksel/matematiksel içerik hataları

20. **(Ö/Y) sin³ özdeşliği katsayı hatası riski.** Doğrusu
    sin³(x) = [3sin(x) − sin(3x)]/4. Kaynak PDF'te katsayı hatası tespit
    edilmişti; eski 4.11'de Laplace dönüşümünde ikinci terimin katsayısı da
    (3/4)·ω/(s²+9ω²) yazılmış — doğru dönüşümde −(1/4)·3ω/(s²+9ω²) olmalı
    (sayısal olarak eşdeğer görünse de 4.20 ile 4.22 arasında bu çarpan
    kayboluyor; madde 6c).
21. **(Y) d_krit = 0,8007 evrensel sabitmiş gibi.** Kritik görev oranı faz
    açısına ve gerilim oranına bağlıyken tek sayı verilmiş, türetimi yok.
22. **(Y) Uygulanan terimin kimliği belirsiz.** Metin K·sin³(θ) yazıyor ama
    kodun sin³ mü sin(3θ) mu ürettiği hiçbir yerde belgelenmiyor (iki ifade
    farklı katsayı anlamı taşır; yeni hatta R07 isteğiyle işaretlendi).

## 5. Sonuç

Eski tezin çekirdek fiziksel gözlemi (düşük güçte nötr kol ters akımı, susturma
ile verim-THD ödünleşimi, Sin³ ile üçüncü harmonik azaltımı) savunulabilir ve
Senaryo 1–3 ekranlarıyla nitel olarak destekli. Sorun içerik fikrinde değil;
(1) katkı hiyerarşisini yanlış kuran başlık/akış, (2) kararlılık kanıtının
yokluğu, (3) geçersiz türetim zinciri, (4) eşit koşullu ve izlenebilir deney
eksikliği ve (5) dil/biçim özensizliğinde. Yeni hat (`tez-latex-v2/`) bu beş
başlığın tamamını yapısal olarak adresleyecek şekilde kurgulanmıştır; eksik
kanıtlar metin içinde turuncu "EKSİK ÇALIŞMA — BUNU İSTİYORUZ" barlarıyla
işaretlenmiştir.
