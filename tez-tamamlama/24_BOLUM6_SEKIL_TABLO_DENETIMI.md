# Bölüm 6 (Deneysel Doğrulama) şekil ve tablo denetimi

- **Tarih:** 18.11.2026 (Mac oturumu, bağımsız denetçi ajan)
- **Kip:** yalnız rapor. Kaynak dosyalara dokunulmadı, derleme ve commit yapılmadı.
- **Denetlenen PDF:** `output.pdf` (213 sayfa). Bölüm 6, PDF s. 129–160 (basılı s. 97–128).
- **Kaynak:** `yeni_tez/bolumler/06-deneysel-dogrulama.tex` (606 satır). Görseller `\graphicspath` üzerinden `tez-latex/figures/deneysel/` altından geliyor (`tez-latex-v2/figures/deneysel` Mac aynasında yok).
- **Yöntem:** PyMuPDF ile her şekil ve tablo sayfası 110 dpi'de, ayrıntılar 150–600 dpi'de işlendi ve gözle incelendi. Gömülü görsellerin etkin çözünürlüğü (piksel / basılı genişlik) ölçüldü. Sayfa sonundaki boşluk ölçüldü. Her `\label` için `\ref` sayıldı. Görüntüler: `/private/tmp/claude-501/-Users-bob-CALISMALAR--mit-abi-tez-yazimi-manuel-kontrol-ayakaleaf/1fc9a723-a9bc-4d46-bec5-6e3d30f64760/scratchpad/b6sekil/`.
- **Öncelik ölçeği** (K-39/K-40 ile aynı): **Yüksek** jüri okurken hemen görür ya da kural ihlalidir. **Orta** okunurluk ya da düzen sorunudur. **Düşük** kozmetiktir.
- **Etiketler:** **[LaTeX]** yalnız `.tex` değişikliği yeter. **[Dönüştürme]** depoda daha iyi bir kaynak var, yalnız dönüştürülmesi gerekir. **[Yeni kaynak]** özgün fotoğraf ya da ekran görüntüsü gerekir. Ümit'e soru sorulmayacağı için (tamamlama kuralı) bu maddeler "kabul et ve karar defterine yaz" seçeneğiyle birlikte verilmiştir.

## 1. Şekil ve tablo listesi

Dosya adlarının ortak öneki `deneysel/onceki_tez_sekil_` kısaltıldı. dpi = basılı boyuttaki etkin çözünürlük.

