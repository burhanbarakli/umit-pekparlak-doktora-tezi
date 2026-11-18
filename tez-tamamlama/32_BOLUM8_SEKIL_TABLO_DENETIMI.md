# Bölüm 8 (Sonuçlar ve Gelecek Çalışmalar) tablo ve sayfa düzeni denetimi

- **Tarih:** 18.11.2026 (Mac oturumu, bağımsız denetçi ajan)
- **Kip:** yalnız rapor. Kaynak dosyalara dokunulmadı, derleme ve commit yapılmadı.
- **Denetlenen PDF:** `output.pdf` (209 sayfa). Bölüm 8, PDF s. 173–181 (basılı s. 141–149). Bölüm açılış sayfasında numara basılmıyor (şablon); s. 141 bir sonraki sayfanın 142 olmasından çıkarıldı. PDF s. 182 (basılı 150) `openright` gereği boş arka sayfa, KAYNAKLAR PDF s. 183'te (basılı 151).
- **PDF sürümü:** PDF bugünkü yazım düzenlemesinden (30 numaralı rapor) önceki derlemedir. Üç tablonun hücreleri PDF ile kaynakta aynı (longtable satır 25'teki noktalı virgül → virgül değişikliği PDF'te de görünüyor). Düz metin farklı olduğu için sayfa sonu ölçümleri (özellikle Y-1) yeni derlemede yinelenmelidir.
- **Kaynak:** `yeni_tez/bolumler/08-sonuc.tex` (129 satır). Üç tablo: `longtable` `tab:arastirma-sorusu-kanit` (satır 10–28), `tabularx` `tab:katki-yontem-kanit` (satır 42–68), `tabularx` `tab:fikri-mulkiyet` (satır 86–103). Şekil yok.
- **Yöntem:** PyMuPDF ile Bölüm 8 sayfaları 110 dpi'de, tablo ayrıntıları 200–220 dpi'de işlendi ve gözle incelendi. Tablo çizgilerinin ve satırların konumu, yazı boyutu ve satır aralığı PDF'ten ölçüldü. Sayfa sonundaki boşluk ölçüldü. Her `\label` için tez genelinde `\ref` sayıldı ve bölümdeki her `\ref` hedefinin varlığı denetlendi. Şablon ayarları `sauthesis.cls` ve `tezpaketleri.sty`'den okundu. Görüntüler: `/private/tmp/claude-501/-Users-bob-CALISMALAR--mit-abi-tez-yazimi-manuel-kontrol-ayakaleaf/1fc9a723-a9bc-4d46-bec5-6e3d30f64760/scratchpad/b8sekil/`.
- **Öncelik ölçeği** (24 ve 28 numaralı raporlarla aynı): **Yüksek** jüri okurken hemen görür ya da kural ihlalidir. **Orta** okunurluk ya da düzen sorunudur. **Düşük** kozmetiktir.
- **Etiketler:** **[LaTeX]** yalnız `.tex` değişikliği yeter. **[Yeni kaynak]** gerektiren madde bu bölümde yok.
- **Ölçü birimi:** pt (PDF koordinatı). Metin alanı genişliği 411,1 pt, yüksekliği yaklaşık 690 pt (tek sayfalarda x = 113,4–524,5, çift sayfalarda 70,9–482,0).

## 1. Tablo listesi

