# R2025b Senaryo 1 doğrulama kaydı

Tarih: 26.08.2026

## Karar

- Nihai faz-başına filtre seti: L1=600 uH, Cf=8 uF, L2=200 uH.
- Dış anahtarlar S1-S2: SKM100GB12T4.
- İç/nötr anahtarlar S3-S4: IXYN100N65C3H1.
- Harici diyotlar D1-D2: DSEI2x61-12B; modelde Diode6 ve Diode7.
- DSEI parametreleri IGBT'lerin iç veya ters paralel diyotlarına uygulanmayacak.
- 200 uH kaynak ve devre rolü bakımından doğru seçimdir; mevcut R2025b dönüşümünün kararlı durum yakınsaması ise ayrı ve henüz kapanmamış bir sorundur.

## Kademeli koşular

| Koşu | Yapı | Sonuç | Kanıt düzeyi |
|---|---|---|---|
| selected_filter_raw_5ms_original_solver | 600/8/200, sade cihazlar | Tamamlandı; son %20 pencerede AC akım RMS 2,4281 A | Kısa süreli fiziksel tutarlılık |
| selected_validated_devices_raw_1ms | 600/8/200 + SKM/IXYN/DSEI | 26,687 s'de tamamlandı | Blok ve cihaz modeli sağlık kontrolü |
| selected_validated_devices_raw_5ms | Aynı ayrıntılı cihaz katmanı | 1200 s'de tamamlanmadı; kontrollü sonlandırıldı | Hesap maliyeti sınırı |
| selected_filter_systemlevel_raw_25ms | 600/8/200, sade cihazlar | 21,332415 ms'de diyot yakınsama hatası | Kararlı hâl/THD/verim geçersiz |

## Kritik gözlem

Tam cihaz dinamikli 1 ms koşuda DA bara 431,5 V olarak korunmuş, ancak ideal gerilim kaynağının başlangıçta boş DA-link kapasitörlerini şarj etmesi 43.148 A tepe akım oluşturmuştur. Bu nedenle ilk 1 ms'deki ekran gücü, THD ve verim değerleri performans sonucu değildir.

25 ms koşuda yakınsamayan bloklar Diode1, Diode3, Diode5, Diode7 ve Diode9 olmuştur. Sorun 21,332415 ms'de tutarlı durum/mod çözümü sırasında oluşmuştur.

## Tezde kullanım

- Excel'deki Senaryo 1 için %92,5 verim ve yaklaşık %15 THD, yeniden üretilmiş MATLAB sonucu değil, gelen gerçek uygulama/deney özeti olarak korunur.
- 1 ms koşu yalnız doğru cihaz eşlemesinin R2025b'de çözülebildiğini kanıtlar.
- 5 ms sade koşu yalnız 200 uH seçiminin kısa süreli fiziksel olarak uygulanabilir olduğunu gösterir.
- Geçerli THD/verim için başlangıç darbesi giderilmeli ve en az iki kararlı 50 Hz periyodu aynı ölçüm penceresiyle tamamlanmalıdır.

## Kalan teknik iş

1. İdeal DA kaynağı yerine fiziksel kaynak empedansı ve/veya ön şarj yapısı kurmak.
2. Diyot komütasyonunda veri sayfasına uygun parasitik/sönüm yollarını ve başlangıç durumlarını belirlemek.
3. Çözücü toleransı ve tutarlı başlangıç ayarlarını devre fiziğini değiştirmeden doğrulamak.
4. Senaryo 1'i en az 40 ms kararlı pencereyle koşturup DA/AA güç, verim ve THD'yi ham sinyallerden yeniden hesaplamak.
5. Senaryo 2-4 için gerçek PWM/kontrol kodunu aynı model tabanına eklemek.
