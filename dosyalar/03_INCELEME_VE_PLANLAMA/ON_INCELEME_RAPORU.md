# Tam tez ön inceleme raporu

Tarih: 12 Temmuz 2026  
Kaynak: `01_TAM_TEZ/tez_tumu_8.docx`

## Kısa karar

Tezin teknik malzemesi tek bir katkıdan ibaret değil; mevcut metin üç katkı iddia ediyor:

1. T-tipi eviriciler için düşük güçte verimi artıran yeni anahtarlama yöntemi,
2. üçüncü harmoniği azaltmaya yönelik Sin³ tabanlı feedforward kompanzasyonu,
3. enerji depolama sistemleri için yeniden yapılandırılabilir GT-tipi güç elektroniği mimarisi.

Sorun, bu katkıların aynı bilimsel omurgada ve kanıt zincirinde yeterince erken birleştirilmemesidir. Başlıktaki "ileri beslemeli kontrol stratejisi" ifadesi ikinci katkıyı ana tez konusu gibi gösterirken, GT-tipi mimari ancak 6. bölümde belirginleşmektedir.

## Sayısal envanter

- Dosya boyutu: 61,75 MB
- Yaklaşık sözcük: 29.890
- Boş olmayan paragraf: 1.177
- Algılanan başlık: 116
- Tablo: 23
- Gömülü görsel: 129
- Word bölümü (section): 3
- İzlenen ekleme: 164
- Yorum parçası: yok

Terim taramasında `T-tipi` 160, `feedforward` 43, `Sin3/Sin³` 11, `LCL` 18 kez geçmektedir. Buna karşılık `Bode` hiç geçmemekte, `kararlılık` yalnızca iki kez geçmektedir. Bu, jürinin kararlılık ve kapılı çevrim kanıtı talebinin mevcut sürümde karşılanmadığını gösterir.

## Ana yapısal sorunlar

### 1. Tez başlığı katkı hiyerarşisini yanlış kuruyor

Mevcut başlık: "Enerji Depolama Sistemleri için geliştirilmiş T-tipi topoloji ile yeni nesil şarj-deşarj mimarisi ve ileri beslemeli kontrol stratejisi".

"Feedforward control" ifadesi yeni veya kapılı çevrimi belirleyen bir kontrol yasası algısı yaratıyor. Mevcut anlatıma göre Sin³ bileşeni hata sinyalinden üretilmeyen ve modülasyon toplamına eklenen bir terimdir. Bu nedenle "Sin³ tabanlı ileri besleme kompanzasyonu" ya da "harmonik şekillendirme bileşeni" daha isabetli bir terimdir. Ancak terim değişikliği kararlılık analizinin yerine geçmez.

### 2. Genelden özele akış kopuyor

Bölüm 1 enerji depolama, batarya yaşlanması, BYS ve dengeleme ile başlıyor. Bölüm 2 fotovoltaik eviricilerin düşük güç performansına geçiyor. Bölüm 3-5 T-tipi evirici, anahtarlama, Sin³ ve gerçek zaman uygulamalarını ele alıyor. Asıl enerji depolama/GT-tipi mimari ise Bölüm 6'da yeniden ortaya çıkıyor. Okur, tezin tek bir ana soruya mı yoksa iki bağımsız probleme mi cevap verdiğini geç anlıyor.

### 3. Katkılar geç ilan ediliyor

Üç katkı en açık biçimde sonuç bölümünde sıralanıyor. Yeni sürümde araştırma boşluğu, hipotez/araştırma soruları, üç katkı ve her katkının doğrulama yöntemi Giriş'in sonunda tek bir tablo veya açık liste halinde verilmelidir.

### 4. Analiz ve doğrulama zinciri eksik

Bölüm 4'te bazı simülasyonların kontrolörsüz yapıldığı ve yalnızca feedforward katsayısıyla akım seviyesinin ayarlandığı belirtilmektedir. Jüri ise kapılı çevrim modelini, Bode diyagramlarını ve nominal güçte çalışmayı istemektedir. Mevcut kanıt, yöntemin oluşum mekanizmasını gösterebilir; fakat kapılı çevrim performansını tek başına kanıtlamaz.

### 5. Deneysel kanıt durumu netleştirilmeli

