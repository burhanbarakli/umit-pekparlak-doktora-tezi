# Sonradan Gelen Dosyalar: İnceleme ve Deney Haritası

## 1. Ana sonuç

Yeni dosyalar tezde savunulan mekanizmayı desteklemektedir: klasik senkron anahtarlama düşük akımda ters enerji dolaşımı oluşturur; ilgili nötr anahtarın susturulması kayıp yolunu keserken akımı süreksiz moda taşır ve üçüncü harmoniği büyütür; PLL tabanlı Sin³ ileri besleme terimi harmonik bozulmayı yeniden azaltmayı hedefler.

Üç senaryo yalnız görüntü olarak gelmiştir. `.slx`, `.mat`, ham zaman serisi veya kontrol kodu bulunmadığı için sayısal değerler henüz yeniden üretilebilir deney kanıtı değildir.

## 2. Anahtarlama senaryoları

| Senaryo | Yüksek güvenli eşleme | IL1 THD | Iout THD | Yorum |
|---|---|---:|---:|---|
| 1 | Klasik senkron anahtarlama | %8,29 | %2,14 | En temiz filtre çıkış akımı; ters akım ve verim kaybı ayrıca ölçülmeli. |
| 2 | Düşük güçte nötr anahtar susturma | %46,86 | %46,35 | 150 Hz baskın; verim kazanımı karşılığında kabul edilemez THD. |
| 3 | Susturma + Sin³ kompanzasyonu | %9,46 | %7,79 | Senaryo 2'ye göre büyük iyileşme, fakat Senaryo 1'in THD seviyesine inmiyor. |

FFT ekranları `t=0,06 s` başlangıçlı iki çevrim, 50 Hz temel frekans ve 550 Hz görüntüleme üst sınırı kullanmaktadır. Sonuçlar tezde kullanılacaksa analiz ayarları birebir yeniden kurulmalıdır.

Senaryo 1 paketi, önceki tezin Şekil 4.5--4.9 sonuç setini doğrulamaktadır. Eski dosyadaki tam $L_1$ dalga biçimi ve büyütülmüş kesit korunmuş; sonradan gelen yüksek çözünürlüklü dört-kanal ekran ile $L_1$/çıkış FFT ekranları yeni tezde Şekil 4.5--4.9 olarak ayrı ayrı yerleştirilmiştir. Özgün dört-kanal ekran, eski Şekil 4.7 başlığındaki ikinci kanalın kontrolör çıkışı değil filtrelenmiş gerilim olduğunu gösterdiğinden kanal açıklaması düzeltilmiştir. Ham zaman serisi eksikliği nedeniyle aktarım, yeniden hesaplanmış sonuç değil ikincil benzetim kanıtıdır.

## 3. Sin³ ifadesindeki kritik düzeltme

Ana kaynak PDF'nin 10. sayfasında katsayılar hatalı dizilmiştir. Doğru özdeşlik:

`sin³(x) = [3 sin(x) - sin(3x)] / 4`

Kaynak metnin bir bölümü ileri besleme yoluna `sin(3x)` eklendiğini, blok diyagram ise PLL'den alınan `sin(x)` işaretinin küpünün kullanıldığını göstermektedir. Gerçek Simulink modeli veya kontrol kodu gelmeden uygulanan terimin `K·sin³(θ)`, `K·sin(3θ)` veya temel bileşeni yeniden ölçeklenmiş bir birleşim olduğu kesinleştirilemez.

## 4. Parametre ve mimari kaynakları

| Kaynak | Değerler | Kanıt rolü |
|---|---|---|
| Deşarj parametre M dosyası | `Vdc=400 V`, `Vrms=230 V`, `f=50 Hz`, `fs=10 kHz`, `Ts=1e-7 s`, `kp=1` | Senaryo benzetimi için aday; `Ts` büyük olasılıkla güç devresi çözüm adımıdır, kontrol örnekleme zamanı olmayabilir. |
| Ümit tez ana kaynak PDF | 30 kW, düşük güç noktası %7, THD %6,1, verim %86,5; 30 kHz trafo anahtarlaması | Eski proje/tez anlatımı. |
| 1001 başvuru formu v9 | 100 kW hedef, 1000 V DA bara referansı, 34,5/0,69 kV, AB/BC/CA fazlar arası konteynerler | Yeni sistem hedefi; deney sonucu değildir. |
| Microchip Vienna PFC | 30 kW, 380/400 V hatlar arası, 700 V DA, 140 kHz, 70 µH, %98,5 verim, tam yükte yaklaşık %2,5–2,6 THD | Harici referans tasarım; tezin prototip parametresi olarak kopyalanamaz. |

30/100 kW, 400/700/1000 V ve 10/30/140 kHz değerleri farklı alt sistemlere ve sürümlere aittir. Tek parametre tablosunda birleştirilmeden önce sistem seviyesi, donanım sürümü ve çalışma modu etiketlenmelidir.

