# T-tipi evirici Simulink denemesi

Bu klasör, tezde tanımlanan T-tipi evirici, LCL filtre, düşük güç bozucu etkisi ve
Sin³ kompanzasyon yolunu hızlıca sınamak için hazırlanmış ortalama değerli bir
Simulink modelidir.

## İçerik

- `models/t_type_lcl_sin3_demo.slx`: otomatik üretilen Simulink modeli
- `models/t_type_q1q4_switching_demo.slx`: Q1-Q4 IGBT'li Simscape Electrical faz kolu
- `models/t_type_q1q4_closed_loop_demo.slx`: kapalı çevrim, nötr susturma ve Sin³ sürümü
- `models/t_type_three_phase_four_wire_average.slx`: üç fazlı dört telli ortalama model
- `models/t_type_three_phase_q1q4_switching.slx`: ortak DA baralı, 12 IGBT'li fiziksel üç faz modeli
- `models/t_type_three_phase_q1q4_closed_loop.slx`: fiziksel üç faz modelinin PR kapalı çevrim sürümü
- `parameters/thesis_demo_parameters.m`: bütün deneme parametreleri
- `scripts/build_demo_model.m`: modeli sıfırdan kurar
- `scripts/run_demo.m`: kompanzasyonsuz ve Sin³ kompanzasyonlu iki deneyi çalıştırır
- `scripts/run_switching_demo.m`: P-O-N anahtarlama durumlarını çalıştırır ve doğrular
- `scripts/run_closed_loop_comparison.m`: üç yöntemi aynı koşullarda karşılaştırır
- `scripts/tune_sin3_gain.m`: geçici Sin³ kazanç taramasını yapar
- `scripts/run_three_phase_average_comparison.m`: üç faz ve nötr akımını karşılaştırır
- `scripts/run_three_phase_switching_demo.m`: fiziksel üç faz modelini koşturur ve kapı durumlarını doğrular
- `scripts/run_three_phase_switching_closed_loop.m`: üç faz kapalı çevrimi koşturur; RMSE, THD ve nötr RMS'i kaydeder
- `results/comparison.png`: akım karşılaştırması
- `results/metrics.csv`: RMSE ve THD karşılaştırması
- `results/switching/observed_switching_states.csv`: gözlenen P-O-N durumları
- `results/switching/switching_waveforms.png`: Q1-Q4, kutup gerilimi ve LCL akımları
- `results/switching/switching_metrics.csv`: açık çevrim ilk RMS/THD kontrolü

## Çalıştırma

MATLAB içinde proje klasörüne geçip aşağıdaki komutu çalıştırın:

```matlab
run(fullfile('scripts','run_demo.m'))
```

Modeli açmak için:

```matlab
open_system(fullfile('models','t_type_lcl_sin3_demo.slx'))
```

Q1-Q4 anahtarlamalı modeli çalıştırmak için:

```matlab
run(fullfile('scripts','run_switching_demo.m'))
```

## Modelin sınırı

İlk deneme anahtarlama ortalaması üzerinden çalışır. LCL kapasitör kolunda
geçici bir seri pasif sönüm direnci bulunur. Q1-Q4 IGBT darbeleri,
ölü zaman, yarı iletken kayıpları ve gerçek nötr akım yolu henüz modellenmemiştir.
`Kdist*sin^3(wt)` terimi, düşük güçte oluşan bozucu etkinin kontrollü bir
eşdeğeridir. Sin³ yolu etkinleştirildiğinde aynı terimin ters işaretlisi
modülasyon komutuna eklenir.

Sonraki aşamada ortalama güç katı, Simscape Electrical anahtarlarıyla kurulmuş
üç fazlı dört telli T-tipi güç katıyla değiştirilebilir.

## Anahtarlamalı modelin mevcut durumu

Anahtarlamalı modelde bölünmüş 400 V DA bara, dört ideal IGBT, geri yönlü nötr
anahtar çifti, 10 kHz PWM, seri sönümlü LCL filtre ve 120 V/50 Hz şebeke kaynağı
bulunmaktadır. Otomatik kontrol yalnızca `P=1010`, `O=0011` ve `N=0101`
durumlarının oluştuğunu doğrulamıştır.