| No | Basılı s. | Dosya | dpi | Karar | Kısa not |
|---|---|---|---|---|---|
| Şekil 6.1 | 98 | `5_1_deney_duzenegi.png` | 155 | OK | Etiketler Türkçe ve okunuyor. Daha keskin EMF kaynağı var (§2, O-5). Altında %25 boş sayfa |
| Şekil 6.2 | 99 | `5_2_evirici_donanimi.jpeg` | 318 | OK | Şekil 6.3 ile aynı panoyu gösteriyor, yerleşim önerisi için bkz. O-1 |
| Şekil 6.3 | 99 | `5_3_donanim_alt_birimleri.jpeg` | 137 | sorun | 1–14 işaretleri görünüyor. **9 ve 11 işaretleri fotoğrafın sol kenarında yarıya kadar kesik**, görüntü yumuşak |
| Tablo 6.1 | 100 | — | — | sorun | İçerik doğru. Tablodan sonra sayfanın %69'u boş (O-1) |
| Şekil 6.4 | 101 | `5_4_faz_donanimlari_1.png` | **104** | sorun | 1–4 görünüyor. Çözünürlük düşük. Sayfanın %28'i boş. 968×1291 EMF kaynağı var |
| Şekil 6.5 | 102 | `5_5_faz_donanimlari_2.png` | **104** | sorun | 5–8 görünüyor. Sorunlar 6.4 ile aynı |
| Tablo 6.2 | 103 | — | — | sorun | Altyazıda ek hatası "6.5**'deki**" (doğrusu 6.5'teki). Kondansatör/kapasitör karışık |
| Şekil 6.6 | 103 | `5_6_giris_devresi.png` | 179 | OK | 1–6 görünüyor. 1 ile 2 işaretleri yan yana ama renkleri ayırt ediliyor. Sayfanın %29'u boş |
| Tablo 6.3 | 104 | — | — | sorun | İçerik doğru. Sayfanın %45'i boş, çünkü Şekil 6.7 sığmıyor |
| Şekil 6.7 | 105 | `5_7_kontrol_buffer.png` | 189 | sorun (düşük) | 1–11 görünüyor. **10 işareti** (açık şeftali zemin, beyaz rakam) zor okunuyor. İşaretler yaklaşık 9 pt, rakamlar yaklaşık 5 pt |
| Şekil 6.8 | 106 | `5_8_igbt_surucu.jpeg` | 115 | sorun (düşük) | Yumuşak. Altyazı "devresi", metin "kartı" diyor. Sayfanın %32'si boş |
| Şekil 6.9 | 108 | `5_9_pencere_karsilastirici.jpeg` | 253 | **sorun** | Şema ekran görüntüsü. Eleman adları ve değerleri basılı boyutta yaklaşık 2 pt, **okunmuyor**. Etiketlerde ondalık nokta var ("0.6v") |
| Şekil 6.10 | 108 | `5_10_pencere_dalga.jpeg` | 171 | OK | İmleçler (2.00 V / 600 mV) ve CH2 davranışı metinle uyuşuyor. Osiloskop arayüzü İngilizce ve ondalık noktalı, cihaz çıktısı olduğu için bırakılabilir |
| Şekil 6.11 | 109 | `5_11_olcum_karti.jpeg` | 243 | OK | — |
| Şekil 6.12 | 109 | `5_12a_acudc240.jpeg`, `5_12b_acudc240_baglanti.jpeg` | 189 / 193 | sorun | (a) alt yazısı iki satıra kırılıyor, (b) tek satır, hizalar bozuk. (b) üretici sayfasının tamamı: İngilizce "Fig 2-13b Voltage and Current Wiring Using a Shunt", logo, "V:1.1.7 Revised: September 2025" ve sayfa no. Kaynak gösterilmemiş |
| Şekil 6.13 | 110 | `5_13_sont_baglanti.jpeg` | 165 | sorun (düşük) | Altyazıda "20 A**–**60 mV", metinde ve Tablo 6.4'te "20 A**/**60 mV" |
| Şekil 6.14 | 111 | `5_14a_emk01.jpeg`, `5_14b_emk01_baglanti.png` | 239 / 223 | sorun (düşük) | (a) yüksüz ekranı gösteriyor (0,0 A, okumalar yaklaşık 3 pt). (b) yazıları yaklaşık 2,5 pt ve İngilizce ("Temperature sensor", "LAN", "USB"). Kaynak gösterilmemiş. 6.13'ten sonra s. 110'un %33'ü boş |
| Şekil 6.15 | 111 | TikZ (satır 227–255) | vektör | **sorun** | **DA bara → PC oku "Kontrol/ölçüm kartı" kutusunun ve yazısının içinden geçiyor.** Kutu yazıları 4 satıra kırılıyor |
| Tablo 6.4 | 112 | — | — | sorun | "5 V A" (doğrusu 5 VA), "23 mV A⁻¹" (Türkçe kullanım mV/A), "Class 0.1" (ondalık nokta). Satırlar sıkışık. Aynı hücrede iki yazı tipi var |
| Şekil 6.16 | 113 | `5_15_pc_arayuzu.png` | 260 | sorun | Boş arayüz, yazılar yaklaşık 3 pt. Şekil 6.17 aynı arayüzü dolu hâliyle gösteriyor. Altyazı "Haberleşme sistemi arayüzü", metin ve pencere başlığı "PC ana kumanda yazılımı" |
| Şekil 6.17 | 114 | `5_16_klasik_pc.jpeg` | 226 | **sorun** | Tablo 6.7'nin dayandığı ekran değerleri (%92,9; %11,1; 431,5 V) basılı boyutta yaklaşık 3,5 pt, **okunmuyor**. Kaynak piksel yeterli (600 dpi'de net) |
| Şekil 6.18 | 114 | `5_17_klasik_l1.png` | 149 | OK | Osiloskop yazıları yaklaşık 5,5 pt, okunuyor. Arayüz İngilizce (cihaz çıktısı) |
| Şekil 6.19 | 115 | `5_18_klasik_faz.png` | 149 | OK | CycleRMS 2,874 A, metindeki 2,87 A ile aynı. Sonrasında sayfanın %34'ü boş |
| Şekil 6.20 | 116 | `5_19_susturma_pc.jpeg` | 223 | **sorun** | **Metinde hiç anılmıyor** (`\ref` sayısı 0). Ekran değerleri okunmuyor (6.17 ile aynı) |
| Şekil 6.21 | 116 | `5_20_susturma_l1.png` | 149 | OK | İçerik notu: ekrandaki ch4 CycleRMS 544,5 mA ("Low resolution"). Metinde kullanılmıyor, jüri sorabilir |
| Şekil 6.22 | 117 | `5_21_susturma_faz.png` | 149 | OK | 2,420 A, metindeki 2,42 A ile aynı. Sonrasında sayfanın %41'i boş |
| Şekil 6.23 | 118 | `5_22_sin3_pc.jpeg` | 232 | **sorun** | **Metinde hiç anılmıyor.** Ekran değerleri okunmuyor |
| Şekil 6.24 | 118 | `5_23_sin3_l1.png` | 149 | OK | ch3 ölçeği burada 1,00 V, önceki kayıtlarda 200 mV. Kanal sırası aynı |
| Şekil 6.25 | 119 | `5_24_sin3_faz.png` | 149 | sorun (düşük) | Alt kenarda öteki kayıtlarda bulunmayan osiloskop menü çubuğu var (Coupling/Termination/…). 2,293 A, metinle aynı |
| Tablo 6.5 | 119 | — | — | sorun (düşük) | Deney verimi "%92,50" gibi iki ondalıklı, Tablo 6.7 ve 6.12'de "%92,5". Satırlar sıkışık |
| Tablo 6.6 | 120 | — | — | **sorun** | "Yorum" sütunu çok dar. İki yana yaslı hücrelerde büyük boşluklar oluşuyor ("Düşük      güç"), hücreler 4–6 satır. Sonrasında sayfanın %35'i boş |
| Tablo 6.7 | 121 | — | — | **sorun** | "Farkın durumu" sütununda aynı sorun var, hücreler 5–6 satır. "Klasik / Nötr susturma …" her satırda yineleniyor |
| Tablo 6.8 | 121 | — | — | sorun | İki yana yaslı dar sütunlar ("Düşük      güç", "Deney     ve"). Satır arası yok |
| Tablo 6.9 | 122 | — | — | sorun | X sütunu olmayan `tabularx{\textwidth}`: sütunlar sola yığılmış, sağda boşluk var. Satırlar birbirine değiyor. $I_{faz}$ ve $\eta_{VI}$ alt simgeleri italik. $\eta_{VI}$ üç ondalıklı (92,700) |
| Tablo 6.10 | 122 | — | — | OK | Satırlar biraz sıkışık (bölüm geneli, §3) |
| Tablo 6.11 | 124 | — | — | sorun | Altyazı üç satır ve köken bilgisi taşıyor. "−12 … − 25" yazısında ikinci eksi ikili işleç aralığıyla basılıyor |
| Tablo 6.12 | 125 | — | — | **sorun** | **Altyazıda açıklama ve gösterge anahtarı var** ("İlk iki satır …", "Fark: % göreli, 'p' yüzde puan"). Hemen sonraki paragraf aynı cümleyi yineliyor. `\scriptsize`, satırlar birbirine değiyor |

