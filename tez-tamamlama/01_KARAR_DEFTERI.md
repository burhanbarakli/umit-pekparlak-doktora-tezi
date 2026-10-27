# Karar defteri — Ümit'e sormadan kapatılan açık noktalar

Kural (27.10.2026, proje sahibi kararı): tez **Ümit'e yeni soru sorulmadan**
tamamlanacak. Ümit'ten gelen dosyalarda yanıtı olmayan her açık nokta burada bir
karara bağlanır. Her karar şu dört öğeyi içerir: dayanak, seçilen değer, tezde nasıl
ifade edileceği, hangi durumda yeniden açılacağı. Yeni karar eklendiğinde `K-xx`
numarası artar. Eski karar silinmez, "yerini aldı: K-yy" diye işaretlenir.

## Genel ilkeler

- **İ1 — Kaynak önceliği.** Ümit kaynakları arasında çelişki varsa en yeni tarihli
  makine okunur kaynak kazanır. Sıra şöyledir:
  1. 12.10 `inverter_common_parameters.m`
  2. 06.10 paketi
  3. 17.08 `değerler.xlsx`
  4. 18.07 e-posta metni

  Kaybeden değer yalnız karar defterinde kalır, tezde kullanılmaz.
- **İ2 — Model koddur.** Gerçek PWM/denetim kaynak kodu gelmeyecek. Ümit'in
  Simulink modelleri uygulamanın tek yürütülebilir tanımı kabul edilir. "Gerçek
  kodu istiyoruz" (R05–R08) türü istekler modelin kendisinden okunarak kapatılır.
- **İ3 — Topoloji tez kapsamına göre düzeltilir.** Bir model, tezde ve e-postalarda
  tanımlanan senaryo topolojisine uymuyorsa (eksik bağlantı, kopya dosya, yanlış
  kapı yolu), tanıma uyacak en küçük değişiklik yapılır. Değişiklik
  `02_MODEL_DUZELTME_KAYDI.md` dosyasına yazılır. Ham paket hiçbir zaman
  değiştirilmez; düzeltme `runs/<tarih>_<konu>/model/` kopyasında, betikle
  (programatik `add_block`/`set_param`) yapılır, elle kaydetme yapılmaz.
- **İ4 — Eksik deney yerine açık sınırlılık.** Yeni donanım deneyi yapılamaz.
  Eldeki Senaryo 1–3 ekranları ve özet tablo "mevcut deneysel kanıt" olarak
  kullanılır. Ham kaydı olmayan iddia sınırlılık olarak yazılır, bu yüzden
  `\eksikistek` barı kalmaz.
- **İ5 — Benzetim ile deney ayrı.** Benzetim yalnız deney özet tablosuna kalibre
  edilir. Kalibre benzetim sonucu "model, deneyin X'ini Y hata ile yeniden
  üretiyor" biçiminde yazılır, deney bulgusu gibi sunulmaz.

## Kararlar

