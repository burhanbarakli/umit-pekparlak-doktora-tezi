# Gerçek veri ve kod karşılaştırma alanı

Yarın gelecek dosyalar mevcut `DENEME` modellerinden ayrı tutulacaktır.

## Dosyaların yerleştirilmesi

- `code/`: DSP/MCU/FPGA kaynak kodu, PWM ve kesme fonksiyonları
- `measurements/`: osiloskop CSV/MAT kayıtları, akım-gerilim dalga şekilleri
- `parameters/`: L1, L2, Cf, Rd, DA bara, anahtarlama frekansı, ölü zaman ve anma gücü
- `schematics/`: güç katı, sürücü ve sensör şemaları

## Birebir kontrol edilecek noktalar

1. Q1-Q4 kapı durumları ile P/O/N tablosu
2. Nötr susturma koşulu ve hangi anahtarın hangi aralıkta kapatıldığı
3. Sin³ denklemi, işareti, katsayısı, birimi ve enjeksiyon noktası
4. PWM frekansı, sayaç tipi, ölü zaman ve hesaplama/ADC gecikmesi
5. LCL elemanları ve sensörlerin devredeki gerçek yerleri
6. Düşük, orta ve anma gücü tanımları
7. Deneyde kullanılan THD penceresi, harmonik sayısı ve RMS hesabı
8. Klasik, susturma, Sin³ ve 150 Hz geri besleme yöntemlerinin aynı koşulda koşturulması

## Mevcut geçici referans

- Model: `models/t_type_three_phase_zero_sequence_feedback.slx`
- Geçici kazanç: `Kzero3_cl = 22 V/A`
- Nötr RMS: `0.14152 A`
- Ortalama faz THD: `%12.561`
- En büyük ortak-mod gerilim: `2.032 V`
- Geçersiz kapı durumu: `0`

Değerler yalnızca yarınki karşılaştırma için başlangıç noktasıdır ve
tez bulgusu değildir.

## 2026-08-22 tarihinde gelen yeni girdiler

- `schematics/tam_topoloji_2026-08-22.pdf`: Proteus'tan alınan tam topoloji
  şemasının hash değeri doğrulanmış, değiştirilmemiş arşiv kopyası
- `schematics/tam_topoloji_2026-08-22_rendered.png`: görsel inceleme için
  üretilmiş tam çözünürlüklü sayfa görseli
- `parameters/2026-08-22_umit_senaryo_parametreleri.md`: e-postayla gelen ortak
  eleman parametreleri, dört senaryo, bildirilen sonuçlar, PDF gözlemleri ve
  açık doğrulama soruları
- `../parameters/pending_2026_08_22_umit_parameters.m`: etkin deneylerden ayrı,
  ad alanı çakışması yaratmayan bekleyen MATLAB parametre yapısı

Bu girdiler henüz etkin model parametrelerinin üzerine yazılmamıştır.

### Aynı tarihte gelen Drive paketi

- `models/Inverter2_senaryo1_2026-08-16.slx`: Senaryo 1 için gelen R2023b
  Simscape modeli
- `measurements/degerler_senaryo_ozeti_2026-08-17.xlsx`: Senaryo 1-3 gerçek
  uygulama ve simülasyon özet tablosu; ham zaman serisi değildir
- `parameters/simulasyon_duzeltmeleri_2026-08-16.docx`: kayıp modelleme,
  thermal port, sıcaklık ve yarı iletken parametre yönergeleri
- `datasheets/`: DSEI2x61-12B, IXYN100N65C3H1 ve SKM100GB12T4 veri
  sayfaları
- `parameters/screenshots/`: Simscape blok parametre ekranları
- `../review/2026-08-22_SENARYO_KAYNAK_ILISKI_MATRISI.md`: Excel, model,
  veri sayfaları, ekranlar ve dört senaryo arasındaki ayrıntılı eşleme

Arşiv dosyaları kaynaklarla SHA-256 düzeyinde birebir aynıdır.

## 2026-10-27 tarihinde alınan girdiler (06.10 ve 12.10 teslimleri)

Ham kaynak: `dosyalar/06_UMIT_ABIDEN_GELENLER/` (tarih sıralı e-posta + Drive
arşivi; ayrıntılı dizin `00_INDEX.md`). Buradaki kopyalar kaynaklarla SHA-256
düzeyinde birebir aynıdır.

- `models/2026-10-12_dort_senaryo_paketi/`: Senaryo 1+2
  (`inverter_scenario1_parametric5_etiquetli.slx`), Senaryo 3 ve Senaryo 4
  modelleri + güncel `inverter_common_parameters.m` (12.10). Modellerin
  `InitFcn`'i parametre dosyasını **aynı klasörden** çalıştırır; dosyalar
  birlikte taşınmalı ve özgün adları korunmalıdır. R2023b ile kaydedilmiştir;
  Specialized Power Systems ölçüm blokları içerir (R2025b uyumluluğu
  doğrulanmadı).
- `parameters/inverter_common_parameters_2026-10-06.m`: parametre dosyasının ilk
  sürümü (L2=500 µH, L2r=0,10 Ω, S3/S4 katsayıları boş).
- `parameters/tezdeki_duzeltmeler_2026-10-06.docx`: kalibrasyon yaklaşımı,
  IGBT eşdeğer parça seçimi, güç ölçümü yerleşme tablosu, senaryo hedefleri.
- `parameters/SKM100GB12T4_dusuk_akim_parametre_uygunlastirma_2026-10-06.docx`:
  SEMIKRON AN 1403 yöntemiyle 2–3 A bölgesi iletim/anahtarlama enerjisi.
- `parameters/L1_enduktor_kayiplari_literatur_ozeti_2026-10-06.docx`: düşük
  güçte L1 çekirdek/AC sargı kaybı modeli ve kaynakları.
- `schematics/tam_topoloji_2026-08-17.jpg`: tam topolojinin raster sürümü.
- `measurements/gercek_uygulama_ozeti_eposta_2026-07-18.csv`: 18.07 e-postasındaki
  gerçek uygulama tablosu (THD ve cosφ işareti xlsx ile çelişiyor; bkz.
  arşiv dizinindeki "Açık sorular").

Bu girdiler henüz koşturulmadı ve tez metnine işlenmedi; ilk koşu sonucu
`../review/` altına tarihli notla düşülecektir.
