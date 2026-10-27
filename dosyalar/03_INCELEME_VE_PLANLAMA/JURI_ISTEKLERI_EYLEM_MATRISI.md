# Jüri istekleri eylem matrisi

Kaynak: `jüri istekleri/Pekparlak_tez_önerileri.pdf`

| No | Jüri isteği | Mevcut durum | Yapılacak iş | Kabul kanıtı |
|---:|---|---|---|---|
| 1 | Başlık daha anlaşılır ve içeriği yansıtır olmalı | Uygun değil | "ileri beslemeli kontrol stratejisi" ifadesini kaldır; T-tipi mimariyi ve Sin³ kompanzasyonunun ikincil rolünü doğru kur | Danışman onaylı TR/EN başlık |
| 2 | Akış genelden özele kurulmalı | Karşılanmıyor | Literatür -> sistem/model -> analiz -> yöntem -> simülasyon -> deney -> sonuç zincirine geç | Yeni içindekiler ve bölüm geçişleri |
| 3 | T-tipi topoloji katkısı FF gölgesinde kalmamalı | Kısmi | Girişte üç katkıyı ilan et; T-tipi anahtarlama ve GT-tipi mimariyi ana eksen yap | Katkı-tablosu ve yeniden sıralanmış bölümler |
| 4 | Genel ve gerektiğinde bölümsel blok diyagramlar | Kısmi; 9 "blok diyagram" anımı var | Tek bir genel enerji/güç/sinyal akış diyagramı; topoloji, kontrol ve test düzeni için alt diyagramlar | SVG/PDF vektör şekiller ve metin içi açıklama |
| 5 | Düşük çözünürlüklü şekiller yenilenmeli | Karşılanmıyor | 129 görseli kaynak/tür/çözünürlük açısından denetle; MATLAB grafiklerini beyaz zemin ve okunur puntoyla yeniden dışa aktar | 100% yakınlaştırmada okunur nihai PDF |
| 6 | T-tipi çalışma modları anlaşılır olmalı | Kısmi | Her mod için aynı devre tabanında renkli akım yolu, aktif/pasif anahtar ve yön oku kullan | Tutarlı renk lejantlı mod şekilleri |
| 7 | Sin³ FF için kapalı çevrim ve Bode analizi | Yok | İdeal türetim + gerçek model varsayımları + `L,S,T` Bode + kazanç/faz marjı + çalışma noktası analizi | Tekrarlanabilir model/kod ve karşılaştırmalı grafikler |
| 8 | Nominal güçte kapalı çevrim çalışma | Yetersiz | Düşük, orta ve nominal güçte aynı kontrol yapısıyla karşılaştırma | Akım izleme, THD, verim, doyum ve geçici rejim tablosu |
| 9 | Elektriksel parametreler tek tabloda verilmeli | Yok | Şebeke, nominal güç, DA bara, anahtarlama/örnekleme, LCL, denetleyici ve sınırları tek tabloda topla | Birimli ve kaynak/hesap yöntemli sistem tablosu |
| 10 | Son kısımda deneysel testler | Kısmi ve riskli | Mevcut Bölüm 5 verilerini ham kayıt ve test protokolüyle denetle; eksik deney yapılamıyorsa iddia kapsamını danışmanla sınırla | Ham veri -> işleme -> şekil zinciri veya açık sınırlılık beyanı |
| 11 | Akademik temel ve doktora tezi örnekleri | Kısmi | Literatürü kaynak özetlerinden senteze çevir; her bölümde iddia-kanıt-kısıt yapısı kur | Kaynaklara dayalı karşılaştırma ve açık araştırma boşluğu |

## Kritik bağımlılıklar

- Başlık, yeni içindekiler ve katkı hiyerarşisi birlikte kararlaştırılmalıdır.
- Stabilite modeli kurulmadan Bode grafiği üretmek yeterli değildir; model varsayımları ve çalışma noktaları kilitlenmelidir.
- Nominal güç testi, deneysel veri durumu ve tez iddiaları birbirinden bağımsız ele alınamaz.
- Şekiller yeniden üretilmeden önce yeni bölüm yapısı kesinleştirilmelidir; aksi halde numaralandırma tekrar bozulur.