| No | Basılı s. | Ortam | Karar | Kısa not |
|---|---|---|---|---|
| Tablo 8.1 | 141–142 | `longtable` | **sorun** | Gövde boyutunda (12 bp) ve 1,5 satır aralığında (satır adımı 20,7–21,7 pt) dizilmiş; tezin öteki tabloları 10 bp / 11,5 pt. Tablo bu yüzden 1,3 sayfa tutuyor, s. 141'e yalnız AS1 sığıyor. Satırlar arasında ek boşluk yok. Tablo metin alanından dar (385,8 pt / 411,1 pt), ortalı. Devam başlığı "(devam)", tezin öteki uzun tablolarında "(devamı)". Hücrede "Bölüm 3'deki", "Bölüm 4'daki" ek hatası. "çalışma modu/modları" (Bölüm 7 "kip" diyor) |
| Tablo 8.2 | 145 | `table[H]` + `tabularx` | **sorun** | **s. 144'ün %71'i boş**: tablo (528,7 pt) s. 144'te kalan 489,5 pt'ye sığmıyor, `[H]` sonraki sayfaya itiyor. **Altyazının ikinci cümlesi koşul açıklaması** (kural ihlali). "T-/tipi" satır sonunda bölünüyor, birinci sütunda tek sözcüklük "güç" satırı. Dördüncü sütunda yer ve tür bilgisi aynı cümle akışında, son nokta yok. "54°" matematik yazı tipinde |
| Tablo 8.3 | 147 | `table[H]` + `tabularx` | **sorun** | **Üçüncü sütun iki yana yaslı**: "Başvuru␣␣␣19.10.2023;␣␣␣patent␣␣␣belgesi␣␣␣veriliş". "rüçhan TR / 2023/013378" numarası iki satıra bölünüyor. Satırlar arası boşluk (11,5 pt) hücre içi satır adımına (12,5 pt) eşit ya da küçük, satır sınırları seçilmiyor. `@{}` yok, yazı çizgilerden 5,4 pt içeride |

Sayım: 3 tablo, üçünde de sorun var.

**Gönderme sayımı (tez geneli):**

| Etiket | `\ref` sayısı | Yer |
|---|---|---|
| `tab:arastirma-sorusu-kanit` | 1 | 08 satır 8 |
| `tab:katki-yontem-kanit` | 2 | 08 satır 40, 76 |
| `tab:fikri-mulkiyet` | 2 | 08 satır 84; `ekler.tex` satır 19 |
| `chap:sonuc` | 1 | `01-giris.tex` satır 107 (TikZ akış şeması) |

Anılmayan tablo yok. Bölüm 8'deki 20 farklı `\ref` hedefinin hepsi tezde birer kez tanımlı (`chap:sistem`, `chap:anahtarlama`, `chap:deney`, `chap:gttipi`, `fig:sin3-yeniden-tarama`, `sec:kalibrasyon`, `sec:kararlilik-bode`, `sec:model-kapi-mantigi`, `sec:s1-s2-kalibre`, `sec:s4-kapali-cevrim`, `sec:sin3-yeniden-tarama`, `sec:thd-kaynaklar`, `tab:deney-dusuk-guc-ozeti`, `tab:kalibrasyon-karsilastirma`, `tab:kararlilik-marjlar`, `tab:kararlilik-olcum`, `tab:s4-tarama` ve bölümün kendi üç tablosu). Bölüm 8'in alt bölümlerinde `\label` yok; Y-2 önerisi 8.3 için bir etiket ekliyor.

**Ölçülen aralıklar:**

| | Önceki metin → altyazı | Altyazı → üst çizgi | Alt çizgi → sonraki metin |
|---|---|---|---|
| Tablo 8.1 | 20,6 pt | 6,3 pt | 20,5 pt |
| Tablo 8.2 | (sayfa başı) | 6,4 pt | 26,3 pt (alt bölüm başlığına) |
| Tablo 8.3 | 20,7 pt | 6,3 pt | 26,2 pt |

Altyazı–tablo aralığı üç tabloda aynı. Tablodan sonraki aralık `longtable`'da yaklaşık 5,7 pt kısa (D-7).

## 2. Sorunlar ve düzeltmeler (öncelik sırasıyla)

### Yüksek

