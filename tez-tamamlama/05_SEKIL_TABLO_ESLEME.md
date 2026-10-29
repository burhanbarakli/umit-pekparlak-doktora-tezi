# İlk tez ↔ yeni tez şekil ve tablo eşlemesi (29.10.2026)

- **İlk tez:** `dosyalar/01_TAM_TEZ/tez_tumu_8.docx`. 107 şekil ve 16 tablo içerir.
- **Yeni tez:** `tez-latex-v2/`, `e2fd45e` sürümü. 87 şekil ve 43 tablo içerir.
  - **29.10.2026 güncellemesi:** Ş 4.24 ve Ş 3.13 geri eklendi; yeni tezde şekil sayısı 89 oldu.
  - Bölüm 4 ve 5'te şekil numaraları birer kaydı: eski 4.1 → 4.2, eski 5.1 → 5.2 vb.
  - Aşağıdaki B ve C numaraları `e2fd45e` sürümüne göredir.
  - İlk tezden içeriğiyle birlikte çıkan şekil sayısı 14'ten 12'ye indi.
- **Kapsam dışı:** ekler. İlk tezde de EK-A, EK-B ve EK-C vardır; yeni tezde aynı belgeler 21 sayfa olarak yer alır.

**Eşleme yöntemi**

1. İlk tezin her şekil başlığı, docx içindeki görsel dosyasıyla eşlendi (`word/media/imageNN`).
2. Yeni tezin görselleri kaynakla karşılaştırıldı. Bayt düzeyinde aynı olanlar (MD5) ve 32×32 gri ölçek benzerliğiyle aynı olanlar eşlendi. Senaryo ekranları ilk tezde EMF, yeni tezde JPG'dir; benzerlik farkı 0,4–1,9/255 olduğundan aynı görsel sayıldı.
3. Görseli farklı olan şekiller başlık ve içerik üzerinden elle eşlendi.

Betik (geçici oturum klasörü): `C:\Users\burha\AppData\Local\Temp\claude\C--CODES--mit-abi\0fce3b75-0fd4-4af6-aca5-dde06b9a5cd1\scratchpad\sekil_esle\cikar.py`.

---

## A. İlk tezde olup yeni tezde OLMAYANLAR

### A.1 Şekiller (14)

| İlk tez | Başlık | Neden çıktı / yerini ne aldı |
|---|---|---|
| Ş 1.4 | EDS bileşenlerinin maliyet payları | Aynı veri Tablo 2.1'de; şekil ayrıca verilmedi |
| Ş 1.10 | Hücre dengesizliğinin batarya ömrüne etkisi (senaryo analizi) | Tez katkısıyla ilgisiz; literatür kısaltması (İP-12) |
| Ş 3.13 | Düşük anahtarlama oranında harmonik bileşenlerin akım dalga şekline etkisi | **29.10.2026: geri eklendi** → yeni Şekil 5.1 (`fig:harmonik-mekanizma`), kalibre S2 parametreleriyle MATLAB'da yeniden üretildi |
| Ş 3.14 | 3. harmonikli akımda referans, oluşan akım ve kontrolör çıkışı | Yerini Bölüm 5 mekanizma ve S4 izleme şekilleri aldı |
| Ş 3.15 | Anahtarlama düzeninin teorik işleyişi | Tablo 3.2 ve Tablo 4.1 ile verildi |
| Ş 3.16 | Düşük akımda kontrolör cevabına göre anahtarlama durumları | Tablo 4.2 (modelden okunan kapı mantığı) ile verildi |
| Ş 4.18 | Feedforward bileşeninin etkisi | Şematikti; yerini Şekil 3.7 blok yapısı aldı |
| Ş 4.20 | Tam güçte feedforward ve kontrolör etkileri | Yerini S4 kapalı çevrim şekilleri (Şekil 5.7–5.9) aldı |
| Ş 4.21 | 2,7 A'da feedforward ve kontrolör etkileri | Aynı neden |
| Ş 4.22 | Düşük güçlerde doğrusal olmayan sistem | Metinle verildi (Kesim 5.2–5.3) |
| Ş 4.24 | Susturma sonrası T-tipinin iki buck eviriciye dönüşmesi | **29.10.2026: geri eklendi** → yeni Şekil 4.1 (`fig:susturma-esdeger`), TikZ |
| Ş 4.25 | dmax'a göre L1 akımları | Ayrı şekil gerekmedi: dalga biçiminin $d_m$'den bağımsızlığı Tablo 5.1'de, mekanizma Şekil 5.1'de |
| Ş 4.26 | sin ve sin+sin³ görev oranlarında L1 akımı | Kaynak katsayı yanlış özdeşlikle türetilmişti; yerini Şekil 5.1 aldı |
| Ş 4.27 | d = Vm·sin için farklı dmax değerlerinde harmonik içeriği | Tablo 5.1 ile birleşti |

Numarası kalkan ama içeriği birleştirilerek ya da yeniden çizilerek yeni tezde bulunan şekiller (örneğin Ş 1.6–1.9, Ş 3.2–3.8) C bölümündedir. İlk tezin 107 şeklinden 93'ü yeni tezde bir karşılığa sahiptir.