Mevcut anahtarlamalı model açık çevrimlidir. İlk geçici parametrelerle şebeke
akımı 1,23 A RMS ve %7,76 THD vermiştir. Değerler modelin çalıştığını gösteren
bir mühendislik kontrolüdür; gerçek LCL değerleri ve kapalı çevrim denetleyici
eklenmeden tez bulgusu olarak kullanılamaz.

## Kapalı çevrim ilk karşılaştırma

Kapalı çevrim modelde şebeke gerilimi ileri beslemesi, P+rezonans akım
denetleyicisi, bir PWM periyotluk sayısal gecikme, seçilebilir nötr anahtar
susturma ve seçilebilir Sin³ kompanzasyonu bulunmaktadır. Geçici parametrelerle:

- Klasik yöntem: 2,30 A RMS, %3,97 THD
- Nötr susturma: 2,31 A RMS, %8,34 THD
- Nötr susturma + Sin³: 2,34 A RMS, %8,13 THD

Ölü zaman eklenmeden yapılan ilk Sin³ kazanç taramasında en düşük THD noktası
geçici olarak +2 V bulunmuştur. Ölü zamanlı güncel sonuç aşağıda ayrıca verilmiştir.
Gerçek sistem değerleri tamamlanmadan sonuçlar tez bulgusu olarak kullanılmamalıdır.

### Ölü zamanlı güncel karşılaştırma

Yükselen kapı kenarına 2 µs deneme ölü zamanı eklendiğinde güncel sonuçlar:

- Klasik ideal: %3,97 THD
- Klasik + 2 µs ölü zaman: %10,07 THD
- Nötr susturma + 2 µs ölü zaman: %11,38 THD
- Nötr susturma + Sin³: %11,18 THD

Ölü zamanlı kazanç taramasında geçici Sin³ kazancı -2 V seçilmiştir. Gerçek ölü
zaman değeri yazılım veya osiloskop kaydından doğrulanmayı beklemektedir.

### Geçici kararlılık analizi

Ortalama LCL ve PR modeli için toplam 150 µs hesaplama/PWM gecikmesiyle kapalı
çevrim kararlı bulunmuştur. Geçici kazanç marjı 9,09 dB, faz marjı 64,16°'dir.
0–2 mH ek şebeke endüktansı taramasındaki bütün modeller kararlı kalmıştır.
Değerler gerçek LCL ve denetleyici katsayılarıyla yeniden üretilmelidir.

## Üç fazlı dört telli ortalama model

Üç adet faz başına LCL/PR modeli 120° kaydırılmış referanslarla birleştirilmiş ve
nötr akımı `-(ia+ib+ic)` olarak ayrıca kaydedilmiştir. Kavramsal karşılaştırma:

- Klasik dengeli çalışma: nötr akımı yaklaşık sıfır
- Nötr susturma bozucu eşdeğeri: faz THD değerleri yaklaşık %8,09 ve nötr akımı 0,574 A RMS
- İdeal Sin³ karşı kompanzasyonu: kavramsal bozucu iptal edilerek nötr akımı yeniden yaklaşık sıfıra iner

Bozucu ve kompanzasyon aynı büyüklükte tanımlandığı için son senaryo ideal bir
mekanizma gösterimidir. Anahtarlamalı fiziksel üç faz sonuçları yerine kullanılamaz.

## Üç fazlı fiziksel anahtarlamalı model

Ortak bölünmüş 400 V DA bara üzerinde üç T-tipi faz kolu, toplam 12 IGBT,
faz başına LCL filtre, 120 V/50 Hz şebeke kaynağı ve 2 µs deneme ölü zamanı
kurulmuştur. Otomatik doğrulama her üç fazda geçersiz kapı durumu ve Q1-Q2
eşzamanlı iletim sayısını sıfır bulmuştur.

