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
7. Teslim sürümünde `\umitnotlarifalse` olmalı: tez sahibine bilgi notları PDF'te görünmemeli (K-28).

## İş paketleri

Durum değerleri: ☐ başlamadı · ◐ sürüyor · ☑ bitti

| İP | İş | Girdi → çıktı | Jüri | Bağımlılık | Durum |
|---|---|---|---|---|---|
| İP-0 | Değiştirilmemiş koşu ve hedef karşılaştırması | 12.10 paketi → `review/2026-10-27_DORT_SENARYO_ILK_KOSU.md` | — | — | ☑ |
| İP-1 | S2 kapı yolunun onarımı (D-01, K-04) ve S2 koşusu | `fix_s2_gate_path_20261027.m` → onarılmış S1+S2 koşusu; doğrulama D-01 + D-08 koşusuyla (`review/2026-10-27_D08_DIYOT_ESLEME.md`) | 8, 10 | İP-0 | ☑ |
| İP-2 | Topoloji ve cihaz eşlemesi denetimi (D-07); Sin³ biçiminin modelden okunması (K-06a) | Bütün modeller → `review/2026-10-27_TOPOLOJI_DENETIMI.md`, D-08…D-10 | 6, 9 | İP-0 | ☑ |
| İP-2b | Diyot eşlemesinin düzeltilmesi (D-08) ve etkisinin ölçülmesi: S3 ve onarılmış S1+S2 | `fix_diode_mapping_20261027.m` → `review/2026-10-27_D08_DIYOT_ESLEME.md` | 9, 10 | İP-2, İP-1 | ☑ |
| İP-3 | Q/cosφ işaretinin dalga biçiminden belirlenmesi (D-06, K-02) | `logsout.mat` → `review/2026-10-27_Q_ISARET_ANALIZI.md`; K-02a | 9, 10 | İP-0 | ☑ |
| İP-4 | S1–S3 ortak parametre kalibrasyonu. Taban model: D-01 + D-03 + D-08 + D-09 uygulanmış. Devre parametreleri sabit, `K1x`/faz serbest; birincil ölçütler P_ac, I_ac, η; THD ikincil (K-01) | İP-1, İP-2b, İP-3 → `review/2026-10-28_KALIBRASYON_S1_S3.md` + `runs/2026-10-28_kalibrasyon/kalibrasyon_tablosu.csv` (K-02b, K-20, D-12) | 8, 10 | İP-1, İP-2b, İP-3 | ☑ |
| İP-5 | S4 kapalı çevrim modelinin kurulması (D-02, K-05): önce P, sonra PI; 2,3 / 10 / 25 A taraması. Kesin tarama `KC_*` = kalibre S3 ileri beslemesi (K-20) + DC bara 2 × 5,6 mF (D-11) | `build_s4_closed_loop_20261028.m` → `review/2026-10-28_S4_KAPALI_CEVRIM.md` + `runs/2026-10-28_s4_kapali_cevrim/s4_tarama_KC.csv` (D-02, D-11 doğrulandı) | 8 | İP-2, İP-4 | ☑ |
| İP-6 | Kararlılık analizi (K-07): L/S/T Bode eğrileri, kazanç/faz marjı, K3 açık/kapalı; kutup karşılaştırması; L_g duyarlılığı | S4 doğrusallaştırması → `review/2026-10-28_KARARLILIK_BODE.md` + `runs/2026-10-28_kararlilik/` (vektörel PDF + CSV); K-21, D-13 | 7 | İP-5 | ☑ |
| İP-7 | Tek parametre tablosu (K-09, K-22) | 12.10 m-dosyası → `tab:sistem-parametreleri` (75 satır, 7 grup; değer, birim, kaynak, tür) + `review/2026-10-28_PARAMETRE_TABLOSU.md`; D-14. Derleme 29.10.2026: 171 sayfa, Undefined yok, tablo s. 37–44 taşmasız (İP-8 sonrası) | 9 | İP-2 | ☑ |
| İP-8 | Tez metni: bölümlere aktarım ve "düşük akımda benzetim modelleme" kesimi | review notları → v2 Bölüm 2–8: `sec:model-dogrulama-duzeltme`, `sec:dusuk-akim-modelleme`, `sec:s4-kapali-cevrim`, `sec:kararlilik-bode`, `sec:kalibrasyon` (29.10.2026; 197 sayfa, Undefined/Overfull yok; "bu" ailesi 0) | 2, 3, 8, 10 | İP-1…İP-7 | ☑ |
| İP-9 | Bütün `\eksikistek` barlarının kapatılması (13 adet, 03:505 kapandı → 12; tablo aşağıda) | İP-1…İP-8 → 0 bar | 10, 11 | İP-8 | ☑ (13/13; son bar 01:56 İP-11'de Şekil 1.1 ile kapandı) |
| İP-10 | Başlık, akış, katkı ilanı ve "eski tez" temizliği (K-11, K-24) | Bölüm 1 beş kesim + Tablo 1.1 `tab:katki-yontem-kanit` (başlık bileşeni → katkı → yöntem → bulgu → kanıt); Bölüm 4/5/7 köprüleri, Kesim 7.3 konumu; Bölüm 8 AS2–AS3 ve Kesim 8.2 kalibre değerlerle; Özet (2 s.) ve Summary (4 s.) yeniden yazıldı. Derleme 29.10.2026: 205 sayfa, Undefined/Overfull yok. Basılı metinde "eski/önceki tez" yok (dosya/etiket adları İP-11) | 1, 2, 3 | İP-8 | ☑ |
| İP-11 | Şekiller: genel blok diyagram, çalışma modu şekilleri, düşük çözünürlüklü görsellerin yenilenmesi | TikZ/MATLAB vektör → `figures/` (K-25): Şekil 1.1 akış (bar 01:56 kapandı), 2.1, 2.3, 2.10, 5.2 TikZ; 2.2 MATLAB vektör; kalibre S1/S2/S3 yeniden koşusundan (`runs/2026-10-29_tez_sekilleri`, metrikler 6 basamak aynı) Şekil 4.2 S1 kapı, 4.4 S1/S2 L1, 5.3 S3 L1; 4.3 model çizimi vektör. Eski 4 kapı ekranı, 5 L1 ekranı, yanlış etiketli faz modeli (C1 = 1 nF), Chicco grafiği ve eşpotansiyel ekranı çıktı. Şekil sırası hatası yok (87 şekil). 300 dpi altı raster 60 → 42; kalanlar Bölüm 6–7 fotoğraf/ekran/GT şemaları, yeniden üretilemez, bölüm girişinde kaynak notu. "LC filtre" başlıkları doğru (fiziksel süzgeç L1–Cf; Kesim 3.6.1 notu). Derleme 29.10.2026: 205 sayfa, Undefined/Overfull yok. Review: `review/2026-10-29_TEZ_SEKILLERI.md` | 4, 5, 6 | İP-8 | ☑ |
| İP-12 | Literatür sentezi ve karşılaştırma tablosu | Bölüm 2 (K-26): tümleşik şarj literatürü (Kesim 2.1), T-tipi karşılaştırma (2.2), süreksiz iletim kompanzasyonu sentezi ve Sin³ ile farkı (2.4), doktora tezi örnekleri paragrafı ve Tablo 2.7 (9 → 19 satır, 4 öbek, AS sütunu) (2.5), araştırma boşluğu dört kümeyle (2.6). 10 doğrulanmış kaynak (3 doktora tezi); kaynak 50 → 60. Derleme 29.10.2026: 207 sayfa, Undefined/Overfull yok | 11 | — | ☑ |
| İP-13 | Son derleme, denetim ve sürüm kaydı | Son derleme 29.10.2026: 228 sayfa, Undefined/Overfull yok; `build_2026-10-29/`, `tez_guncel_2026-10-29.pdf`, kök `main.pdf` (K-27). EKLER (21 belge), TEŞEKKÜR, ÖZGEÇMİŞ yazıldı; anabilim/bilim dalı ve teslim ayı dolduruldu; patent tablosu ve Bölüm 6 ölçüm tablosu ek belgelerle güncellendi; D-03/04/10/13/14 doğrulandı. Teslim öncesi kalan alanlar: öğrenci no, savunma tarihi, onay sayfası jürisi | hepsi | hepsi | ☑ |

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
| 01:56 | Problem–yöntem–katkı akış şekli | İP-11 TikZ şekli — **Kapandı**: Şekil 1.1 `fig:tez-akisi` (TikZ) |
| 02:267 | Gerçek FV profili ve ticari evirici ham kaydı | **Kapandı** — İP-8 (K-12/İ4 sınırlılık paragrafı) |
| 02:284 | Kapı işaretleri ve endüktör akımı | **Kapandı** — İP-8 (`fig:s2-kapi-isaretleri`, `fig:s1-s2-kalibre-dalga`) |
| 03:406 | Gerçek denetim kodu ve kapı mantığı | **Kapandı** — İP-8 (`sec:denetim-modelden`) |
| 03:505 | Kalan parametrelerin kilitlenmesi | **Kapandı** (İP-7 tablosu, K-09/K-22) |
| 04:138 | Kapı mantığı ve senaryo eşlemesi | **Kapandı** — İP-8 (`sec:model-kapi-mantigi`) |
| 04:289 | Verim ve güç adlandırma çelişkileri | **Kapandı** — İP-8 (`sec:guc-tanimlari`, `tab:s1-s2-kalibre`) |
| 05:42 | Gerçek Sin³ kodu ve harmonik bağlaşım | **Kapandı** — İP-8 (K-06a + harmonik bağlaşım ölçümü) |
| 05:240 | Gerçek parametrelerle kararlılık doğrulaması | **Kapandı** — İP-8 (`sec:kararlilik-bode`) |
| 06:6 | Deney protokolü ve ham kayıtlar | **Kapandı** — İP-8 (K-10 deneysel kanıt kapsamı) |
| 06:465 | Düşük–orta–anma deney seti | **Kapandı** — İP-8 (`sec:s4-kapali-cevrim` + K-08/K-10) |
| 07:259 | GT-tipi model paketi | **Kapandı** — İP-8 (K-12 nitel + sınırlılık) |
| 07:317 | Tetikleme mantığı ve gömülü yazılım | **Kapandı** — İP-8 (K-12 nitel + sınırlılık) |

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
