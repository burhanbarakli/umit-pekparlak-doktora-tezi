# Tezin yeniden tasarım omurgası

## Önerilen ana sav

T-tipi dönüştürücünün yapısal ve anahtarlama özellikleri, enerji depolama sistemlerinde hem şarj-deşarj işlevlerinin yeniden yapılandırılması hem de düşük güçte verim-harmonik ödünleşiminin iyileştirilmesi için kullanılabilir; Sin³ terimi bu ikinci hedefte kullanılan bir ileri besleme kompanzasyonudur, bağımsız bir kapalı çevrim kontrolcüsü değildir.

Bu sav, mevcut üç katkıyı tek bir "T-tipi tabanlı yeniden yapılandırma ve performans iyileştirme" ekseninde birleştirir.

## Başlık adayları

### Önerilen birleşik başlık

**Enerji Depolama Sistemleri İçin Geliştirilmiş T-Tipi Dönüştürücü Mimarisi ve Düşük Güç Performansını İyileştiren Anahtarlama ve Sin³ Tabanlı Kompanzasyon Yöntemleri**

Bu başlık, "feedforward control" yanlış anlamasını azaltır ve T-tipi katkıyı öne alır.

### Mimari ağırlıklı alternatif

**Enerji Depolama Sistemleri İçin T-Tipi Dönüştürücü Tabanlı Yeniden Yapılandırılabilir Şarj-Deşarj Mimarisi ve Düşük Güç Performansının İyileştirilmesi**

GT-tipi mimari birincil doktora katkısı olarak konumlandırılacaksa tercih edilmelidir.

### Düşük güç ağırlıklı alternatif

**T-Tipi Eviricilerde Düşük Güç Verim ve Harmonik Performansının Yeni Anahtarlama ve Sin³ Tabanlı İleri Besleme Kompanzasyonu ile İyileştirilmesi**

GT-tipi mimari tez kapsamından çıkarılacak veya ikincil ek çalışma olarak verilecekse tercih edilmelidir.

## Önerilen bölüm yapısı

### 1. Giriş

- problem bağlamı ve motivasyon,
- tek cümlelik ana sav,
- araştırma soruları,
- kapsam ve sınırlılıklar,
- üç katkı ve her katkının doğrulama yöntemi,
- tez organizasyonu.

Mevcut Bölüm 1'deki genel batarya/BYS anlatımı kısaltılmalı; yalnızca ana savı kurmak için gerekli kısımlar korunmalıdır.

### 2. Literatür, kuramsal temel ve araştırma boşluğu

- enerji depolama ve güç dönüşüm mimarileri,
- T-tipi evirici ve yeniden yapılandırılabilir topolojiler,
- düşük güç verimi, ters akım ve THD,
- akım kontrolü, şebeke gerilimi ileri beslemesi ve kompanzasyon ayrımı,
- literatür karşılaştırma tablosu,
- açık araştırma boşluğu.

### 3. Sistem mimarisi, model ve deney/benzetim metodolojisi

- genel blok diyagram,
- enerji akışı ve sinyal akışı,
- T-tipi topoloji ve çalışma modları,
- LCL, şebeke, DA bara, anahtarlama ve kontrol modeli,
- tek bir elektriksel parametre tablosu,
- ölçütler: verim, THD, kararlılık marjları, geçici rejim,
- simülasyon ve deney protokolleri.

Bu bölüm, sonraki tüm sonuçların ortak referans noktası olmalıdır.

### 4. T-tipi eviricide düşük güç analizi ve yeni anahtarlama yöntemi

- ters akım dolaşım mekanizması,
- senkron buck eşdeğeri,
- klasik ve önerilen anahtarlama,
- verim kazanımı ve THD maliyeti,
- analiz sonucu ve ara karar.

Analiz, yöntem ve ilk sonuçlar tek yerde tamamlanmalı; ileriki bölümlerde aynı analize geri dönülmemelidir.

### 5. Sin³ tabanlı ileri besleme kompanzasyonu ve kapalı çevrim analizi

- terimin matematiksel tanımı ve fiziksel gerekçesi,
- "kontrolcü" değil "kompanzasyon" olduğunun blok diyagramla gösterimi,
- kapalı çevrim türetimi,
- Bode, kazanç/faz marjı, `S` ve `T`,
- PWM/gecikme/LCL/doyum varsayımları,
- düşük-orta-nominal güç karşılaştırması,
- klasik / yeni anahtarlama / yeni anahtarlama + Sin³ ablasyonu.

### 6. Deneysel doğrulama

- donanımı yalnızca testi yeniden üretecek ayrıntıda tanıt,
- ölçüm cihazı, kalibrasyon, örnekleme, belirsizlik,
- test matrisi ve ham veri işleme,
- simülasyon-deney karşılaştırması,
- düşük ve nominal güç sonuçları,
- sınırlılıklar.

Yeni deney gerçekten yapılamıyorsa bu bölüm yalnızca mevcut ve izlenebilir kanıta dayanmalı; desteklenmeyen genellemeler kaldırılmalıdır.

### 7. GT-tipi yeniden yapılandırılabilir enerji depolama mimarisi

- tasarım gereksinimleri,
- klasik mimariyle karşılaştırma,
- evirici/PFC/BYS işlevleri ve mod geçişleri,
- anahtarlama durumları ve güvenlik kısıtları,
- simülasyon/deney kanıtı,
- yarı iletken sayısı, kayıp, hacim ve maliyet etkisi,
- patentler ile bilimsel katkı arasındaki ayrım.

Bu katkı tezin ana savında tutulacaksa Bölüm 1-3'te mutlaka hazırlanmalı; sonradan eklenmiş bağımsız bir çalışma gibi görünmemelidir.

### 8. Sonuçlar ve gelecek çalışmalar

- her araştırma sorusuna sayısal cevap,
- her katkı için kanıt ve sınır,
- simülasyon ile deneyin ayrı raporlanması,
- desteklenmeyen genelleme yapmadan gelecek çalışmalar.

## Zorunlu ortak tablolar ve şekiller

1. Tezin genel sistem blok diyagramı.
2. Üç katkı - araştırma sorusu - yöntem - kanıt matrisi.
3. Elektriksel ve kontrol parametreleri tablosu.
4. T-tipi çalışma modları için renkli akım yolu şekil seti.
5. Klasik ve önerilen anahtarlama karşılaştırması.
6. Sin³ kapalı/açık blok diyagramı ve Bode seti.
7. Düşük-orta-nominal güç test matrisi.
8. Simülasyon-deney sonuç tablosu ve belirsizlik notları.
9. GT-tipi ve klasik ESS mimarisi işlev/eleman/kayıp karşılaştırması.

## Yazım ilkeleri

- `feedforward control` yerine, matematiksel yapı doğruladığı sürece `ileri besleme kompanzasyonu` kullan.
- Her iddia için kaynak, türetim, simülasyon veya deney kanıtı belirt.
- Kontrolörsüz mekanizma analizi ile kapalı çevrim performans testini birbirine karıştırma.
- Simülasyon ve deney sonuçlarını aynı tabloda bile olsa açıkça ayır.
- "İyileştirildi" gibi ifadeleri metrik, baz çizgi, güç seviyesi ve belirsizlikle birlikte kullan.
- Şekil ve tablolara metin içinde yorum getirmeden yalnızca "verilmiştir" demekle yetinme.