Sayım: 25 şekil, 12 tablo. 11 tanesi OK, 26 tanesinde sorun var. Kalın "sorun" olanlar (6.9, 6.15, 6.17, 6.20, 6.23, Tablo 6.6, 6.7, 6.12) Yüksek ya da Orta maddelere girer.

## 2. Sorunlar ve düzeltmeler (öncelik sırasıyla)

### Yüksek

**Y-1. Şekil 6.20 ve 6.23 metinde anılmıyor.** [LaTeX] SAÜ kuralına göre her şekle metinde gönderme yapılmalıdır. `fig:deney-susturma-pc` ve `fig:deney-sin3-pc` için `\ref` sayısı 0. Düzeltme: 6.7 ve 6.8 kesimlerinin giriş paragrafına, 6.6'daki Şekil 6.17 cümlesinin eşi olan birer cümle eklenmeli. Örnek: "Şekil~\ref{fig:deney-susturma-pc}, susturma deneyinde PC yazılımında alınan grafikleri göstermektedir. THDi eğrisi kayıt boyunca \%45--50 arasındadır." ve "Şekil~\ref{fig:deney-sin3-pc} … THDi eğrisi kaydın büyük bölümünde \%14--18 arasındadır." Sayılar Tablo 6.7'deki gibidir.

**Y-2. Şekil 6.15 (TikZ): DA bara → PC oku "Kontrol/ölçüm kartı" kutusunun içinden geçiyor.** [LaTeX] Satır 250'deki `\draw[arr] (dc) |- (pc);` dikey kolu `ctrl` düğümünün tam ortasından geçiriyor. Okun üzerinden "Kontrol/ölçüm" ve "PWM," sözcükleri kesiliyor. Düzeltme:
- `\draw[arr] (dc.west) -- ++(-5mm,0) |- (pc.west);` ile ok solda dolaştırılmalı. Ya da alt satırın sırası değiştirilip `ctrl` evirici altına, osiloskop sola alınmalı.
- `meas` biçiminde `text width=32mm`, `data` biçiminde `text width=45mm` yapılmalı. Böylece "Kontrol/ölçüm kartı" ve "PC ana kumanda yazılımı" ikişer satıra iner.
- İsteğe bağlı: "EMK-01 + CT" yerine "EMK-01 + akım trafosu" yazılabilir (metindeki adla aynı olur).