### A.2 Tablolar (2)

| İlk tez | Başlık | Neden çıktı / yerini ne aldı |
|---|---|---|
| T 4.2 | Farklı dmax değerlerinde harmonik oranlarının değişmezliği | Bulgu Tablo 5.1 ve metinde tek cümle |
| T 4.3 | V1m ve V3m katsayılarının kombinasyonları | Yanlış sin³ özdeşliğiyle hesaplanmıştı. Yerini doğru özdeşlikle yapılan tarama aldı: Şekil 5.1 ve Kesim 5.4 aday çiftleri (D-xx / K-xx kaydı) |

---

## B. Yeni tezde olup ilk tezde OLMAYANLAR

### B.1 Şekiller (yeni içerik, 20)

| Yeni tez | İçerik | Üretim |
|---|---|---|
| Ş 1.1 | Tezin problem–yöntem–katkı akışı | TikZ |
| Ş 3.1 | Genel sistem mimarisi (güç ve geri besleme yolu, Sin³ konumu) | TikZ |
| Ş 3.2 | Üç fazlı tam güç topolojisi (giriş/EMI, üç faz hücresi, algılama) | Ümit'in 22.08 teslimi |
| Ş 3.6 | Faz başına LCL filtre, durum değişkenleri, ölçüm noktaları | TikZ |
| Ş 4.5 | Kalibre benzetimde S1/S2 son şebeke periyodu dalga şekilleri | MATLAB (kalibre model) |
| Ş 5.7 | S4: 25 A'da P/PI/PIR akım izleme | MATLAB (S4 modeli) |
| Ş 5.8 | S4: verim, THD ve genlik hatası taraması | MATLAB |
| Ş 5.9 | S4: PI ile 10→25 A basamak yanıtı | MATLAB |
| Ş 5.10 | Kararlılık: açık çevrim L(jω) Bode, K34 açık/kapalı | MATLAB |
| Ş 5.11 | Kararlılık: S ve T duyarlılık eğrileri | MATLAB |
| Ş 5.12 | Kararlılık: Nyquist (analog ve sayısal gerçekleme) | MATLAB |
| Ş 5.13 | Kararlılık: ek şebeke endüktansı Lg taraması | MATLAB |
| Ş 5.14 | Kararlılık: analitik L(jω) ile anahtarlamalı modelde ölçüm | MATLAB |
| Ş 5.15 | Kararlılık: basamakta K34 açık/kapalı geçici yanıt | MATLAB |
| Ş 6.25 | Deney düzeneğinde güç, ölçüm ve veri toplama akışı | TikZ |
| Ş 7.7 | Proje başvurusundaki değiştirilmiş T-tipi PFC güç katı | Proje başvuru belgesi |
| Ş 7.8 | AB–BC–CA konteyner şarj/deşarj mimarisi | Proje başvuru belgesi |
| Ş 7.9 | GT-tipi enerji ve denetim katmanları sentezi | TikZ |
| Ş 7.18 | IGBT PFC denetimi ve iki görev oranı tetiklemesi | Proje başvuru belgesi |
| Ş 7.19 | GT-tipi güvenli durum geçişleri (durum makinesi) | TikZ |

Kararlılık ve S4 kanıtının tamamı (Ş 5.7–5.15) ilk tezde yoktur. İlk tezde "Bode" sözcüğü hiç geçmez.

### B.2 Tablolar (yeni içerik, 30)

| Yeni tez | İçerik |
|---|---|
| T 1.1 | Özgün katkılar: başlık karşılığı, yöntem, bulgu, kanıt |
| T 2.7 | Literatürün karşılaştırmalı sentezi (19 satır, AS sütunu) |
| T 3.1 | Model ve doğrulama katmanları |
| T 3.2 | T-tipi ideal anahtarlama durumları ve kapı komutları |
| T 3.3 | Birleşik parametre tablosu (75 satır) |
| T 3.4 | Yarı iletken eşlemesi (rol, bağlantı, model bloğu) |
| T 3.5 | Karşılaştırmalı doğrulama matrisi |
| T 3.6 | Model düzeltme özeti (D-01…D-14) |
| T 3.7 | Köprü Thevenin iç empedansı |
| T 4.1 | Klasik ve önerilen anahtarlamanın işlevsel karşılaştırması |
| T 4.2 | Modelden okunan kapı mantığı (S1, S2, S3) |
| T 4.3 | Senaryo ekranlarından temel bileşen ve THD (kalibre edilmemiş) |
| T 5.2 | S4 düşük/orta/anma akımı taraması |
| T 5.3 | S4 basamak yanıtı |
| T 5.4 | Kararlılık marjları |
| T 5.5 | Lg duyarlılığı |
| T 5.6 | L(jω) analitik ↔ ölçülen |
| T 5.7 | K34 açık/kapalı geçici yanıt |
| T 6.5 | Ölçüm cihazları ve doğrulama sınırları |
| T 6.6 | Üç yöntemin çalışma koşulları |
| T 6.7 | Deney özeti ↔ PC ekranı anlık değerleri |
| T 6.8 | Güç bölgelerine göre kanıt düzeyi |
| T 6.9 | Deney özetinden yeniden hesaplanan verim |
| T 6.10 | Deney özeti ↔ kalibre benzetim (V_dc ve kayıp satırlarıyla) |
| T 7.1 | GT-tipi tasarım gereksinimleri ve kanıt durumu |
| T 7.2 | GT-tipi çalışma modları ve geçiş koşulları |
| T 7.3 | GT-tipi koruma işlevleri ve doğrulama |
| T 7.4 | GT-tipi ↔ klasik ve literatürdeki mimariler |
| T 7.5 | GT-tipi doğrulama matrisi |
| T 8.1 | Araştırma sorusu–kanıt–sonuç matrisi |