Açık çevrim ilk koşuda faz akımları yaklaşık 0,865 A RMS, faz THD değerleri
%21,79-%21,92 ve nötr akımı 0,457 A RMS bulunmuştur. Yüksek THD, modelin henüz
kapalı çevrim akım denetimi içermediğini gösterir. Sonuçlar topoloji ve kapı dizisi
doğrulamasıdır; tez başarım sonucu olarak kullanılmamalıdır.

### Fiziksel üç faz kapalı çevrim

Faz başına PR akım denetleyicisi, şebeke gerilimi ileri beslemesi ve bir PWM
periyotluk sayısal gecikme fiziksel modele bağlanmıştır. İlk koşuda faz akımları
2,225-2,230 A RMS, izleme RMSE değerleri 0,241-0,243 A ve THD değerleri
%10,75-%11,04 aralığında bulunmuştur. Her fazdaki geçersiz kapı durumu sayısı
sıfırdır. Nötr RMS akımı 0,639 A'dır; sonraki aşamada nötr susturma ve
Sin³ kompanzasyonunun azaltması gereken temel değeri oluşturur. Parametreler
hâlâ geçicidir ve sonuçlar tez bulgusu olarak kullanılmamalıdır.

## Fiziksel nötr susturma ve Sin³ taraması

Klasik, nötr susturma ve nötr susturma+Sin³ durumları aynı 2,3 A RMS
referansında karşılaştırılmıştır. -6 ile 0 V arasındaki 1 V adımlı ince
taramada en düşük susturmalı nötr RMS değeri Ksin3=-2 V noktasında elde
edilmiştir:

- Klasik: 0,6386 A nötr RMS, %10,898 ortalama faz THD
- Nötr susturma: 0,7113 A nötr RMS, %13,625 ortalama faz THD
- Nötr susturma + Sin³ (-2 V): 0,6938 A nötr RMS, %13,772 ortalama faz THD

Sin³, yalnız susturma durumuna göre nötr RMS'i yaklaşık %2,46 azaltmış; ancak
klasik yöntemin altına inememiş ve THD'yi iyileştirmemiştir. Mevcut sonuç olumlu
tez kanıtı değildir. Enjeksiyon noktası, Sin³ ölçeklemesi ve nötr susturma
mantığı gerçek devre/kod bilgisiyle yeniden tasarlanmalıdır.

## Fiziksel güç seviyesi taraması

Gerçek anma gücü henüz kaynak dosyalardan doğrulanmadığı için 0,75 A,
1,50 A ve 2,30 A RMS akım referansları sırasıyla düşük, orta ve
`Anma_DENEME` olarak koşturulmuştur. 120 V faz gerilimi varsayımıyla karşılıkları
yaklaşık 270 W, 540 W ve 828 W'tır.

Düşük güçte klasik yöntem %22,62 THD ve 0,295 A nötr RMS verirken mevcut
nötr susturma %52,30 THD ve 1,211 A nötr RMS vermiştir. -2 V Sin³ eklenmesi
düşük ve orta güçte iyileşme sağlamamıştır. Kapı durumu ihlali bütün dokuz
koşuda sıfırdır. Tarama, mevcut susturma/kompanzasyon biçiminin özellikle düşük
güçte yeniden tasarlanması gerektiğini göstermektedir; olumlu tez sonucu olarak
kullanılmamalıdır.

## Ölçülen 150 Hz nötr akımı geri beslemesi

Sin³ ileri beslemesine ek bir araştırma kolu olarak ölçülen nötr akımının
150 Hz bileşenini ayıran kapalı çevrim sıfır-dizi denetleyicisi kurulmuştur.
Denetleyici çıkışı sınırlı ortak-mod gerilim olarak üç faz komutuna aynı
anda eklenmektedir. 12-30 V/A ince taramasında en düşük nötr RMS değeri
22 V/A noktasında bulunmuştur:

- Klasik: 0,6386 A nötr RMS, %10,896 ortalama THD
- Nötr susturma: 0,7113 A nötr RMS, %13,630 ortalama THD
- 150 Hz geri besleme: 0,1415 A nötr RMS, %12,561 ortalama THD