| No | Açık nokta | Karar | Dayanak | Yeniden açılır mı |
|---|---|---|---|---|
| K-01 | THD hedefi: xlsx/m-dosyası 15/47/14 mi, 18.07 e-postası 5/–/4 mü? | **15/47/14** kullanılır. Kalibrasyonda THD ikincil ölçüttür; birincil ölçütler P_ac, I_ac ve verimdir. | İ1. İki makine okunur kaynak birbiriyle tutarlı; e-posta tek ve eski. | Ham analizör kaydı bulunursa |
| K-02 | cosφ/Q işareti: e-posta pozitif, xlsx negatif | Karşılaştırma **büyüklük** üzerinden yapılır (\|Q\|, \|cosφ\|). Benzetimde işaret, dalga biçiminden (akımın gerilime göre faz açısı) hesaplanır. Tezde üretici (evirici→şebeke) kuralı açıkça yazılır. | Güç analizörünün yön kuralı belgede yok. Benzetimdeki +Q, filtre kapasitörünün ~43 var'lık reaktif gücüyle uyumlu. | — |
| K-03 | Senaryo tanımları | S1 klasik tamamlayıcı · S2 nötr IGBT susturma (alternans boyunca 1/0) · S3 = S2 + K1·sin θ + K3·sin³ θ · S4 = S3 + L1 akım geri beslemeli denetleyici, yüksek akım | 17.08, 06.10 ve 12.10 e-postalarındaki ortak tanım | — |
| K-04 | S1+S2 modelinde S2 devresinin kapı sinyali yok (`g12…g42` Goto eksik) | S2 devresine **S3 modelinin susturmalı PWM alt sistemi K3 = 0 ile** bağlanır. Genlik `K12`, faz `phase_deg2` olur; ikisi de m-dosyasında "Senaryo 2" diye tanımlı. | K-03 + İ3; düzeltme kaydı D-01 | — |
| K-05 | S4 modeli teslim edilmedi (dosya S3'ün kopyası) | S4, S3 tabanından kurulur. İki aşamalı: (a) Ümit'in tarif ettiği oransal L1 akım denetimi, `Kp = 0.03`; (b) jüri maddesi 8 için PI akım denetimi. Hedef akım `Ifaz_rms_target(4) = 25 A`; düşük/orta/nominal taraması 2,3 / 10 / 25 A. | İ1 (m-dosyası 25 A), 12.10 e-postası (P denetleyici, ~20 A); düzeltme kaydı D-02 | — |
| K-06 | Sin³ biçimi: K·sin³θ mı, K·sin(3θ) mı? | Modeldeki blok yapısı esas alınır (İ2). S3 modelinde `K33`'ün beslendiği blok okunur ve sonuç K-06a olarak yazılır. Özdeşlik: sin³x = [3 sin x − sin 3x]/4. | İ2 | — |
| K-07 | Kararlılık (jüri maddesi 7) | Üç katmanlı kanıt: (1) analitik — Sin³ terimi modülasyon toplamına eklenen dış ileri besleme girişidir ve 1 + C(s)G(s) = 0 değişmez; (2) S4 doğrusallaştırmasıyla L/S/T Bode eğrileri ve kazanç/faz marjı, K3 açık ve kapalı; (3) zaman alanında aynı basamak yanıtı ve kutup karşılaştırması. | Jüri maddesi 7 ve Ümit'in savunma yorumu | — |
| K-08 | Nominal güç (jüri maddesi 8) | Benzetimde nominal nokta S4'ün 25 A'lik çalışma noktasıdır (≈ 3 kW, 120 V). Donanım anma gücü (20 kVA–25 kW) ifadeleri tezde tasarım hedefi olarak kalır; laboratuvar şebeke gerilimi sınırı nedeniyle tam anma gücünde deney olmadığı sınırlılık olarak yazılır. | İ1 ve İ4 | — |
| K-09 | Parametre tablosu (jüri maddesi 9) | Tek tablo 12.10 m-dosyasından üretilir: değer, birim, kaynak ve "ölçülmüş / veri sayfası / kalibre" sütunlarıyla. | İ1 | — |
| K-10 | Deneysel bölüm (jüri maddesi 10) | Bölüm 6, eldeki Senaryo 1–3 ekranları ve özet tablo ile yazılır. Ham kayıt, protokol ve tekrar sayısı eksikliği sınırlılık paragrafına dönüşür. | İ4 | — |
| K-11 | Başlık (jüri maddesi 1) | "İleri beslemeli kontrol" ifadesi çıkarılır. Varsayılan başlık: *Enerji Depolama Sistemleri İçin Geliştirilmiş T-Tipi Dönüştürücü Mimarisi ve Düşük Güç Performansını İyileştiren Anahtarlama ve Sin³ Tabanlı Kompanzasyon Yöntemleri*. | `TEZ_YENIDEN_TASARIM_OMURGASI.md`; danışman onayı tezin dışında kalan bir adımdır | Danışman farklı başlık verirse |
| K-12 | GT-tipi mimari (Bölüm 7): model paketi yok | Bölüm, eldeki başvuru/şema içeriğiyle mimari öneri olarak kalır. Sayısal iddialar ham veri yoksa nitel ifadeye indirilir ve sınırlılık yazılır. | İ4 | — |
| K-13 | Model düzeltmelerinin tezde raporlanması | Tezde Bölüm 3'e "Benzetim modelinin doğrulanması ve düzeltilmesi" alt kesimi eklenir. Düzeltmeler kişi adı vermeden, akademik dille, D-xx kayıtlarının özetiyle verilir. Tam kayıt çalışma alanında kalır. | Proje sahibinin 27.10 isteği | — |
| K-14 | `Kp`, `K12`, `phase_deg2`, `L1_core_Rp4` tanımlı ama kullanılmıyor | `K12` ve `phase_deg2` K-04 ile, `Kp` K-05 ile bağlanır. `L1_core_Rp4` S4'te yüksek akım çekirdek kaybı için kullanılır; anlamı m-dosyası yorumundan okunur. | İ2, İ3 | — |
| K-15 | 18.07 e-postasındaki "CMC kütüphanesi" notu | Yok sayılır. Modeller yalnız standart Simscape ve Specialized Power Systems blokları içeriyor ve eksiksiz koşuyor. | 27.10 koşusu | — |
| K-06a | Sin³ biçimi (K-06'nın uygulaması) | Modelde terim **K33·sin³θ** biçiminde: birim genlikli sinüsün küpü, işareti pozitif, normalizasyon yok. Görev oranı toplamına açık çevrim ileri besleme olarak eklenir. Özdeşlikle m(θ) = 0,7425·sin θ − 0,0975·sin 3θ; tepe değer K13 + K33 = 0,84. `sin(3θ)` bloğu yok. | `inverter_senaryo3/Sine Wave3` → `Product15` → `Product1` → `K3` (= `K33`) zinciri; `review/2026-10-27_TOPOLOJI_DENETIMI.md` | — |
| K-17 | EMC X kapasitörünün tek faz eşdeğeri | `EMC_Cx_eq` = 0,5 µF / `EMC_Rx_eq` = 0,2 Ω kullanılır (D-09). | İ1: m-dosyasının kendi EMC tanımı ve şema | — |
| K-18 | Diyot eşlemesi | D1–D2 = DSEI2x61-12B, DS3–DS4 = IXYN iç FRD (D-08). Tezdeki `tab:yariiletken-esleme` buna göre düzeltilir. | Şema, m-dosyası başlıkları, gerilim sınıfı | — |
| K-02a | K-02'nin uygulaması: Q/cosφ raporlama ve kalibrasyon hedefi | **Nokta:** C (evirici çıkış uçları, EMC sonrası/L2 öncesi; analizörün bağlı olduğu 120 V tarafı). **Kural:** üretici, evirici → şebeke pozitif. Tezde iki büyüklük ayrı verilir: cosφ₁ (yer değiştirme) ve PF = P/(V·I). Deney değerleri işaretsiz \|Q\| ve \|cosφ₁\| olarak, cosfi yuvarlama bandıyla verilir; analizörün işaret kuralının belgede olmaması sınırlılık olarak yazılır. **İP-4:** her senaryoda serbest değişkenler faz (`phase_deg*`) ve genlik (`K1x`; S3'te K33/K13 oranı sabit). P_ac faz ile ±%1 içinde, C noktasındaki \|Q₁\| genlik ile yuvarlama bandı içinde; P ve Q eşleşik olduğu için 2×2 birlikte çözülür, genlik çözünürlüğü %0,005'ten iyi. İşaret dalı kalibrasyonsuz modele en yakın daldır (S3: Q > 0). I_ac, verim ve THD bağımsız doğrulama ölçütüdür. Şebeke gerilimi okuma çözünürlüğü \|Q\|'da ±12 var belirsizlik verdiğinden \|Q\| uyumsuzluğu tek başına modeli reddettirmez. | `review/2026-10-27_Q_ISARET_ANALIZI.md` (İP-3); D-06 | Analizör kuralı belgelenirse |
| K-16 | TODO.md R01–R16 istek listesi | Ümit'e gönderilmeyecek. Her madde bu defterdeki bir karara ya da Bölüm 8 sınırlılığına bağlanarak kapatılır (eşleme: `00_TAMAMLAMA_PLANI.md`). | Proje sahibi kararı | — |
