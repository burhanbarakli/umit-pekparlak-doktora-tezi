# İlk tez ile yeni tezin karşılaştırılması ve jüri isteklerinin karşılandığı yerler

Tarih: 29.10.2026

| Sürüm | Kaynak |
|---|---|
| İlk tez (sınav sürümü) | `dosyalar/01_TAM_TEZ/tez_tumu_8.docx` (MD5 `acf094b6…69d0`; 06.10 paketindeki kopyayla aynı dosya) |
| Yeni tez | `tez-latex-v2/build/main.pdf` (29.10.2026 derlemesi, 197 sayfa); numara ve sayfalar `build/main.aux`, `main.toc`, `main.lof`, `main.lot` dosyalarından |
| Ara taslak | `tez-latex-v2` hattının 01.09.2026 durumu (git `69ecf5f`, başlangıç kaydı). Ara taslak yalnız eski S4 ve L2 değerlerinin kökenini göstermek için anılır |

Sayfa numaraları PDF'te basılı sayfa numarasıdır (ana metin s. 1 = PDF'in 29. fiziksel sayfası).
Kontrol yöntemi: aux dosyasındaki 216 etiketin her biri için PDF metninde ilgili sayfada
"Şekil n." / "Tablo n." başlığının, "(n)" denklem numarasının ya da kesim başlığının
bulunduğu denetlendi. Bölüm açılış sayfaları dışında tamamı doğrulandı. Bölüm açılış sayfaları
İçindekiler ile tutarlıdır.

---

## 1. Özet

- **Başlık ve kavram düzeltildi.** "İleri beslemeli kontrol stratejisi" ifadesi başlıktan çıktı
  (K-11). Sin³ terimi tez boyunca "ileri besleme kompanzasyonu" olarak tanımlanıyor; terim
  bağımsız bir denetleyici sayılmıyor.
- **Yapı yeniden kuruldu.** 7 bölüm yerine 8 bölüm var: Giriş → Literatür → Sistem/model/metodoloji →
  Düşük güç analizi ve anahtarlama → Sin³ ve kapalı çevrim → Deney → GT-tipi → Sonuç.
  İlk tezin 27 sayfalık batarya/BYS "Giriş" bölümü Kesim 2.1'e (6 sayfa) indi. Yeni Bölüm 1
  amaç, AS1–AS4 araştırma soruları, üç katkı, kapsam ve tez düzenini içeriyor.
- **Kararlılık kanıtı sıfırdan eklendi.** İlk tezde "Bode" sözcüğü hiç geçmiyor. Yeni tezde
  Kesim 5.8 (s. 91–101) üç katmanlı kanıt veriyor: analitik, frekans alanı (L/S/T, Nyquist,
  marjlar, K34 açık/kapalı) ve anahtarlamalı modelde zaman alanı.
- **Nominal akımda kapalı çevrim (S4) eklendi.** İlk tezde S4 yok, Sin³ benzetimi
  denetleyicisizdi. Yeni tezde 2,3 / 10 / 25 A için P, PI ve PIR taraması ile basamak yanıtı
  var (Kesim 5.7). 25 A'da PI sonucu: −%2,1 genlik hatası, doyum yok.
- **Hatalı türetim zinciri çıkarıldı.** Eski Bölüm 4.6'daki 4.2–4.26 zinciri yerine üç parça
  geldi: geçerlilik sınırı ve HTF çerçevesi (Kesim 5.2), doğru sin³ özdeşliği (Eşitlik 5.1–5.3)
  ve yeniden yapılmış katsayı taraması (Kesim 5.4).
- **Benzetim modeli denetlendi, düzeltildi ve deneye kalibre edildi.** Kesim 3.8'de D-01 … D-11
  özeti var (Tablo 3.6). Kesim 6.10'da S1–S3 kalibrasyonu var. P_ac farkı ±%1 içinde; η farkı
  −1,35 / −0,27 / −0,25 puan (Tablo 6.10).
- **Tek parametre tablosu eklendi.** Tablo 3.3 (s. 37–44) 75 satırdır; her satırda değer, birim,
  kaynak ve tür var. LCL değerleri tek kaynağa bağlandı: L1 = 600 µH, Cf = 8 µF, L2 = 1000 µH.
- **Açık kalanlar biçim ve sunum işleri.** Bölüm 1'deki tek `\eksikistek` barı (s. 6), katkı
  tablosu, raster şekillerin yenilenmesi ve literatür sentezinin derinleştirilmesi kaldı.
  Ekler ve özgeçmiş yer tutucu durumda. Yeni deney yapılamadığı için deney kapsamı sınırlılık
  olarak yazıldı.

## 2. Sayısal görünüm