**Y-3. Şekil 6.17, 6.20 ve 6.23: metnin ve Tablo 6.7'nin dayandığı ekran değerleri okunmuyor.** [LaTeX] Tablo 6.7'deki PC sütunu (verim %92,9 / %93,8 / %93,9; THDi %11,1 / %48,6 / %15,7; $V_{\mathrm{dc}}$ 431,5 / 394,7 / 427,5 V) bu ekranlardan okunuyor. Basılı boyutta alan yazıları yaklaşık 3,5 pt; jüri büyüteçsiz doğrulayamaz. Kaynak görüntüler 1249–1455 piksel genişliğinde ve 600 dpi büyütmede net, yani yeni ekran görüntüsü gerekmez. Düzeltme:
- Her şekil iki alt şekle bölünür: (a) tam ekran, (b) aynı dosyanın sol veri paneli (EMK-01 tablosu ve AcuDC-240 alanı, kaynak görüntünün sol yaklaşık %27'si, üst yaklaşık %60'ı), `\includegraphics[trim=…,clip,width=0.45\textwidth]` ile.
- (b) ölçeğinde rakamlar yaklaşık 7 pt olur. Kesim değerleri derlemede ayarlanmalı.
- Seçenek: üç panel tek bir yeni şekilde yan yana verilir ("PC ekranındaki anlık değerler: (a) klasik, (b) susturma, (c) susturma+Sin³"), Tablo 6.7'nin yanına konur.

**Y-4. Tablo 6.12 altyazısında açıklama ve gösterge anahtarı var.** [LaTeX] Proje kuralı (altyazı yalnız ne gösterildiğini söyler) ihlal ediliyor. "İlk iki satır kalibrasyon hedefidir, öteki satırlar bağımsız karşılaştırmadır" cümlesi tablodan hemen sonraki paragrafta (satır 582) aynen yineleniyor. "Fark: % göreli, 'p' yüzde puan" gösterge anahtarı satır sonunda "Fark: %" diye kırılıyor. Düzeltme:
- Altyazı: "Deney özeti ile benzetim modelinin karşılaştırılması."
- Fark gösterimi satır 582'deki paragrafa bir cümle olarak eklenir: "Fark sütununda \% göreli farkı, p yüzde puanı göstermektedir."

**Y-5. Tablo 6.6 ve 6.7: dar ve iki yana yaslı yorum sütunları.** [LaTeX] Üç orta sütun `X` olduğundan genişlik eşit paylaşılıyor, yorum sütunu da sayılar kadar dar kalıyor. Hücreler 4–6 satıra çıkıyor, sözcükler arasında büyük boşluklar oluşuyor. Tablo 6.7, s. 120'ye sığmadığı için s. 120'nin %35'i boş kalıyor. Düzeltme, şablonun hazır `L{}` sütun türüyle (`sauthesis.cls`, `\teksatir\raggedright`):
- Tablo 6.6: `{L{0.22\textwidth} *{3}{>{\centering\arraybackslash}p{0.12\textwidth}} >{\teksatir\raggedright\arraybackslash}X}`
- Tablo 6.7: `{L{0.19\textwidth} L{0.10\textwidth} *{2}{>{\centering\arraybackslash}p{0.10\textwidth}} >{\teksatir\raggedright\arraybackslash}X}`. Yöntem adı yalnız grubun ilk satırında yazılır, öteki iki satırda boş bırakılır (`\midrule` grupları zaten ayırıyor).
- Böylece hücreler 1–2 satıra iner ve iki tablo büyük olasılıkla aynı sayfaya sığar.

**Y-6. Bölümde yaklaşık 4 sayfalık boşluk.** [LaTeX] Sayfa sonu boşlukları (içerik altından metin alanı sonuna):

| Basılı s. | 98 | 100 | 101 | 102 | 103 | 104 | 106 | 110 | 115 | 117 | 120 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Boş | %25 | **%69** | %28 | %28 | %29 | **%45** | %32 | %33 | %34 | %41 | %35 |

Nedenleri: (i) satır 39, 74, 99 ve 136'daki elle konmuş `\clearpage`; (ii) şablonun zorunlu `[H]` yerleşimiyle yüksek şekillerin (6.4 ve 6.5 `0.68\textheight`, 6.8 `0.64\textheight`) bir sonraki sayfaya itilmesi. Düzeltme (yerleşim şablon gereği `[H]` kalır):
- Dört `\clearpage` kaldırılır. Bölüm başlığı (6.3) yeni sayfa gerektirmez.
- Şekil 6.4 ve 6.5 tek şekilde yan yana iki alt şekil olur: "(a) birinci görünüm, (b) ikinci görünüm", her biri `0.48\textwidth`. Tablo 6.2 hemen altına girer. İşaretler yaklaşık 9 pt'ye iner, okunur kalır. O-5'teki EMF dönüşümüyle birlikte yapılırsa netlik artar.
- Şekil 6.8 `height=0.45\textheight` yapılır. Fotoğrafta metnin andığı bir ayrıntı yok.
- Şekil 6.2 ile 6.3 için O-1'e bakınız.
- Değişikliklerden sonra derlenip boşluklar yeniden ölçülmelidir.

