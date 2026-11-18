# Bölüm 6 fazlalık, gereksiz ayrıntı, tekrar ve jüri riski incelemesi

- **Kapsam:** `yeni_tez/bolumler/06-deneysel-dogrulama.tex` (606 satır, HEAD = d197f4e). Tekrar ve sayı karşılaştırması için 01, 03, 04, 05, 07 (yalnız Bölüm 6'ya gönderme yapan satırlar), 08, `onkisim/ozet.tex` ve `ekler.tex` okundu. Ayrıca `tez-tamamlama/01_KARAR_DEFTERI.md` (K-01, K-02a, K-08, K-29), rapor 17, 18, 22 ve review notları `2026-10-28_KALIBRASYON_S1_S3.md`, `2026-11-01_S1_THD_TEZ_SAHIBI_DEGERLENDIRMESI.md` denetlendi.
- **Bakış açısı:** jüri üyesi, tez danışmanı, güç elektroniği uzmanı. Bölüm 6 bugün dil açısından düzenlendiği için (rapor 22) dil önerisi yalnız anlamı etkileyen yerlerde var.
- **Görev kipi:** incele (yalnız rapor). Hiçbir `.tex` dosyası değişmedi. Derleme ve commit yapılmadı.
- **Tarih:** 18.11.2026. Satır numaraları dosyaların bugünkü hâline aittir. Alıntılar en çok 20 kelimedir.
- **Kelime sayımı:** `wc -w`, `%` yorum satırları dışarıda, LaTeX komutları dahil (rapor 12, 14, 17 ile aynı yöntem). Sayfa kestirimi ~300 kelime/sayfa.
- **İşaretler (rapor 18 ile aynı):** **[HESAP]** yeni benzetim gerektirmeyen elle hesap (tezde yeni sayı olur, tez sahibi onayı gerekir). **[YENİ SAYI]** yeni benzetim ya da kayıtlardan yeni okuma gerektirir. Her [HESAP] ve [YENİ SAYI] önerisinin yanında yeni sayı gerektirmeyen bir seçenek (**A**) verilmiştir.
- **Kısıtlar:** sayı uydurulmadı; uyuşmazlıklar iki tarafın satırıyla verildi, tahminle çözülmedi. Önerilen metinler olumsuz kurgu kullanmaz. Altyazıya cümle eklenmesi önerilmez; yalnız altyazıdan çıkarma önerilir.

---

## 1. Özet

### 1.1 Kelime sayısı

| Kesim | Satır | Kelime | Pay | Şekil / tablo |
|---|---|---:|---:|---|
| Bölüm girişi + "Deneysel veri kümesi" | 1–7 | 194 | %4 | – |
| 6.1 Deney Düzeneği ve Güç Donanımı | 8–113 | 475 | %9 | 6 / 3 |
| 6.2 Kontrol Kartı, Tampon Kartı ve Kapı Sürücüsü | 114–135 | 282 | %5 | 2 / 0 |
| 6.3 Gerilim ve Akım Ölçme Devreleri | 136–173 | 410 | %8 | 3 / 0 |
| 6.4 DA ve AA Güç Analizörleri (TikZ dahil) | 174–280 | 586 | %11 | 4 / 1 |
| 6.5 PC Ana Kumanda Yazılımı ve Veri Toplama | 281–295 | 209 | %4 | 1 / 0 |
| 6.6 Klasik Anahtarlama Modu Deney Kayıtları | 296–326 | 214 | %4 | 3 / 0 |
| 6.7 Nötr Anahtar Susturma Modu Deney Kayıtları | 327–355 | 132 | %2 | 3 / 0 |
| 6.8 Susturma ve Sin³ Modu Deney Kayıtları | 356–384 | 133 | %2 | 3 / 0 |
| 6.9 Deney Sonuçlarının Değerlendirilmesi (giriş) | 385–473 | 674 | %12 | 0 / 4 |
| 6.9.1 Deney Özet Tablosunun Sayısal Denetimi | 474–495 | 165 | %3 | 0 / 1 |
| 6.9.2 Faz Akımı THD Değerlerinin Karşılaştırılması | 496–518 | 219 | %4 | 0 / 1 |
| 6.10 Kalibrasyon (giriş) | 519–523 | 73 | %1 | – |
| 6.10.1 Yöntem | 524–550 | 527 | %10 | 0 / 1 |
| 6.10.2 Kalibrasyon sonucu ve bağımsız karşılaştırma (`\umitnot` dahil) | 551–600 | 959 | %18 | 0 / 1 |
| 6.11 Genel Değerlendirme | 601–606 | 171 | %3 | – |
| **Toplam** | | **5 423** | | **25 / 12** |
| `\umitnot` hariç (PDF'te görünen) | | 5 317 | | |

**Öbekler:** donanım ve ölçüm altyapısı (6.1–6.5) 1 962 kelime (%36) ve 16 şekil, 4 tablo; ham deney kayıtları (6.6–6.8) 479 kelime (%9) ve 9 şekil; değerlendirme ve sayısal denetim (6.9) 1 058 kelime (%20) ve 6 tablo; kalibrasyon (6.10) 1 559 kelime (%29) ve 2 tablo; giriş ve genel değerlendirme 365 kelime (%7). Sayfa kestirimi: ~18 sayfa metin + ~15 sayfa şekil + ~5 sayfa tablo, yaklaşık 35 sayfa. Kesim 6.1 tek başına 475 kelimeye karşılık altı fotoğraf, üç tablo ve üç `\clearpage` taşıyor (~8–9 sayfa).

### 1.2 Bulgu sayısı

| Tür | Yüksek | Orta | Düşük | Toplam |
|---|---:|---:|---:|---:|
| Tekrar (B6-T) | 2 | 5 | 7 | 14 |
| Gereksiz ayrıntı (B6-A) | 0 | 3 | 5 | 8 |
| Yanlış yer / oran (B6-Y) | 0 | 1 | 1 | 2 |
| Şekil, tablo, altyazı (B6-S) | 0 | 3 | 6 | 9 |
| Jüri riski (B6-J) | 6 | 10 | 8 | 24 |
| **Toplam** | **8** | **22** | **27** | **57** |

### 1.3 Önerilerin hepsi uygulanırsa tahmini kazanç

- **Bölüm 6 metni:** tek tek kazançların toplamı ~1 300 kelime. Örtüşmeler (B6-T01 ile B6-T06; B6-T03 ile B6-T04; B6-T02 ile B6-S01) düşülünce **~1 150 kelime (~%21)**.
- **Şekil ve tablo:** `tab:deney-juri-durum` (B6-T06), `tab:deney-kosullari`'nın `tab:gelen-excel-senaryolar` ile birleşmesi (B6-T04), `fig:deney-evirici-genel` ve iki faz fotoğrafının tek şekle inmesi (B6-A03), iki üretici bağlantı görseli (B6-J15), pencere karşılaştırıcı şekillerinden biri (B6-A04): **~3,5–4 sayfa**.
- **Jüri riski düzeltmelerinin ekleri:** ~120 kelime (B6-J01, J07, J08, J10, S01 cümleleri). Kazanca dahil edilmedi.
- **PDF'te görünen net kazanç:** ~3,4 sayfa metin + ~3,7 sayfa şekil/tablo − ~0,4 sayfa ek = **~6,7 sayfa**.
- **Diğer bölümler:** 04:134 (bir cümle), 07:8 (bir cümle), 03:595 (isteğe bağlı) ~50 kelime.
- Önerilerden sonra Bölüm 6 ~4 300 kelime, ~20 şekil ve ~10 tablo olur. Ham deney kayıtlarının payı %9'dan ~%12'ye, donanım öbeğinin payı %36'dan ~%30'a iner.
- **Başlık:** kesim başlıklarının hiçbiri kaldırılmıyor. 6.2 ve 6.3 kısalıyor, ikisi tek kesimde birleşebilir (isteğe bağlı, B6-A02).

### 1.4 En önemli 5 öneri

1. **Deney veriminin tanımını tabloyla uyumlu yaz (B6-J01).** `tab:kalibrasyon-karsilastirma` deney sütununda verim %92,5 iken aynı sütunun $P_{\mathrm{ac}}$ ve $P_{\mathrm{dc}}$ satırlarından %92,70 çıkıyor (06:567, 06:571, 06:573). S2'de fark 0,48 puan. 06:294 deney veriminin Eşitlik `eq:verim-tanimi` ile hesaplandığını söylüyor, 06:494 ise bildirilen verimin DA çarpımından farklı olduğunu gösteriyor. Jüri tabloyu kendisi bölerek bulur. Yeni sayı gerektirmeyen çözüm: iki cümleyle hangi satırın hangi tanıma dayandığını yaz.
2. **"Deney özeti" adını iki değer kümesine birden verme (B6-J02).** Metin ve iki tablo DA bara için 430/395/427 V ve şebeke için 120/120/124 V veriyor (06:298, 06:329, 06:358, 06:425–426, 06:444). Aynı adla anılan özet tablosu 431,5/395,0/427,5 V ve 119,8/121,0/124,3 V veriyor (06:294, 06:487–489, 03:468, 03:470). S2'de 121,0 V yuvarlanınca 120 V olmaz. Bölüm 5 S2 mekanizmasını 121,0 V ile kurmuş (05:57, $V_m=171{,}1$ V).
3. **THD'nin kalibrasyondaki rolünü tek ifadeye indir (B6-J03).** 06:526'nın son iki cümlesi ("THD hedefi olarak…", "ikincil ölçüt") K-01'in kalıntısıdır. K-02a ve tezin geri kalanı THD'yi bağımsız ölçüt sayıyor (04:139, 05:215, 06:584, 06:605, 08:34, Özet). 06:584 THD'yi "en güçlü bağımsız kanıt" diye niteliyor; "ikincil ölçüt" bununla da çelişiyor. İki cümle çıkmalı.
4. **06:590'daki harmonik empedans zinciri ve 06:599'daki pencere tanımı (B6-J05, B6-J06).** "$L_1+L_2$ toplamının beşinci harmonikteki yaklaşık 10 Ω empedansı" tablo değerleriyle 2,5 Ω çıkıyor [HESAP]; 0,44 A ve %20 sayıları bu değere bağlı. 06:599 "son periyot ile 0,08–0,10 s ortalaması"nı karşılaştırıyor; 0,1 s benzetimde son periyot zaten 0,08–0,10 s'dir (03:580). Yeni sayı gerektirmeyen çözüm: sayı zincirini çıkar, pencere cümlesini kayıtla denetle.
5. **Tekrarları ve S4 özetini indir (B6-T01, T02, T06, T03).** "~2,3 A, düşük güç, anma S4 benzetimiyle" bölüm içinde dört kez (06:4, 06:10, 06:413, 06:605), "aktif ve reaktif güce kalibre edildi, öteki büyüklükler bağımsız" altı kez geçiyor. `tab:deney-juri-durum` Bölüm 5'teki `tab:s4-tarama` ve `tab:s4-basamak` ile Bölüm 8'in matrisinden başka bilgi taşımıyor, dış gönderme almıyor. Kazanç ~350 kelime + ~0,5 sayfa.

### 1.5 Jüri riski taşıyan noktalar

| Kimlik | Konu | Yer |
|---|---|---|
| B6-J01 | Deney verimi "bildirilen" değer, benzetim verimi $P_{\mathrm{ac}}/P_{\mathrm{dc}}$; aynı tabloda iki tanım | 06:294, 06:494, 06:571–574, 06:588 ↔ 03:583–585 |
| B6-J02 | "Deney özeti" adıyla iki değer kümesi (430 ↔ 431,5 V; 120 ↔ 121,0 V) | 06:298, 329, 358, 425–426, 444 ↔ 06:294, 487–489; 03:468, 03:470; 05:57 |
| B6-J03 | THD hem "bağımsız ölçüt" hem "THD hedefi / ikincil ölçüt" | 06:526 ↔ 06:584, 06:605, 04:139, 05:215, 08:34, Özet; K-01 ↔ K-02a |
| B6-J04 | PF ile $\cos\varphi_1$ ayrımı; özet satırından $P/(VI)$ hesabı S1 THD'siyle uyuşmuyor | 06:517, 06:242, 06:427 ↔ 03:585, 07:395; `\umitnot` 06:595 |
| B6-J05 | "Beşinci harmonikte yaklaşık 10 Ω" → tablo değerleriyle 2,5 Ω | 06:590 ↔ 03 `tab:sistem-parametreleri` ($L_1$, $L_2$) |
| B6-J06 | "Son periyot" ile "0,08–0,10 s ortalaması" aynı pencere | 06:599 ↔ 03:580 |
| B6-J07 | Verim belirsizliği yalnız DA tarafı; S2→S3 farkı (0,3 puan) belirsizlik içinde, başka bölümler "artırmıştır" diyor | 06:279, 06:268 ↔ 01:44, 08:34, 08:127, Özet |
| B6-J08 | S2 deneyi farklı DA bara geriliminde (395 V ↔ 431,5 / 427,5 V) | 06:294, 06:426 ↔ 06:407, 08:32 |
| B6-J09 | Tek çalışma noktası, yöntem başına tek kayıt; S1 THD'si kayıtta %5–22 | 06:6, 06:300, 06:413 ↔ 08:115 |
| B6-J10 | S1 $\cos\varphi$ aralığı (−0,990–1,000) ile kalibrasyonda kullanılan 1,000 | 06:427 ↔ 06:528, 06:568, 06:577 |
| B6-J11 | Deneyin açık çevrim olduğu benzetim modelinden çıkarılıyor | 06:285, 06:309 |
| B6-J12 | "Anma gücündeki" S4 ↔ S4 anma **akımı** 120 V'ta (~3 kW/faz) | 06:4 ↔ 05:220, 01:57, K-08 |
| B6-J13 | 20 kVA anma görünür güç ile "20–25 kW" | 06:10 ↔ 03:464, 07:4, 07:415, 08:80; K-08 |
| B6-J14 | Verim sınırına yardımcı besleme ve fan dahil mi | 06:52, 06:84, 06:108, 06:279 |
| B6-J15 | Üretici dokümanından alınan iki bağlantı görseli atıfsız | 06:176, 06:188, 06:205, 06:217 |
| B6-J19 | "Üretici işaret kuralı" analizör üreticisi diye okunabilir | 06:528 ↔ 03:580, 03 tablo "Güç ölçüm noktası ve işaret kuralı", K-02a |

---

## 2. Önceki raporlardan Bölüm 6'ya değen maddelerin durumu

### 2.1 Rapor 22 (Bölüm 6 yazım düzenlemesi) açık maddeleri

| Rapor 22 maddesi | Konu | Bugünkü durum | Bu rapordaki karşılığı |
|---|---|---|---|
| §6.1 | 06:528 "Üretici işaret kuralı" | **Açık.** K-02a ve 03:580 kuralın üretici (generator) kuralı olduğunu gösteriyor; anlam doğru, okuma riski var | B6-J19 |
| §6.2 | 06:526 THD'nin rolü | **Açık.** Son iki cümle K-01 kalıntısı; K-02a ile çelişiyor | B6-J03 |
| §6.3 ve §3 | 06:605 kendine gönderme | **Değişti.** Satırda artık `\ref{chap:deney}` yok, "bu bölümle" var (kural 1). Rapor 22 §1 "yasak sözcük 0" ve §3 "gönderme sayısı değişmedi" diyor; commit d197f4e'deki satır bununla uyuşmuyor | B6-J23 |
| §6.4 | 06:156 "ayrı bir ölçümün konusudur" | **Açık.** Cümle jüriyi "ölçüldü mü?" sorusuna çağırıyor | B6-J18 |
| §6.5 | 06:127 "kurulmuştur" | Anlam doğru. Ek iş yok | – |
| §6.6 | 06:605 mekanizma cümlesi | İddia gücü deney sayılarıyla destekleniyor. Ek iş yok | – |
| §6.7 | 06:116 numaralı liste | Liste kısalmalı | B6-A01 |
| §5 tablo hücreleri | 06:427, 443, 447, 451 noktalı virgül ve "dalgalanır" | "Yorum" ve "Farkın durumu" sütunları kalkarsa dördü de kapanır | B6-T03, B6-S04 |
| §5 altyazı | 06:557 iki açıklama cümlesi | **Açık** (proje kuralı) | B6-S01 |
| §5 fazlalık | 4/10/413, 387/582, 300/411 | **Açık** | B6-T01, B6-T02, B6-T03 |
| §5 terim | kondansatör / kapasitör | **Açık** (06:49, 51, 82, 83, 143, 147, 528) | B6-S09 |

### 2.2 Rapor 17 ve 18'in Bölüm 6 maddeleri

| Bulgu | Konu | Bugünkü durum |
|---|---|---|
| H-09 | 06:389 "üç katı" bara gerekçesi | **Kapandı.** Bölüm 6'da yok |
| H-15 | S2 zarf betimi (06:586) | **Açık**, B6-T13 |
| H-55 | Basamak yerleşme 0,44 ↔ 0,43 ms | **Kapandı.** 06:469 %0,17 ve 0,43 ms veriyor (05:350–352 ile aynı) |
| H-57 | 08:34 DA bara koşulu | **Kapandı.** 08:34 431,5 V ve 427,5 V'u yazıyor |
| H-49 | Büyütülmüş bara kapsamı | **Bölüm 6'da kısmen açık:** 06:467 orta güç satırında "büyütülmüş DA bara" yok, 06:468'de var. Rapor 18 §3.2'ye göre bütün `KC_*` koşuları büyütülmüş barayla. B6-T06 uygulanırsa kapanır |
| H-52 | THD$_{i,\mathrm{faz}}$ ↔ THD$_I$ simgesi | **Açık**, B6-S08 |
| Rapor 17 §3 | `fig:deney-susturma-pc`, `fig:deney-sin3-pc` gönderme almıyor | **Açık**, B6-S03 |

---

## 3. Sayı tutarlılığı tablosu (bölümler arası)

| Büyüklük | Bölüm 6 | Öteki yer | Durum |
|---|---|---|---|
| Deney verimi %92,5 / %94,2 / %94,5 | 06:298, 329, 358, 400–402, 494, 571 | 04:141, 04:169, 08:32, 08:34, 08:54, 08:59, 08:127, Özet, 03:629 (S2 %94,2), 01:43 (1,7 puan) | **Tutarlı.** Tanım sorunu B6-J01'de |
| $\eta_{VI}$ %92,700 / %93,715 / %94,373 | 06:487–489 | – | Tablodaki $P_{\mathrm{ac}}$ ve $P_{\mathrm{dc}}$ satırları (06:567, 06:573) bu değerleri veriyor; aynı tablonun verim satırı (06:571) bildirilen değeri veriyor. **Tablo içi tanım farkı** (B6-J01) |
| Benzetim verimi %91,15 / %93,93 / %94,25 | 06:400–402, 06:571 | 04:141, 08:32, 08:54, Özet | Tutarlı. 03:629 S2 için %94,07 ve 16,99 W veriyor (kalibrasyon öncesi doğrulama adımı); 06:571 ve 06:574 kalibre değer %93,93 ve 16,39 W (B6-J24) |
| Deney THD %15 / %47 / %14 | 06:298, 329, 358, 400–402, 407, 487–489, 510–512, 517, 526, 576 | 04:143, 04:169, 05:4, 08:32, 08:34, 08:54, 08:127, Özet | Tutarlı |
| Benzetim THD %39,5 / %56,7 / %14,8 | 06:400–402, 510–512, 576, 584 | 04:143, 05:4, 05:215, 08:32, 08:34, Özet | Tutarlı |
| Faz akımı "yaklaşık 2,3 A" | 06:4, 10, 294, 298, 329, 358, 413, 424, 466 | 01:57, 03:640, 04:11 (3,3 A tepe), 08:109, Özet | Tutarlı. Ölçülen 2,26 / 2,33 / 2,31 A (06:487–489, 05:140) |
| DA bara gerilimi | **430 / 395 / 427 V:** 06:298, 329, 358, 426, 444, 448, 452 | **431,5 / 395,0 / 427,5 V:** 06:294, 06:487–489, 06:572; 03:470; 08:34; 05:57 (S2 395 V) | **Uyuşmuyor**, iki kaynak aynı adla (B6-J02) |
| Şebeke gerilimi | **120 / 120 / 124 V:** 06:298, 329, 358, 425 | **119,8 / 121,0 / 124,3 V:** 06:294, 06:487–489; 03:468; 05:57 ($V_m=171{,}1$ V = 121,0·√2) | **S2'de uyuşmuyor** (121,0 → 120 yuvarlama değil) (B6-J02) |
| AA güç 249,6 / 253,2 / 281,2 W | 06:487–489, 06:567 | 08:44 "250–280 W" | Tutarlı |
| $\cos\varphi$ S1 | 06:427 "−0,990–1,000" | 06:568 bant 0–7,9 var, 06:577 "1,000" | **Bölüm içi uyuşmazlık** (B6-J10). [HESAP] 0,990 okuması 35,6 var verir |
| Gerilim THD %3,7 / %5,4 / %4,8 | 06:428, 06:590 | – | Tutarlı |
| Osiloskop RMS S1 2,87 A | 06:499 | 06:517 "kayıt boyunca 2,0–2,3 A", 06:487 2,26 A | Osilogram PC kaydının akım bandı dışında (B6-J17) |
| S4 10 A PIR: −%2,2, %97,28; 25 A PIR: −%1,0, %96,03; basamak %0,17, 0,43 ms | 06:467–469 | 05:300, 05:304, 05:350–352, 05:588 | Tutarlı |
| Anma gücü | 06:10 "20–25 kW", "20 kVA" | 03:464 20 kVA; 07:4, 07:415, 08:80 "20–25 kW"; K-08 | $P\le S$ ile çelişiyor (B6-J13) |
| "Anma gücü" ↔ S4 | 06:4 "Anma gücündeki geri beslemeli (S4)" | 05:220 (120 V, 25 A, ~3 kW/faz), 01:57 "Anma akımı koşulu" | **Terim uyuşmuyor** (B6-J12) |
| Aşırı akım eşiği | 06:147 (2,0 / 0,6 V, simetrik) | 03 tablo "yaklaşık 30,4 A" | Tutarlı: 0,7 V / 23 mV/A = 30,4 A |
| HLSR RMS sınırı 39,9 A | 06:145, 06:273 | 03 tablo "ölçülebilir tepe 56,5 A" | Tutarlı: 56,5/√2 = 39,95 A |
| AMC1200 giriş 162,5 mV | 06:139 | 03 tablo (ofset 1,3 V, ADC 2,6 V) | Tutarlı: 1,3 V / 8 |
| $L_1+L_2$ empedansı | 06:549 "50 Hz'te ~0,5 Ω" | 03 tablo 600 + 1000 µH | Tutarlı (0,50 Ω) |
| | 06:590 "beşinci harmonikte ~10 Ω" | aynı | **Uyuşmuyor**: 2π·250·1,6 mH = 2,5 Ω (B6-J05). Kaynak `review/2026-11-01_S1_THD_TEZ_SAHIBI_DEGERLENDIRMESI.md`:47 aynı değeri taşıyor |
| Benzetim penceresi | 06:599 "son periyot ile 0,08–0,10 s ortalaması" | 03:580 "0,1 s anındaki, yani 0,08–0,10 s penceresinin ortalaması" | **Aynı pencere** (B6-J06). Kaynak `review/2026-10-28_KALIBRASYON_S1_S3.md`:269–271 aynı ifadeyi taşıyor |
| Haberleşme çevrimi 1 s, gecikme 50 ms | 06:283 | 03:595 | Tutarlı, tekrar (B6-T08) |
| Ölü zaman 1 µs | 06:125, 06:549 | 03:516 | Tutarlı |
| Kalibrasyon belirsizlikleri | 06:553 | K-02a (±12 var) | Elle denetlendi: $\pm$\%1 · $P$ / $\mathrm{d}P/\mathrm{d}\ln a$ → %0,025 / %0,38 / %0,20; ±12 var / $\mathrm{d}Q/\mathrm{d}\varphi$ → 0,05° / 0,4° / 0,5–1°. Tutarlı |

**Elle denetlenip tutarlı bulunan öteki sayılar:** 06:549 ölü zaman kestirimi (4,31 V / 2,6 A = 1,66 Ω), 06:553 darbe kısalması (50 µs × %1,5–3,3 = 0,75–1,65 µs), 06:573–576 bütün fark sütunları, 06:597 sıralama farkları, 06:568 $|Q_{g,1}|$ bantları (S1 0–7,9; S2 24,1–26,7; S3 19,9–23,6 var), 06:279 (%0,5 × 94 = 0,47 puan).

---

## 4. `\label`–`\ref` taraması

**Yöntem:** `yeni_tez/bolumler`, `onkisim`, `sekiller` altındaki `.tex` dosyalarında `\ref`, `\eqref`, `\autoref`, `\pageref` arandı.

**Bölüm 6'da hiç gönderme almayan şekiller:** `fig:deney-susturma-pc` (06:335), `fig:deney-sin3-pc` (06:364). İkisi de dış gönderme almıyor (B6-S03).

**Başka bölümlerden gönderme alan, korunması gereken Bölüm 6 etiketleri:**

| Etiket | Dış göndermeler |
|---|---|
| `chap:deney` | 01:91, 03:540, 03:562, 07:4, 07:8, 07:266, 07:383, 07:395, 08:27, 08:55, ekler:19 |
| `sec:kalibrasyon` | 01:50, 03:79, 03:612, 03:648, 03:650, 04:30, 04:139, 05:159, 05:215, 08:34, 08:60 |
| `tab:kalibrasyon-karsilastirma` | 04:141, 05:4, 08:25, 08:26, 08:32, 08:55, 08:60 |
| `tab:deney-dusuk-guc-ozeti` | 08:25 |
| `sec:thd-kaynaklar` | 08:34 |
| `tab:kopru-ic-empedansi` | 04:145 |

**Çıkarılması ya da birleştirilmesi önerilen etiketlerin hiçbiri dış gönderme almıyor:** `tab:deney-juri-durum` (B6-T06), `tab:deney-kosullari` (iki iç gönderme: 06:409, 06:590; B6-T04), `fig:deney-evirici-genel`, `fig:deney-faz-donanim-2` (B6-A03), `tab:deney-giris-komponentler` ve `fig:deney-giris-devresi` (isteğe bağlı, B6-T07), `fig:deney-pencere-dalga` (B6-A04).

**EK A bağımlılığı:** RFM-0505S (ekler:28) ve TCR2EF (ekler:29) veri sayfaları yalnız 06:143'teki cümleden gönderme alıyor. B6-A02 o cümleyi çıkarırsa iki ek sayfası da çıkmalı ya da parça adları tek yan cümlede kalmalı. ADuM4135 (ekler:25), AMC1200, HLSR, AcuDC240, EMK-01 gönderme almaya devam ediyor.

**Bölümler arası gönderme (kural 11):** 06:4'teki `chap:gttipi` 06:605'te de var; B6-T01 uygulanınca 06:4'teki S4/GT cümleleri kısalır ve paragraftaki üç bölümler arası gönderme ikiye iner.

---

## 5. Bulgu listesi

Biçim: **Kimlik — tür — öncelik — tahmini kazanç**, ardından yer, alıntı ve öneri.

### 5.1 Tekrarlar

**B6-T01 — tekrar — yüksek — ~90 kelime**
- **Konu:** Deney noktası yaklaşık 2,3 A, düşük güç; anma çalışması S4 benzetimiyle.
- **Yer:** **06:4** (cümle 4–5, birincil), 06:10 (son cümle), 06:413 (cümle 1–3), 06:605 (cümle 7), 06:466 (tablo hücresi) ↔ 01:57, 03:640, 08:109, Özet.
- **Alıntı:** 06:10 "Deneyler yaklaşık 2.3 A faz akımında, düşük güç noktasında yapılmıştır." ↔ 06:413 "Deneyler yaklaşık 2.3 A faz akımındaki düşük güç noktasında yapılmıştır."
- **Öneri:** Bilgi 06:4'te kalsın (B6-J12 düzeltmesiyle). 06:10 son cümle ve 06:605 cümle 7 çıksın. 06:413 B6-T06 ile birlikte kalkar; kapsamı sınırlayan tek cümle istenirse 06:407'nin sonuna "Deneysel karşılaştırma yaklaşık 2,3 A düşük güç noktasındadır." yeter.

**B6-T02 — tekrar — yüksek — ~110 kelime**
- **Konu:** "Model aktif ve reaktif güce kalibre edildi, öteki büyüklükler bağımsız karşılaştırmadır."
- **Yer:** 06:6 (cümle 3), 06:387 (cümle 3–4), 06:522 (cümle 2), **06:526** (birincil, yöntem), **06:582** (cümle 2–3), 06:586 (cümle 4), 06:588 (son cümle), 06:605 (cümle 4), 06:557 (altyazı) ↔ 01:50, 04:139.
- **Alıntı:** 06:586 "İki serbest değişken aktif ve reaktif güce ayrıldığından AA akımı ve THD bağımsız karşılaştırma olarak kalmaktadır."
- **Öneri:** Yöntem 06:526'da, tablo okuması 06:582'de kalsın. 06:6 cümle 3, 06:387 cümle 3–4 ("Benzetim sütunu… Alt Bölüm… verilmektedir" yerine yalnız "(Alt Bölüm~\ref{sec:kalibrasyon})"), 06:586 cümle 4 ve 06:588 son cümle çıksın. Altyazı için B6-S01.

**B6-T03 — tekrar — orta — ~70 kelime + iki tablo sütunu**
- **Konu:** Ekran değeri anlık okuma, özet değeri kayıt ortalaması.
- **Yer:** 06:300 (son iki cümle), **06:411** (cümle 2–3, birincil), `tab:deney-metin-ekran-karsilastirma` "Farkın durumu" sütunu (06:442–452: "Ekran değeri anlık okumadır." üç kez, "Yakın değerler." üç kez), `tab:thd-kaynaklar` "Analizör anlık okuması" sütunu (06:510–512; THD satırlarıyla aynı üç değer), 06:517 (cümle 5).
- **Öneri:** Açıklama 06:411'de bir kez dursun. "Farkın durumu" sütunu kalksın; THD eğri aralıkları (%5–22, %45–50, %14–18) gerekiyorsa 06:300 ve 06:329/358 cümlelerine taşınsın. `tab:deney-metin-ekran-karsilastirma` içindeki üç THD satırı `tab:thd-kaynaklar` ile aynı olduğundan çıkabilir; tablo verim ve $V_{\mathrm{dc}}$ satırlarıyla kalır. Rapor 22 §5'teki dört noktalı virgül ve "dalgalanır" da böylece kalkar.

**B6-T04 — tekrar — orta — ~100 kelime + ~0,4 sayfa**
- **Konu:** Deney özet sayıları altı tabloda ve üç paragrafta.
- **Yer:** 06:298, 06:329, 06:358 (cümle 2, "Deney özeti … bildirmektedir") ↔ `tab:deney-dusuk-guc-ozeti`, `tab:deney-kosullari`, `tab:gelen-excel-senaryolar`, `tab:deney-metin-ekran-karsilastirma`, `tab:kalibrasyon-karsilastirma`, `tab:thd-kaynaklar`.
- **Öneri:**
  - Üç paragraftaki "Deney özeti…" cümleleri çıksın ya da yalnız verim ve THD'yi versin. Gerilim sayıları B6-J02'deki uyuşmazlığın iki kaynağıdır.
  - `tab:deney-kosullari` ile `tab:gelen-excel-senaryolar` birleşsin: özet tablosuna THD$_v$ ve $\cos\varphi$ sütunları eklenir, "Yorum" sütunu kalkar (B6-S04). 06:409 ve 06:590'daki iki gönderme birleşik tabloya yönelir. Yeni sayı gerekmez; hücreler iki tablodan alınır.

**B6-T05 — tekrar — orta — ~40 kelime**
- **Konu:** "Verim ve THD sıralaması model ile deneyde aynı."
- **Yer:** 06:407 (son cümle), 06:466 (hücre), **06:597** (birincil, sayılarla), 06:605 (cümle 5) ↔ 08:32, 08:127, `\umitnot` 06:593.
- **Öneri:** Sayılı biçim 06:597'de, sonuç 06:605'te kalsın. 06:407 son cümle çıksın; 06:466 B6-T06 ile kalkar.

**B6-T06 — tekrar (ve yanlış yer) — orta — ~80 kelime + ~0,5 sayfa**
- **Konu:** `tab:deney-juri-durum` ve 06:413.
- **Yer:** 06:413, 06:457–472 ↔ 05:288–304 (`tab:s4-tarama`), 05:339–356 (`tab:s4-basamak`), 05:588, 08:25–27 (`tab:arastirma-sorusu-kanit` AS2, AS3), 08:109.
- **Alıntı:** 06:413 "Tablo~\ref{tab:deney-juri-durum}, her güç bölgesinin hangi yöntemle incelendiğini ve elde edilen sonucu özetlemektedir."
- **Öneri:** Tablo ve 06:413 kalksın. Dört satırın dördü de başka yerde var; tablo deney bölümünde benzetim sonucunu yeniden veriyor. Etiket adı ("juri-durum") da süreç izi taşıyor. Dış gönderme yok. Böylece 06:467'deki "büyütülmüş DA bara" eksikliği de kapanır (rapor 18 H-49).

**B6-T07 — tekrar — orta — ~60 kelime (+ isteğe bağlı ~0,8 sayfa)**
- **Konu:** Donanım bileşenleri üç lejant tablosunda ve iki cümlede.
- **Yer:** `tab:deney-alt-birimler` (06:47–53), `tab:deney-faz-komponentler` (06:82–85), `tab:deney-giris-komponentler` (06:107–109) ↔ 06:58 (cümle 3), 06:90 (cümle 3). Aynı öğe birden çok kez: $L_1$ bobini (47, 85), kapı sürme kartı (47, 85), boost diyotları (48, 82), fonksiyon değiştirme röleleri (49, 82), snubber (49, 83), kontrol ve tampon kartı (50, 109), inrush röleleri (52, 107).
- **Alıntı:** 06:58 "İki görüntü ayrı tutulduğundan boost diyotlarının, fonksiyon değiştirme rölelerinin, DA bara ve snubber kapasitörlerinin…"
- **Öneri:** 06:58 ve 06:90'ın üçüncü cümleleri çıksın (lejant tablosunu üçüncü kez sayıyor). İsteğe bağlı: giriş devresi şekli ve tablosu çıkar; altı öğenin üçü `tab:deney-alt-birimler`'de var, kalanlar (sigorta, 12–24 V kaynak, EMI süzgeci) sonuçlara değmiyor.

**B6-T08 — tekrar — düşük — ~25 kelime (Bölüm 3)**
- **Yer:** 06:283 (cümle 3–4) ↔ 03:595 (cümle 2).
- **Öneri:** Donanım bilgisi Bölüm 6'da kalsın. 03:595'te "DA ve AA analizörleri ardışık okunduğundan haberleşme kayıtları kararlı durum verimi için uygundur" biçimi yeter.

**B6-T09 — tekrar — düşük — ~15 kelime (Bölüm 4)**
- **Yer:** 06:294 (cümle 3) ↔ 04:134 (cümle 4).
- **Alıntı:** 06:294 "Her benzetim kendi deneyinin DA bara ve şebeke gerilimiyle yapılmıştır." ↔ 04:134 "Her senaryo kendi deneyinin DA bara ve şebeke gerilimiyle benzetilmiştir."
- **Öneri:** Bölüm 6'da kalsın, 04:134'teki cümle çıksın.

**B6-T10 — tekrar — düşük — ~25 kelime**
- **Yer:** 06:205 (cümle 2–4) ↔ 06:268 (tablo hücresi, 30 kelimeyi aşıyor; rapor 22 §5).
- **Öneri:** Hücre "Kalibrasyon ölçümü, EK A (15.01.2025)" olsun; sayılar 06:205'te kalsın.

**B6-T11 — tekrar — düşük — ~20 kelime**
- **Yer:** 06:125 (son cümle, ölü zaman 1 µs) ↔ 03:516, 03:437 ↔ 06:549.
- **Öneri:** 06:125'teki ölü zaman cümlesi çıksın; değer 06:549'daki hesapta kullanılıyor ve tabloda var.

**B6-T12 — tekrar — düşük — ~0 (Bölüm 4 tarafı)**
- **Yer:** 06:549 (cümle 3–4: süreksiz iletim, akım kaynağı, senkron olmayan alçaltıcı) ↔ 04:103, 04:145, 03 `sec:dusuk-akim-modelleme`.
- **Öneri:** Bölüm 6'daki cümle kalibrasyon sonucunu açıklıyor, kalsın. 04:145'teki "akım kaynağına yaklaşmakta" yan cümlesi tabloya gönderme ile yetinebilir. Değişiklik isteğe bağlı.

**B6-T13 — tekrar — düşük — ~20 kelime**
- **Yer:** 06:586 (cümle 2) ↔ 04:147 ↔ 05:72–74 (rapor 17 H-15).
- **Öneri:** 06:586'da zarf betimi "dalga biçimi deneyle aynı karakterdedir (Şekil … ve Şekil …)" boyuna insin.

**B6-T14 — tekrar (süreç anlatısı) — düşük — ~120 kelime**
- **Yer ve öneri:**
  - 06:4 son cümle "…tutarlılık bakımından denetlenmiştir." → çıksın (06:411 ve tablolar gösteriyor).
  - 06:6 cümle 4 "…özgün görüntü dosyalarından alınmış ve özgün çözünürlükleriyle verilmiştir." → çıksın (arşiv kökeni üst-anlatısı; 07:8'de de aynı cümle var).
  - 06:409 → B6-T04 sonrası tek tablo kaldığından çıksın.
  - 06:411 son cümle "Tablo, kayıtların kendi içindeki tutarlılığını göstermektedir." → çıksın.
  - 06:599 son cümle (tabloyu tekrar eden totoloji) → çıksın.
  - 06:603 (donanım envanteri) ve 06:605 cümle 6 ("Özet ve ekran değerleri… tablolar hâlinde verilmiştir") → Genel Değerlendirme bulgulara insin; 06:603 tek cümle olabilir: "Deney düzeneği, ölçüm zinciri ve üç yönteme ait kayıtlar belgelenmiştir."

### 5.2 Gereksiz ayrıntı

**B6-A01 — gereksiz ayrıntı — orta — ~90 kelime**
- **Yer:** 06:116 (cümle 4–7, (1)–(11) numaralı işlev listesi).
- **Alıntı:** 06:116 "Aynı fotoğrafta (7) ile 5 V lineer regülatörler, (8) ile röle ve fanlar için MOSFET güç çıkışları…"
- **Gerekçe:** Regülatörler, MOSFET çıkışları ve besleme katları hiçbir sonuca girmiyor. Jürinin yeniden üretim için beklediği bilgi mikrodenetleyici, haberleşme ve diferansiyel PWM yoludur; ilk iki cümle bunu veriyor.
- **Öneri:** İlk üç cümle kalsın, numaralı liste çıksın. Numaralar fotoğrafta kalabilir; okur için lejant gerekiyorsa 06:116 yerine kısa bir lejant tablosu (rapor 22 §6.7) düşünülebilir, ama bu B6-T07'deki tablo yükünü artırır.

**B6-A02 — gereksiz ayrıntı — orta — ~150 kelime**
- **Yer:** 06:139 (cümle 3, 5: 162,5 mV, 387 V), 06:141 (ADC kanal dağılımı, ofset, −2047/+2048), 06:143 (cümle 4–5: RFM-0505S, TCR2EF250), 06:165 (cümle 3–4: 4 mm² ters-U iletken, TLV431, MC33269).
- **Gerekçe:** Bölümün raporladığı her sayı analizörlerden ve osiloskoptan geliyor; kontrol kartının ADC zinciri ölçüm sonucuna girmiyor. Ölçeklemenin ana değerleri `tab:sistem-parametreleri`'nde zaten var.
- **Öneri:** 06:139–143 tek paragrafa insin: AMC1200 izolasyonu, faz ve bara ölçümü, nötr nokta korumasının FAULT ile PWM'yi kesmesi. 06:165'te "ters-U iletkenler $L_1$, kondansatör ve faz akımının osiloskopla ayrı ölçülmesini sağlamaktadır" kalsın (osiloskop kayıtlarının kaynağı); regülatör parça adları çıksın. EK A bağımlılığı §4'te. İsteğe bağlı: 6.2 ve 6.3 "Denetim ve Ölçüm Kartları" başlığında birleşir.

**B6-A03 — gereksiz ayrıntı (şekil) — orta — ~1,5–2 sayfa**
- **Yer:** `fig:deney-evirici-genel` (06:23–28) ve 06:21; `fig:deney-faz-donanim-1` ve `-2` (06:60–72, her biri 0,68 metin yüksekliği).
- **Gerekçe:** Genel görünüm, hemen ardından gelen numaralı `fig:deney-donanim-kartlar` ile aynı panoyu gösteriyor; 06:21 bunu "yerleşim bağlamı" diye gerekçelendiriyor. İki faz fotoğrafı iki tam sayfa kaplıyor.
- **Öneri:** `fig:deney-evirici-genel` ve 06:21 çıksın. İki faz fotoğrafı (a)/(b) alt şekilli tek şekle insin (alt şekil yazısı "(a) Birinci görünüm", "(b) İkinci görünüm"). Altyazıya cümle eklenmez.

**B6-A04 — gereksiz ayrıntı — düşük — ~70 kelime + ~0,5 sayfa**
- **Yer:** 06:147–163 (pencere karşılaştırıcı devresi ve dalga şekli).
- **Öneri:** Koruma zinciri güvenlik açısından değerli, ama iki şekil fazla. Devre şekli kalsın, dalga şekli ve 06:156 çıksın; ya da tersi. B6-J18 ile birlikte.

**B6-A05 — gereksiz ayrıntı — düşük — ~30 kelime**
- **Yer:** 06:285 (cümle 1–2: 38400 baud, veri sırası).
- **Öneri:** Çıksın; 06:283 çevrim süresini ve okuma sırasını zaten veriyor.

**B6-A06 — gereksiz ayrıntı — düşük — ~50 kelime**
- **Yer:** 06:127 (cümle 2–5: ADuM4135 özellikleri tek tek).
- **Öneri:** "Desatürasyon koruması ve FAULT/RESET zinciri" cümleleri kalsın; diferansiyel giriş ve Miller kenetleme veri sayfasında (EK A). "Yüksek frekanslı anahtarlamada" ifadesi 10 kHz için de abartılı okunabilir.

**B6-A07 — gereksiz ayrıntı — düşük — ~25 kelime**
- **Yer:** 06:530 (cümle 1 "İlk kalibrasyon adımları… göstermiştir"), 06:549 (son cümle "S1 ve S2'de dört, S3'te altı kalibrasyon benzetimi gerekmiştir").
- **Öneri:** Süreç bilgisidir; ikincisi çıkabilir. İlk cümle "Evirici köprüsünün temel bileşen gerilimi modülasyonla bire bir değişmemektedir." biçiminde bulgu olarak yazılabilir.

**B6-A08 — gereksiz ayrıntı (tablo) — düşük — ~15 kelime**
- **Yer:** `tab:olcum-cihazlari` son sütun, 06:270–272 ("Bildirilen özellik üretici değeriyle aynıdır." üç kez).
- **Öneri:** Hücreler "Üretici veri sayfası" olsun.

### 5.3 Yanlış yer ve oran

**B6-Y01 — oran — orta — ~0**
- **Yer:** 6.6–6.8 (479 kelime, %9) ↔ 6.1–6.5 (1 962, %36) ↔ 6.10 (1 559, %29).
- **Gerekçe:** Bölümün adı "Deneysel Doğrulama", ama deney kayıtlarının yorumu S2 ve S3'te şekil başına tek cümle. S2 ve S3'ün PC ekranları metinde hiç anılmıyor (B6-S03).
- **Öneri:** B6-A01–A03 ile donanım öbeği kısalınca oran kendiliğinden düzelir. 06:329 ve 06:358'de PC ekranına birer gönderme yeter. Kalibrasyon kesimi 11 dış gönderme aldığı için yerinde kalmalı.

**B6-Y02 — yanlış yer — düşük — ~0**
- **Yer:** 06:285 (cümle 4–6: osiloskop kanal adı "kontrolör çıkışı") PC yazılımı kesiminde.
- **Öneri:** Osiloskop kanal tanımının yanına, 06:309'a taşınsın (B6-J11 metniyle).

### 5.4 Şekil, tablo ve altyazı

**B6-S01 — altyazı (proje kuralı) — orta — ~20 kelime**
- **Yer:** 06:557.
- **Alıntı:** "İlk iki satır kalibrasyon hedefidir, öteki satırlar bağımsız karşılaştırmadır. Fark: % göreli, ``p'' yüzde puan."
- **Öneri:** Altyazı "Deney özeti ile benzetim modelinin karşılaştırılması." olsun. Birinci cümle 06:582'de var. Gösterim açıklaması 06:582'nin sonuna metin cümlesi olarak girsin: "Fark sütununda göreli fark yüzde, verim ve THD farkı yüzde puan (p) olarak verilmiştir."

**B6-S02 — altyazı (proje kuralı) — orta — ~10 kelime**
- **Yer:** 06:534 (22 kelime, "(kalibrasyon öncesi benzetimler)" yöntem açıklaması).
- **Öneri:** "Köprünün Thevenin iç empedansı, ara seviye zaman oranı ve güç duyarlılıkları." Kalibrasyon öncesi bilgisi 06:530'da zaten var; istenirse sütun başlığı "Ara seviye, kalibrasyon öncesi (\%)" olur.

**B6-S03 — şekil — orta — ~10 kelime eklenir**
- **Yer:** `fig:deney-susturma-pc` (06:331–336), `fig:deney-sin3-pc` (06:360–365). İç ve dış gönderme yok.
- **Öneri:** 06:329 ve 06:358'deki ilk cümleye "(Şekil~\ref{…})" eklensin ya da 06:300'ün eşi olan tek cümle: "PC ekranındaki eğriler Şekil~\ref{…} üzerindedir." Yeni sayı gerekmez.

**B6-S04 — tablo — düşük — ~25 kelime**
- **Yer:** `tab:deney-kosullari` "Yorum" sütunu (06:424–428: "Deneyler arasında gerilim farkı vardır." vb.).
- **Öneri:** Sütun kalksın (B6-T04 birleştirmesiyle). $\cos\varphi_1$ ve THD$_v$ ölçüm noktası bilgisi 06:528 ve 06:590'da var.

**B6-S05 — şekil içi yazı — düşük — 0**
- **Yer:** TikZ 06:242 "EMK-01 + CT: $P_{\mathrm{ac}}$, THD, PF".
- **Öneri:** "PF" yerine "$\cos\varphi_1$" (B6-J04; K-29 PF okumasını değerlendirme dışında tutuyor).

**B6-S06 — altyazı — düşük — isteğe bağlı**
- **Yer:** 06:314, 323, 343, 352, 372, 381 (altı altyazıda aynı dört kanal listesi).
- **Öneri:** Altyazılar şeklin gösterdiğini söylüyor, kural ihlali yok. Kısaltmak istenirse "Klasik yöntemde $L_1$ akımının osiloskop kaydı." biçimi; kanal listesi 06:309'da metinde var.

**B6-S07 — altyazı — düşük — 0**
- **Yer:** 06:77 (altyazıda iki `\ref`; Tablolar Listesi'ne gönderme olarak geçiyor).
- **Öneri:** "Faz donanımı bileşenleri." Hangi şekle ait olduğu 06:58'de yazıyor.

**B6-S08 — gösterim — düşük — 0**
- **Yer:** $P_o$, $Q_o$ (06:485, 06:528) ↔ $P_{\mathrm{ac}}$ (06:567); $I_{faz}$ italik alt simge (06:485); THD$_{i,\mathrm{faz}}$ (06:398, 06:576) ↔ THD$_i$ (06:443) ↔ "THDi" (06:300, 06:411) ↔ Bölüm 5 THD$_I$ (rapor 17 H-52).
- **Öneri:** Tek simge: $P_{\mathrm{ac}}$, $I_{\mathrm{faz}}$, THD$_{i}$ (faz akımı olduğu metinde bir kez söylenir).

**B6-S09 — terim — düşük — 0**
- **Yer:** kondansatör (06:82, 83, 143, 147) ↔ kapasitör (06:49, 51, 528); "senkron alçaltıcı" (06:298, 06:549; Bölüm 4) ↔ "senkron-buck" (Özet, 04:11, 04:167 "senkron buck", 08:24, 08:30, 08:53).
- **Öneri:** Tez genelinde tek terim seçilsin (rapor 22 §5), tek geçişte düzeltilsin.

### 5.5 Jüri riski

**B6-J01 — jüri riski (verim tanımı) — yüksek — +~35 kelime**
- **Yer:** 06:294 (son cümle), 06:400–402, 06:476–494, **06:571–574**, 06:588 (cümle 2) ↔ 03:583–585 (`eq:verim-tanimi` "yalnızca aynı zaman penceresinden elde edilen giriş ve çıkış güçlerine").
- **Alıntı:** 06:294 "Verim ve THD, Eşitlik~\eqref{eq:verim-tanimi} ve Eşitlik~\eqref{eq:thd-rmse-tanimlari} ile hesaplanmıştır."
- **Sorun:** `tab:kalibrasyon-karsilastirma` deney sütununda verim satırı bildirilen değeri (%92,5 / %94,2 / %94,5), $P_{\mathrm{ac}}$, $P_{\mathrm{dc}}$ ve $P_{\mathrm{dc}}-P_{\mathrm{ac}}$ satırları ise $V_{\mathrm{dc}}I_{\mathrm{dc}}$ çarpımını veriyor; ikincisinden çıkan verim %92,70 / %93,72 / %94,37'dir (06:487–489'da zaten var). Benzetim sütununda üç satır kendi içinde tutarlı ($P_{\mathrm{ac}}/P_{\mathrm{dc}}$). 06:588'deki "deneyde 19,7 W kayba" çarpım tabanına, aynı cümlenin −1,35 puanı bildirilen verime dayanıyor. Jürinin soracağı soru: "Tablonuzun deney sütununda verim neden $P_{\mathrm{ac}}/P_{\mathrm{dc}}$ değil?"
- **Önerilen A (yeni sayı yok):**
  - 06:294 son cümle → "Benzetimde verim ve THD, Eşitlik~\eqref{eq:verim-tanimi} ve Eşitlik~\eqref{eq:thd-rmse-tanimlari} ile hesaplanmıştır. Deney verimi ve THD'si deney özetinde bildirilen değerlerdir."
  - 06:582 sonuna → "Verim satırının deney sütunu bildirilen verimdir. $P_{\mathrm{dc}}$ ve kayıp satırları özet tablosundaki $V_{\mathrm{dc}}I_{\mathrm{dc}}$ çarpımından hesaplanmıştır."
  - 06:588 cümle 2 → "…deneyde DA giriş çarpımına göre \SI{19.7}{\watt} kayba karşılık gelmektedir."
- **Önerilen B [HESAP]:** `tab:kalibrasyon-karsilastirma`'ya "$\eta_{VI}$ (\%)" satırı (deney 92,70 / 93,72 / 94,37; fark −1,55 / +0,21 / −0,12 p). Sayılar 06:487–489'dan türetildiği için yeni ölçüm değildir, ama tabloda yeni farklar doğar.
- **Karar defterine:** "Bildirilen verim"in kaynağı (PC yazılımının kayıt boyunca hesapladığı değer mi, deney raporunun yuvarlanmış sayısı mı) bir K kaydıyla sabitlenmeli; 06:283 PC yazılımının "verim hesabına temel" oluşturduğunu söylüyor, ama hesabın penceresini söylemiyor. Bilgi yoksa A seçeneği yeterlidir.
- **Savunmada sözlü yanıt:** "Bildirilen verim kaydın değeridir; özet satırındaki $V$, $I$, $P$ tek okumadır. İki tanım arasındaki fark S1 ve S3'te 0,2 puan, S2'de 0,48 puandır ve DA tarafı belirsizliği (±0,5 puan) içindedir."
- **Not [HESAP, yalnız savunma]:** $\eta_{VI}$ tabanında S1→S2 artışı 1,02 puan, S2→S3 artışı 0,66 puandır (bildirilen tabanda 1,7 ve 0,3). Ana metne girmesi önerilmez; jüri hesaplarsa yanıt yukarıdakidir.

**B6-J02 — jüri riski (iki kaynak aynı adla) — yüksek — 0**
- **Yer:** **430/395/427 V, 120/120/124 V:** 06:298, 06:329, 06:358, 06:425–426, 06:444, 06:448, 06:452 ("Özet" sütunu). **431,5/395,0/427,5 V, 119,8/121,0/124,3 V:** 06:294, 06:487–489, 06:572; 03:468, 03:470; 05:57; 08:34.
- **Alıntı:** 06:411 "Ekran değeri görselde okunabilen tek anlık değer, özet değeri ise deney raporundaki sayıdır." ↔ 06:476 "Deney özet tablosunun kaynağı olan çalışma kitabı…"
- **Sorun:** `tab:deney-metin-ekran-karsilastirma` S1 için "Özet 430 V, PC ekranı 431,5 V" diyor; "deney özet tablosundaki değerler" başlıklı `tab:gelen-excel-senaryolar` aynı deney için 431,5 V veriyor. S2 şebeke gerilimi 120 V ↔ 121,0 V yuvarlamayla açıklanmaz.
- **Önerilen (yeni sayı yok):**
  - 06:6'ya bir cümle: "Deney raporu yuvarlanmış özet değerleri, deney özet tablosu ise ölçülen değerleri vermektedir." (kaynak adlandırması; ikinci kaynak 03 tablosunda "DÖ, Ölçülmüş" türündedir).
  - `tab:deney-metin-ekran-karsilastirma` "Özet" sütun başlığı → "Deney raporu".
  - `tab:deney-kosullari` (ya da B6-T04 birleşik tablosu) özet tablosunun değerlerini taşısın: 431,5 / 395,0 / 427,5 V; 119,8 / 121,0 / 124,3 V; 2,26 / 2,33 / 2,31 A.
  - 06:298, 06:329, 06:358'deki gerilim sayıları çıksın (B6-T04) ya da aynı değerlere çekilsin.
- **Savunmada sözlü yanıt:** "Rapor değerleri yuvarlanmış metin değerleridir; hesaplarda ve benzetimlerde özet tablosunun ölçülen değerleri kullanılmıştır (Bölüm 3 parametre tablosu; Bölüm 5'teki S2 mekanizması 121,0 V ile kurulmuştur)."

**B6-J03 — jüri riski (THD'nin rolü) — yüksek — −35 kelime**
- **Yer:** 06:526 (son iki cümle) ↔ 06:526 (cümle 4), 06:584 ("en güçlü bağımsız kanıttır"), 06:605, 04:139, 05:215, 08:34 ("kalibre edilmeden"), 08:59, Özet ("kalibrasyon hedefi olmayan THD"). Karar: K-01 ("THD ikincil ölçüttür; birincil ölçütler P_ac, I_ac ve verimdir") ↔ K-02a ("I_ac, verim ve THD bağımsız doğrulama ölçütüdür").
- **Alıntı:** 06:526 "THD hedefi olarak deney özetinin %15, %47 ve %14 değerleri alınmıştır."
- **Sorun:** Aynı paragrafta THD "kalibrasyonun dışında" ve "THD hedefi". "Birincil ölçütler olan $P_{\mathrm{ac}}$, $I_{\mathrm{ac}}$ ve verim" kalibrasyon hedefi ($P_{\mathrm{ac}}$) ile bağımsız ölçütleri aynı listeye koyuyor. "İkincil ölçüt", 06:584'teki "en güçlü bağımsız kanıt" nitelemesini zayıflatıyor. Cümleler K-01 döneminin kalıntısıdır; yöntem K-02a ile değişmiştir.
- **Önerilen A (önerilen):** İki cümle çıksın. Hangi THD değerlerinin kullanıldığı 06:517 son cümlesinde zaten yazıyor.
- **Önerilen A2 (sıralama korunmak istenirse):** "Bağımsız karşılaştırmada AA akımı, verim ve faz akımı THD'si birlikte değerlendirilmiştir." Yeni sayı yok.
- **Karar defterine:** K-01'in "ikincil ölçüt" hükmünün K-02a ile kapandığı not düşülmeli.

**B6-J04 — jüri riski (PF ile $\cos\varphi_1$) — yüksek — ~0**
- **Yer:** 06:517 (cümle 5–6), 06:242 (TikZ "PF"), 06:427 ↔ 03:585 ("Temel bileşen güç faktörü ile toplam güç faktörü … ayrı büyüklüklerdir"), 07:395 ("Düşük güçte verim, akım THD'si, güç faktörü" deneyle doğrulanmış listesinde), `\umitnot` 06:595. Karar: K-29 (anlık PF okuması değerlendirmeye alınmaz, karar Kesim 6 ve Bölüm 8'de birer cümleyle yazılır).
- **Alıntı:** 06:517 "Analizörün güç faktörü göstergesi tek bir anlık okumadır."
- **Sorun:**
  1. PDF okuru 06:517'de "güç faktörü göstergesi"ni 06:427'deki "Analizörün $\cos\varphi$ göstergesi" ile aynı şey sanır. O zaman kalibrasyonun reaktif güç hedefi (06:528) "tek anlık okuma"ya dayanıyormuş gibi görünür.
  2. Bölüm 3 PF'yi $P/(VI)$ diye tanımlıyor; jüri özet satırından hesaplar [HESAP]: S1 0,922, S2 0,898, S3 0,979. $\cos\varphi_1$ ile birlikte bu oranlar S1 için ~%42, S2 için ~%48, S3 için ~%19 THD'ye karşılık gelir. S2 deneyle uyumlu, S1 değil. K-29'un "anlık okuma, akım 2,0–2,3 A arasında değişiyor" yanıtı bu hesaba da yanıttır.
  3. 07:395 güç faktörünü deneyle doğrulanmış büyüklük sayıyor; Bölüm 6 PF'yi değerlendirme dışında tutuyor. K-29'un istediği Bölüm 8 cümlesi bugünkü 08'de yok (yalnız 08:115 gelecek çalışma).
- **Önerilen A (yeni sayı yok, K-29 ile uyumlu):**
  - 06:517 cümle 5 → "Analizörün toplam güç faktörü (PF) göstergesi tek bir anlık okumadır." ($\cos\varphi_1$'den ayrılır.)
  - 07:395 → "Düşük güçte verim, akım THD'si, temel bileşen güç faktörü".
  - 06:242 → "$\cos\varphi_1$" (B6-S05).
  - K-29'un Bölüm 8 cümlesi için tez sahibi kararı: ya 08:109'a bir yan cümle ("toplam güç faktörü anlık okuma olduğundan değerlendirme dışındadır") ya da K-29 bu yönüyle güncellenir.
- **[HESAP] ana metne önerilmez.** Savunma hazırlığı `\umitnot` 06:595'te var; yukarıdaki üç senaryo oranı nota eklenebilir.
- **Savunmada ek yanıt [HESAP]:** Kalibre S1 modelinin $P/(VI)$ oranı 0,930'dur (06:567, 06:570); model kendi THD'siyle (%39,5) tutarlıdır.

**B6-J05 — jüri riski (sayı hatası) — yüksek — −50 kelime**
- **Yer:** 06:590 (cümle 4–6) ↔ 03 `tab:sistem-parametreleri` ($L_1=600$ µH, $L_2=1000$ µH) ↔ 06:549 (aynı toplam için 50 Hz'te 0,5 Ω, doğru).
- **Alıntı:** 06:590 "Harmonik gerilim, $L_1+L_2$ toplamının beşinci harmonikteki yaklaşık 10 Ω empedansı üzerinde…"
- **Sorun [HESAP]:** $2\pi\cdot250\cdot1{,}6\,\mathrm{mH}=2{,}5\,\Omega$. 10 Ω yaklaşık 1 kHz'e karşılık gelir. 0,44 A ve "%20" sayıları bu değerden türetilmiş. Aynı değer `review/2026-11-01_S1_THD_TEZ_SAHIBI_DEGERLENDIRMESI.md`:47'de de var. Ayrıca analizör C noktasında ölçtüğü için o gerilimin karşısındaki empedansa $L_2$ girmez. Tahminle düzeltilmedi.
- **Önerilen A (önerilen, yeni sayı yok):** Cümle 4–6 ("Büyüklük mertebesi bakımından…" → "…yaklaşık %20'sidir.") çıksın. Kalanlar (THD$_v$ değerleri, ölçüm noktası, faz ilişkisi, son cümle) niteliksel sonucu taşıyor.
- **Önerilen B [HESAP]:** Tez sahibi 10 Ω'un dayanağını (harmonik mertebesi, empedans yolu) yazar ve zincir o dayanakla yeniden hesaplanır.

**B6-J06 — jüri riski (benzetim penceresi) — yüksek — 0**
- **Yer:** 06:599 (cümle 1–2) ↔ 03:580.
- **Alıntı:** 06:599 "S2 ve S3'te son periyot ile 0,08–0,10 s ortalaması arasındaki fark DA güçte 0,4–0,5 W…" ↔ 03:580 "S1--S3 için değerler 0,1 s anındaki, yani 0,08--0,10 s penceresinin ortalamasıdır."
- **Sorun:** 0,1 s benzetimde 50 Hz'in son periyodu 0,08–0,10 s'dir; iki ifade aynı pencereyi karşılaştırıyor. İfade review notundan (`2026-10-28_KALIBRASYON_S1_S3.md`:269–271) aynen gelmiş. Hangi iki büyüklüğün karşılaştırıldığı (örneğin Display bloğunun 0,1 s değeri ile betiğin pencere ortalaması) metinden anlaşılmıyor.
- **Önerilen A:** Koşu kayıtlarından iki pencerenin adı bulunup cümleye yazılır (yeni sayı gerekmez, sayılar aynı kalır).
- **Önerilen A2 (kayıt bulunamazsa):** 06:599 paragrafı çıkar. "Benzetim tarafı belirsizliği" bilgisi düşer, çelişki kalkar.

**B6-J07 — jüri riski (ölçüm belirsizliği ve verim farkı) — orta — +~25 kelime**
- **Yer:** 06:279, 06:268 ("Class 0.1" akım transformatörüne ait; EMK-01'in kendi doğruluk sınıfı yazılmamış) ↔ 06:407 ("verimi %94,5 düzeyinde korurken") ↔ 01:44 ("verimi bir miktar daha arttırmıştır"), Özet ve 08:34 ("%94,5'e taşımıştır"), 08:127 ("korumuş ve %94,5'e taşımıştır").
- **Sorun:** Birleşik belirsizlik eşitliği iki terim içeriyor, metin yalnız DA terimini veriyor. S2→S3 verim farkı 0,3 puan, DA terimi ±0,5 puan. Bölüm 6 "korurken" diyor (doğru), Bölüm 1, 8 ve Özet artış diyor.
- **Önerilen A (yeni sayı yok):**
  - 01:44 "verimi bir miktar daha arttırmıştır" → "verimi korumuştur". Özet, 08:34 ve 08:127'de "%94,5'e taşımıştır" → "%94,5 düzeyinde korumuştur".
  - 06:407'ye olumlu çerçeveli tek cümle: "S1→S2 verim artışı (1,7 puan), DA tarafı belirsizliğinin (±0,5 puan) üzerindedir."
- **Önerilen B [HESAP]:** EMK-01'in güç doğruluk sınıfı EK A veri sayfasından (ekler:32–33) okunup 06:279'a AA terimi eklenir; `tab:olcum-cihazlari` ilk satırına analizörün sınıfı yazılır.

**B6-J08 — jüri riski (farklı DA bara gerilimi) — orta — +~20 kelime**
- **Yer:** 06:294, 06:426 (S2 395 V; S1 431,5, S3 427,5 V) ↔ 06:407, 08:32.
- **Jürinin soracağı soru:** "S2'nin verim artışının bir kısmı %8 düşük bara geriliminden (daha küçük anahtarlama kaybı ve dalgalanma) gelmiş olamaz mı?" Benzetimler de her deneyin kendi geriliminde yapıldığı için aynı karışmayı taşıyor.
- **Önerilen A (yeni sayı yok):** 06:407'ye: "DA bara gerilimleri birbirine en yakın olan S1 ve S3 deneyleri arasında verim farkı 2,0 puandır." (08:34 aynı karşılaştırmayı koşuluyla zaten yapıyor.)
- **Önerilen B [YENİ SAYI]:** Kalibre S2 modelini 431,5 V'ta koşmak; susturmanın etkisi bara gerilimi etkisinden ayrılır (S2 Normal modda ~2 saat).

**B6-J09 — jüri riski (tek nokta, tek kayıt) — orta — ~0**
- **Yer:** 06:6 ("her yöntem için bir satırlık deney özet tablosu"), 06:300 (S1 THD'si kayıtta %5–22), 06:413 ↔ 08:115 ("en az üç tekrarla raporlanmalıdır").
- **Önerilen A:** Kapsam bir kez ve olumlu yazılsın (B6-T01): deney noktası düşük güç bölgesini temsil eden 2,3 A'dir; orta ve anma akımı S4'tedir. 08:115 gelecek çalışma olarak zaten yerinde. THD için kayıt boyunca aralıklar (06:300 ve tablo) bir yayılım ölçüsü olarak kalsın.
- **Önerilen B [YENİ SAYI]:** S2 ve S3 kayıt sürelerinin ekranlardan okunması; THD eğrilerinden ortalama ve yayılım çıkarılması.
- **Savunmada sözlü yanıt:** "Deney düzeneği güvenlik amacıyla 120 V'a sınırlandı; düşük güç noktası yöntemin hedef bölgesidir. S1 THD'sindeki yayılıma rağmen üç kaynak (analizör özeti, anlık okuma, osilogram) S2'yi %47 düzeyinde, S3'ü %12–16 aralığında veriyor."

**B6-J10 — jüri riski (S1 $\cos\varphi$) — orta — +~12 kelime**
- **Yer:** 06:427 ("$-0{,}990$--$1{,}000$") ↔ 06:528 (S1 bandı 0–7,9 var), 06:568, 06:577 ("1,000").
- **Sorun [HESAP]:** 0–7,9 var bandı 1,000 okumasının yuvarlama bandından çıkıyor; tablodaki aralığın alt ucu (0,990) 35,6 var verir.
- **Önerilen A:** 06:528'e "S1 bandı özet okumasındaki 1,000 değerinden hesaplanmıştır." eklensin; ya da `tab:deney-kosullari` S1 hücresi özetteki okumayı versin ve aralık 06:300'deki kayıt betimine taşınsın. Hangisinin doğru olduğu özet tablosundan denetlenmeli; tahminle seçilmedi.

**B6-J11 — jüri riski (deneyin denetim kipi) — orta — ~0**
- **Yer:** 06:285 (cümle 4–6), 06:309 ("işlemciden alınan ortalama endüktör akımı").
- **Alıntı:** 06:285 "Dolayısıyla kanal adındaki ifade, benzetim modelinin yapısına göre modülasyon komutu olarak okunmuştur."
- **Sorun:** Deneyin açık çevrim olduğu deney kaydından değil benzetim modelinden çıkarılıyor gibi okunuyor. Kanal adı "kontrolör çıkışı" ve işlemcinin ortalama akım kanalı jüriye kapalı çevrim izlenimi verebilir. Kalibrasyonun genlik değişkeni bu kabule dayanıyor.
- **Önerilen (yeni sayı yok):** Cümle 4–6 06:309'a taşınsın (B6-Y02) ve tek cümle olsun: "Senaryo tanımına göre S1--S3 açık çevrim modülasyonla çalıştığından ilk kanal modülasyon komutunu göstermektedir (Alt Bölüm~\ref{sec:s4-kapali-cevrim})."

**B6-J12 — jüri riski (anma gücü ↔ anma akımı) — orta — 0**
- **Yer:** 06:4 (cümle 5) ↔ 05:220 (S4 anma noktası 120 V, 25 A, faz başına ~3 kW), 01:57 ("Anma akımı koşulu"), 06:413, K-08.
- **Alıntı:** 06:4 "Anma gücündeki geri beslemeli (S4) çalışma, kalibre edilmiş benzetim modeliyle incelenmiştir."
- **Öneri:** "Anma akımındaki (\SI{25}{\ampere}) geri beslemeli (S4) çalışma…" S4 120 V'ta koştuğu için anma gücü değil, anma akımıdır.

**B6-J13 — jüri riski (kVA ↔ kW) — orta — ~0**
- **Yer:** 06:10 (cümle 1–2) ↔ 03:464 (20 kVA), 07:4, 07:415, 08:80 ("20–25 kW"). Karar: K-08 ("Donanım anma gücü (20 kVA–25 kW) ifadeleri tezde tasarım hedefi olarak kalır").
- **Sorun:** Aktif güç görünür gücü aşamaz; 25 kW, 20 kVA anma ile birlikte okunamaz. 06:10 cümle 2 ayrıca nedenselliği ters kuruyor ("anma görünür gücü akım sensörü boyutlandırma hesabından gelmektedir").
- **Önerilen A (yeni sayı yok):** 06:10 → "Deney düzeneği, \SI{20}{\kilo\volt\ampere} anma görünür gücü hedeflenerek … kurulmuştur (Tablo~\ref{tab:sistem-parametreleri})." "20–25 kW" ve sensör cümlesi çıkar. Aynı değişiklik 07:4, 07:415, 08:80'e uygulanır. K-08'in ifadesi tez sahibinin onayıyla güncellenir.

**B6-J14 — jüri riski (verim sınırı) — orta — +~15 kelime (bilgi varsa)**
- **Yer:** 06:52 ("Kumanda beslemeleri"), 06:84 ("Yüksek devirli soğutma fanı"), 06:108 ("12 V--24 V güç kaynakları"), 06:279.
- **Jürinin soracağı soru:** "250 W'ta fan ve sürücü beslemeleri verimi belirgin etkiler. Bunlar DA bara ölçümünün içinde mi?"
- **Önerilen:** Yardımcı beslemelerin nereden beslendiği (DA bara mı, ayrı kaynak mı) tek yan cümleyle yazılsın. Bilgi tez sahibindedir; karar defterine yazılır, metinde tahmin yapılmaz. Bilgi yoksa: "Verim, DA bara girişi ile AA çıkışı arasındaki güç akışından hesaplanmıştır" biçimindeki sınır cümlesi yeterlidir (06:225 ve TikZ zaten bu sınırı çiziyor).

**B6-J15 — jüri riski (üçüncü taraf görselleri) — orta — ~0,4 sayfa**
- **Yer:** `fig:deney-acudc240`(b) (06:187–188, "DA analizörü ve şönt bağlantı şekli", üretici dokümanı, 06:176), `fig:deney-emk01`(b) (06:216–217, "Üretici tarafından önerilen bağlantı şekli").
- **Sorun:** Üretici dokümanından alınan görseller atıfsız. Veri sayfaları EK A'da (ekler:30–33) zaten var.
- **Öneri:** İki (b) alt şekli çıksın; şekiller tek fotoğrafa insin. Metin: "Bağlantı, EK A'daki veri sayfasında verilen düzene göre yapılmıştır." Altyazıya atıf eklemek gerekmez.

**B6-J16 — jüri riski (THD tanımları) — düşük — +~10 kelime**
- **Yer:** `tab:thd-kaynaklar` (06:508–512): analizör (harmonik mertebesi yazılmamış), osiloskop (25. harmonik, 06:499), benzetim (S1–S3 THD bloğu, 03:592) ↔ S4 ($H=50$).
- **Önerilen A:** 06:499'a "Kaynakların harmonik mertebe sınırları farklıdır." yan cümlesi.
- **Önerilen B [HESAP]:** Analizörün mertebe sınırı EK A veri sayfasından okunup sütun başlığına yazılır.

**B6-J17 — jüri riski (osilogram çalışma noktası) — düşük — 0**
- **Yer:** 06:499 (S1 osilogramı 2,87 A) ↔ 06:517 ("2,0 A ile 2,3 A arasında"), 06:487 (2,26 A).
- **Öneri:** Metinde değişiklik gerekmez; "Osiloskop kayıtları analizör özetinden ayrı anlarda alınmıştır" cümlesi yerinde. Savunma: osilogram yüksek akımdadır; review notuna göre akım yüksekken THD düşer, yani osilogramın %21'i S1 THD'sinin alt sınırına yakın bir değerdir.

**B6-J18 — jüri riski (kendini zayıflatan cümle) — düşük — −15 kelime**
- **Yer:** 06:156 son cümle.
- **Alıntı:** "Gecikme süresi ve gerçek kısa devre kesme enerjisi ise ayrı bir ölçümün konusudur."
- **Öneri:** Çıksın. Önceki cümle ("koruma mantığını işlevsel olarak örneklemektedir") kaydın kapsamını olumlu biçimde söylüyor.

**B6-J19 — jüri riski (işaret kuralı) — orta — ~0**
- **Yer:** 06:528 (cümle 3–4) ↔ 03:580 ("$i_g$ ise üretici kuralıyla, evirici fazından şebekeye doğru pozitif"), 03:585, 03 tablo "Güç ölçüm noktası ve işaret kuralı", K-02a ("Kural: üretici, evirici → şebeke pozitif").
- **Alıntı:** 06:528 "Üretici işaret kuralı kullanılmıştır."
- **Sorun:** Kastedilen üretici (generator) kuralıdır (K-02a ve Bölüm 3 kesin). İki cümle sonra "analizörün $\cos\varphi$ göstergesi" anıldığı için okur "üretici"yi analizör üreticisi sanabilir. Cümle 4 ayrıca 03:585'i tekrarlıyor.
- **Öneri:** Cümle 3–4 → "Güç yönü için Bölüm 3'teki üretici (generator) işaret kuralı kullanılmıştır: evirici$\rightarrow$şebeke yönü pozitiftir." "$Q_{g,1}>0$ … durumdur" tanımı 03:585'te var, çıkabilir. Analizörün kendi işaret kuralının belgelenmediği K-02a'ya göre sınırlılıktır; metindeki "Eksi işareti analizörün $\cos\varphi$ göstergesinden gelmektedir" cümlesi bunu olumlu biçimde karşılıyor.

**B6-J20 — jüri riski (ADC aralığı) — düşük — 0**
- **Yer:** 06:141 son cümle ("yaklaşık $-2047$ ile $+2048$").
- **Not:** 12 bit işaretli gösterim genellikle −2048…+2047'dir; ofset sayımına göre ters de olabilir. Doğrulanamadı. B6-A02 uygulanırsa cümle zaten çıkar.

**B6-J21 — jüri riski (belirsiz cümle) — düşük — −20 kelime**
- **Yer:** 06:125 (cümle 2) ↔ 03 tablo "Kapı sürücüsü $+15/-5$ V".
- **Alıntı:** "Yaklaşık 12 V genlikte, tek yönlü iletim amacıyla H-köprü tabanlı bir sürme çözümü kullanılmaktadır."
- **Sorun:** Neyin 12 V olduğu (diferansiyel işaret mi, sürücü beslemesi mi) yazmıyor; kapı gerilimi sanılırsa Bölüm 3 ile çelişir.
- **Öneri:** Çıksın ya da tez sahibi neyin sürüldüğünü bir sözcükle belirtsin.

**B6-J22 — jüri riski (tanımsız simge) — düşük — +~8 kelime**
- **Yer:** 06:549 ($\Delta i_L\approx2{,}6$ A) ↔ 04:11 (tepe–tepe dalgalanma ~9 A), 04:149 (ters akım tepesi ~−2,6 A).
- **Öneri:** "$\Delta i_L$, S1'de ters yöndeki akım tepesidir (Alt Bölüm~\ref{sec:s1-s2-kalibre})." Değer Bölüm 4'te var; jüri $\Delta i_L$'yi 9 A'lik dalgalanma sanmasın.

**B6-J23 — kural 1 / rapor 22 uyuşmazlığı — düşük — 0**
- **Yer:** 06:605 cümle 8 "… kanıt zinciri bu bölümle tamamlanmaktadır."
- **Öneri:** Rapor 22 §3'ün önerisi: "Faz kolu ölçeğindeki iki katkının kanıt zinciri deneysel doğrulamayla tamamlanmaktadır." Rapor 22 §1'deki "yasak sözcük 0" ve "gönderme sayısı değişmedi" satırları bu commit için düzeltilmeli.

**B6-J24 — jüri riski (doğrulama adımı ↔ kalibre sonuç) — düşük — 0**
- **Yer:** 03:629 (S2: "$\eta=\%94{,}07$ (deney %94,2); kayıp 16,99 W (deney 16,98 W)") ↔ 06:571, 06:574 (kalibre S2: %93,93; 16,39 W).
- **Sorun:** Jüri "kalibrasyon S2 kaybındaki uyumu bozmuş mu?" diye sorabilir. Ayrıca 03:629 verimi bildirilen değerle, kaybı çarpım tabanıyla karşılaştırıyor (B6-J01'in eşi).
- **Öneri:** 03:629 hücresine "kalibrasyon öncesi" nitelemesi ya da yalnız "S2 kapı yolu tezdeki tanımla örtüşmektedir" sonucu. Bölüm 3'ün işi; burada bilgi için.

---

## 6. Yeni sayı ya da tez sahibi bilgisi gerektiren öneriler

| Kimlik | Ne gerekir | Gerekmezse yapılacak (A) |
|---|---|---|
| B6-J01 (B) | [HESAP] $\eta_{VI}$ satırı ve farkları (06:487–489'dan) | İki tanım cümlesi (06:294, 06:582, 06:588) |
| B6-J01 | Karar defteri: "bildirilen verim"in kaynağı | A seçeneği yeterli |
| B6-J04 | Karar defteri: K-29'un Bölüm 8 cümlesi | 06:517 "toplam güç faktörü (PF)", 07:395, TikZ |
| B6-J05 (B) | [HESAP] 10 Ω'un dayanağı ve zincirin yeniden hesabı | Sayı zincirini çıkar |
| B6-J06 | Koşu kaydında iki pencerenin adı (yeni sayı yok) | Paragrafı çıkar |
| B6-J07 (B) | [HESAP] EMK-01 doğruluk sınıfı (EK A) ve AA terimi | Bölüm 1, 8, Özet'te "korumuştur"; 06:407 olumlu belirsizlik cümlesi |
| B6-J08 (B) | [YENİ SAYI] Kalibre S2 modeli 431,5 V'ta | S1–S3 karşılaştırma cümlesi |
| B6-J09 (B) | [YENİ SAYI] S2/S3 kayıt süreleri ve THD yayılımı | Kapsamı bir kez yaz |
| B6-J10 | Özet tablosunda S1 $\cos\varphi$ okumasının denetimi | 06:528'e bant dayanağı cümlesi |
| B6-J13 | K-08'in güncellenmesi (tez sahibi onayı) | "20 kVA" tek ifade |
| B6-J14 | Tez sahibi bilgisi: yardımcı besleme nereden | Ölçüm sınırı cümlesi |
| B6-J16 (B) | [HESAP] Analizörün harmonik mertebesi (EK A) | Bir yan cümle |
| B6-J21 | Tez sahibi bilgisi: 12 V'luk sürme | Cümleyi çıkar |

---

## 7. Önerilen uygulama sırası

1. **Jüri riski düzeltmeleri (önce, kısaltılacak paragraflara dokunuyor):**
   - B6-J03 (06:526 iki cümle), B6-J05 (06:590 zincir), B6-J06 (06:599), B6-J01 (06:294, 06:582, 06:588), B6-J02 (kaynak adları, `tab:deney-kosullari` değerleri, sütun başlığı).
   - B6-J04 (06:517, 07:395, TikZ), B6-J19 (06:528), B6-J12 (06:4), B6-J13 (06:10, 07:4, 07:415, 08:80), B6-J07 (01:44, Özet, 08:34, 08:127, 06:407), B6-J08 (06:407), B6-J10 (06:528), B6-J11 (06:285 → 06:309).
   - B6-J18, J21, J22, J23.
2. **Büyük çıkarmalar ve birleştirmeler:** B6-T06 (`tab:deney-juri-durum`, 06:413), B6-T04 (`tab:deney-kosullari` + `tab:gelen-excel-senaryolar`), B6-A03 (genel görünüm, iki faz fotoğrafı), B6-J15 (iki üretici görseli), B6-A04, B6-A01, B6-A02 (EK A bağımlılığıyla), B6-T07.
3. **Bölüm içi tekrarlar:** B6-T01, T02, T03, T05, T10, T11, T13, T14; B6-A05–A08.
4. **Altyazı ve tablo:** B6-S01, S02, S03, S04, S05, S07; isteğe bağlı S06.
5. **Bölümler arası:** B6-T08 (03:595), B6-T09 (04:134), B6-T14 (07:8), B6-J24 (03:629), B6-S08, B6-S09 (tez geneli terim kararı).
6. **Yeni sayı ve tez sahibi bilgisi kararları:** §6 tablosu. Kararlar `01_KARAR_DEFTERI.md`'ye yazılır; K-01'in "ikincil ölçüt" hükmünün kapandığı da not düşülür.
7. **Her adımdan sonra** Ayakaleaf'te derlenmeli ve tanımsız gönderme kalmadığı denetlenmeli. Derlemeyi ana oturum yapar.

**Korunması gereken etiketler** (başka bölümlerden gönderme alıyor): `chap:deney`, `sec:kalibrasyon`, `tab:kalibrasyon-karsilastirma`, `tab:deney-dusuk-guc-ozeti` (08:25), `sec:thd-kaynaklar` (08:34), `tab:kopru-ic-empedansi` (04:145). `tab:deney-kosullari` birleşirse 06:409 ve 06:590'daki iki iç gönderme birleşik tabloya yönelmeli.