| Ölçüt | İlk tez | Yeni tez |
|---|---|---|
| Toplam sayfa | 213 [^1] | 197 [^2] |
| Ön kısım | ≈ 23 (kapak … ABSTRACT, roma i–xix) [^1] | 28 fiziksel sayfa (kapak … SUMMARY, roma xxvi'ya kadar) |
| Ana metin | s. 1–165 (165 s.) | s. 1–160 (160 s.) |
| Kaynaklar | s. 166–170; **45** kaynak [^3] | s. 161–165; **50** kaynak [^3] |
| Ekler | s. 171–189 (EK-A: 2 kalibrasyon sertifikası + 13 veri sayfası; EK-B/C: patentler) | s. 167, yalnız eklerin sonra konacağını bildiren tek cümlelik yer tutucu |
| Özgeçmiş | s. 190 | s. 169, boş şablon |
| Bölüm | 7 | 8 |
| Kesim (x.y) / alt kesim (x.y.z) | 55 / 43 [^4] | 55 / 23 (+5 adlandırılmış paragraf) |
| Şekil | **107** (Ş. 1.1–6.15) | **95** (Ş. 2.1–7.19; Bölüm 1 ve 8'de şekil yok) |
| Tablo | **16** | **43** |
| Numaralı denklem | **58** numara, 57 ayrı numara (4.14 iki kez); 72 Word denklem nesnesi, hepsi Bölüm 4'te [^5] | **49** (Bölüm 2: 3, 3: 15, 4: 5, 5: 20, 7: 6) |
| Vektör şekil | Word'e gömülü 129 görsel; kaynakların 27/57'si baskı için riskli [^6] | 24/95: 15 PDF + 9 TikZ. 71 şekil raster (74 raster dosya; 60'ı ilk tez ya da geçici kökenli, 9'u senaryo ekranı) |
| `\eksikistek` barı | — (Word hattında yok) | **1** (`01-giris.tex:56`, PDF s. 6) |
| "Bode" / "kararlılık" geçişi | 0 / 2 | 7 / 37 (bölüm `.tex` dosyaları) |
| Yaklaşık sözcük (ana metin) | ≈ 25,6 bin [^7] | ≈ 38,1 bin [^7] |
| Derleme denetimi | — | `main.log`: Undefined 0, Overfull 0; PDF'te "??" 0 |

[^1]: Word'ün `docProps/app.xml` içine yazdığı sayfa sayısı (Pages = 213). Bölüm sayfaları
    docx'teki İçindekiler alanından okundu. Ön kısım = 213 − 190.
[^2]: `main.log` "Output written … (197 pages)". `pdftotext` çıktısında 197 sayfa sonu var.
[^3]: İlk tez: KAYNAKLAR başlığı ile EK başlığı arasındaki `[n]` numaralı paragraflar (1–45).
    Yeni tez: `build/main.bbl` içindeki `\bibitem` sayısı.
[^4]: İlk tez: `heading 2/3` stilli numaralı başlıklar. Stil almamış 4.6 ve 4.8 ile `heading 3`
    düzeyindeki 3.9 dahildir. 22 adet x.y.z başlık `heading 2` stilindedir.
[^5]: Ana metindeki "(n.m)" ile biten denklem paragrafları sayıldı. Yeni tezde `\label{eq:…}` 49'dur,
    `equation` ortamı da 49'dur. Numarasız ortam yok.
[^6]: `dosyalar/03_INCELEME_VE_PLANLAMA/ON_INCELEME_RAPORU.md` (12.07.2026) eleme sonucu.
[^7]: İlk tez: docx `w:t` metni, 1. GİRİŞ ile KAYNAKLAR arası. Yeni tez: `pdftotext`, s. 1–160
    (tablo, başlık ve sayfa numaraları dahil). Yöntemler farklıdır; değerler yalnız mertebe karşılaştırması içindir.

## 3. Bölüm yapısı eşlemesi

| İlk tez (bölüm / kesim, sayfa) | Yeni tez (bölüm / kesim, sayfa) | İşlem |
|---|---|---|
| 1. Giriş: 1.1–1.8 EDS maliyeti, batarya yaşlanması, hücre dengesizliği, BYS, dengeleme (s. 1–27; Ş. 1.1–1.10, T. 1.1–1.3) | 2.1 EDS'de güç dönüşüm mimarileri (s. 7–12; Ş. 2.1–2.4, T. 2.1–2.3) | Taşındı, kısaltıldı |
| — | 1. Giriş (s. 1–6): amaç, AS1–AS4, üç katkı, kapsam/sınır, tez düzeni | Yeni |
| 2.1–2.6 FV çalışma koşulları, ağırlıklı verim, düşük güçte verim ve THD (s. 28–43) | 2.3 FV çalışma profili, kısmi yükte verim ve harmonik bozulma (s. 14–20) | Taşındı; profil "temsilî" diye yeniden adlandırıldı |
| 2.7–2.8 literatür yaklaşımları, "feedforward yaklaşımlarının önemi" | 2.4 Şebeke akım kontrolü ve ileri besleme yaklaşımları (s. 20) | Birleşti |
| 3.2 T-tipi topoloji (literatür kısmı) | 2.2 T-tipi dönüştürücünün kuramsal temeli (s. 12) | Taşındı |
| — | 2.5 Literatürün karşılaştırmalı değerlendirmesi (Tablo 2.7, s. 21–23); 2.6 Araştırma boşluğu (s. 23) | Yeni |
| — | 3.1 Genel mimari ve inceleme sınırı (Şekil 3.1, s. 26) | Yeni |
| 3.3–3.4 çalışma prensibi, akım yolları (Ş. 3.1–3.8, s. 49–) | 3.2 T-tipi faz kolu ve anahtarlama durumları (Şekil 3.3–3.4, Tablo 3.2, s. 26–30) | Birleşti; vektör ve renkli yeniden çizildi |
| 3.5 senkron buck eşdeğeri (Ş. 3.9–3.12) | 3.3 Düşük güç eşdeğeri (Şekil 3.5, s. 30–32) ve 4.2 Senkron buck eşdeğer modeli (s. 59) | Bölündü |
| — | 3.4 LCL filtre ve şebeke modeli (s. 32); 3.6 Parametreler (Tablo 3.3); 3.6.1 L2; 3.6.2 Yarı iletken eşlemesi | Yeni |
| 4.4–4.5 klasik ve önerilen kontrol blok diyagramı (Ş. 4.17, 4.23) | 3.5 Denetim, modülasyon ve Sin³ (Şekil 3.7, s. 34–36); 3.5.1 modelden okunan denetim | Taşındı, vektör çizildi |
| — | 3.7 Doğrulama metodolojisi (Tablo 3.5); 3.8 Modelin doğrulanması ve düzeltilmesi (Tablo 3.6); 3.9 Düşük akımda benzetim modelleme (Tablo 3.7) | Yeni |
| 3.6 düşük güç analizi; 4.2 ters akım dolaşımı | 4.1 Ters akım dolaşım mekanizması (s. 57) | Birleşti |
| 4.3 nötr anahtar susturma; simülasyon Ş. 4.1–4.16 | 4.3–4.4 klasik ve önerilen yöntem (s. 60–62); 4.4.1 modelden okunan kapı mantığı (Tablo 4.2); 4.5.2 senaryo ekran kayıtları (Ş. 4.7–4.18) | Taşındı, model kanıtıyla genişletildi |
| 3.8 verim–harmonik ödünleşimi | 4.5 Ödünleşim (s. 65); 4.5.1 kalibre S1–S2 karşılaştırması (Tablo 4.3); 4.5.3 güç tanımları ve anma ifadeleri | Taşındı, genişletildi |
| 3.7 harmonik oluşum mekanizması; 4.6 matematiksel açıklama (Eşitlik 4.1–4.55, T. 4.1–4.3, Ş. 4.25–4.28) | 5.1 Sin³ tanımı; 5.2 Basitleştirilmiş türetimlerin geçerlilik sınırı; 5.3 DCM mekanizması; 5.4 Doğru özdeşlikle yeniden tarama (s. 77–83) | Yeniden yazıldı; 4.2–4.26 türetim zinciri çıkarıldı |
| 4.5 ileri besleme etkisi (Ş. 4.18–4.19) | 5.5 Önerilen yapı ve ileri besleme mekanizması (Şekil 5.2–5.3, s. 83) | Taşındı |
| 4.7 Sin³ simülasyonu (Ş. 4.29–4.32) | 5.6 Senaryo 3 benzetim kayıtları (Şekil 5.4–5.7, s. 84–87) | Taşındı |
| Ş. 4.20–4.22 (tam güçte "feedforward ve kontrolör etkileri", 37,1 A) | — | Çıkarıldı; yerine S4 geldi |
| — | 5.7 S4 akım geri beslemeli kapalı çevrim (s. 88–91); 5.8 Kararlılık ve Bode analizi (s. 91–101) | Yeni |
| 4.8 Literatüre katkı (stilsiz başlık) | 2.4–2.6 ve 8.2 | Dağıtıldı |
| 5.1–5.9 donanım, kartlar, ölçüm, analizörler, PC yazılımı (s. 117–140) | 6.1–6.5 (s. 103–116; Tablo 6.1–6.3) | Taşındı; alt birim listesi tabloya dönüştü |
| 5.10–5.12 klasik / susturma / Sin³ deney kayıtları (s. 140–146) | 6.6–6.8 (s. 117–122) | Taşındı |
| 5.13 Bölüm sonucu ve T. 5.4 (benzetim sütunu boş) | 6.9 Değerlendirme, 6.9.1 sayısal denetim (Tablo 6.4–6.9); 6.10 kalibrasyon (Tablo 6.10); 6.11 sonuç | Genişletildi |
| 6.1–6.5 GT-tipi topoloji, PFC, BYS (Ş. 6.1–6.7) | 7.2 GT-tipi yapı; 7.2.1 RL1 tabanlı işlev paylaşımı (s. 133) | Taşındı |
| 6.5 şarj yönü benzetimi (Ş. 6.8–6.15) | 7.3 Şarj yönündeki benzetim kayıtları (Şekil 7.10–7.17, s. 139–144) | Taşındı |
| — | 7.1 gereksinimler, 7.2.2 100 kW proje mimarisi, 7.4 modlar, 7.5 geçiş ve güvenlik, 7.6 klasik mimariyle karşılaştırma, 7.7 kanıt düzeyi | Yeni |
| 7. Sonuç; 7.1 Fikri mülkiyet (T. 7.1); 7.2 Gelecek çalışmalar (s. 161–165) | 8.1 Araştırma sorularının yanıtları (Tablo 8.1); 8.2 katkılar; 8.2.4 fikrî mülkiyet (Tablo 8.2); 8.3 Sınırlılıklar; 8.4 Gelecek çalışmalar; 8.5 Genel sonuç | Genişletildi |
| EK-A/B/C (s. 171–189) | EKLER (s. 167): yer tutucu | Çıkarıldı (henüz yerine konmadı) |

## 4. İçerik farkları

### 4.1 İlk tezin 22 bulgusunun yeni tezdeki durumu

Kaynak: `tez-latex-v2/review/2026-09-01_ESKI_TEZ_SORUN_TESPITI.md`.

| # | Bulgu (kısa) | Durum | Yeni tezdeki yer ve kanıt |
|---|---|---|---|
| 1 | Başlık ile içerik uyuşmuyor ("ileri beslemeli kontrol") | giderildi | Kapak ve Özet/Summary başlığı K-11'e göre değişti. Kapsam paragrafı Sin³'ü kompanzasyon olarak sınırlıyor (Bölüm 1, s. 5). Danışman onayı tez dışında (İP-10) |
| 2 | Bölüm 1 bir Giriş değil | giderildi | Bölüm 1 (s. 1–6): amaç, AS1–AS4, üç katkı (s. 4), kapsam (s. 5), tez düzeni (s. 6). Batarya literatürü Kesim 2.1'de. Katkı **tablosu** yok (İP-10) |
| 3 | Genelden özele akış kopuk; GT-tipi önceden hazırlanmıyor | kısmen | GT-tipi Bölüm 1'de (AS4, katkı 3) ve Kesim 2.1'de hazırlanıyor. Bölüm 7 deney bölümünden sonra geliyor ve kendi benzetim kayıtlarını taşıyor (Kesim 7.3), yani akış benzetime geri dönüyor (İP-10) |
| 4 | Bölüm 5 alt birim listeleri düz numaralı paragraf | giderildi | Tablo 6.1 (s. 106) |
| 5 | Kararlılık kanıtı yok | giderildi | Kesim 5.8 (s. 91–101); Tablo 5.4–5.7; Şekil 5.11–5.16 |
| 6 | Sin³ türetim zinciri (4.2–4.26) geçersiz | giderildi | Zincir çıkarıldı. Yerine Kesim 5.2 (s. 78–79) geldi: tek çalışma noktası oranının aktarım fonksiyonu sayılamayacağı, süperpozisyon sınırı ve HTF çerçevesi (Eşitlik 5.4). Bağlaşım S4 anahtarlamalı modelde ölçüldü |
| 7 | Katsayı taraması çelişkili (T. 4.3 ile Ş. 4.28) | giderildi | Kesim 5.4 (s. 81–83), Tablo 5.1, Eşitlik 5.15, Şekil 5.1. Eski çiftler S1 noktasında THD ≈ %68 veriyor. Analitik aday (D1, D3) = (0,34; 0,40) ile kalibre (K13, K33) ayrı adlandırıldı (s. 78) |
| 8 | Yöntemler eşit koşulda karşılaştırılmamış | kısmen | Tablo 6.6 (s. 124); s. 119 ve 122'de "tek değişkenli üstünlük değil" ifadesi; Kesim 8.3 madde 2 (s. 157). Deney yinelenemediği için koşul farkı yalnız açıkça yazıldı |
| 9 | "Kontrolör kullanılmamıştır" ile "kontrolör çıkışı" çelişkisi | giderildi | Kesim 6.5 (s. 116): S1–S3 açık çevrimdir, kanal adı modülasyon komutu olarak okunur, geri besleme yalnız S4'te bulunur |
| 10 | Güç anma değeri tutarsız (kVA/kW) | giderildi | Kesim 4.5.3 (s. 75): 20 kVA anma görünür gücü, 20–25 kW tasarım aralığı, laboratuvarda yaklaşık 250–280 W; Tablo 3.3 |
| 11 | %23,6 düşük güç oranı saha bulgusu gibi sunulmuş | giderildi | Kesim 2.3: "temsilî profil" (s. 14), Tablo 2.4 (s. 15), Şekil 2.6 (s. 14) aynı 144 noktadan üretildi. Motivasyonla sınırlı olduğu s. 18'de yazılı |
| 12 | Deneysel izlenebilirlik yok; T. 5.4'ün benzetim sütunu boş | kısmen | Tablo 6.5 (ölçüm cihazları, s. 123), Şekil 6.25 (ölçüm zinciri, s. 123), Tablo 6.7 ve 6.9 (sayısal denetim, s. 125), Tablo 6.10 (benzetim sütunu dolu, s. 128). Ham kayıt yok; Kesim 8.3 madde 7'de sınırlılık (s. 158) |
| 13 | Patentler bilimsel kanıt yerine kullanılmış | giderildi | Bölüm 1, s. 5; Kesim 8.2.4 (s. 156), Tablo 8.2 (s. 157) |
| 14 | Terminoloji tutarsız, İngilizce ağırlıklı | giderildi | "feedforward" 48 → 4 (bölüm metninde görünen tek geçiş Bölüm 1'deki parantez içi İngilizce karşılık; diğer üçü etiket ve dosya adı; Summary ve kaynak adları sayıma dahil değil). "ileri besleme" 0 → 48. "sinküp" 9 → 0 [^8] |
| 15 | Kırık çapraz referanslar | giderildi | Bütün atıflar `\ref`/`\eqref` ile. `main.log`'da Undefined 0, PDF'te "??" 0 |
| 16 | Başlık numaralandırması bozuk (4.6, 4.8, 3.8, 1.6.x) | giderildi | LaTeX otomatik numaralandırması; İçindekiler (s. ix–xii) |
| 17 | "verilmiştir" üslubu, "Bu …" / "bu nedenle" tekrarı | kısmen | "bu nedenle" 73 → 0; paragraf başı "Bu" 47 → 0. Ancak "verilmiştir" 38 → 30 ve "gösterilmiştir" 21 → 16 [^8] |
| 18 | Şekil kalitesi düşük | kısmen | Yeni vektör şekiller: Şekil 2.6, 2.7, 2.9, 3.1, 3.3–3.7, 4.1, 4.6, 5.1, 5.8–5.16, 6.25, 7.9, 7.19. 71 şekil raster kaldı (İP-11) |
| 19 | 164 izlenen değişiklik açık | giderildi | LaTeX hattında izlenen değişiklik yok. İncelenen docx'te de `w:ins`/`w:del` sayısı 0 (bkz. Kesim 7) |
| 20 | sin³ özdeşliği katsayı hatası riski | giderildi | Eşitlik 3.11 (s. 35), Eşitlik 5.1–5.3 (s. 77): sin³θ = (3/4)sin θ − (1/4)sin 3θ. Laplace zinciri çıkarıldı |
| 21 | d_krit = 0,8007 evrensel sabitmiş gibi | giderildi | Eşitlik 5.9 (s. 80): d_krit(θ) = v_g(θ)/V_h, "tek bir evrensel sayı değildir" |
| 22 | Uygulanan terimin kimliği (sin³ mü sin 3θ mı) belirsiz | giderildi | Kesim 5.1 (s. 77–78): modelde K33·sin³θ, sin 3θ bloğu yok (K-06a) |

Özet: 17 giderildi, 5 kısmen (3, 8, 12, 17, 18), 0 açık.

[^8]: İlk tez: docx metninde büyük/küçük harf duyarsız sayım. Yeni tez: `chapters/*.tex` içinde
    aynı sayım. Sorun tespit notundaki sayılar (feedforward 39, sinküp 8, bu nedenle 69)
    farklı sayım yöntemindendir; eğilim aynıdır.

### 4.2 Özel olarak istenen başlıklar

| Konu | İlk tez | Ara taslak (01.09.2026) | Yeni tez |
|---|---|---|---|
| Hatalı türetim zinciri | Eski 4.6: genlik oranı aktarım fonksiyonu gibi kullanılıyor, süperpozisyon uygulanıyor, 4.20 → 4.22 arasında 3ω çarpanı kayboluyor, K1 = 9K3 eksik terimden çıkıyor; 4.14 numarası iki kez kullanılmış | Uyarı barıyla işaretli | Zincir yok. Kesim 5.2 geçerlilik sınırını ve HTF'yi veriyor. Katsayılar yeniden tarandı (Kesim 5.4) ya da kalibre edildi (Kesim 6.10) |
| sin³ özdeşliği | Laplace dönüşümünde ikinci terim katsayısı hatalı yazılmış (bulgu 20) | — | sin³θ = [3 sin θ − sin 3θ]/4; m(θ) = 0,7425 sin θ − 0,0975 sin 3θ (ilk değer), kalibre (A1, A3) = (0,7317; −0,0961) (s. 77–83) |
| S4 / kapalı çevrim | **Yok.** Sin³ benzetimi "kontrolör kullanılmadan" yapılmış. Tam güç gösterimi yalnız Ş. 4.20–4.21 (37,1 A) | S4: "30 A", K_p = 3 V/A, K_i = 100 V/(A·s), 100 µs denetim periyodu, K3 = −2 V; kararlılık için 150 µs gecikmeli ortalama model, GM 9,09 dB, PM 64,16° | Kesim 5.7: 2,3 / 10 / 25 A taraması, K_p = 0,03 (parametre dosyası), PI sıfırı 60 Hz (Tablo 5.2). 25 A'da PI: I_L1,1 = 24,47 A (−%2,1), THD %9,2, η %96,45, doyum %0; PIR −%1,0. Kesim 5.8, Tablo 5.4: PI (A) geçişleri 586 / 2454 / 3386 Hz, PM 77,7 / 120,8 / 54,2°, GM +35,2 dB, gecikme marjı 44,4 µs. "GM 9,09 dB" ve "30 A" metinde yok |
| L2 | L1 = 650 µH, C = 8 µF, **L2 = 150 µH** (Bölüm 4 benzetimi, V_DA = 420 V) | L1 = 600 µH, Cf = 8 µF, **L2 = 200 µH** (L2 aday karşılaştırma alt kesimiyle) | **L2 = 1000 µH** (şebeke + varyak eşdeğeri, tasarım türü; Kesim 3.6.1, s. 44–45). 200 ve 400 µH'nin daha eski kaynaklara ait olduğu ve kullanılmadığı açıkça yazılı. L2 aday alt kesimi kaldırıldı. Ölçülmediği Kesim 8.3 madde 9'da sınırlılık olarak yazılı |
| Üç faz / tek faz kapsamı | "3 fazlı, 4 telli … aslında 3 adet bir fazlı evirici"; sensör hesabı üç faz üzerinden (20 kVA / 3) | Güç tanımı üç faz toplamı; "12 IGBT'li üç fazlı model" | Prototip üç faz dört telli; benzetim ve deney tek faz kolunda (Bölüm 1 s. 5; Kesim 3.1 s. 25–26; Bölüm 6 girişi s. 103). Güç tanımı tek faz kolu için (Eşitlik 3.12, s. 47) |
| Ölü zaman | Değer verilmemiş; yalnız nitel anılmış (4 geçiş) | "Parametre dosyası ölü zaman içermemektedir" (yanlış); 2 µs deneme değeri | t_d = 1 µs, tasarım türü, DTR = 120 dayanaklı; modelde yükselen kenar gecikmesi (Tablo 3.3, s. 41) |
| Model düzeltmeleri | Model denetimi yok | — | Kesim 3.8 (s. 49–51), Tablo 3.6: D-01 (S2 kapı yolu), D-02 (S4 kuruldu), D-03 (yükleme sırası), D-06 (Q işareti), D-07 + D-08 (diyot eşlemesi), D-09 (EMC X kapasitörü), D-11 (DA bara 2 × 5,6 mF, yalnız S4). Tabloda olmayanlar: D-04, D-05, D-10, D-12, D-13, D-14. Tablo dışındakiler sayısal etkisi olmayan ya da yalnız koşu yöntemine ait kayıtlardır; s. 51'de toplu bir cümleyle anılır |
| Kalibrasyon | T. 5.4'te benzetim sütunu boş | — | Kesim 6.10 (s. 126–129), Tablo 6.10: P_ac farkı −%0,96 / +%0,24 / −%0,46; \|Q₁\| bantta; I_ac −%1,8 / +%3,7 / −%1,4; η −1,35 / −0,27 / −0,25 puan; THD S1 39,5 (deney 15), S2 56,7 (47), S3 14,8 (14). S1 ve S2 THD farkı Kesim 8.3 madde 10'da sınırlılık olarak yazılı |
| Kararlılık analizi | Yok ("Bode" 0) | Geçici ortalama LCL/PR modeli (150 µs, GM 9,09 dB) | Kesim 5.8: analitik katman (Eşitlik 5.18–5.20, s. 92–93); L, S, T, Nyquist ve L_g taraması (Şekil 5.11–5.14, Tablo 5.4–5.5); ölçülen ve analitik L karşılaştırması (Tablo 5.6, Şekil 5.15); K34 açık/kapalı basamak (Tablo 5.7, Şekil 5.16). Sayısal gerçeklemenin (B) kararsız olduğu marj tablosunda ve Kesim 8.3 madde 8'de yazılı |

## 5. Jüri istekleri → yeni tezde karşılandığı yer

Jüri isteklerinin kaynağı `jüri istekleri/Pekparlak_tez_önerileri.pdf`. Teknik dayanak olarak
aynı klasördeki yorum dosyasından yalnız teknik nokta alındı: u = C(s)e + F biçiminde, F hatadan
üretilmiyorsa 1 + C(s)G(s) = 0 değişmez. Ayrıca "feedforward control" yerine
"feedforward compensation/injection" adlandırması kullanılır.

| No | Jüri isteği (kısa) | İlk tezdeki durum | Yeni tezde karşılandığı yer | Durum | Kalan iş |
|---|---|---|---|---|---|
| 1 | Başlık anlaşılır olmalı ve içeriği yansıtmalı | Başlık "… ve İleri Beslemeli Kontrol Stratejisi" | Kapak, iç kapak, onay, Özet ve Summary başlığı (K-11). Bölüm 1 kapsam paragrafı, s. 5 | kısmen | İP-10: danışman onayı; Bölüm 1'de başlığın üç bileşeninin (T-tipi mimari, anahtarlama, Sin³ kompanzasyonu) katkılarla açık eşlenmesi |
| 2 | Bölüm ve akış sırası genelden özele olmalı | Batarya → FV → T-tipi → yöntem+benzetim → deney → GT-tipi; analiz ile benzetim iç içe | Bölüm sırası 1–8 (İçindekiler s. ix–xii). Açılış köprüleri: Bölüm 2 s. 7, 3 s. 25, 5 s. 77, 6 s. 103, 7 s. 131, 8 s. 153. Kesim 3.7 (s. 46), Tablo 3.5 (s. 47), Tablo 3.1 (s. 27) | kısmen | İP-10: Bölüm 4 açılışında Bölüm 3'e açık köprü yok. Bölüm 7 deneyden sonra yeni benzetim kayıtları (Kesim 7.3) getiriyor |
| 3 | T-tipi topoloji katkısı Sin³ gölgesinde kalmamalı | Üç katkı ancak sonuçta sıralanıyor | Bölüm 1, s. 4 (üç katkı listesi, AS1–AS4); Kesim 4.4 (s. 61), Tablo 4.1 (s. 61); Kesim 4.4.1, Tablo 4.2 (s. 62); Kesim 8.2 (s. 155), Tablo 8.1 (s. 153) | kısmen | İP-10: Bölüm 1'e katkı–yöntem–kanıt tablosu |
| 4 | Genel blok diyagram, gerekirse bölüm diyagramları | Ş. 4.17 ve 4.23 raster kontrol blok diyagramları | Şekil 3.1 genel sistem mimarisi (TikZ, s. 26); Şekil 3.6 LCL modeli (s. 33); Şekil 3.7 denetim–modülasyon blok diyagramı (s. 35); Kesim 3.5.1 (s. 36); Şekil 6.25 ölçüm zinciri (s. 123); Şekil 7.9 GT-tipi sentez mimarisi (s. 139); Şekil 7.19 durum makinesi (s. 147) | kısmen | İP-11: Bölüm 1'deki problem–yöntem–katkı akış şekli (`\eksikistek`, s. 6) |
| 5 | Düşük çözünürlüklü şekiller yenilenmeli | 129 gömülü görsel; Bölüm 4'te beş TIFF 560 × 396 piksel | 24/95 vektör şekil: Şekil 2.6, 2.7, 2.9, 3.1, 3.3–3.7, 4.1, 4.6, 5.1, 5.8–5.16, 6.25, 7.9, 7.19. Kararlılık ve S4 şekillerinin tamamı vektör PDF | kısmen | İP-11: 71 raster şekil (ilk tez kökenli Şekil 4.2–4.5, 4.7–4.8, 4.12–4.15 ve 5.2–5.4; Bölüm 6 ve 7 fotoğraf ve ekranları). Senaryo ekranları (Şekil 4.9–4.11, 4.16–4.18, 5.5–5.7) yeniden üretilemez; senaryo ekranları için kaynak ve sınır notu gerekir |
| 6 | T-tipi çalışma modları anlaşılır olmalı (dağınık, renksiz şekiller) | Ş. 3.2–3.8: yedi ayrı, renksiz mod şekli | Şekil 3.3 üç gerilim durumu (renkli, vektör, s. 29); Tablo 3.2 kapı durumları (s. 29); Şekil 3.4 aynı devre tabanında dört akım yolu ve renk lejandı (s. 31); Şekil 3.5 senkron buck eşdeğerleri (s. 31); Tablo 4.2 modelden okunan kapı mantığı (s. 62); Şekil 4.1 S2 kapı komutları (vektör, s. 63) | karşılandı | İP-11 (isteğe bağlı): Bölüm 4'teki raster kapı darbesi şekilleri aynı renk diline çekilebilir |
| 7 | Sin³ için kapalı çevrim modeli ve Bode diyagramı | Yok | Kesim 5.8 (s. 91–101): 5.8.1 analitik katman, Eşitlik 5.18–5.20 (s. 92–93); Tablo 5.4 marjlar (s. 94); Şekil 5.11 L Bode (s. 95); Şekil 5.12 S ve T (s. 96); Şekil 5.13 Nyquist (s. 97); Tablo 5.5 ve Şekil 5.14 L_g duyarlılığı (s. 97–98); Tablo 5.6 ve Şekil 5.15 ölçülen L (s. 99); Tablo 5.7 ve Şekil 5.16 K34 açık/kapalı basamak (s. 100–101); 5.8.4 sınırlar (s. 100) | karşılandı | — |
| 8 | Nominal güçte kapalı çevrim çalışma gösterilmeli | Yok; yalnız denetleyicisiz düşük güç benzetimi | Kesim 5.7 (s. 88–91); Tablo 5.2 tarama (s. 89); Şekil 5.8 25 A izleme (s. 90); Şekil 5.9 tarama özeti (s. 90); Tablo 5.3 ve Şekil 5.10 10 → 25 A basamak (s. 91–92); Tablo 3.6 D-11 satırı (s. 49–50); Tablo 6.8 kanıt düzeyi (s. 125) | karşılandı | — (benzetimle; donanımda anma deneyi yok, K-08 sınırlılığı Kesim 8.3 madde 3) |
| 9 | Elektriksel parametreler tek tabloda | Değerler metin içine dağınık, kaynaklar çelişkili | Tablo 3.3 (s. 37–44, 75 satır: değer, birim, kaynak, tür); Kesim 3.6 (s. 36); Kesim 3.6.1 L2 (s. 44); Kesim 3.6.2 ve Tablo 3.4 yarı iletken eşlemesi (s. 45–46) | karşılandı | — |
| 10 | Son kısımda deneysel testler | Bölüm 5 deney kayıtları; T. 5.4'ün benzetim sütunu boş; ham kayıt yok | Bölüm 6 (s. 103–130); Tablo 6.4 deney özeti (s. 122); Tablo 6.5–6.9 (s. 123–125); Tablo 6.8 güç bölgesine göre kanıt (s. 125); Kesim 6.10 kalibrasyon (s. 126), Tablo 6.10 (s. 128); Tablo 4.3 (s. 66); Kesim 3.8 (s. 49); Kesim 8.3 sınırlılıklar (s. 157–159) | kısmen | Yeni deney yapılamaz (İ4, K-10). Jüri belgesindeki maddede de deneyin yapılamayacağına dair parantez notu var. Kapanış sınırlılık beyanıyla yapıldı; İP-13'te son denetim |
| 11 | Akademik temel; doktora tezi örnekleri incelenmeli | Literatür özet düzeyinde; araştırma boşluğu yok | Bölüm 2 (s. 7–24); Kesim 2.5 ve Tablo 2.7 (9 çalışmalı karşılaştırma, s. 21–23); Kesim 2.6 Araştırma boşluğu (s. 23); 50 kaynak; Tablo 8.1 araştırma sorusu–kanıt matrisi (s. 153) | kısmen | İP-12: literatür sentezinin derinleştirilmesi, ulusal tez merkezi doktora tezi örnekleri, Tablo 2.7'nin genişletilmesi |

**Sayım:** 4 madde karşılandı (6, 7, 8, 9), 7 madde kısmen (1, 2, 3, 4, 5, 10, 11), 0 madde açık.

### Ek: jüri tablosundaki numaraların etiket karşılıkları

| Jüri | Etiketler (`label` → numara, sayfa) |
|---|---|
| 2 | `sec:dogrulama-metodolojisi` → 3.7, s. 46 · `tab:dogrulama-matrisi` → 3.5, s. 47 · `tab:model-katmanlari` → 3.1, s. 27 |
| 3 | `sec:model-kapi-mantigi` → 4.4.1, s. 62 · `tab:model-kapi-mantigi` → 4.2, s. 62 · `tab:klasik-onerilen-islevsel` → 4.1, s. 61 · `tab:arastirma-sorusu-kanit` → 8.1, s. 153 |
| 4 | `fig:genel-sistem-mimarisi` → 3.1, s. 26 · `fig:faz-basina-lcl-modeli` → 3.6, s. 33 · `fig:denetim-modulasyon-blok` → 3.7, s. 35 · `sec:denetim-modelden` → 3.5.1, s. 36 · `fig:deney-olcum-zinciri` → 6.25, s. 123 · `fig:gt-sentez-mimarisi` → 7.9, s. 139 · `fig:gt-durum-makinesi` → 7.19, s. 147 |
| 6 | `fig:t-tipi-uc-seviye` → 3.3, s. 29 · `tab:t-tipi-durumlar` → 3.2, s. 29 · `fig:t-tipi-akim-yollari` → 3.4, s. 31 · `fig:senkron-buck-esdeger` → 3.5, s. 31 · `fig:s2-kapi-isaretleri` → 4.1, s. 63 |
| 7 | `sec:kararlilik-bode` → 5.8, s. 91 · `eq:sin3-acik-cevrim` → 5.18, s. 92 · `eq:sin3-duyarlilik` → 5.19, s. 92 · `eq:sin3-kapali-cevrim-girisleri` → 5.20, s. 93 · `tab:kararlilik-marjlar` → 5.4, s. 94 · `fig:kararlilik-l-bode` → 5.11, s. 95 · `fig:kararlilik-s-t` → 5.12, s. 96 · `fig:kararlilik-nyquist` → 5.13, s. 97 · `tab:kararlilik-lg` → 5.5, s. 97 · `fig:kararlilik-lg` → 5.14, s. 98 · `tab:kararlilik-olcum` → 5.6, s. 99 · `fig:kararlilik-olcum` → 5.15, s. 99 · `tab:kararlilik-basamak` → 5.7, s. 100 · `fig:kararlilik-basamak` → 5.16, s. 101 |
| 8 | `sec:s4-kapali-cevrim` → 5.7, s. 88 · `tab:s4-tarama` → 5.2, s. 89 · `fig:s4-akim-izleme-25a` → 5.8, s. 90 · `fig:s4-tarama-ozet` → 5.9, s. 90 · `tab:s4-basamak` → 5.3, s. 91 · `fig:s4-basamak` → 5.10, s. 92 · `tab:model-duzeltme-ozeti` → 3.6, s. 49 · `tab:deney-juri-durum` → 6.8, s. 125 |
| 9 | `tab:sistem-parametreleri` → 3.3, s. 37 · `sec:l2-tanimi` → 3.6.1, s. 44 · `sec:yariiletken-esleme` → 3.6.2, s. 45 · `tab:yariiletken-esleme` → 3.4, s. 46 |
| 10 | `sec:kalibrasyon` → 6.10, s. 126 · `tab:kalibrasyon-karsilastirma` → 6.10, s. 128 · `tab:s1-s2-kalibre` → 4.3, s. 66 · `tab:deney-dusuk-guc-ozeti` → 6.4, s. 122 · `tab:deney-juri-durum` → 6.8, s. 125 · `sec:model-dogrulama-duzeltme` → 3.8, s. 49 · `sec:dusuk-akim-modelleme` → 3.9, s. 52 |
| 11 | `tab:literatur-karsilastirma` → 2.7, s. 21 · `chap:literatur` → 2, s. 7 |

## 6. Açık kalanlar

| İP | Tamamlanacak iş | Jüri |
|---|---|---|
| İP-9 | Son `\eksikistek` barı `01-giris.tex:56` (problem–yöntem–katkı akış şekli, s. 6); kapanışı İP-11'e bağlı | 4 |
| İP-10 | Bölüm 1'e katkı–yöntem–kanıt tablosu; başlığın üç bileşeninin katkılarla eşlenmesi; Bölüm 4 açılış köprüsü; Bölüm 7'nin akıştaki yeri ve Kesim 7.3'ün sunuluşu; danışmanla başlık onayı | 1, 2, 3 |
| İP-11 | Kavramsal akış şekli (TikZ); 71 raster şeklin ≥ 300 dpi ya da vektör olarak yenilenmesi, yeniden üretilemeyenler için kaynak ve sınır notu; Şekil 4.2/4.3 sıra hatasının giderilmesi (Kesim 7, madde 3) | 4, 5, 6 |
| İP-12 | Literatür sentezinin genişletilmesi; doktora tezi örnekleri; Tablo 2.7'nin kapsamının artırılması | 11 |
| İP-13 | Son derleme ve sürüm kaydı. Plan tablosunda görünmeyen ama teslim için gereken işler: EKLER yer tutucusu (ilk tezdeki EK-A sertifika/veri sayfaları ve EK-B/C patentleri ya yeniden eklenmeli ya da çıkarılma kararı yazılmalı); boş ÖZGEÇMİŞ; kimlik yer tutucuları (öğrenci no, anabilim/bilim dalı, savunma tarihi); "HAZİRAN 2026" teslim tarihi; Bitti tanımı 5 için D-03 (kopya modellerde açık), D-10 ve D-14 (açık, düşük öncelik) kayıtlarının kapatılması | hepsi |

## 7. Doğrulamada bulunan tutarsızlıklar

Düzeltme yapılmadı; yalnız raporlanıyor.

1. **Eski S4 ve L2 değerlerinin kökeni.** 30 A, K_p = 3 V/A, 150 µs, GM 9,09 dB ve L2 = 200 µH
   ilk tezde (docx) **yok**. Değerler `tez-latex-v2` ara taslağına (01.09.2026, git `69ecf5f`) ve
   `tez-matlab-simulink/README.md` geçici analizine aittir. İlk tezin LCL değerleri
   L1 = 650 µH, C = 8 µF, L2 = 150 µH; ilk tezde S4 ve kapalı çevrim yoktur. Yeni tez metninde
   eski değerlerin hiçbiri kalmamıştır (`chapters/*.tex` taramasında 0).
2. **Bulgu 19 yinelenemedi.** İncelenen `tez_tumu_8.docx` içinde `w:ins`, `w:del`, `w:moveFrom`
   ve `rPrChange` sayısı 0. "164 izlenen ekleme" sayısı `ON_INCELEME_RAPORU.md` (12.07.2026)
   kaynaklıdır; aynı MD5'li dosyada izlenen değişiklik bulunmadı. Sayım yöntemi farkı olası.
3. **Şekil sırası.** Şekil 4.3 (s. 63) Şekil 4.2'den (s. 64) önce basılıyor. Neden `[H]` yerleşimi
   (`04-dusuk-guc-anahtarlama.tex`, 137 ve 144. satırlardaki figure ortamları). Aux denetiminde
   başka sıra ters dönmesi yok.
4. **Şekil 4.4 başlığı.** Başlık "tek fazlı T-tipi evirici ve LC filtre yapısı" diyor (ilk tez
   görseli); tezin geri kalanında filtre LCL'dir.
5. **Parametre tablosu sayfa aralığı.** Planda Tablo 3.3 için "s. 36–43" yazılı (İP-7, 171 sayfalık
   derleme). Güncel derlemede tablo s. 37–44 aralığında; kesim başı s. 36.
6. **Jüri 11 ve İP-8 özeti.** İP-8 özetinde "Bölüm 2 yalnız dil temizliğinden geçti" deniyor. Oysa
   Bölüm 2'de karşılaştırma tablosu (Tablo 2.7, s. 21–23) ve araştırma boşluğu kesimi
   (Kesim 2.6, s. 23) mevcut. Madde 11 "açık" değil, "kısmen" durumunda.
7. **Görünmeyen eski adlar.** Bazı etiket ve dosya adları `eski_`, `onceki_tez_`, `gecici_`
   içeriyor (ör. `fig:eski-feedforward-etkisi`, `tab:onceki-benzetim-ozeti`; 60 grafik dosyası).
   PDF'te görünmüyorlar ve Bitti tanımı 6'yı bozmuyorlar. İP-11'de dosyalar yenilenirken adlar da değişebilir.
8. **Bölüm 1 yapısı.** Bölüm 1'de numaralı kesim yok (İçindekiler'de yalnız "1 GİRİŞ"). Amaç, AS,
   katkı, kapsam ve düzen paragraf olarak geçiyor. Kılavuza aykırı değil, ancak İP-10'daki katkı
   tablosu için alt kesim gerekebilir.
9. **Aux ile PDF eşleşmesi.** Bölüm açılış sayfaları dışında 216 etiketin tamamı PDF'te
   doğru sayfada bulundu. Eksik ya da yanlış yerde etiket yok. Brifingteki bütün etiketler mevcut.