---

## C. İki tezde de olanlar (taşınan, birleştirilen veya yeniden üretilen)

| İlk tez | Yeni tez | Durum |
|---|---|---|
| Ş 1.1 | Ş 2.1 | TikZ ile yeniden çizildi |
| Ş 1.2 + 1.3 | Ş 2.2 (a, b) | MATLAB ile vektörel yeniden üretildi |
| Ş 1.5 | Ş 2.3 | TikZ ile yeniden çizildi |
| Ş 1.6–1.9 | Ş 2.4 | Dört şekil tek bileşik şekilde |
| Ş 2.1–2.5 | Ş 2.6 (4 panel) | MATLAB ile yeniden üretildi, birleştirildi |
| Ş 2.6, 2.7, 2.9, 2.10 | Ş 2.7 | MATLAB ile yeniden üretildi, birleştirildi |
| Ş 2.8 | Ş 2.8 | Tablo 2.6 kaydından MATLAB çizimi |
| Ş 3.1 (= Ş 6.1, aynı görsel) | Ş 2.5 ve Ş 3.4(a) | İlk tezde iki kez basılmıştı; yeni tezde bir kez. Ayrıca TikZ sürümü var |
| Ş 3.2–3.4 | Ş 3.3 (a–c) | TikZ alt şekiller |
| Ş 3.5–3.8 | Ş 3.4 (b–e) | TikZ alt şekiller |
| Ş 3.9–3.10 | Ş 3.5 (a, b) | TikZ alt şekiller |
| Ş 3.11–3.12 | Ş 2.9 | DE/CCM endüktör akımı, TikZ |
| Ş 4.1–4.2 | Ş 4.2 | Klasik kapı komutları; kalibre modelden yeniden üretildi |
| Ş 4.3–4.4 | Ş 4.3 | Simülasyon yapısı ekranı yerine modelin vektör çizimi |
| Ş 4.5–4.6 | Ş 4.4 (a, b) | Klasik L1 akımı; kalibre modelden |
| Ş 4.7–4.9 | Ş 4.6–4.8 | Aynı S1 senaryo ekranları (kalibre edilmemiş) |
| Ş 4.10–4.11 | Ş 4.1 | Susturma kapı komutları; modelden |
| Ş 4.12–4.13 | Ş 4.4 (c, d) | Susturma L1 akımı; kalibre modelden |
| Ş 4.14–4.16 | Ş 4.9–4.11 | Aynı S2 senaryo ekranları |
| Ş 4.17 + 4.23 | Ş 3.7 | Klasik ve önerilen blok diyagram tek TikZ şekilde |
| Ş 4.19 | Ş 5.2 | Eşpotansiyel durum, TikZ |
| Ş 4.28 | Ş 5.1 | V1m–V3m taraması doğru özdeşlikle yeniden yapıldı |
| Ş 4.29 | Ş 5.3 | S3 L1 akımı; kalibre modelden |
| Ş 4.30–4.32 | Ş 5.4–5.6 | Aynı S3 senaryo ekranları |
| Ş 5.1–5.24 | Ş 6.1–6.24 | Deney fotoğrafları ve ekranları; bire bir, aynı sıra |
| Ş 6.2–6.15 | Ş 7.1–7.6, 7.10–7.17 | GT-tipi şemalar ve şarj benzetimi; bire bir |
| T 1.1 | T 2.1 | Kaynakla güncellendi |
| T 1.2 | T 2.3 | Nitel karşılaştırma olarak yeniden kuruldu |
| T 1.3 | T 2.2 | Taşındı |
| T 2.1 | T 2.4 | 144 noktalı temsilî profilden yeniden hesaplandı |
| T 2.2 + 2.3 | T 2.5 | Avrupa ve CEC katsayıları tek tabloda |
| T 2.4 | T 2.6 | Taşındı; motivasyon kaydı olarak işaretlendi |
| T 4.1 | T 5.1 | Parçalı DCM/CCM modeliyle yeniden hesaplandı |
| T 4.4 | T 4.4 | Taşındı; verim tanımı belgesiz, bulgu olarak kullanılmıyor |
| T 5.1–5.3 | T 6.1–6.3 | Taşındı |
| T 5.4 | T 6.4 + T 6.10 | Deney özeti ayrı; benzetim yerine kalibre benzetim karşılaştırması |
| T 7.1 | T 8.2 | Patent bülteni verileriyle yeniden kuruldu |