**Y-1. Basılı s. 144'ün %71'i boş (Tablo 8.2 `[H]`).** [LaTeX]
- s. 144'te metin 273,6 pt'de bitiyor; metin alanı 763 pt'ye kadar. Kalan 489,5 pt. Tablo 8.2 altyazı üstünden alt çizgiye 528,7 pt, `\intextsep` ile yaklaşık 541 pt. Açık yaklaşık 51 pt; tablo s. 145'e itiliyor ve s. 144'te yaklaşık 490 pt (sayfanın %71'i) boş kalıyor.
- Tez genelinde bütün tablolar `[H]` (36 tablo, 77 şekil; `sauthesis.cls` satır 463–464 `\floatplacement{table}{H}`). Şablonun Word modeli bunu istiyor, bu yüzden yüzdürme (`[tp]`) önerilmiyor. Ayrıca şablonda `\textfloatsep=0bp`, yani bir üst yüzer tablonun altında metinle arada boşluk kalmaz.
- Kaynakta yerini değiştirmek güvenilir değil: tablo 8.2.1'den sonraya alınırsa boşluk yalnız oraya kayar; 8.2.2'den sonraya alınırsa sonuç bugünkü yazım düzenlemesine ve O-1'in getireceği yaklaşık yarım sayfalık kaymaya bağlı kalır.
- **Önerilen düzeltme: Tablo 8.2'yi Tablo 8.1 gibi `longtable` yapmak.** Tablo sayfaya sığarsa bütün olarak basılır; sığmazsa satır sınırından bölünür ve devam başlığı tekrarlanır. Hangi derlemede olursa olsun büyük boşluk kalmaz. Yeni paket gerekmez (`longtable` şablonda yüklü). `X` yerine sabit genişlik verilir; genişlikler toplamı 0,955\textwidth + 6 × 3 pt ≈ 410,6 pt.
  ```latex
  \begingroup
  \setlength{\tabcolsep}{3pt}
  \begin{longtable}{@{}>{\footnotesize\raggedright\arraybackslash}p{0.17\textwidth}%
                       >{\footnotesize\raggedright\arraybackslash}p{0.20\textwidth}%
                       >{\footnotesize\raggedright\arraybackslash}p{0.405\textwidth}%
                       >{\footnotesize\raggedright\arraybackslash}p{0.18\textwidth}@{}}
    \caption{Özgün katkılar: başlıktaki karşılık, yöntem, başlıca bulgu ve kanıt.}
    \label{tab:katki-yontem-kanit}\\
    \toprule
    \textbf{Katkı ve başlıktaki karşılığı} & \textbf{Yöntem} & \textbf{Başlıca bulgu ve koşulu} & \textbf{Kanıtın yeri ve türü} \\
    \midrule
    \endfirsthead
    \caption[]{Özgün katkılar: başlıktaki karşılık, yöntem, başlıca bulgu ve kanıt (devamı).}\\
    \toprule
    \textbf{Katkı ve başlıktaki karşılığı} & \textbf{Yöntem} & \textbf{Başlıca bulgu ve koşulu} & \textbf{Kanıtın yeri ve türü} \\
    \midrule
    \endhead
    \bottomrule
    \endfoot
    % satır 52–65 aynen (O-5 düzeltmeleriyle), satırlar arasında \addlinespace kalır
  \end{longtable}
  \endgroup
  ```
  - `\footnotesize` sütun başına verildi (Bölüm 3'teki `tab:sistem-parametreleri` ile aynı yöntem); böylece altyazı normal boyutta kalır. Tablonun bütününü `{\footnotesize ...}` grubuna almak altyazıyı da küçültür.
  - Üçüncü sütun 154,6 pt'den 166,5 pt'ye genişler (+%8). İkinci satırın üçüncü hücresi (14 satır, tablonun en uzun hücresi) yaklaşık 13 satıra iner. Altyazının tek satıra inmesiyle (Y-2) birlikte tablo yaklaşık 50 pt kısalır; eski PDF'teki akışta s. 144'e bütün olarak sığması olasıdır.
- **Seçenek (şablona en yakın):** `table[H]` kalır; yalnız Y-2 (altyazı) ve aynı sütun genişlikleri (`p{0.17}`, `p{0.20}`, `X`, `p{0.18}`) uygulanır, yeni derlemede s. 144'teki boşluk yeniden ölçülür. Tablo yine sığmazsa yukarıdaki `longtable` biçimine geçilir.

**Y-2. Tablo 8.2 altyazısında koşul açıklaması (kural ihlali); bilgi gövdede eksik.** [LaTeX]
- Altyazının ikinci cümlesi ("Deney değerleri yaklaşık 2,3 A faz akımı, 250–280 W AA güç ve yaklaşık 120 V şebeke gerilimindeki tek faz kolu içindir.") koşul açıklamasıdır; proje kuralına göre gövdeye taşınmalıdır. Altyazı bugün 3 satır.
- **Gövdede aynı bilgi tam olarak yok.** Satır 109 (8.3 "Sonuçların Elde Edildiği Koşullar") yalnız "yaklaşık 120 V" ve "yaklaşık 2,3 A faz akımı" diyor. "250–280 W AA güç" ve "tek faz kolu" yok. Ayrıca 8.3, tablodan iki sayfa sonra geliyor. 30 numaralı rapordaki "aynı koşul satır 109'da zaten var" notu yalnız kısmen doğru.
- Düzeltme:
  - Satır 44: `\caption{Özgün katkılar: başlıktaki karşılık, yöntem, başlıca bulgu ve kanıt.}`
  - Satır 40'ın sonuna (tablodan hemen önce): `Tablodaki deney değerleri, prototipin tek faz kolunda, yaklaşık \SI{2.3}{\ampere} faz akımında, \num{250}--\SI{280}{\watt} AA güçte ve yaklaşık \SI{120}{\volt} şebeke geriliminde elde edilmiştir (Alt Bölüm~\ref{sec:sonuc-kosullar}).`
  - Satır 107'den sonra: `\label{sec:sonuc-kosullar}`
  - İsteğe bağlı, 8.3'ün tek başına eksiksiz olması için satır 109'daki ilk cümleye "\num{250}--\SI{280}{\watt} AA güçte" eklenebilir. Sayılar altyazıdakiyle aynı; yeni değer girilmiyor.

**Y-3. Tablo 8.3: iki yana yaslı sütun, bölünen numara, seçilmeyen satır sınırları.** [LaTeX]
- Üçüncü sütun `X` (iki yana yaslı). Ulusal patent satırlarında ilk satır uzatılmış: "Başvuru␣␣␣19.10.2023;␣␣␣patent␣␣␣belgesi␣␣␣veriliş". Jüri hemen görür.
- WO 2025/085038 satırında "rüçhan TR" bir satırda, "2023/013378" alt satırda tek başına kalıyor.
- Satır içi satır adımı 12,5 pt, iki tablo satırı arası 11,5 pt. Satır sınırı hücre içi satır kırılmasından ayırt edilmiyor (örneğin satır 1'in ikinci satırı "21.02.2025 (Bülten 2025/2)" ile satır 2'nin ilk satırı arasında fark yok).
- Düzeltme (satır 91–100):
  ```latex
  \begin{tabularx}{\textwidth}{@{}>{\raggedright\arraybackslash}p{0.15\textwidth}%
                                  >{\raggedright\arraybackslash}p{0.21\textwidth}%
                                  >{\raggedright\arraybackslash}X@{}}
    \toprule
    \textbf{Tür} & \textbf{Numara} & \textbf{Başvuru, veriliş ve yayın bilgisi} \\
    \midrule
    Ulusal patent & TR~2023~013377~B & Başvuru 19.10.2023; patent belgesi veriliş 21.02.2025 (Bülten~2025/2) \\ \addlinespace
    Ulusal patent & TR~2023~013378~B & Başvuru 19.10.2023; patent belgesi veriliş 23.06.2025 (Bülten~2025/6) \\ \addlinespace
    Ulusal patent & TR~2023~013379~B & Başvuru 19.10.2023; patent belgesi veriliş 21.02.2025 (Bülten~2025/2) \\ \addlinespace
    PCT başvurusu & WO~2025/085037~A1 & PCT/TR2024/051205; başvuru 18.10.2024; yayın 24.04.2025; rüçhan TR~2023/013377 \\ \addlinespace
    PCT başvurusu & WO~2025/085038~A3 & PCT/TR2024/051206; başvuru 18.10.2024; yayın 24.04.2025; arama raporu 03.07.2025; rüçhan TR~2023/013378 \\ \addlinespace
    PCT başvurusu & WO~2025/085039~A1 & PCT/TR2024/051207; başvuru 18.10.2024; yayın 24.04.2025; rüçhan TR~2023/013379 \\
    \bottomrule
  \end{tabularx}
  ```
  - "Tür" ve "Numara" sütunları içerikten geniş ("PCT başvurusu" yaklaşık 61 pt = 0,15\textwidth, "WO 2025/085037 A1" yaklaşık 87 pt = 0,21\textwidth). Daraltma ve `@{}` ile üçüncü sütun yaklaşık 206 pt'den 241 pt'ye çıkar.
  - `~` bağları numaraların ve "Bülten 2025/2"nin satır sonunda bölünmesini önler.
  - `@{}` Tablo 8.1 ve 8.2 ile kenar hizasını eşitler (bugün yazı çizgilerden 5,4 pt içeride, D-3).
  - Sayı ve tarihlere dokunulmadı.

### Orta

**O-1. Tablo 8.1 gövde boyutunda ve 1,5 satır aralığında; tablo gereksiz uzun ve dar.** [LaTeX]
- `longtable` yüzer ortam olmadığı için şablonun tablo ayarlarını almıyor: hücreler 12 bp ve `\birbucuksatir` (20,7 bp) ile diziliyor, PDF'te satır adımı 20,7–21,7 pt. Tablo 8.2 ve 8.3 ile Bölüm 2 ve 3'teki üç `longtable` 10 bp / 11,5 pt.
- Sonuç: tablo yaklaşık 1,3 sayfa tutuyor. s. 141'e yalnız AS1 sığıyor; AS2–AS4 s. 142'yi 522 pt dolduruyor. Satır 1–4 arasında ek boşluk yok (AS2 son satırı → AS3 ilk satırı 20,7 pt, hücre içi adımla aynı).
- Genişlikler toplamı 0,86\textwidth + 6 × 6 bp = 385,8 pt; metin alanı 411,1 pt. Tablo ortalı olduğu için iki yanda 12,6 pt içeride; Tablo 8.2 ve 8.3 tam genişlikte.
- Düzeltme (satır 10), Bölüm 3'teki `tab:sistem-parametreleri` yöntemiyle:
  ```latex
  \begingroup
  \setlength{\tabcolsep}{3pt}
  \begin{longtable}{@{}>{\footnotesize\raggedright\arraybackslash}p{0.06\textwidth}%
                       >{\footnotesize\raggedright\arraybackslash}p{0.25\textwidth}%
                       >{\footnotesize\raggedright\arraybackslash}p{0.32\textwidth}%
                       >{\footnotesize\raggedright\arraybackslash}p{0.32\textwidth}@{}}
  ...
    AS1 & ... \\ \addlinespace
    AS2 & ... \\ \addlinespace
    AS3 & ... \\ \addlinespace
    AS4 & ... \\
  \end{longtable}
  \endgroup
  ```
  Genişlik 0,95 × 411,1 + 18 = 408,5 pt. Tahmini yükseklik yaklaşık 25 satır × 11,5 pt + başlık ≈ 350 pt (bugün yaklaşık 750 pt). Tablo büyük olasılıkla AS2 ya da AS3'ten sonra bölünür.
- **Not:** Bu değişiklik bölümün geri kalanını yaklaşık yarım sayfa yukarı kaydırır. Y-1'deki boşluk ölçümü bundan sonra yapılmalıdır. Sıra: O-1 → Y-2 → derleme → Y-1 kararı.

**O-2. Tablo 8.1 devam başlığı "(devam)"; tezin öteki uzun tabloları "(devamı)".** [LaTeX]
- `02-literatur.tex` satır 337, `03-sistem-model-metodoloji.tex` satır 452 ve 622: "(devamı)". Satır 17: `\caption[]{Araştırma sorusu--kanıt--sonuç matrisi (devamı).}\\`
- Devam sayfasında başlık satırı ve altyazı doğru tekrarlanıyor; `\endfoot` her sayfayı `\bottomrule` ile kapatıyor. Sayfa bölünmesi satır sınırında, hücre ortasında bölünme yok.

**O-3. Tablo 8.1 hücresinde ve gövdede `\ref` sonrası ek hataları.** [LaTeX]
- `chap:sistem` = 3, `chap:anahtarlama` = 4, `tab:katki-yontem-kanit` = 8.2 basılıyor. Ekler sabit yazıldığı için ünlü uyumu bozuk:
  - Satır 24 (Tablo 8.1, AS1) ve satır 30: `Bölüm~\ref{chap:sistem}'deki` → `'teki` ("3'teki"); `Bölüm~\ref{chap:anahtarlama}'daki` → `'teki` ("4'teki").
  - Satır 76: `Tablo~\ref{tab:katki-yontem-kanit}'te` → `'de` ("8.2'de").
- Doğru olanlar: `chap:gttipi}'deki` (7'deki), `tab:fikri-mulkiyet}'te` (8.3'te), Bölüm 4 satır 4 `chap:sistem}'te`.

**O-4. Tablo 8.1 AS4 satırında "mod"; Bölüm 7 ve Tablo 8.2 "kip" diyor.** [LaTeX]
- Satır 27: "çalışma modu ve doğrulama tabloları" ve "tasarım tanımı (çalışma modları, güvenli kip geçişi)". Aynı hücrede "mod" ile "kip" yan yana. Bölüm 7'de "mod" hiç geçmiyor; anılan tablonun altyazısı "GT-tipi mimarinin önerilen çalışma kipleri ve geçiş koşulları" (07 satır 146). Tablo 8.2 satır 63 da "çalışma kipleri".
- Düzeltme: "çalışma kipi ve doğrulama tabloları", "(çalışma kipleri, güvenli kip geçişi)".

**O-5. Tablo 8.2 hücre içi kırılmalar ve dördüncü sütun biçimi.** [LaTeX]
- Satır 62: "geliştirilmiş T-/tipi dönüştürücü" satır sonunda tireden bölünüyor. Tez başlığı aynı sorunu `\mbox{T-TİPİ}` ile çözmüş (`tez.tex` satır 11). Düzeltme: `geliştirilmiş \mbox{T-tipi} dönüştürücü`.
- Satır 52: birinci sütunda "susturma (``düşük" ile "performansını" arasında "güç" tek başına bir satırda kalıyor (sütun 70 pt, "performansını" sığmıyor). Sütun 0,17'de kalırsa kaçınılmaz; Y-1'deki genişliklerde birinci sütun bilerek daraltılmadı. Kabul edilebilir.
- Satır 53: "senkron-/buck" açık tireden bölünüyor. Kabul edilebilir; istenirse `\mbox{senkron-buck}`.
- Dördüncü sütun ("Kanıtın yeri ve türü") iki bilgiyi aynı akışta veriyor: "…Tablo 5.2. Mekanizma doğrulanmış, … aynı yönde". Yer listesi noktayla bitiyor, tür cümlesi noktasız. Üçüncü sütun hücreleri noktayla, birinci ve ikinci sütun noktasız bitiyor. Düzeltme: yer listesinden sonra `\newline`, tür bölümünün sonuna nokta (üçüncü sütun gibi tam cümleler):
  - Satır 55: `… Tablo~\ref{tab:s4-tarama}.\newline Mekanizma doğrulanmış, verim kazancı deney ve benzetimde aynı yönde.`
  - Satır 60: `… \ref{tab:kararlilik-marjlar}.\newline Düşük güçte deney ve kalibre edilmiş benzetim, … zaman alanı incelemesi.`
  - Satır 65: `Bölüm~\ref{chap:gttipi}.\newline GT-tipi deney düzeneği, evirici kipinde düşük güç deneyi, şarj yönünde benzetim kaydı.`
  - PDF'te satır 1 ve 2'de tür bölümü zaten yeni satırda başlıyor; satır 3'te bir satır eklenir (hücre 6 → 7 satır, satır yüksekliği 9 satır olduğu için tablo uzamaz).
- İsteğe bağlı kısaltma (Y-1'e yardım eder, sayı değişmez): satır 59'da "kararlılık marjları" art arda iki cümlede geçiyor ("…çevrimin kararlılık marjlarını korumaktadır. Analog eşdeğer çevrimin kararlılık marjları yeterlidir (faz marjı $54^{\circ}$, kazanç marjı \SI{35}{\decibel})."). Tek cümle yaklaşık 2 satır kazandırır: "Sin\textsuperscript{3} terimi akım çevriminin dışında kaldığından analog eşdeğer çevrimin kararlılık marjları değişmemektedir (faz marjı \SI{54}{\degree}, kazanç marjı \SI{35}{\decibel})." Metin değişikliği olduğu için yazım kurallarına göre gözden geçirilmeli.

### Düşük

**D-1. "54°" matematik yazı tipinde.** [LaTeX] Satır 34 ve 59'da `$54^{\circ}$` Cambria Math rakamlarıyla basılıyor; yanındaki "35 dB" (`\SI`) Times. `tezpaketleri.sty` satır 14 `mode=text` olduğu için `\SI{54}{\degree}` Times basar. Tez genelinde 93 `^{\circ}` var (85'i Bölüm 5'te); Bölüm 3 ve 6'da birer `\degree` kullanılmış. Genel karar verilmeli; Bölüm 8 için iki değişiklik yeter.

**D-2. Gönderme listelerinin sırası ve biçimi.** [LaTeX]
- Tablo 8.1 AS3 (satır 26): "Tablo 6.12, Şekil 5.2, Tablo 5.2, Tablo 5.4 ve Tablo 5.6" sırasız. Öneri: "Şekil~5.2, Tablo~5.2, 5.4, 5.6 ve 6.12" sırası.
- Tablo 8.2 satır 60: "Alt Bölüm 5.3, 6.10, 5.6, 5.7" → "5.3, 5.6, 5.7, 6.10".
- Tablo 8.2 satır 55: "Alt Bölüm 4.4.1 ve Tablo 6.12, Bölüm 6, Tablo 5.2" ("ve" yanlış yerde) → "Alt Bölüm~4.4.1, Bölüm~6, Tablo~5.2 ve 6.12".
- Tablo 8.1 "Tablo" sözcüğünü her göndermede yineliyor, Tablo 8.2 "Tablo 6.12, 5.4" diye kısaltıyor. Tek biçim seçilmeli.

**D-3. Tablo 8.3'te `@{}` yok.** Yazı çizgilerden 5,4 pt içeride, Tablo 8.1 ve 8.2'de çizgi hizasında. Y-3 kodunda düzeltildi.

**D-4. Patent tablosunda iki numara biçimi.** Bilgi notu; sayılara dokunulmadı.
- "TR 2023 013377 B" patent belgesinin yayın numarası, "TR 2023/013377" (rüçhan) ulusal başvuru numarası. İkisi de resmî biçim, tablo kendi içinde tutarlı ve EK B/EK C altyazılarıyla uyumlu (`ekler.tex` satır 41–49). Ancak başvuru numarası biçimi tabloda yalnız rüçhan olarak geçtiği için okur iki yazımı tutarsızlık sanabilir. Öneri: ulusal satırlarda "Başvuru TR~2023/013377, 19.10.2023; …" (EK B görüntüsünden doğrulanarak) ya da hiçbir şey eklemeden bırakmak.
- Tarihler altı satırda da GG.AA.YYYY, bülten numaraları "2025/2" biçiminde tutarlı. PCT numaraları boşluksuz (PCT/TR2024/051205), WO numaraları boşluklu (WO 2025/085037 A1); ikisi de WIPO yazımı.
- WO 2025/085038 satırında tür kodu A3, yayın tarihi 24.04.2025. WIPO'da A3 arama raporunun sonradan yayımlandığı belgenin kodudur; 24.04.2025'teki ilk yayın A2 olur. Tabloda arama raporu tarihi (03.07.2025) ayrıca verildiği için çelişki yok, ama EK C görüntüsüyle karşılaştırılması önerilir. Değişiklik önerilmiyor.

**D-5. Tablo 8.3 altyazısında "(kaynak: EK B ve EK C)".** Aynı bilgi satır 84'te "(EK B ve EK C)" olarak var. Yalın altyazı kuralına göre çıkarılabilir: `\caption{Tez çalışmasıyla ilişkili fikrî mülkiyet çıktıları.}` Kaynak belirtmek altyazıda olağan bir kullanım olduğu için isteğe bağlı.

**D-6. Tablo 8.1 altyazısı sütun sırasıyla uyuşmuyor.** Altyazı "soru–kanıt–sonuç", sütunlar Soru, Sonuç düzeyi, Başlıca dayanak, Kanıt türü. Öneri: `\caption{Araştırma sorusu--sonuç--kanıt matrisi.}` (devam başlığı da).

**D-7. `longtable` sonrası boşluk kısa.** Alt çizgi → sonraki metin Tablo 8.1'de 20,5 pt, Tablo 8.3'te 26,2 pt. Şablon `table` ortamının sonuna ayar ekliyor (`sauthesis.cls` satır 482), `longtable` ise `\LTpost` (12 pt) kullanıyor. Yaklaşık 6 pt'lik fark gözle zor seçilir. İstenirse longtable'dan sonra `\vspace{6bp}` ya da tez geneli için `\setlength{\LTpost}{18bp}` (Bölüm 2 ve 3'teki longtable'larla birlikte denetlenmeli).

**D-8. "senkron-buck" yazımı.** Bölüm 8'de dört yerde de tireli, Bölüm 3 ve Özet ile aynı. Tez genelinde iki yer tiresiz: `02-literatur.tex` satır 377 ve `04-dusuk-guc-anahtarlama.tex` satır 167 ("senkron buck benzeri"). Bölüm 8 değişmez; o iki yer düzeltilmeli.

**D-9. Tablo 8.2 başlık satırı.** Birinci sütun başlığı "Katkı ve / başlıktaki / karşılığı" 3 satır, öteki başlıklar 1–2 satır. Kısaltma olmadan çözülmez ("başlıktaki karşılığı" sütundan geniş). Kabul edilebilir.

## 3. Sayfa düzeni (eski PDF)

| Basılı s. | Durum |
|---|---|
| 141 | Bölüm açılışı. Tablo 8.1'in yalnız AS1 satırı; sayfa altında yaklaşık 46 pt (%7) boş (AS2 satırı sığmıyor). O-1 ile değişir |
| 142 | Tablo 8.1 devamı (AS2–AS4) ve AS1 paragrafının başı. Taşma yok |
| 143 | Düz metin. Sayfa başında 2 satırlık paragraf sonu ("potansiyeli artmaktadır…") |
| **144** | **4 satır metin ve 8.2 başlığıyla giriş paragrafı; sayfanın %71'i boş (Y-1)** |
| 145 | Tablo 8.2 ve 8.2.1'in başı |
| 146–148 | Düz metin. s. 147'de Tablo 8.3. Sayfa başlarında 2–4 satırlık paragraf sonları, tek satırlık dul ya da yetim satır yok |
| 149 | Bölüm sonu |
| 150 | Boş arka sayfa (`openright`; `sauthesis.cls` satır 159–161, kılavuz 3.5 gereği numaralı). Şablon kuralı, işlem gerekmez |

Tabloların hiçbirinde sağ kenar taşması yok (Tablo 8.2 hücre yazısı en çok 524,4 pt'ye, metin kenarı 524,5 pt'ye kadar). Metin taşmaları ve tek satırlar yeni derlemede yeniden denetlenmelidir; Y-1 ve O-1 sayfa akışını değiştirecektir.

## 4. Biçim tutarlılığı denetiminin sonuçları (sorun çıkmayanlar)

- **Tablo 8.1 "Sonuç düzeyi" sütunu:** dört hücre de "yanıtlandı." ile bitiyor. Öteki iki metin sütununun hücreleri de noktayla bitiyor. Tutarlı.
- **Sayı ve birim:** akım, gerilim, güç ve dB değerleri `\SI` ile (ondalık virgül `output-decimal-marker={,}` ile geliyor). Yüzdeler ve puanlar elle yazılmış ondalık virgülle ("\%92,5", "0,25 puan"), gövde metniyle aynı biçimde. Aralıklar `\num{250}--\SI{280}{\watt}` biçiminde, satır 80'deki `\num{20}--\SI{25}{\kilo\watt}` ile aynı. Tek aykırılık D-1 (`$54^{\circ}$`).
- **Terimler:** "DA bara", "AA güç", "Vienna PFC", "kalibre edilmiş" bölüm içinde tutarlı. "senkron-buck" bölüm içinde tutarlı (D-8 tez geneli). Tek tutarsızlık O-4 (mod/kip).
- **Altyazı–tablo aralığı:** üç tabloda 6,3–6,4 pt, aynı.

## 5. Kaynak gereksinimi özeti

| Gereksinim | Maddeler |
|---|---|
| **Yalnız LaTeX** | Hepsi (Y-1, Y-2, Y-3, O-1 … O-5, D-1 … D-9) |
| **Yeni kaynak** | Yok. D-4'teki ulusal başvuru numarası eklenecekse EK B görüntüsünden doğrulanmalı |

**Önerilen uygulama sırası:**
1. Y-2 (altyazı → satır 40, etiket), Y-3 (patent tablosu), O-2, O-3, O-4, O-5, D-1, D-2 (tek oturum, metin ve tablo).
2. O-1 (Tablo 8.1 küçük yazı ve genişlik).
3. Derleme; s. 144 civarındaki boşluğu yeniden ölçme.
4. Y-1: Tablo 8.2 sayfaya sığmıyorsa `longtable` biçimine geçme (ya da baştan `longtable` yapılıp karar gereksizleştirilir).
5. Derleme sonrası tek satırlar ve taşmalar için Bölüm 8 sayfalarının yeniden taranması.
