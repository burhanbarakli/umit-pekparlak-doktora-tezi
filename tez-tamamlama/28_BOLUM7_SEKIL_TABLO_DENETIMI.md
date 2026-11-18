# Bölüm 7 (GT-tipi mimari) şekil ve tablo denetimi

- **Tarih:** 18.11.2026 (Mac oturumu, bağımsız denetçi ajan)
- **Kip:** yalnız rapor. Kaynak dosyalara dokunulmadı, derleme ve commit yapılmadı.
- **Denetlenen PDF:** `output.pdf` (209 sayfa). Bölüm 7, PDF s. 157–172 (basılı s. 125–140). Bölüm 8 PDF s. 173'te başlıyor.
- **Kaynak:** `yeni_tez/bolumler/07-gt-tipi-mimari.tex` (419 satır). İki TikZ çizimi (Şekil 7.7 ve 7.8) bölüm dosyasının içinde, `sekiller/` altında değil. Görseller `\graphicspath` üzerinden `tez-latex/figures/gt-tipi/`, `tez-latex-v2/figures/gt-tipi/` ve `tez-latex-v2/figures/umit_2026-11-09/` altından geliyor.
- **Yöntem:** PyMuPDF ile her şekil ve tablo sayfası 110 dpi'de, ayrıntılar 200–400 dpi'de işlendi ve gözle incelendi. Gömülü görsellerin etkin çözünürlüğü (piksel / basılı genişlik) ölçüldü. Sayfa sonundaki boşluk ölçüldü. Her `\label` için `\ref` sayıldı. Depoda daha iyi kaynak (EMF, vektör PDF, `.slx`, veri) arandı. Görüntüler: `/private/tmp/claude-501/-Users-bob-CALISMALAR--mit-abi-tez-yazimi-manuel-kontrol-ayakaleaf/1fc9a723-a9bc-4d46-bec5-6e3d30f64760/scratchpad/b7sekil/`.
- **Öncelik ölçeği** (24 numaralı raporla aynı): **Yüksek** jüri okurken hemen görür ya da kural ihlalidir. **Orta** okunurluk ya da düzen sorunudur. **Düşük** kozmetiktir.
- **Etiketler:** **[LaTeX]** yalnız `.tex` değişikliği yeter. **[Yeni kaynak]** özgün çizim dosyası, model ya da veri gerekir. Ümit'e soru sorulmayacağı için (tamamlama kuralı) bu maddeler "kabul et ve karar defterine yaz" seçeneğiyle birlikte verilmiştir.
- **Kaynak taraması sonucu:** Bölüm 7 görsellerinin depoda daha iyi bir sürümü yok. EMF yalnız `deneysel/` altında var. Şarj yönü Simulink modeli ve kayıt verisi `tez-matlab-simulink/` altında yok (oradaki `.slx` dosyalarının hepsi evirici kipine ait). `tez-word` docx'inde bu şekiller yok.

## 1. Şekil ve tablo listesi

dpi = basılı boyuttaki etkin çözünürlük. Yazı boyutları basılı boyutta tahmindir.

