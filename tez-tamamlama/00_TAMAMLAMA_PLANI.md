# Tez tamamlama planı

Hedef: `tez-latex-v2/` hattından, Ümit'e soru sormadan, jüri isteklerinin tamamını
karşılayan ve içinde hiç `\eksikistek` barı kalmayan teslim edilebilir bir PDF
üretmek.

Kararlar `01_KARAR_DEFTERI.md` dosyasında, model düzeltmeleri
`02_MODEL_DUZELTME_KAYDI.md` dosyasında tutulur. İş paketlerini yürüten alan
uzmanı alt ajan `.claude/agents/tez-beyin.md` dosyasında tanımlıdır.

## Bitti tanımı

1. Jüri maddeleri 1–11'in her biri, aşağıdaki "kabul kanıtı" sütunundaki çıktıyla karşılanmış olmalı.
2. `grep -c eksikistek tez-latex-v2/chapters/*.tex` toplamı 0 olmalı.
3. Tectonic derlemesi hatasız tamamlanmalı ve `Undefined` uyarısı olmamalı.
   Çıktı `build_YYYY-MM-DD/` klasörüne ve `tez_guncel_YYYY-MM-DD.pdf` adıyla kaydedilmeli.
4. Bütün benzetim sayıları tarihli bir review notuna dayanmalı (kanıt döngüsü).
5. Model düzeltme kaydındaki bütün D-xx kayıtları "doğrulandı" ya da Bölüm 8'de
   sınırlılık olarak yazılmış olmalı.
6. Metinde "önceki tez", "eski Şekil" ve benzeri üst-anlatı kalmamalı.

## İş paketleri

Durum değerleri: ☐ başlamadı · ◐ sürüyor · ☑ bitti

| İP | İş | Girdi → çıktı | Jüri | Bağımlılık | Durum |
|---|---|---|---|---|---|
| İP-0 | Değiştirilmemiş koşu ve hedef karşılaştırması | 12.10 paketi → `review/2026-10-27_DORT_SENARYO_ILK_KOSU.md` | — | — | ☑ |
| İP-1 | S2 kapı yolunun onarımı (D-01, K-04) ve S2 koşusu | `fix_s2_gate_path_20261027.m` → onarılmış S1+S2 koşusu + review notu | 8, 10 | İP-0 | ◐ |
| İP-2 | Topoloji ve cihaz eşlemesi denetimi (D-07); Sin³ biçiminin modelden okunması (K-06a) | Bütün modeller → `review/2026-10-27_TOPOLOJI_DENETIMI.md`, D-08…D-10 | 6, 9 | İP-0 | ☑ |
| İP-2b | Diyot eşlemesinin düzeltilmesi (D-08) ve etkisinin ölçülmesi: S3 ve onarılmış S1+S2 | `fix_diode_mapping_20261027.m` → koşular + review notu | 9, 10 | İP-2, İP-1 | ◐ |
| İP-3 | Q/cosφ işaretinin dalga biçiminden belirlenmesi (D-06, K-02) | `logsout.mat` → işaret notu | 9, 10 | İP-0 | ◐ |
| İP-4 | S1–S3 ortak parametre kalibrasyonu. Taban model: D-01 + D-03 + D-08 + D-09 uygulanmış. Devre parametreleri sabit, `K1x`/faz serbest; birincil ölçütler P_ac, I_ac, η; THD ikincil (K-01) | İP-1, İP-2b, İP-3 → kalibrasyon tablosu + review notu | 8, 10 | İP-1, İP-2b, İP-3 | ☐ |
| İP-5 | S4 kapalı çevrim modelinin kurulması (D-02, K-05): önce P, sonra PI; 2,3 / 10 / 25 A taraması | `build_s4_closed_loop_20261027.m` → akım izleme, THD, η, doyum ve geçici rejim tablosu | 8 | İP-2 | ☐ |
| İP-6 | Kararlılık analizi (K-07): L/S/T Bode eğrileri, kazanç/faz marjı, K3 açık/kapalı; kutup karşılaştırması; L_g duyarlılığı | S4 doğrusallaştırması → vektörel PDF + CSV + review notu | 7 | İP-5 | ☐ |
| İP-7 | Tek parametre tablosu (K-09) | 12.10 m-dosyası → LaTeX tablosu (değer, birim, kaynak, tür) | 9 | İP-2 | ☐ |
| İP-8 | Tez metni: bölümlere aktarım ve "düşük akımda benzetim modelleme" kesimi | review notları → v2 Bölüm 3–6 + model düzeltme kesimi (K-13) | 2, 3, 8, 10 | İP-1…İP-7 | ☐ |
| İP-9 | Bütün `\eksikistek` barlarının kapatılması (13 adet; tablo aşağıda) | İP-1…İP-8 → 0 bar | 10, 11 | İP-8 | ☐ |
| İP-10 | Başlık, akış, katkı ilanı ve "eski tez" temizliği (K-11) | metadata + Bölüm 1 + Bölüm 8 | 1, 2, 3 | İP-8 | ☐ |
| İP-11 | Şekiller: genel blok diyagram, çalışma modu şekilleri, düşük çözünürlüklü görsellerin yenilenmesi | TikZ/MATLAB vektör → `figures/` | 4, 5, 6 | İP-8 | ☐ |
| İP-12 | Literatür sentezi ve karşılaştırma tablosu | Bölüm 2 | 11 | — | ☐ |
| İP-13 | Son derleme, denetim ve sürüm kaydı | `build_YYYY-MM-DD/`, `tez_guncel_YYYY-MM-DD.pdf` | hepsi | hepsi | ☐ |

