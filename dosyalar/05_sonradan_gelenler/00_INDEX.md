# 05 Sonradan Gelenler — Dosya İndeksi

İnceleme tarihi: 13 Temmuz 2026

## Birincil teknik kanıtlar

- `Senaryo_1/`: klasik anahtarlama ile uyumlu dalga şekilleri ve THD ekranları.
- `Senaryo_2/`: nötr anahtar susturma ile uyumlu dalga şekilleri ve yüksek üçüncü harmonik/THD ekranları.
- `Senaryo_3/`: nötr susturma + Sin³ kompanzasyonu ile uyumlu dalga şekilleri ve THD ekranları.
- `Desarjv30parametre_deadtime_olmayan.m`: 400 V, 230 V RMS, 50 Hz, 10 kHz ve `1e-7 s` benzetim adımı içeren aday parametre dosyası. Dosya adı ölü zaman içermeyen modeli belirtmektedir.
- `ümit tez ana kaynak.pdf`: düşük güç anahtarlama mekanizması, Sin³ ileri besleme fikri ve eski 30 kW sistem anlatımı.

## Sistem hedefi ve mimari kaynağı

- `1001_basvuru_formu_versiyon_9.docx`: 100 kW hedef, 1000 V DA bara kontrol referansı, 34,5/0,69 kV bağlantı ve fazlar arası AB/BC/CA konteyner mimarisi. Dosya deney sonucu değil, proje hedefi ve tasarım kaynağıdır.

## Destekleyici kaynaklar

- `3-Phase-30-kW-Vienna-PFC-Reference-Design-DS50002952.pdf`: Microchip Vienna PFC referansı; 30 kW, 400 V hatlar arası, 700 V DA ve 140 kHz. Tezin kendi donanımı olarak kullanılamaz.
- `Ek-A - Doğrultucu ve Evirici Devre Topolojileri.docx`: literatür ve topoloji şekil kataloğu.
- `Ek-D - Batarya ve Şarj Yönetim Sistemleri.docx`: BYS dengeleme yöntemleri, akış şemaları ve karşılaştırma tablosu.

## Kapsam dışı

- `Rev6_2_Goksin_Sonmez_23500405019 Düzenlenen Son Revize.docx`: fotovoltaik hücrelerde kusur tespiti ve derin öğrenme tezi; enerji depolama/T-tipi tezinin kapsamına ait değildir.

## Arşiv durumu

`Senaryo_1.rar`, `Senaryo_2.rar` ve `Senaryo_3.rar` korunmuştur. İçerikleri aynı adlı klasörlere çıkarılmıştır. Her arşivde JPG ve EMF biçiminde altı dosya bulunmaktadır.