## 5. Tez yazımında yapılacaklar

1. Bölüm 3'te klasik, susturma ve susturma+Sin³ anahtarlama durumları aynı faz kolu üzerinde kapılar ve akım yollarıyla çizilecek.
2. Sin³ özdeşliği doğru katsayılarla verilecek; kaynak PDF'deki yazım hatası tekrarlanmayacak.
3. Senaryo THD değerleri Bölüm 4/5'e “kurtarılmış benzetim ekranı; ham veri bekleniyor” etiketiyle alınacak ve ham veri gelene kadar nihai kanıt sayılmayacak.
4. Vienna PFC verileri literatür karşılaştırmasında kullanılacak; tez prototipinin verim/THD sonucu gibi sunulmayacak.
5. Ek-A topoloji şekilleri Bölüm 2'de yalnız gerekli dört topolojinin karşılaştırmasına indirgenecek.
6. Ek-D BYS yöntemleri Bölüm 2'de sentez tablo ve araştırma boşluğu için kullanılacak; on üç şekil topluca ana metne alınmayacak.
7. 100 kW başvuru mimarisi ile eski 30 kW tez mimarisi ayrı sürümler olarak anlatılacak; nihai tez kapsamı danışmanla kilitlenecek.
8. Başvuru formuna göre şebekeye enerji basan deşarj prototipi laboratuvar standartları nedeniyle test edilmeyecektir. Gerçek şebekeye bağlı deney yoksa deşarj katkısı benzetimle sınırlı açıklanacak.

## 6. Benzetim ve deney planı

### Aşama A — Birebir yeniden üretim

- Ölü zamansız tek faz modeli kurulacak.
- 400 V/230 V/50 Hz/10 kHz aday parametreleri girilecek.
- Senaryo 1–2–3 aynı LCL, yük ve kontrol koşulunda koşturulacak.
- `IL1` ve `Iout` için 0,06–0,10 s aralığındaki iki çevrim FFT penceresi kullanılacak.
- Temel, 3., 5., 7., 9. ve 11. harmoniklerle THD raporlanacak.

### Aşama B — Gerçekçilik basamakları

- Ölü zaman, yarı iletken gerilim düşümü, parazitik kapasite ve ölçüm gecikmesi tek tek eklenecek.
- Sin³ kazancı yalnız düşük güçte taranacak; orta/anma gücünde etkisizleştirme veya yumuşak geçiş uygulanacak.
- Kapalı çevrim PR/PI yapısı, L/S/T Bode eğrileri ve şebeke empedansı duyarlılığı gerçek parametrelerle yeniden hesaplanacak.

### Aşama C — Donanım doğrulaması

- Düşük, orta ve anma gücünde en az üç tekrar yapılacak.
- Eşzamanlı `Vdc`, faz gerilimi, `IL1`, şebekeye/yüke giden akım, dört kapı işareti ve güç analizörü kaydı alınacak.
- THD, verim, güç faktörü, ters akım alanı, RMS akım, kontrol eforu, sıcaklık ve doyum süresi raporlanacak.
- Ham CSV/MAT kaydı, kalibrasyon bilgisi, prob oranları ve deney tarihi saklanacak.

## 7. Hâlen eksik dosyalar

- Senaryo 1–2–3'ü üreten `.slx` modelleri
- `L1`, `L2`, `Cf`, `Rd` ve yarı iletken parametreleri
- Gerçek kapılama kodu ve Sin³ denklemi
- Ölü zaman ve sürücü ayarları
- Ham zaman serileri ve güç/verim kayıtları
- Sistemin nihai 30 kW mı, 100 kW mı olduğunu belirleyen tasarım kararı

## 8. 2026-08-22 ek girdileri

Ümit'in yeni e-postasıyla `L1/L2/C` ve seri dirençleri, S12/S34 geçiş
süreleri, DS12/DS34/D12 diyot parametreleri, 431 V DA bara, 169 V RMS çalışma
noktası ve dört senaryonun denetim tanımları gelmiştir. Tam Proteus topoloji
şeması da incelenmiştir. Ayrıntılar ve kaynaklar arasındaki farklar
`incoming_real_data/parameters/2026-08-22_umit_senaryo_parametreleri.md`
dosyasında kayıtlıdır.

Bu bilgi, yukarıdaki eksiklerin bir bölümünü kapatır; fakat etkin modellere
henüz uygulanmamıştır. Özellikle e-postadaki `L2=200 µH` ile şemadaki
`L2=600 µH` farkı, anahtarlama/örnekleme frekansları, K1/K3 ve PI kazançları,
Senaryo 2 kapı mantığının kesin eşlemesi, kayıp modeli ve THD/verim hesap
yöntemi hâlâ doğrulanmalıdır. Bildirilen %92,5/%94,2/%94,5 verim ve yaklaşık
%47/%14 THD değerleri modele zorla uydurulmayacak; aynı koşullarda bağımsız
olarak yeniden hesaplanacaktır.