| No | Basılı s. | Dosya | dpi | Karar | Kısa not |
|---|---|---|---|---|---|
| Tablo 7.1 | 127 | — | — | OK | Sütunlar zaten `raggedright`, okunuyor. Satırlar birbirine değiyor (bölüm geneli, §3). Tablo s. 126'ya sığmadığı için s. 126'nın %16'sı boş |
| Şekil 7.1 | 127 | `gt-tipi/onceki_tez_6_2_viyana_pfc.jpeg` | 195 | OK (düşük) | Eleman adları (D1_L1, Q3_L1 …) yaklaşık 4,5 pt, okunuyor. Proteus tür etiketleri "DIODE", "IGBT" yaklaşık 3 pt ve İngilizce. "DC+/DC−" yaklaşık 2,5 pt |
| Şekil 7.2 | 128 | `gt-tipi/onceki_tez_6_3_cok_sekonderli_bys.jpeg` | 240 | sorun (düşük) | Okunuyor. Transformatör üstte "TR2", altta "SARJ_TRF_1" diye iki farklı adla etiketli. 2. kol ile N. kol arasında boşluk var, atlanan kolları gösteren "⋮" işareti yok |
| Şekil 7.3 | 128 | `umit_2026-11-09/gt_tipi_ana_topoloji_rl1.jpg` | 156 | OK | Etiketler yaklaşık 5 pt, okunuyor. "NOTR" (Ö'süz), "DC+/DC−" (tezde DA bara) |
| Şekil 7.4 | 129 | `umit_2026-11-09/gt_tipi_evirici_lcl_rl2.jpg` | 159 | **sorun** | **Röle "RL2 / RELAY_2" diye etiketli**; metin, Tablo 7.1–7.2, Şekil 7.3 ve durum makinesi RL1 diyor. Üstünde kırmızı KONTROL kutusu basılı. Giriş ucu "L1" ile bobin "L1" aynı adı taşıyor. Sonrasında sayfanın %24'ü boş |
| Şekil 7.5 | 130 | `gt-tipi/onceki_tez_6_6_iki_seviye_trafo_modu.jpeg` | 157 | OK (düşük) | Q1_L1 … yaklaşık 4 pt, "IGBT" yaklaşık 3 pt. Burada RL1–RL3 üç fazın rölelerini numaralandırıyor; Şekil 7.4'teki "RL2" ile çelişiyor (Y-4) |
| Şekil 7.6 | 130 | `tez-latex-v2/figures/gt-tipi/pfc_modu_q1q3_q2q4.png` (894×573) | 167 | **sorun** | **Etiketler 300 dpi'de bile okunmuyor** (kaynak bozuk: "IGBT" → "IGII", "DIODE" → "DCDE", DC+/DC− seçilmiyor). **Altyazıda açıklama cümlesi var** (Q3/Q4 konumu). Altyazı "NÖTR", şekil "NOTR" |
| Şekil 7.7 | 131 | TikZ (satır 99–133) | vektör | **sorun** | **Kesikli "RL1 kip seçimi → Vienna PFC" çizgisi "Batarya grupları" kutusunun ve yazısının içinden geçiyor.** Kutulardaki iki satır birbirine değiyor. Deşarjda batarya → DA bara yolu çizilmemiş. Şekil, ilk göndermeden önce basılıyor |
| Tablo 7.2 | 132 | — | — | sorun | `p` sütunları iki yana yaslı: "Ön    şarj    /    öz", "PFC–DA      bara–Q₁–Q₂". Satırlar birbirine değiyor |
| Şekil 7.8 | 133 | TikZ (satır 201–236) | vektör | **sorun** | **Ön şarj → Kilitli hata çizgisi "Şarj PFC + CC/CV" kutusunun ve "CC/CV" yazısının içinden geçiyor.** Geçiş etiketleri ("ölçüm ve geri bildirim uygun", iki "akım sıfıra yakın") kutuların üzerine biniyor. Ön şarj → hata ile hata → Güvenli kapalı okları aynı yatay çizgiyi paylaşıyor. "enerji kesme ve yetkili sıfırlama" etiketi sol alt köşede kopuk duruyor |
| Tablo 7.3 | 134 | — | — | sorun | İki yana yaslı dar hücreler: "Faz/batarya        aşırı", "İlgili   buck   kolunun". "watchdog" İngilizce. Tablo ilk göndermeden önce basılıyor (aynı sayfa, kabul edilebilir) |
| Şekil 7.9 | 135 | `gt-tipi/onceki_tez_6_8_simulink_modeli.png` (1358×609) | 243 | **sorun** | Simulink ekran görüntüsü. Blok adları yaklaşık 1,5 pt, bölge başlıkları ("ŞEBEKE", "PFC KONTROL DEVRESİ") yaklaşık 2,5 pt; **hiçbiri okunmuyor**. Pencere çerçevesi duruyor ("Ready", "60%", sol araç çubuğu) |
| Şekil 7.10 | 135 | `gt-tipi/onceki_tez_6_9_pfc_sebeke_akimlari.jpeg` (1271×509) | 232 | **sorun** | Scope ekranı. Eksen rakamları yaklaşık 2 pt, **okunmuyor**; eksen adı yok. İngilizce pencere ("Scope3", "File Tools View Simulation Help"). Ondalık nokta. Gösterge yok. Sonrasında s. 135'in %26'sı boş |
| Şekil 7.11 | 136 | `gt-tipi/onceki_tez_6_10_da_bara_gerilimleri.png` (1217×519) | 222 | **sorun** | Rakamlar yaklaşık 2,4 pt, okunmuyor. **Görüntünün sağ yaklaşık %20'si boş beyaz şerit**, pencere metin alanında yaklaşık 19 mm sola kaymış. İki eğri (kırmızı, camgöbeği) göstergesiz. Scope başlığı tekil "DA bara gerilimi", altyazı çoğul |
| Şekil 7.12 | 136 | `6_11_primer_gerilim.png`, `6_12_primer_akim.png` | 333 / 250 | sorun | Rakamlar yaklaşık 4 pt (sınırda). İngilizce pencere çerçevesi. (a) scope başlığının son ")" işareti simgenin altında. (b) scope başlığında yazım hatası "tranformatörün". (a) zaman ekseni 0–2,5×10⁻⁴ (offset 0,4), (b) 0,39965–0,4; pencereler farklı uzunlukta |
| Şekil 7.13 | 137 | `6_13_sekonder_gerilim.png`, `6_14_sekonder_akim.png` | 297 / 260 | sorun (düşük) | (a) rakamları yaklaşık 3 pt ve sıkışık. (a) ile (b) farklı arayüz ölçeğinde çekilmiş, üst kenarlar 7 pt kayık, (b)'de pencere gölgesi var |
| Şekil 7.14 | 137 | `gt-tipi/onceki_tez_6_15_batarya_soc.jpeg` (711×546) | 156 | **sorun** | MATLAB "Figure 1" penceresi, İngilizce menüler. Veri imleçleri ondalık noktalı ("X 0.225056 Y 61.3154"). **Batarya akımı −9,96 A**, oysa metin (satır 181) "akım işareti şarj yönünde pozitif" diyor. SoC 0,4 s boyunca düz (%61,3). Tek y ekseninde %, V ve A birimsiz karışık. "SOC" ↔ metinde "SoC" |
| Tablo 7.4 | 138 | — | — | **sorun** | `\footnotesize`, iki yana yaslı dar sütunlar, büyük boşluklar ("Dizi    veya    modül", "Birçok          yapıda"). Birinci sütunun bazı hücrelerinde satır aralığı öteki hücrelerden büyük ("Arızalı birimi / ayırma"). "bypass" İngilizce |
| Tablo 7.5 | 139 | — | — | sorun | Aynı sorun: "PFC      akımı,      DA      bara,", "Aşırı          akım/gerilim/sıcaklık". Üçüncü sütun hücreleri noktayla bitiyor, öteki sütunlar bitmiyor |

Sayım: 14 şekil, 5 tablo. 5 tanesi OK ya da yalnız düşük notlu, 14 tanesinde sorun var. Kalın "sorun" olanlar (Şekil 7.4, 7.6, 7.7, 7.8, 7.9, 7.10, 7.11, 7.14 ve Tablo 7.4) Yüksek ya da Orta maddelere girer.

Gönderme sayımı: bütün şekil ve tablolara metinde gönderme var. Alt şekil etiketleri `fig:gt-sekonder-gerilim/akim` ve üst etiket `fig:gt-primer` anılmıyor, ama karşılık gelen üst ya da alt etiket anıldığı için sorun değil.

## 2. Sorunlar ve düzeltmeler (öncelik sırasıyla)

### Yüksek

**Y-1. Şekil 7.8 (durum makinesi): çizgi kutunun içinden geçiyor, etiketler kutulara biniyor.** [LaTeX]
Nedenler:
- `charge` düğümü `below left=of ready` ile tam `pre` sütununun altına düşüyor. Satır 228'deki `\draw[arr] (pre) |- (fault);` dikey kolu "Şarj PFC + CC/CV" kutusunun ortasından geçiyor ve "CC/CV" yazısını kesiyor.
- Sütun aralığı 13 mm, ama "ölçüm ve geri bildirim uygun" ve "akım sıfıra yakın" etiketleri bundan geniş. Etiketler komşu kutuların kenarına biniyor.
- Satır 228 ve 232'deki iki ok `fault` düğümünün batısında aynı yatay doğruyu kullanıyor; hangi okun nereye gittiği okunmuyor.
- `scale=0.95, transform shape` bütün yazıyı küçültüyor.

Önerilen yeniden yerleşim (derlenip denetlenmeli):
```latex
\begin{tikzpicture}[
  node distance=12mm and 13mm,
  state/.style={draw,rounded corners,align=center,text width=22mm,
                minimum height=10mm,fill=blue!5,font=\small},
  safe/.style={state,fill=green!10},
  fault/.style={state,fill=red!8},
  arr/.style={-{Latex[length=2mm]},thick},
  guard/.style={font=\scriptsize,align=center,fill=white,inner sep=1pt}
]
  \node[safe] (off) {Güvenli kapalı};
  \node[state,right=of off] (pre) {Ön şarj ve\\öz sınama};
  \node[state,right=of pre] (ready) {Hazır};
  \node[state,below=14mm of ready] (reconf) {RL1\\kip geçişi};
  \node[state,left=of reconf] (charge) {Şarj\\PFC + CC/CV};
  \node[state,right=of reconf] (dis) {Deşarj\\evirici kipi};
  \node[fault,below=16mm of reconf] (fault) {Kilitli hata};

  \draw[arr] (off) -- node[above,guard]{başlat} (pre);
  \draw[arr] (pre) -- node[above,guard]{uygun} (ready);
  \draw[arr] (ready) -- node[guard,sloped,above]{şarj izni} (charge);
  \draw[arr] (ready) -- node[guard,sloped,above]{şebeke hazır} (dis);
  \draw[arr] (charge) -- node[above,guard]{$i\approx 0$} (reconf);
  \draw[arr] (dis) -- node[above,guard]{$i\approx 0$} (reconf);
  \draw[arr] (reconf) -- node[right,guard]{röle\\doğrulandı} (ready);
  % Ön şarj -> hata: charge kutusunun solundan dolaşır
  \draw[arr] ([yshift=-3mm]pre.west) -- ++(-5mm,0) |- (fault.west);
  \draw[arr] (charge) -- (fault);
  \draw[arr] (dis) -- (fault);
  \draw[arr] (reconf) -- (fault);
  % Hata -> güvenli kapalı: ayrı bir alt yol
  \draw[arr] (fault.south) -- ++(0,-5mm) -| node[pos=0.75,left,guard]
        {enerji kesme ve\\yetkili sıfırlama} (off.south);
\end{tikzpicture}
```
- Genişlik yaklaşık 4 × 24,4 + 3 × 13 ≈ 137 mm, metin alanı yaklaşık 145 mm; `scale` gerekmez.
- "ölçüm ve geri bildirim uygun" yerine "uygun", "akım sıfıra yakın" yerine $i\approx 0$ yazıldı. Tam koşul Eşitlik 7.3'te ve metinde zaten var. Uzun biçim istenirse etiketler `below` konup sütun aralığı 16 mm yapılır, kutular `text width=20mm` olur.
- İsteğe bağlı içerik: olağan kapatma için `Hazır → Güvenli kapalı` oku yok. Eklenirse `(ready.north) -- ++(0,5mm) -| (off.north)` yolu başka çizgiyle kesişmez.

**Y-2. Şekil 7.7 (enerji ve denetim katmanları): kesikli çizgi kutunun içinden geçiyor.** [LaTeX]
- `battery` düğümü `pfc` ile aynı sütunda. Satır 127'deki `\draw[signal] (ems) -| (pfc);` dikey kolu "Batarya grupları" kutusunun ortasından geçiyor. Düzeltme, çizgiyi sütun arasındaki 9 mm'lik boşluktan dolaştırmak:
  ```latex
  \draw[signal] (ems.west) -| ([xshift=-4.5mm]battery.west)
                |- ([yshift=-4mm]pfc.south) -- (pfc.south);
  ```
- Kutulardaki iki satır birbirine değiyor; "Batarya başına / doğrultucu–buck" ve "Çok sekonderli / BYS trafoları" satırlarında ş ve ç çengelleri alt satıra dokunuyor. Düzeltme: üç biçime `execute at begin node={\setlength{\baselineskip}{1.15em}}` eklenmesi (ya da `\\[1pt]`).
- **İçerik:** satır 97 "Deşarjda ise enerji, ortak DA bara ve T-tipi evirici üzerinden şebekeye aktarılmaktadır" diyor, ama şekilde bataryadan DA baraya bir yol yok; "deşarj" oku DA baradan başlıyor. Öneri: sütun boşluğundan, mevcut çizgilerle kesişmeyen bir ok:
  ```latex
  \draw[flow] ([yshift=3mm]battery.east) -- ++(4.5mm,0)
              |- node[pos=0.25,left,font=\scriptsize]{deşarj} ([yshift=-3mm]dc.west);
  ```
  Bu okun dikey kolu `pfc → dc` okunun altında biter, kesişme olmaz. Mimari doğru değilse (bataryalar deşarjda başka yoldan bağlanıyorsa) satır 97 düzeltilir.
- Şekil satır 99'da basılıyor, ilk gönderme satır 135'te. Satır 135'in ilk cümlesi şekilden önceki paragrafın sonuna taşınabilir (D-6).

**Y-3. Şekil 7.6: altyazıda açıklama var ve etiketler okunmuyor.** [LaTeX] + [Yeni kaynak]
- Proje kuralı (altyazı yalnız ne gösterildiğini söyler) ihlal ediliyor. Altyazı: "Nötr IGBT gruplarıyla oluşturulan üç fazlı PFC bölümü." İkinci cümle satır 88'deki paragrafa taşınır: "Her fazda $Q_4$ DA bara orta noktası (şekilde NOTR) tarafındaki, $Q_3$ ise faz düğümü tarafındaki nötr IGBT'dir." Böylece "NÖTR" ↔ "NOTR" çelişkisi de giderilir.
- Kaynak görüntü (894×573) bozuk bir ara kopya; `onceki_tez_6_7_pfc_modu.jpeg` ile aynı boyutta, etiketler yeniden yazılmış. Etiket bölgesinde 300 dpi'de bile "IGII", "DCDE" görülüyor; DC+/DC−, L1–L3, N uçları seçilmiyor. Üç seçenek:
  - (a) [Yeni kaynak] Proteus'tan vektör PDF dışa aktarımı. Aynı Proteus projesinden Bölüm 3 için `tam_topoloji_notr_q1q3_q2q4.pdf` ve `tam_topoloji_faz1_hucresi.pdf` vektör olarak alınmış; bu şekil için de yapılabilir.
  - (b) [LaTeX] Görüntünün üstüne beyaz zeminli TikZ etiketleri (`\node[anchor=south west,inner sep=0] (img) {\includegraphics…};` ve `\begin{scope}[x={(img.south east)},y={(img.north west)}]`). Bozuk etiketler (D1_L1 … D2_L3, Q4_L1 … Q3_L3, L1_L1 …, C_L1 …, uçlar) okunur biçimde yeniden yazılır, "DIODE/IGBT" tür etiketleri örtülür, "DC±" yerine "DA±", "NOTR" yerine "NÖTR" yazılabilir.
  - (c) [LaTeX] `circuitikz` ile yeniden çizim. Şekil 7.1 ile Şekil 7.4'ün birleşimi olduğu için yük orta düzeydedir.
  - Öneri: (b). Soru sorulmayacağı için (a) için bekleme yapılmaz.

**Y-4. Şekil 7.4 röle adı RL2; metin RL1 diyor.** [LaTeX], içerik kararı
- Şekilde röle "RL2 / RELAY_2" diye etiketli, Şekil 7.3'te aynı konumdaki röle "RL1". Şekil 7.5'te RL1–RL3 üç fazın rölelerini numaralandırıyor. Bölüm 3'teki faz hücresi altyazısı (03 satır 39) ise bir hücrede "kip değişim röleleri RL1–RL2" diyor. Okur üç farklı adlandırma görüyor. Satır 70'teki `\kirmizinot` bu sorunu zaten kaydetmiş ve PDF'te kırmızı kutu olarak basılı.
- Düzeltme seçenekleri: (i) satır 69'a RL2'nin görevini tanımlayan bir cümle (faz hücresindeki ikinci röle olarak, Bölüm 3'teki faz hücresi şekline göndermeyle), ve satır 79'a "Şekil 7.5'teki RL1–RL3, üç fazın kip rölelerini göstermektedir" cümlesi; (ii) RL2 tek başına bir işlev taşımıyorsa satır 69'daki "RL1 ve RL2" ifadesi "röle" yapılır. Karar verilince `\kirmizinot` kaldırılır.
- Aynı şekilde giriş ucu "L1" (faz) ile filtre bobini "L1" aynı adı taşıyor. Etiket düzeltmesi Y-3 (b)'deki gibi yerleşik TikZ etiketiyle yapılabilir; yapılmazsa metinde "giriş ucundaki L1 faz adıdır" denmez, kabul edilir (düşük).

**Y-5. Benzetim ekranlarının (Şekil 7.9–7.14) rakamları okunmuyor, pencere çerçeveleri İngilizce.** [LaTeX] + [Yeni kaynak]
Metin bu şekillerde sayısal değer okumuyor ("nitel olarak göstermektedir", satır 348). Bu nedenle jüri riski Bölüm 6'daki PC ekranlarından düşüktür, ama eksenleri okunmayan bir dalga biçimi kanıt olarak zayıf görünür. Adım adım:
1. **[LaTeX] Pencere çerçevesini kırpmak (hepsi için).** `\includegraphics[trim=… ,clip]` ile başlık çubuğu, menü, araç çubuğu ve durum çubuğu atılır. Yaklaşık değerler: 7.10 üstten %10; 7.11 üstten %12, **sağdan %20** (boş beyaz şerit), 7.12 ve 7.13 üstten %17, alttan %5; 7.14 üstten %18; 7.9 üstten %3, soldan %3, alttan %3. Kazanç: İngilizce menüler, "Scope3", iki farklı "Scope2" adı (7.11 ve 7.12 (b)), "Ready", "Sample based" yazıları kalkar; çizim alanı aynı genişlikte %10–20 büyür; 7.11 ortalanır.
2. **[LaTeX] 7.10 ve 7.11 için eksenleri yeniden yazmak.** Kırpma rakamları yalnız yaklaşık 2,5 pt'ye çıkarır, yetmez. `pgfplots` ile `\addplot graphics[xmin=0,xmax=0.2,ymin=-40,ymax=40]{…}` (7.10) kullanılır; görüntü tam eksen kutusuna kırpılır, pgfplots Türkçe eksen adlarını ("Zaman (s)", "Akım (A)", "Gerilim (V)") ve virgüllü rakamları (`/pgf/number format/use comma`) normal boyutta çizer. Eksen aralıkları kaynak görüntüden okunabiliyor: 7.10 x 0–0,2 s, y −40…40 A; 7.11 x 0–0,2 s, y alt sınırı yaklaşık −40 V, üst sınırı etiketsiz (yaklaşık 390 V), uygulamada piksel ölçümüyle kesinleştirilmeli. İsteğe bağlı: renkler için gösterge (7.10'da üç faz, 7.11'de üst ve alt yarı).
3. 7.12 ve 7.13 için kırpma sonrası rakamlar yaklaşık 4,5 pt olur; kabul edilebilir. İstenirse aynı `\addplot graphics` yöntemi uygulanır.
4. **Şekil 7.9 Simulink modeli:** kaynak pikseli yetmediği için (bölge başlıkları kaynakta yaklaşık 8 piksel) hiçbir ölçekte okunmaz. [LaTeX] seçenek: görüntünün üstüne 7 pt'lik Türkçe bölge etiketleri (Şebeke, Filtre, Köprü doğrultucu, PFC devresi, DA bara, PFC denetimi, Batarya akım–gerilim denetimi 1–3, Transformatör–DA/DA dönüştürücü–batarya 1–3) yerleşik TikZ düğümleriyle konur. Metin (satır 268) yalnız alt sistemlerin aynı modelde bulunduğunu söylediğinden bu yeterlidir. [Yeni kaynak] seçenek: Simulink'ten vektör dışa aktarım (`print -s… -dpdf`); model depoda yok.
5. **[Yeni kaynak], en iyi çözüm:** şarj modelinin yeniden koşturulup verinin `pgfplots` ya da `exportgraphics` ile Türkçe etiketli çizilmesi. Model ve veri depoda yok; soru sorulmayacağı için 1–4 uygulanıp bu madde K kaydına "kabul" olarak yazılmalı.

**Y-6. Şekil 7.14: akım işareti metinle çelişiyor.** [LaTeX]
- Ekrandaki batarya akımı −9,96 A. Satır 181 "Akım işareti şarj yönünde pozitif seçilmiştir" diyor. Simulink batarya bloğunda deşarj yönü pozitiftir, yani şekildeki negatif akım şarjı gösterir; ama okur bunu metinden çıkaramaz. SoC 0,4 s boyunca %61,3'te düz görünüyor, şarj gözle görülmüyor.
- Düzeltme (altyazıya değil, satır 339 paragrafına): "Simulink batarya modelinde akım deşarj yönünde pozitif olduğundan şarj akımı yaklaşık −10 A olarak görünmektedir. 0,4 s'lik kayıtta SoC değişimi ekran çözünürlüğünün altındadır." Ayrıca uç geriliminin yaklaşık 3,46 V olması (hücre düzeyi model) bir yan cümleyle söylenmeli; yoksa jüri 20 kW'lık sistemde 3,5 V'luk "batarya"yı sorar.
- Ekrandaki "SOC" etiketi görüntünün parçası; metinde "SoC" kalır. Veri imleçlerindeki ondalık nokta ve İngilizce "Figure 1" menüleri: menüler Y-5 adım 1 ile kırpılır, imleçler kabul edilir (§4).

### Orta

**O-1. Tablo 7.2–7.5: iki yana yaslı dar sütunlar.** [LaTeX]
`p{…}` sütunları iki yana yaslı olduğundan dar hücrelerde sözcükler arasında büyük boşluklar oluşuyor. Tablo 7.1 zaten `raggedright` ve temiz görünüyor. Şablonun hazır `L{}` türü (`sauthesis.cls` satır 478: `\teksatir\raggedright`) kullanılmalı:
- Tablo 7.2 (satır 147): `{@{}L{0.17\textwidth}L{0.31\textwidth}>{\teksatir\raggedright\arraybackslash}X@{}}`
- Tablo 7.3 (satır 245): `{@{}L{0.20\textwidth}L{0.33\textwidth}>{\teksatir\raggedright\arraybackslash}X@{}}`
- Tablo 7.4 (satır 361): `{@{}L{0.14\textwidth}L{0.24\textwidth}L{0.26\textwidth}>{\teksatir\raggedright\arraybackslash}X@{}}`. Birinci sütun ("Ölçüt") şu an gereğinden geniş, öteki üçü sıkışık. `\teksatir` birinci sütundaki tutarsız satır aralığını ("Arızalı birimi / ayırma", "Yarı / iletken/kontrol / yükü") da giderir. `\footnotesize` yerine `\small` denenebilir; tablo aynı sayfada kalırsa okunurluk artar.
- Tablo 7.5 (satır 390): `{@{}L{0.20\textwidth}L{0.38\textwidth}>{\teksatir\raggedright\arraybackslash}X@{}}`. Üçüncü sütunun hücre sonlarındaki noktalar kaldırılmalı (öteki sütunlar ve Tablo 7.1, 7.3, 7.4 noktasız). Aynı tutarsızlık Tablo 7.2'nin üçüncü sütununda da var.

**O-2. Bölümde yaklaşık 0,8 sayfalık boşluk.** [LaTeX]
| Basılı s. | 126 | 127 | 129 | 135 |
|---|---|---|---|---|
| Boş | %16 | %12 | %24 | %26 |

Nedenleri: s. 126'da Tablo 7.1, s. 127'de Şekil 7.2, s. 129'da Şekil 7.5, s. 135'te Şekil 7.11 `[H]` yüzünden sonraki sayfaya itiliyor. Düzeltme (yerleşim şablon gereği `[H]` kalır):
- Y-5 adım 1'deki kırpma 7.10 ve 7.11'i yaklaşık %12–20 kısaltır; büyük olasılıkla ikisi s. 135'e birlikte sığar.
- Şekil 7.2 `width=0.60\textwidth` (şu an 0.67) yapılırsa s. 127'ye sığabilir; etiketler yaklaşık 3,5 pt'ye iner, hâlâ okunur.
- Şekil 7.5 için `width=0.82\textwidth` (şu an 0.88) denenebilir.
- Değişikliklerden sonra derlenip boşluklar yeniden ölçülmelidir.

**O-3. Şekil 7.11: boş şerit ve eksik değer.** [LaTeX]
- Görüntünün sağ yaklaşık %20'si boş, pencere sola kaymış (Y-5 adım 1: `trim=0 0 <%20> 0, clip`).
- Metin (satır 286) "birbirine yakın bir çalışma bandına" diyor ama değer vermiyor. Ekrandan iki yarı geriliminin yaklaşık 225 V'ta oturduğu ve başlangıçta yaklaşık 290 V'a çıktığı okunuyor. Satır 286'ya "üst ve alt yarı gerilimleri yaklaşık \SI{225}{\volt} çevresinde oturmaktadır" eklenmeli. Bu değerin Tablo 3.4'teki DA bara gerilimiyle tutarlılığı kontrol edilmeli (jüri sorusu).

**O-4. Şekil 7.12 (b) scope başlığında yazım hatası ve (a) başlığında kesik parantez.** [Yeni kaynak], kabul önerilir
- "tranformatörün" yazım hatası ve ")" üzerine binen simge görüntünün içinde. Y-5 adım 2'deki gibi eksenler yeniden yazılırsa scope başlıkları da kırpılır, sorun ortadan kalkar. Yapılmazsa kabul edilip K kaydına yazılır.
- (a) ile (b) farklı zaman pencereleri gösteriyor (0,25 ms ↔ 0,35 ms; (a) göreli, (b) mutlak zaman). Metin karşılaştırma yapmadığından sorun değil; eksenler yeniden yazılırsa ikisi de aynı göreli zamanla etiketlenmeli.

### Düşük

**D-1. Şekil 7.2 etiketleri.** [LaTeX] Aynı transformatör "TR2" ve "SARJ_TRF_1" adlarını taşıyor; Şekil 7.5'te transformatörler TR1–TR3. 2. kol ile N. kol arasına "⋮" konmalı. İkisi de yerleşik TikZ etiketiyle yapılabilir (TR2'nin üstüne beyaz zeminli "TR", SARJ_TRF_1'in üstüne boş beyaz kutu, arada `$\vdots$`).

**D-2. Şekil 7.13 görünüm birliği.** [LaTeX] (a) ve (b) farklı arayüz ölçeğinde. Y-5 adım 1'deki kırpmayla pencere gölgesi ve 7 pt'lik üst kenar kayması kaybolur; iki alt şekle `height=` ile aynı yükseklik verilmeli.

**D-3. Şekil 7.13 içerik notu.** Scope başlıkları "(kontrol öncesi)", metin (satır 317) "doğrultma öncesi" diyor. Akım tek yönlü (0–8 A); Şekil 7.2'deki orta uçlu sekonder ve iki diyotla tutarlı. Metin "buck denetimi öncesi" diye düzeltilirse ekranla birebir uyuşur. Jüri sorusu notu olarak da bırakılabilir.

**D-4. Şekil 7.9 içerik notu.** Model ekranında "KÖPRÜ DOĞRULTUCU" ve ayrı "PFC DEVRESİ" blokları var; Şekil 7.1 ve 7.6'daki Vienna yapısıyla görsel olarak eşleşmiyor. Etiketler okunmadığı için jüri büyük olasılıkla fark etmez; fark ederse modelin Vienna davranışını diyot köprüsü ve çift yönlü anahtar grubuyla kurduğu söylenmeli. Gerekirse `\umitnot` olarak eklenir.

**D-5. Şekillerdeki İngilizce ve terim farkları.** "DC+/DC−" (Şekil 7.1, 7.3–7.6; tezde "DA bara"), "DIODE", "RELAY_2", "NOTR". Şekil 7.6 için Y-3 (b) yapılırsa orada düzeltilir. Öteki çizimler okunur olduğundan Proteus çıktısı olarak bırakılabilir (§4).

**D-6. Yüzer nesneler ilk göndermeden önce.** Şekil 7.7 (satır 99 / 135), Şekil 7.8 (201 / 238), Tablo 7.3 (240 / 261), Tablo 7.4 (356 / 376) metinde ilk anılmadan önce basılıyor. Hepsi göndermeyle aynı sayfada; kabul edilebilir. Düzeltilmek istenirse gönderme cümlesi yüzer nesneden önceki paragrafa alınır (Şekil 7.7 için satır 135'in ilk cümlesi satır 97'nin sonuna).

**D-7. Tablo 7.3 ve 7.4'te İngilizce terimler.** "watchdog" → "bekçi zamanlayıcı (watchdog)" ilk geçişte; "bypass olanağı" → "devre dışı bırakma (bypass) olanağı".

**D-8. Tablo 7.4 altyazısı** iki satıra kırılıyor ve şablonun asılı iki yana yaslı biçiminde ilk satır geriliyor. Öneri: "GT-tipi mimarinin geleneksel ve yeniden yapılandırılabilir EDS yaklaşımlarıyla nitel karşılaştırması." ("literatürdeki" sütun başlığında zaten var.)

**D-9. Alt yazı biçimi.** Bölüm 7'nin alt şekil yazıları noktasız ("(a) Primer sargı gerilimi"); Bölüm 3 ve 4 de noktasız. Bölüm 6'daki alt yazılar ise noktalı ("Panodaki AcuDC240."). Tez genelinde tek biçim seçilmeli; çoğunluk noktasız olduğundan Bölüm 6 düzeltilmeli.

## 3. Bölüm genelini aşan bulgular (24 numaralı raporun §3'üyle aynı)

1. **`\SI{20}{\kilo\volt\ampere}` "20 kV A" diye basılıyor** (s. 125, 126, 139). Doğrusu "20 kVA". Bölüm 6'daki "5 V A" ile aynı `siunitx` ayarı sorunu; `inter-unit-product` ya da `\SI{20}{kVA}` ile genel olarak çözülmeli.
2. **Tablo satır yüksekliği.** Tablo 7.1–7.5'te satırlar birbirine değiyor. Şablonun `\Ts` desteği ya da yerel `\renewcommand\arraystretch{1.15}` (24 §3-2).
3. **İki yana yaslı `p` sütunları** bütün tezde aynı sorunu doğuruyor (Bölüm 6'da Tablo 6.6–6.8, burada Tablo 7.2–7.5). Tez genelinde `p{}` → `L{}` taraması yapılması önerilir.
4. **`\kirmizinot` kutuları basılıyor** (s. 129). Son derlemede `\kirmizinotlarfalse` gerekecek; ama `tezpaketleri.sty` satır 88'in uyardığı gibi, önce not çözülmeli (Y-4).

## 4. Bilerek bırakılması önerilenler

- **Proteus çizimlerindeki (Şekil 7.1–7.5) eleman adları ve "IGBT/DIODE" tür etiketleri:** okunur boyutta, çizim aracının çıktısı. Yalnız Şekil 7.6 düzeltilmeli.
- **Scope ve MATLAB ekranlarındaki ondalık nokta** (eksen rakamları, Şekil 7.14 veri imleçleri): yazılım çıktısıdır. Eksenler Y-5 adım 2 ile yeniden yazılırsa virgüle döner; yazılmazsa bırakılır. Metindeki değerler virgüllü yazılmalı (O-3, Y-6 önerileri öyle).
- **Scope başlıkları** zaten Türkçe ("şebeke akımları (A)", "DA bara gerilimi", "Bir adet bataryayı besleyen …"). Yazım hatası dışında (O-4) dokunulmaz.
- **Şekil 7.14'teki elle eklenmiş kırmızı oklar ve italik etiketler** ("SOC", "Batarya gerilimi", "Batarya akımı"): görüntünün parçası, bırakılabilir.

## 5. Kaynak gereksinimi özeti

| Gereksinim | Maddeler |
|---|---|
| **Yalnız LaTeX** | Y-1, Y-2, Y-3 (altyazı ve (b)/(c) seçeneği), Y-4, Y-5 adım 1–4, Y-6, O-1, O-2, O-3, D-1, D-2, D-3, D-6, D-7, D-8, D-9, §3 maddeleri |
| **Dönüştürme (kaynak depoda var)** | Yok. Bölüm 7 için depoda EMF ya da vektör kaynak bulunmadı |
| **Yeni kaynak (özgün dosya)** | Y-3 (a): Şekil 7.6'nın Proteus vektör dışa aktarımı; Y-5 adım 4–5: şarj yönü Simulink modeli ve kayıt verisi (Şekil 7.9–7.14'ün yeniden çizimi); O-4: scope başlıkları. Ümit'e soru sorulmayacağı için öneri: LaTeX seçenekleri uygulansın, bu maddeler K kaydına "kabul" olarak yazılsın |

Önerilen uygulama sırası: Y-3 altyazı kısmı, Y-6, O-1, O-3 metin cümlesi, D-7, D-8 ve §3-1 (metin ve tablo, tek oturum). Ardından Y-1 ve Y-2 (TikZ, derleyip görsel denetimle). Sonra Y-5 adım 1 (kırpma) ve O-2 (boşlukları yeniden ölçerek). En son Y-5 adım 2 ve 4, Y-3 (b), D-1 (görüntü üstü TikZ etiketleri ve `\addplot graphics`). Y-4 bir içerik kararı gerektirdiği için önce karar defterine yazılmalı.