### Orta

**O-1. Şekil 6.2, 6.3 ve Tablo 6.1 yerleşimi; Şekil 6.3'te kesik işaretler.** [LaTeX] + [Yeni kaynak]
- Şekil 6.2 (genel görünüm) ile 6.3 (numaralı görünüm) aynı panoyu gösteriyor. Tablo 6.1, 6.3'ten ayrı sayfaya düşüyor, sonrasında %69 boşluk kalıyor. [LaTeX] düzeltme: 6.2 küçültülür (`width=0.6\textwidth`) ya da 6.3 ile tek şekilde iki alt şekil yapılır. Tablo 6.1 doğrudan 6.3'ün altına konur. Okur, numaraları ve açıklamalarını aynı sayfada görür.
- 6.3'te 9 ve 11 işaretleri ile 9, 10 ve 11 kutularının sol kenarı görüntünün içinde kesik. Görüntü 565×589 piksel (137 dpi) ve yumuşak. Depoda daha iyi bir sürümü yok (EMF yok, `tez-word` docx'inde de yok). [Yeni kaynak]: özgün işaretli fotoğraf. Soru sorulmayacağı için öneri: kabul edilip K kaydına yazılsın. 9 ve 11 yarım hâlleriyle de okunuyor.

**O-2. Şekil 6.9 pencere karşılaştırıcı şeması okunmuyor.** [Yeni kaynak] ya da [LaTeX, yeniden çizim] Eleman adları ve değerleri (R1 10k, R2 4k7, R3 2k, U1 LM2904, U2 TL072, D1/D2 BAV70W, "Vp+ 2v", "Vp− 0.6v" …) basılı boyutta yaklaşık 2 pt. Şekil zaten `0.96\textwidth`; yatay sayfaya almak yalnız 1,5 kat büyütür (yaklaşık 3 pt), yetmez. İki seçenek var:
- (a) Özgün EDA dosyasından vektör PDF almak [Yeni kaynak].
- (b) Şemayı `circuitikz` ile yeniden çizmek [LaTeX]. Değerler kaynak görüntünün kendi çözünürlüğünde okunabiliyor, sağ yarı (Q1, R5–R9, D3) da büyütmede seçiliyor. Yeniden çizimde eşik etiketleri "2,0 V" ve "0,6 V" diye Türkçe ondalıkla yazılır.

Bölüm 5'teki Şekil 5.5 TikZ yeniden çiziminin (K-39) eşi bir iştir. Yeniden çizim notu altyazıya yazılmaz (proje kuralı).

**O-3. Şekil 6.12 (b) ve 6.14 (b): üretici sayfası ayıklanmamış, kaynak gösterilmemiş.** [LaTeX]
- 6.12 (b)'de üretici kılavuzunun İngilizce şekil başlığı, logosu, sürüm ve tarih satırı ile sayfa numarası duruyor. Düzeltme: `trim=0 <alt ~%25> 0 0, clip` ile yalnız bağlantı çizimi bırakılır.
- 6.12 (a) alt yazısı "Evirici donanımı üzerindeki AcuDC240." iki satıra kırılıyor, (b) tek satır. Kısaltılmalı ("Panodaki AcuDC240.") ya da genişlikler `0.48/0.48` yapılmalı.
- İki (b) panosu da üretici belgesinden alınmış, ama metinde atıf yok. Metindeki "üretici dokümanındaki" cümlelerine (satır 176 ve 205) kaynak atfı eklenmeli. `kaynaklar.tex` içinde Accuenergy ya da Entes girdisi yok; girdiler EK A'daki veri sayfalarından kurulabilir. Atıf altyazıya değil metne yazılır (proje kuralı).

**O-4. Tablo 6.9 dizgisi.** [LaTeX]
- `tabularx{\textwidth}{c r r r r r r r}` içinde X sütunu yok. Sütunlar sola yığılıyor, sağda boş şerit kalıyor, sağa yaslı sayılar ortalı başlıkların altında kayıyor. Düzeltme: `\begin{tabular}{c *{7}{c}}` ya da `S` sütunları kullanılmalı.
- `I_{faz}` → `I_{\mathrm{faz}}`, `\eta_{VI}` → `\eta_{\mathrm{VI}}` (metindeki satır 476 da öyle).
- $\eta_{VI}$ değerleri 92,700 / 93,715 / 94,373 girdilerden daha duyarlı görünüyor. 92,70 / 93,72 / 94,37 yazılmalı (metindeki −0,20 / +0,48 / +0,13 farkları değişmez).