Paralel yürütülebilecekler: İP-2, İP-3 ve İP-12 birbirinden bağımsızdır. İP-1
uzun bir MATLAB koşusudur (Normal modda ~2 saat, tek Accelerator koşusunda ~30 dk).

## Jüri maddesi → kabul kanıtı

| Jüri | İstek | Kabul kanıtı | İP |
|---|---|---|---|
| 1 | Başlık içeriği yansıtmalı | K-11 başlığı `config/tez-metadata.tex` içinde, TR ve EN | İP-10 |
| 2 | Akış genelden özele kurulmalı | Bölüm sırası: literatür → sistem/model → analiz → yöntem → benzetim → deney → sonuç; her bölüm köprüyle açılmalı | İP-8, İP-10 |
| 3 | T-tipi katkı öne çıkmalı | Bölüm 1'de üç katkı tablosu | İP-10 |
| 4 | Blok diyagramlar | Genel enerji/sinyal akış diyagramı + alt diyagramlar (vektör) | İP-11 |
| 5 | Şekil çözünürlüğü | Bütün şekiller vektör ya da ≥ 300 dpi | İP-11 |
| 6 | Çalışma modları anlaşılır olmalı | Aynı devre tabanında renkli akım yolu şekilleri | İP-11, İP-2 |
| 7 | Sin³ için kapalı çevrim ve Bode analizi | Analitik ispat + L/S/T Bode (K3 açık/kapalı) + marj tablosu | İP-6 |
| 8 | Nominal güçte kapalı çevrim | S4: 2,3 / 10 / 25 A tablosu (akım izleme, THD, η, doyum, geçici rejim) | İP-5 |
| 9 | Tek parametre tablosu | Birimli ve kaynaklı tek tablo | İP-7 |
| 10 | Deneysel testler | Bölüm 6 mevcut deney kanıtı + kalibre benzetim karşılaştırması + açık sınırlılık | İP-4, İP-8 |
| 11 | Akademik temel | Literatür karşılaştırma tablosu ve araştırma boşluğu | İP-12 |

## `\eksikistek` barlarının kapanış yolu

| Bölüm:satır | Bar | Kapanış |
|---|---|---|
| 01:56 | Problem–yöntem–katkı akış şekli | İP-11 TikZ şekli |
| 02:267 | Gerçek FV profili ve ticari evirici ham kaydı | Sınırlılık (K-12/İ4); temsilî profil "motivasyon" olarak kalır |
| 02:284 | Kapı işaretleri ve endüktör akımı | İP-1/İP-4 koşusundan S2 kapı + iL1 dalga biçimi |
| 03:406 | Gerçek denetim kodu ve kapı mantığı | İ2: modelden okunan PWM yapısı + İP-2 |
| 03:505 | Kalan parametrelerin kilitlenmesi | İP-7 tablosu (K-09) |
| 04:138 | Kapı mantığı ve senaryo eşlemesi | İP-1 + İP-2 (R2023b'de koşu tamam) |
| 04:289 | Verim ve güç adlandırma çelişkileri | İP-4: P_dc/P_ac, işaret ve pencere tanımı; anma güç ifadeleri K-08 |
| 05:42 | Gerçek Sin³ kodu ve harmonik bağlaşım | K-06a (modelden okunan biçim) + İP-6 küçük işaret taraması ya da sınırlılık |
| 05:240 | Gerçek parametrelerle kararlılık doğrulaması | İP-6 |
| 06:6 | Deney protokolü ve ham kayıtlar | Sınırlılık (K-10) + elde olan ekranlar |
| 06:465 | Düşük–orta–anma deney seti | İP-5 benzetim taraması + sınırlılık (K-08, K-10) |
| 07:259 | GT-tipi model paketi | K-12: nitel mimari + sınırlılık |
| 07:317 | Tetikleme mantığı ve gömülü yazılım | K-12: nitel + sınırlılık |

## TODO.md R01–R16 → kapanış (K-16)

| İstek | Kapanış |
|---|---|
| R01 model paketi | 12.10 paketi geldi; S4 eksiği D-02 ile kapanır |
| R02 sistem kimliği | Tek faz T-tipi evirici, laboratuvar noktası ≈ 120 V; anma ifadeleri K-08 |
| R03 filtre/empedans | 12.10 m-dosyası (L1, L1r, L2, L2r, C, Rp) |
| R04 cihazlar | Veri sayfaları + m-dosyası tabloları; D-07 denetimi |
| R05 PWM kodu | İ2: modelin PWM alt sistemleri |
| R06 denetleyici katsayıları | `Kp = 0.03` (12.10) + İP-5 PI tasarımı |
| R07 Sin³ biçimi | K-06a |
| R08 Ts/çözücü | Model: ode15s, MaxStep `sim_max_step` = 1e-6 |
| R09 senaryo eşlemesi | K-03 |
| R10 çalışma noktaları | m-dosyası hedef dizileri + K-08 |
| R11 ham kanallar | Benzetim `logsout.mat`; deney ham kaydı yok → sınırlılık |
| R12 FFT/THD penceresi | Modeldeki THD bloğu (50 Hz, bir periyot); tezde tanım olarak yazılır |
| R13–R14 donanım kayıtları | Sınırlılık (K-10) |
| R15–R16 geçici olay ve parametre etiketleri | İP-5 geçici rejim koşusu + İP-7 tablo "tür" sütunu |