Tam tezde "Gerçek Zaman Uygulamaları" bölümü, donanım açıklamaları ve gerçek uygulama/simülasyon karşılaştırma tablosu vardır. Buna karşın jüri notunda son kısım için deneysel test istenmiş ve parantez içinde bunun yapılamadığı belirtilmiştir. Yeni metinden önce mevcut deney verilerinin ham kayıt, test koşulu, kalibrasyon, tekrarlanabilirlik ve nominal güç kapsaması bakımından denetlenmesi gerekir. Yeni deney yapılamıyorsa iddialar mevcut kanıt kapsamıyla sınırlanmalı ve bu akademik risk danışmanla açıkça kararlaştırılmalıdır.

### 6. Biçim ve numaralandırma kusurları var

- Bölüm 4 başlıklarında 4.6 görünmüyor; 4.5'ten 4.7'ye geçiliyor.
- Metinde 4.8 "Yapılan Çalışmanın Literatüre Katkısı" bulunuyor, fakat başlık stiliyle işaretlenmemiş.
- Bölüm 3'te 3.8 başlığı iki ayrı başlık paragrafına bölünmüş; 3.9 ise `Heading 3` düzeyindedir.
- Tam tezde izlenen değişiklikler bulunmaktadır; nihai derlemeden önce temizlenmelidir.

### 7. Şekil kaynaklarında baskı kalitesi riski var

Bölüm klasörlerinde 57 şekil dosyası bulundu: 21 PNG, 31 JPEG ve 5 TIFF. Tam tezde ise 129 gömülü görsel vardır; dolayısıyla tam tezdeki her görselin ayrı kaynak dosyası mevcut değildir. Basit baskı ön elemesinde (genişlik 1500 pikselden veya yükseklik 900 pikselden az) 57 kaynağın 27'si riskli bulundu.

En kritik örnekler Bölüm 4'teki beş simülasyon TIFF dosyasıdır; her biri yalnızca 560 x 396 pikseldir. Bölüm 3'teki `Sekil3_11_senkron_buck_akımlar.jpg` 704 x 686, `Sekil3_12_senkron_buck_sureksiz_akımlar.jpg` 704 x 645 pikseldir. `Sekil4_21_feedforward3.jpg` ise 1395 x 612 piksellik bir model ekran görüntüsüdür; ince çizgiler ve küçük blok etiketleri tez baskısında okunabilirlik riski taşır. Bu şekiller ekran görüntüsü büyütülerek değil, kaynak model/grafikten vektör veya en az 300 dpi hedefiyle yeniden üretilmelidir.

## Kararlılık savının doğru kurulumu

Doğrusal ve doyumsuz bir modelde

`u(s) = C(s)[r(s)-y(s)] + f(s)` ve `y(s) = G(s)u(s)`

ise

`y(s) = [G(s)C(s)/(1+G(s)C(s))]r(s) + [G(s)/(1+G(s)C(s))]f(s)`.

Bu ideal varsayımlar altında dışsal ve hata/geri beslemeden bağımsız `f(s)` terimi karakteristik paydayı değiştirmez. Fakat tezdeki gerçek sistem PWM, örnekleme/gecikme, LCL rezonansı, doyum, akım sınırlama, DCM/ters akım bölgesi ve çalışma noktasına bağlı doğrusal olmayanlıklar içerir. Bu nedenle yeni tez şunları birlikte vermelidir:

1. varsayımları açık ideal kapalı çevrim türetimi,
2. Sin³ bileşeni kapalı/açık iken aynı `L(s)=C(s)G(s)` Bode eğrisinin neden değişmediğinin gösterimi,
3. duyarlılık `S=1/(1+L)` ve tamamlayıcı duyarlılık `T=L/(1+L)`,
4. düşük güç ve nominal güç çalışma noktalarında lineerleştirilmiş/benzetim tabanlı doğrulama,
5. doyum ve sınırlayıcıların devreye girip girmediğini gösteren zaman alanı sonuçları.

## Öncelik sırası

1. Tezin tek cümlelik ana savını ve hangi üç katkının korunacağını kesinleştir.
2. Başlığı "kontrol stratejisi" yerine katkı hiyerarşisini yansıtacak biçimde değiştir.
3. Yeni içindekiler ve kanıt matrisi oluştur.
4. Sistem blok diyagramı ve parametre tablosunu tek referans noktaları olarak hazırla.
5. Kapalı çevrim/stabilite ve nominal güç kanıtını tamamla.
6. Deneysel kanıtın gerçek kapsamını denetle; iddiaları buna göre kilitle.
7. Metni yeni omurgaya taşı, şekilleri yeniden üret ve son biçim denetimini yap.