**O-5. Fotoğrafların düşük çözünürlüğü (6.4 ve 6.5'te 104 dpi): depoda daha iyi kaynak var.** [Dönüştürme] `tez-latex/figures/deneysel/` altındaki Word kopyalarının EMF sürümleri tezdeki PNG'lerden daha yüksek çözünürlüklü fotoğraf ve **vektör** işaret katmanı içeriyor. EMF içindeki DIB başlıkları okunarak denetlendi:

| Şekil | Tezdeki PNG | EMF (`image68/71/72/73/74.emf`) |
|---|---|---|
| 6.1 | 840×632 | 1291×968 |
| 6.4 | 515×684 | **968×1291** |
| 6.5 | 516×686 | **968×1291** |
| 6.6 | 958×720 | 1008×756 |
| 6.7 | 969×729 | 1291×968 |

`image71.emf` içindeki fotoğraf açılarak bakıldı: PNG'den belirgin biçimde keskin. PNG'deki renkli yarı saydam kutular EMF'de ayrı vektör nesneleri. Düzeltme: EMF'ler LibreOffice ya da Inkscape ile PDF'e çevrilir (Mac'te ikisi de kurulu değil; Windows'ta ya da kurulumdan sonra yapılır). Sonra `\includegraphics` yolları değiştirilir. Bitmap 16 bit renkte; dönüşümden sonra bantlaşma olup olmadığına bakılmalı. Bu yapılırsa 6.7'deki 10 işaretinin rengi de vektör katmanda düzeltilebilir. Not: metindeki satır 6 "özgün çözünürlükleriyle verilmiştir" diyor, oysa bu beş şekil şu an Word'ün küçülttüğü önizlemelerden geliyor. Dönüşüm yapılmazsa bu ifade düzeltilmeli.

**O-6. Tablo 6.4, 6.8 ve 6.11'de birim, sayı ve hücre dizgisi.** [LaTeX]
- Tablo 6.4 ve satır 205: `\SI{5}{\volt\ampere}` "5 V A" diye basılıyor. Doğrusu "5 VA": `\SI{5}{VA}` ya da `\si{\volt\ampere}` için `inter-unit-product=` boş.
- `\SI{23}{\milli\volt\per\ampere}` "23 mV A⁻¹" diye basılıyor. Türkçe metinde "23 mV/A" beklenir: `per-mode=symbol` yerel ya da genel olarak verilmeli.
- "Class 0.1" ondalık noktalı. "0,1 sınıfı" ya da "doğruluk sınıfı 0,1" yazılmalı (tabloda ve satır 205'te).
- Tablo 6.8: birinci, ikinci ve dördüncü sütunlar iki yana yaslı ve dar ("Düşük      güç (2,3 A)"). Sütunlar `L{…}` yapılmalı, satırlar arasına `\addlinespace[2pt]` ya da şablonun `\Ts` desteği konmalı (§3).
- Tablo 6.11: `$-12\ldots-25$` ikinci eksiyi ikili işleç sayıyor ("… − 25"). `$-12\ldots{-25}$` ya da "−25 ile −12" yazılmalı. Altyazı üç satır ve köken bilgisi taşıyor ("kalibrasyon benzetimlerinden ölçülen", "(kalibrasyon öncesi benzetimler)"). Bu bilgi satır 530'da zaten var. Altyazı: "Köprünün Thevenin iç empedansı, ara seviye zaman oranı ve güç duyarlılıkları."

**O-7. Şekil 6.16 gereksiz ve altyazısı metinle uyuşmuyor.** [LaTeX] Boş arayüz ekranı, yazıları yaklaşık 3 pt. Aynı pencere 6.17'de verilerle dolu hâlde var. Altyazı "Haberleşme sistemi arayüzü", ama metin ve pencere başlığı "PC ana kumanda yazılımı". Düzeltme: ya şekil kaldırılır ve satır 283 Şekil 6.17'ye bağlanır (yarım sayfa kazanılır), ya da altyazı "PC ana kumanda yazılımının arayüzü." yapılır.

### Düşük

**D-1. Tablo 6.2 altyazısı.** [LaTeX] "Şekil 6.4 ve Şekil 6.5**'deki**" → "**'teki**" (beş-teki). Daha yalın seçenek: "Eviricinin bir fazına ait bileşenler." Şekil göndermesi metinde zaten var (satır 58). Y-6'daki birleştirme yapılırsa "Şekil 6.4'teki" yazılır.

**D-2. Terim birliği (tablolar ve altyazılar).** [LaTeX]
- Tablo 6.1'de "Snubber kapasitörleri", "LCL filtre kapasitörleri"; Tablo 6.2'de "Snubber kondansatörleri", "DA bara elektrolitik kondansatörleri", "Boost diyotları ve kondansatörü"; metinde ikisi de geçiyor. Tek terim seçilmeli (öneri: kondansatör).
- Tablo 6.1'de "Yükseltici (boost) diyotları", Tablo 6.2'de "Boost diyotları".
- Tablo 6.1'de "Ölçme kartı", Şekil 6.11 ve metinde "Ölçüm kartı".
- Şekil 6.8 altyazısı "IGBT kapı sürme devresi", metinde "kartı". Fotoğraf bir kartı gösteriyor, "IGBT kapı sürme kartı." yazılmalı.

**D-3. Şekil 6.13 altyazısı.** [LaTeX] `\SI{20}{\ampere}--\SI{60}{\milli\volt}` → `\SI{20}{\ampere}/\SI{60}{\milli\volt}` (metin ve Tablo 6.4 ile aynı olur).

**D-4. Tablo 6.5 duyarlılığı.** [LaTeX] Deney verimi "%92,50 / %94,20 / %94,50", oysa kaynak (özet) ve Tablo 6.7 ile 6.12'de bir ondalık var. "%92,5 / %94,2 / %94,5" yazılmalı. Benzetim sütunu iki ondalıklı kalabilir.

**D-5. Şekil 6.25'te menü çubuğu.** [LaTeX] Öteki osiloskop kayıtlarında olmayan alt menü (Coupling, Termination, Invert, Bandwidth, Label, More) duruyor. `trim=0 <alt ~%12> 0 0, clip` ile kırpılmalı. Bu, 6.18–6.24 ile aynı görünüm sağlar ve şekil boyunu kısaltır.

**D-6. Osiloskop kayıtlarının altyazıları (6.18, 6.19, 6.21, 6.22, 6.24, 6.25).** [LaTeX], isteğe bağlı. Altyazılar dört kanalı tek tek sayıyor; bu, gösterge benzeri bir anahtar. İki satıra kırılınca şablonun asılı iki yana yaslı biçimi ilk satırı geriyor ("Şekil  6.24.  Sin³   uygulanmış"). Öneri: "Klasik yöntemde $L_1$ akımının osiloskop kaydı." / "… faz akımının osiloskop kaydı." Kanal sırası metinde Şekil 6.18 için zaten yazılı (satır 309); 6.21 ve 6.24 paragraflarına "kanal düzeni Şekil 6.18 ile aynıdır" eklenir. 6.24 ve 6.25'te ch3 ölçeğinin 1,00 V olduğu gerekirse metinde söylenir.

**D-7. Şekil 6.7'de 10 işareti** açık şeftali zemin üzerinde beyaz rakamla basılmış, zor okunuyor. O-5'teki EMF dönüşümünde rengi koyulaştırılabilir [Dönüştürme]. Yapılmazsa kabul edilebilir.

**D-8. Şekil 6.8 (115 dpi)** yumuşak. EMF kaynağı yok [Yeni kaynak]. Metin fotoğraftaki bir ayrıntıya gönderme yapmadığı için kabul edilebilir. Y-6'daki küçültme etkin çözünürlüğü yaklaşık 165 dpi'ye çıkarır.

**D-9. Şekil 6.14 (a)** analizörü yüksüz anda gösteriyor (L–N 21–25 V, akım 0,0 A). Metin ekrandaki değerlere gönderme yapmadığı için sorun değil. Jüri sorarsa cihaz tanıtım fotoğrafı olduğu söylenir.

**D-10. Şekil 6.21 içerik notu.** Ekrandaki ch4 CycleRMS 544,5 mA ("Low resolution" uyarılı). Kayıttaki $L_1$ akımı açıkça daha büyük. Metin bu değeri kullanmıyor. Jüri sorusu notu (`\umitnot`) olarak eklenebilir; şekil değişmez.

**D-11. Tablo 6.9 ilk göndermeden uzakta.** Tablo ilk kez bölüm girişinde (s. 97) anılıyor, s. 122'de basılıyor. Giriş paragrafı veri kümesini özetlediği için bu ileri gönderme kabul edilebilir. İşlem önerilmez.

## 3. Bölüm genelini aşan bulgular (karar gerektirir)

Bunlar Bölüm 6'ya özgü değil. Düzeltme `tezpaketleri.sty` ya da bütün bölümler düzeyinde yapılacağından K kaydıyla karar verilmeli.

1. **Sayılar iki farklı yazı tipiyle basılıyor.** `siunitx` sayıları matematik yazı tipiyle (Cambria Math) basıyor, düz metindeki sayılar Times. Fark aynı hücrede görülüyor: Tablo 6.4'te "**300** MHz, 2,5 GS/s" (300 Cambria, 2,5 Times); Tablo 6.6 ve 6.7'de "430 V" Cambria, "%92,5" Times; Tablo 6.11'in bütün sayıları; Şekil 6.13 altyazısı; düz metin ("3,3 V", "20 A/60 mV"). Öneri: `tezpaketleri.sty` içinde `\sisetup{output-decimal-marker={,}, mode=text}`. Şablon dosyası değişmez, ama tezin bütün `\SI`/`\num` çıktısı değişir; Bölüm 4–7 yeniden gözle denetlenmeli.
2. **Tablo satır yüksekliği.** `sauthesis.cls` `\arraystretch{1}` ve tek satır aralığı kullanıyor. Şablon Word'deki tek aralıklı hücre yüksekliği (19,3 bp) için `\Ts` desteğini sağlıyor, ama Bölüm 6'da (ve öteki bölümlerde) hiç kullanılmamış (`grep` sayısı 0). Sonuç olarak Tablo 6.9, 6.11 ve 6.12'de satırlar birbirine değiyor, alt simgeler alttaki satıra yaklaşıyor. Öneri: tablo satır sonlarına `\Ts` eklemek (Word şablonuna uygunluk gerekçesiyle, biçim kilidine aykırı değil). Daha basit seçenek: bu tablolarda yerel `\renewcommand\arraystretch{1.15}`.
3. **Tablo 6.12'nin `\scriptsize` (8 pt) boyutu** SAÜ kılavuzundaki tablo yazı boyutu alt sınırıyla karşılaştırılmalı. Sınır 9 pt ise iki seçenek var: tablo yatay sayfaya alınır, ya da "Fark" sütunları atılıp yalnız deney ve benzetim değerleri verilir (farklar metinde zaten var).
4. **İki satırlı altyazılarda gerilen ilk satır.** Şablonun asılı ve iki yana yaslı altyazı biçimi kısa ikinci satırlı altyazılarda ilk satırı geriyor (Tablo 6.5, 6.7, 6.9, 6.12; Şekil 6.24, 6.25). Biçim kilitli olduğundan çözüm altyazıları kısaltmaktır (Y-4, O-6, D-6).

## 4. Bilerek bırakılması önerilenler

- **Osiloskop ve analizör ekranlarındaki İngilizce yazı ve ondalık nokta** (6.10, 6.14 (a), 6.18–6.25: "Value / Mean / Min / Max", "Low signal amplitude", "121.2 V", "4-Oct-25"): cihaz çıktısıdır, değiştirilemez. Metindeki ve tablolardaki karşılıkları ondalık virgülle yazılmış, bu doğru.
- **PC yazılımı ekranları** zaten Türkçe ve ondalık virgüllü (alan adları "Verim [%]", "Faz Akımı [A]", "Hata Kodu"). Yalnız "Clear" düğmesi ve "DC Bara" ekseni İngilizce; bırakılabilir.
- **Kart üzerindeki baskılar** ("GATE DRIVER V.05", "Driver Buffer v0.1", "Olcme Karti_V01"): fiziksel nesnenin parçasıdır.
- **Şekil 6.9'daki net adları** (VCC, VIN+, GND, FAULT, COMP1): yeniden çizimde (O-2) de teknik ad olarak kalabilir.
- **Şekil 6.14 (a) ve (b) üst kenarlarındaki 4 pt kayma**: gözle fark edilmiyor.

## 5. Kaynak gereksinimi özeti

| Gereksinim | Maddeler |
|---|---|
| **Yalnız LaTeX** | Y-1, Y-2, Y-3, Y-4, Y-5, Y-6, O-1 (yerleşim kısmı), O-2 (b) yeniden çizim, O-3, O-4, O-6, O-7, D-1 … D-6, §3 maddeleri |
| **Dönüştürme (kaynak depoda var)** | O-5: `image68/71/72/73/74.emf` → PDF (Şekil 6.1, 6.4, 6.5, 6.6, 6.7), D-7. LibreOffice ya da Inkscape gerekir (Windows PC ya da Mac'e kurulum) |
| **Yeni kaynak (özgün dosya)** | O-1: Şekil 6.3'ün kesiksiz ve yüksek çözünürlüklü işaretli fotoğrafı; O-2 (a): pencere karşılaştırıcının özgün şema dosyası; D-8: Şekil 6.8'in özgün fotoğrafı. Ümit'e soru sorulmayacağı için öneri: 6.3 ve 6.8 olduğu gibi kabul edilsin, 6.9 için O-2 (b) yapılsın; karar K kaydına yazılsın |

Önerilen uygulama sırası: Y-1, Y-4, Y-2, Y-5, O-4, O-6 ve D-1 … D-4 (metin ve tablo, tek oturum). Ardından Y-3, Y-6, O-1, O-3, O-7 ve D-5 (görsel yerleşim; derleyip boşlukları yeniden ölçerek). Sonra O-5 (EMF dönüşümü) ve O-2 (b) (TikZ şema). §3'teki genel maddeler ayrı K kararıyla ele alınmalı.