Geri besleme, klasik duruma göre nötr RMS'i yaklaşık %77,8 ve yalnız susturma
durumuna göre yaklaşık %80,1 azaltmıştır. En büyük ortak-mod denetleyici
çıkışı 2,03 V, geçersiz kapı durumu sayısı sıfırdır. THD klasik
yöntemin altına inmediği ve bütün parametreler geçici olduğu için sonuç henüz
tez kanıtı değildir. Gerçek kod ve veriler geldiğinde yapı birebir karşılaştırılacaktır.

## 2026-08-22 deney kampanyası

Sonradan gelen R2023b Senaryo 1 modeli R2025b'de kaldırılan Specialized Power
Systems blokları nedeniyle değişmeden koşturulamamıştır. Dönüşüm adayı 29.9048
ms'de diyot denklemlerinin yakınsamamasıyla durmuştur. Üç yöntem geçici fiziksel
modelde yeniden koşturulmuş; Sin3 kolu nötr RMS'i yalnız susturmaya göre %2,46
azaltmış fakat THD'yi iyileştirmemiştir. Ayrı Senaryo 4 ortalama modelinde 30 A
tepe ve 30 A RMS yorumları PI ile doyumsuz izlenmiştir. Bütün komut, ölçüt,
kanıt seviyesi ve sınırlılıklar `results/campaign_20260822/README.md` içinde
toplanmıştır.

## 2026-08-26 L2 aday değerlendirmesi

`200/400/600 µH` değerleri kaynak ve devre rolü bakımından ayrıştırılmıştır.
Tam topolojideki `L1/L2/L3=600 µH` etiketleri A/B/C faz bobinleridir;
LCL filtrenin iki ardışık bobinini göstermez. En yeni parametre notu ve Excel
gerçek uygulama Senaryo 1-2 satırları `L2=200 µH` değerini bağımsız biçimde
tekrarladığı için nihai filtre seti `L1=600 µH`, `Cf=8 µF`, `L2=200 µH`
olarak seçilmiştir. Kaynak `.slx` içindeki `CL1=400 µH` eski model ayarı olarak
korunmuştur.

İdeal duyarlılık hesabında 200/400/600 µH için rezonans frekansları sırasıyla
4,594/3,632/3,249 kHz bulunmuştur. Seçilen 200 µH değeri 10 kHz anahtarlamada
`fs/2` sınırına yaklaşık 406 Hz uzaktadır; gerçek sönüm, gecikme ve akım
denetleyicisiyle kararlılık doğrulaması hâlâ gereklidir. Betik ve sonuçlar:

- `scripts/evaluate_l2_candidates_20260826.m`
- `parameters/validated_filter_parameters_20260826.m`
- `results/l2_candidate_evaluation_20260826/`

## 2026-08-26 R2025b Senaryo 1 doğrulaması

Kaynak model korunarak ayrı R2025b çalışma kopyalarında nihai
L1=600 uH, Cf=8 uF, L2=200 uH seti uygulanmıştır. Dış S1-S2
anahtarları SKM100GB12T4, iç S3-S4 anahtarları IXYN100N65C3H1 ve yalnız
harici D1-D2 diyotları DSEI2x61-12B olarak eşlenmiştir.

Tam cihaz dinamikli 1 ms sağlık kontrolü başarıyla tamamlanmıştır.
Aynı ayrıntıda 5 ms koşu 1200 saniyede tamamlanmadığı için hesap
maliyeti sınırıyla durdurulmuştur. Cihaz dinamikleri sadeleştirilen 25 ms
sistem koşusu 21,332415 ms'de diyot yakınsama hatası vermiştir. Başlangıçta
ideal kaynak ile boş DA-link kapasitörleri arasında 43,1 kA tepe oluştuğundan
mevcut koşulardan verim veya THD sonucu kabul edilmemiştir.

Ayrıntılı karar, koşu kimlikleri ve kalan işler:

- review/2026-08-26_R2025B_SENARYO1_DOGRULAMA.md
- results/scenario1_r2025b_validation/selected_validated_devices_raw_1ms/
- results/scenario1_r2025b_validation/selected_filter_systemlevel_raw_25ms/
