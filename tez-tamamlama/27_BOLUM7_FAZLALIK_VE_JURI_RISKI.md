# Bölüm 7 fazlalık, gereksiz ayrıntı, tekrar ve jüri riski incelemesi

- **Kapsam:** `yeni_tez/bolumler/07-gt-tipi-mimari.tex` (419 satır, HEAD = c743cb5, rapor 26 sonrası). Tekrar ve sayı karşılaştırması için 01, 02, 03, 06, 08, `onkisim/ozet.tex` ve (yalnız GT cümleleri) `onkisim/summary.tex` okundu. Ayrıca `01_KARAR_DEFTERI.md` (K-08, K-12, K-30, K-31, K-32, K-36, K-41), rapor 23 ve rapor 26 denetlendi.
- **Şekiller açılıp okundu:** Bölüm 7'nin 14 görüntüsü ve `fig:gelen-faz1-hucresi`'nin kaynağı olan `sekiller/guc_yapi_10.pdf` (L3 hücresi kırpılarak, röle etiketleri PDF metninden). Görüntülerden okunan değerler **[HESAP]** olarak işaretlendi.
- **Bakış açısı:** jüri üyesi, tez danışmanı, güç elektroniği uzmanı. Bölüm 7 bugün dil açısından düzenlendiği için (rapor 26) dil önerisi yalnız anlamı etkileyen yerlerde var.
- **Görev kipi:** incele (yalnız rapor). Hiçbir `.tex` dosyası değişmedi. Derleme ve commit yapılmadı.
- **Tarih:** 18.11.2026. Satır numaraları dosyaların bugünkü hâline aittir. Alıntılar en çok 20 kelimedir.
- **Kelime sayımı:** `wc -w`, `%` yorum satırları dışarıda, LaTeX komutları ve TikZ dahil (rapor 12, 14, 17, 23 ile aynı yöntem). Sayfa kestirimi ~300 kelime/sayfa.
- **İşaretler (rapor 18 ve 23 ile aynı):** **[HESAP]** yeni benzetim gerektirmeyen elle hesap ya da şekilden okuma (tezde yeni sayı olur, tez sahibi onayı gerekir). **[YENİ SAYI]** yeni benzetim, model ya da tez sahibi bilgisi gerektirir. Her [HESAP] ve [YENİ SAYI] önerisinin yanında yeni sayı gerektirmeyen bir seçenek (**A**) verilmiştir.
- **Kısıtlar:** sayı uydurulmadı; uyuşmazlıklar iki tarafın satırıyla verildi. Önerilen metinler olumsuz kurgu kullanmaz. Altyazıya cümle eklenmesi önerilmez; yalnız altyazıdan çıkarma ya da sözcük değişikliği önerilir. Tez sahibinin 18.11.2026 görüşü gereği küçük sayı farkları **Düşük** önceliktedir.

---

## 1. Özet

### 1.1 Kelime sayısı

| Kesim | Satır | Kelime | Pay | Şekil / tablo / denklem |
|---|---|---:|---:|---|
| Bölüm girişi | 1–9 | 200 | %6 | – |
| 7.1 Tasarım Gereksinimleri | 10–18 | 226 | %7 | – |
| 7.2 GT-Tipi Topolojinin Yapısı (TikZ ~123 kelime dahil) | 19–136 | 717 | %21 | 7 / 1 / – |
| 7.3 Şarj ve Deşarj Çalışma Modları | 137–182 | 400 | %12 | – / 1 / 2 |
| 7.4 Mod Geçişleri ve Güvenlik Kısıtları (TikZ ~125 kelime dahil) | 183–262 | 575 | %17 | 1 / 1 / 1 |
| 7.5 Şarj Yönündeki Benzetim Kayıtları | 263–350 | 359 | %11 | 6 (4 alt şekil) / – / – |
| 7.6 Klasik Mimari ile Karşılaştırma | 351–379 | 399 | %12 | – / 1 / – |
| 7.7 Doğrulama Durumu ve Mevcut Kanıt Düzeyi | 380–412 | 279 | %8 | – / 1 / 1 |
| 7.8 Değerlendirme | 413–419 | 183 | %5 | – |
| **Toplam** | | **3 338** | | **14 / 5 / 4** |
| `\kirmizinot` (satır 70) hariç | | 3 312 | | |

**Öbekler:** tasarım tanımı (7.1, 7.3, 7.4: gereksinim, kip tablosu, CC–CV, SoC, geçiş izni, durum makinesi, koruma tablosu) 1 201 kelime (%36), 3 tablo, 3 denklem. Topoloji (7.2) 717 kelime (%21), 7 şekil. Kanıt (7.5 benzetim kayıtları) 359 kelime (%11), 6 şekil. Karşılaştırma ve doğrulama (7.6, 7.7) 678 kelime (%20), 2 tablo, 1 denklem. Sayfa kestirimi: ~11 sayfa metin + ~10 sayfa şekil + ~3 sayfa tablo, yaklaşık 24 sayfa.

**Oran sorunu:** Bölümün tek sayısal kanıtı olan şarj benzetimi metnin %11'i. Hiçbiri uygulanmamış ya da benzetilmemiş tasarım tanımları (koruma tablosu, SoC güncellemesi, gidiş–dönüş verimi, karşılaştırma ölçütleri, IEC kapsamları) bunun üç katı yer kaplıyor. Jüri bu oranı "kanıtsız tasarım metni" diye okuyabilir (B7-A01–A03).

### 1.2 Bulgu sayısı

| Tür | Yüksek | Orta | Düşük | Toplam |
|---|---:|---:|---:|---:|
| Tekrar (B7-T) | 1 | 5 | 4 | 10 |
| Gereksiz ayrıntı (B7-A) | 0 | 3 | 1 | 4 |
| Şekil, tablo, altyazı, terim (B7-S) | 0 | 2 | 3 | 5 |
| Sayı tutarlılığı (B7-N) | 0 | 0 | 3 | 3 |
| Jüri riski (B7-J) | 6 | 7 | 8 | 21 |
| **Toplam** | **7** | **17** | **19** | **43** |

### 1.3 Önerilerin hepsi uygulanırsa tahmini kazanç

- **Bölüm 7 metni:** tek tek kazançların toplamı ~900 kelime. Örtüşmeler (B7-T01 ile B7-T05; B7-T03 ile B7-T05; B7-A03 ile B7-T05) düşülünce **~780 kelime (~%23)**.
- **Eklenen metin:** jüri riski düzeltmeleri ~110 kelime (B7-J02, J04, J05, J06, J11). Kazanca dahil edilmedi.
- **Denklem:** 4 → 2 (SoC güncellemesi ve gidiş–dönüş verimi çıkar, B7-A02, B7-A03). CC–CV denklemi iki satırdan bir satıra iner (B7-J03).
- **PDF'te görünen net kazanç:** ~2,6 sayfa metin − ~0,4 sayfa ek = **~2,2 sayfa**. Şekil ve tablo sayısı değişmiyor.
- **Diğer bölümler:** 01:21, 01:45, 08:36, 08:64, 08:80, 08:119, Özet, Summary'de birer cümle değişikliği (B7-T01, B7-J08, B7-J09) ~40 kelime kazanç.
- Önerilerden sonra Bölüm 7 ~2 650 kelime olur. Benzetim kanıtının payı %11'den ~%14'e çıkar, tasarım tanımı öbeğinin payı %36'dan ~%28'e iner.

### 1.4 En önemli 6 öneri

1. **Son paragraftaki iddiayı kanıtla eşle (B7-J01, B7-J02).** 07:419 "aynı donanımın iki enerji yönünde de işlevini yerine getirdiğini göstermiştir" diyor. Donanım yalnız evirici kipinde ve düşük güçte denendi. Şarj benzetimi de aynı donanımın modeli değil: `fig:gt-simulink-modeli` görüntüsünde "KÖPRÜ DOĞRULTUCU", "PFC DEVRESİ" ve "EVİRİCİ" ayrı bloklar, modelde RL1 yok. Rapor 26'nın önerdiği "ortak yarı iletken tabanında göstermiştir" biçimi de aynı sorunu taşıyor. Öneri: "Evirici kipindeki deneyler deşarj yönünü, şarj kipi benzetim kayıtları ise şarj zincirinin işleyişini göstermiştir."
2. **CC–CV denkleminin ikinci satırı her zaman sıfır veriyor (B7-J03).** $v_{b,k}\geq V_{\mathrm{CV},k}$ iken $K_{v,k}(V_{\mathrm{CV},k}-v_{b,k})\leq0$ olur ve doyum sıfıra kırpar. Denklem CV kipi yerine eşikte aç–kapa davranışı tanımlıyor. Tek satırlık doğru biçim §5.5'te. Yeni sayı gerekmez.
3. **Batarya akımının işareti (B7-J04).** `fig:gt-batarya-soc` görüntüsünde batarya akımı $-9{,}96$ A, 07:181 ise akım işaretini "şarj yönünde pozitif" tanımlıyor. Jüri "batarya deşarj mı oluyor?" diye sorar. 07:339'a tek cümle yeter.
4. **RL2 ve röle adları (B7-J05, `\kirmizinot` satır 70).** Aynı röle `fig:gt-ana-topoloji`'de RL1, `fig:gt-evirici-lcl`'de RL2 diye etiketli. `fig:gt-iki-seviye-trafo`'da RL1–RL3 faz sırasıyla numaralı. Proteus şemasında (Şekil 3.x, `fig:gelen-faz1-hucresi`) her hücrede iki röle var: RL2 orta noktayı PFC düğümüne bağlıyor, RL1 transformatöre aktarıyor. Metin notu yanıtlamıyor; not kalmalı. Tez sahibinin onayıyla eklenecek iki cümle §5.5'te.
5. **Deşarjda bataryanın DA baraya yolu çizilmemiş (B7-J06).** `fig:gt-sentez-mimarisi`'nde deşarj oku DA baradan başlıyor; bataryadan DA baraya ok yok. Şarjda batarya dizisinin DA baradan nasıl ayrıldığı da yazmıyor. Güç elektroniği jürisinin ilk sorusu olur. TikZ'e bir ok eklemek yeni bilgi gerektirmiyor (03:11 ve 07:97 bunu zaten söylüyor).
6. **Kanıt ayrımı cümlesini ve öteki tekrarları indir (B7-T01–T05).** "Evirici kipi deneyle, şarj yönü benzetimle, gerisi tasarım tanımı" bilgisi Bölüm 7'de altı kez (07:8, 07:348, 07:371, 07:383, 07:395–399, 07:415), Bölüm 1, 8, Özet ve Summary'de yedi kez geçiyor. Yeniden yapılandırılabilir sistem literatürü 07:13 ve 07:354'te, Bölüm 2'de (02:50, 02:136) aynı atıflarla. Kazanç ~400 kelime.

### 1.5 Jüri riski taşıyan noktalar

| Kimlik | Konu | Yer |
|---|---|---|
| B7-J01 | "Aynı donanımın iki enerji yönünde de işlevini yerine getirdiği" | 07:419 ↔ 07:8, 07:383, 07:395–397 |
| B7-J02 | Şarj benzetimi ayrı Vienna ve evirici bloklarıyla kurulmuş eşdeğer devre; RL1 yok | 07:266, 07:268, 07:383 ↔ `fig:gt-simulink-modeli` |
| B7-J03 | CC–CV denkleminde CV satırı her zaman sıfır | 07:164–173 |
| B7-J04 | Benzetimde batarya akımı negatif, metinde şarj akımı pozitif | 07:181 ↔ `fig:gt-batarya-soc`, 07:339 |
| B7-J05 | RL1/RL2 adları üç şekilde üç farklı anlamda; `\kirmizinot` açık | 07:69–70, 07:6, 07:60, 07:79 ↔ 03:39, `guc_yapi_10.pdf` |
| B7-J06 | Batarya–DA bara bağlantısı (deşarjda besleme, şarjda ayırma) tanımsız | 07:97, 07:140, 07:151 ↔ TikZ 07:109–129, 03:11 |
| B7-J07 | $D_1$–$D_2$ "kararlı çalışmada iletimde değil"; evirici konumunda $DS_1$–$DS_2$'ye paralel | 07:35 ↔ 03:544, `fig:gt-evirici-lcl` |
| B7-J08 | "Eleman sayısını / maliyet ve hacmi azaltma olanağı" sayısal karşılaştırma olmadan | 01:45, 08:64, 08:80, Özet, Summary ↔ 07:370, 07:376, 07:378 |
| B7-J09 | AS4 "hücre dengeleme kipleri" soruyor; kip tablosunda dengeleme kipi yok | 01:34 ↔ 07:140–160, 07:367, 08:36 |
| B7-J10 | Şarj benzetiminin çalışma koşulları yazılmamış; şekiller 450 V bara, 3,46 V hücre gösteriyor | 07:266–346 ↔ 07:15, 03 tablo |
| B7-J11 | "İki seviyeli yarım köprü" ↔ primerde üç seviyeli gerilim; üçgen bağlantı yazılmamış | 07:79, 07:295 ↔ `fig:gt-iki-seviye-trafo`, `fig:gt-primer-gerilim` |
| B7-J12 | Güvenli kapalı durumda "ana kontaktörler kapalı" | 07:151 |
| B7-J13 | Koruma tablosu altyazısı "doğrulama kanıtları"; hiçbiri uygulanmadı | 07:242 ↔ 07:399 |

---

## 2. Önceki raporlardan Bölüm 7'ye değen maddelerin durumu

### 2.1 Rapor 26 (Bölüm 7 yazım düzenlemesi) açık maddeleri

| Rapor 26 maddesi | Konu | Bugünkü durum | Bu rapordaki karşılığı |
|---|---|---|---|
| §6.1 | 07:419 iddia gücü | **Açık.** Editörün önerdiği biçim de şarj benzetiminin ortak donanım modeli olduğunu ima ediyor | B7-J01, B7-J02 |
| §6.2 | 07:4 "Şeklin alt kısmındaki transformatörler" | **Kapandı.** Proteus şemasında TR1–TR3 altta; 03:24 aynı ifadeyi kullanıyor | Tekrar: B7-T07 |
| §6.3 | 07:6 "GT-tipi" adının literatürden ayrımı | Ek iş gerekmez. "geliştirilmiş/değiştirilmiş" eğik çizgisi | B7-J20 |
| §6.4 | 07:186 "yol açmaktadır" ↔ "yol açabilir" | Fizik doğru (farklı gerilimli düğümlerin birleşmesi sınırsız akım doğurur). Ek iş gerekmez | – |
| §6.5 | 07:378 karşılaştırma ölçütleri | **Açık.** Gelecek çalışmaya taşınmalı | B7-A03 |
| §6.6 | "doğrultucu/boost diyotları" ↔ "PFC yükseltici diyotları" | **Açık.** Aynı eleman ($D_1$–$D_2$); K-36 adı "PFC yükseltici (boost) diyotları" | B7-S02 |
| §6.7 | RL2 | **Açık.** Şekil etiketleri çelişiyor; Proteus şeması yanıtı veriyor | B7-J05 |
| §6.8 | 07:135 "gerekmemektedir" | Ek iş gerekmez | – |
| §5 altyazı | 07:93 ikinci cümle | **Açık** (proje kuralı) | B7-S01 |
| §5 fazlalık | 4/15/378; 8/383/415; 97/51; 348/383 | **Açık** | B7-T01, T03, T06, T09 |
| §5 terim | kip/mod, buck, trafo, diyot adı | **Açık** | B7-S02, B7-S03 |
| §5 başlık | "Mevcut Kanıt Düzeyi" | **Açık** | B7-J19 |
| §5 üst-anlatı | 07:8, 07:266, 07:383, 07:417 | **Açık** | B7-T05, B7-T08 |
| §5 tablo hücreleri | geniş zaman ve noktalı virgül (151–157, 368, 370, 371) | Bu raporun kapsamı dışında; B7-S03 ile tek geçişte yapılabilir | – |

### 2.2 Rapor 23'ün Bölüm 7 maddeleri

| Bulgu | Konu | Bugünkü durum |
|---|---|---|
| B6-J13 | 20 kVA ↔ "20–25 kW" | **Açık**, Bölüm 7'de dört yerde (07:4, 07:15, 07:378, 07:415). B7-N01 |
| B6-J04 | 07:395 "güç faktörü" deneyle doğrulanmış listesinde | **Açık.** Öneri: "temel bileşen güç faktörü" (K-29). B7-J18'e eklendi |
| B6-T14 | 07:8 "özgün çözünürlükleriyle verilmiştir" | **Açık**, B7-T08 |

---

## 3. Sayı ve terim tutarlılığı (bölümler arası)

| Büyüklük / terim | Bölüm 7 | Öteki yer | Durum |
|---|---|---|---|
| Anma görünür gücü 20 kVA | 07:4, 07:15, 07:378 | 03 tablo, 06:10, Summary | Tutarlı |
| Tasarım güç aralığı 20–25 kW | 07:4, 07:15, 07:378, 07:415 | 03 tablo, 06:10, 08:80, Summary; K-08, K-30 | $P\leq S$ ile çelişiyor (B6-J13). Tez sahibi görüşüyle **Düşük** (B7-N01) |
| Dış anahtarlar 10 kHz PWM | 07:33 (tablo) | 03:515 | Tutarlı |
| Şarj kipi yüksek frekans katı | 07:15 "anahtarlama frekansı sınırları evirici kipiyle ortaktır" | `fig:gt-primer-gerilim`, `fig:gt-sekonder-gerilim` periyodu ~67 µs → ~15 kHz [HESAP] | Okuma farkı, **Düşük** (B7-N02) |
| Vienna doğrultma diyodu sayısı 6 | 07:42 | 3 faz × $D_1$–$D_2$ (03:510) | Tutarlı |
| BYS transformatörü sayısı 3 | 07:79 | 03:24 ($TR1$–$TR3$), `guc_yapi_10.pdf` | Tutarlı |
| Benzetim DA bara gerilimi | metinde yok | `fig:gt-da-bara` iki yarı ~225 V; `fig:gt-primer-gerilim` ±~450 V [HESAP] | Metin sayı vermiyor; jüri şekilden okur (B7-J10) |
| Batarya akımı işareti | 07:181 şarjda pozitif | `fig:gt-batarya-soc` $-9{,}96$ A | **Uyuşmuyor** (B7-J04) |
| SoC birimi | 07:177 0–1 aralığına doyum | `fig:gt-batarya-soc` 61,3 (yüzde) | **Düşük** (B7-N03) |
| $D_1$–$D_2$ adı | "doğrultucu/boost diyotları" 07:22, 07:376, 07:415; "doğrultucu diyotlar" 07:4; "PFC yükseltici diyotları" 07:35, 07:88 | 03:24 "doğrultucu ve yükseltici diyotlar"; 03:39 "PFC diyotları"; 03:510, 03:544 "PFC yükseltici diyotları"; 06:48, 06:81 "Boost diyotları"; 08:119 "doğrultucu/boost"; Summary "boost diodes"; K-36 | **Karışık** (B7-S02) |
| Röle adı | "RL1 fonksiyon anahtarı" 07:6, 07:22; "RL1 rölesi" 07:376, 07:415; "RL1 ve RL2" 07:69 | 03:24 "kip değişim röleleri"; 03:39 "$RL1$--$RL2$"; 06:49, 06:81 "Fonksiyon değiştirme röleleri" | **Karışık**, B7-J05 ve B7-S03 |
| kip / mod | metinde "kip" biçimleri (32), başlık, tablo ve altyazıda "Mod/modları/modu" (11, etiketler hariç) | 01, 08 metninde "kip"; 08:27 "çalışma modu" | **Karışık** (B7-S03) |
| buck / alçaltıcı | "buck" 21 kez (metin, TikZ, tablo) | 01:15, 04, 06 "senkron alçaltıcı"; 08, Özet "senkron-buck" | **Karışık** (B7-S03; rapor 23 B6-S09) |
| transformatör / trafo | metinde "transformatör" (22); TikZ 07:113 ve tablo 07:153 "trafo" (4) | 06:239 "akım trafosu" | **Karışık** (B7-S03) |

**Şekilden okunup elle denetlenen değerler [HESAP]:** primer gerilimi ±~450 V ve DA bara yarıları ~225 V birbiriyle tutarlı (üçgen bağlı primerde hat arası gerilim ±$V_{\mathrm{dc}}$). Primer gücü ~450 V × 0,9 A × ~0,65 doluluk ≈ 260 W/transformatör; batarya tarafı 7 × 3,46 V × 9,96 A ≈ 240 W/transformatör: tutarlı. PFC şebeke akımı tepe ~28 A (~20 A RMS); bu, batarya tarafındaki ~0,75 kW'tan çok daha büyük bir giriş gücüne karşılık gelir (modelde DA barada dirençler görünüyor). Ayrıntı B7-J17.

---

## 4. `\label`–`\ref` taraması

**Yöntem:** `yeni_tez/bolumler`, `onkisim`, `sekiller` altındaki `.tex` dosyalarında `\ref`, `\eqref`, `\autoref`, `\pageref` arandı.

**Bölüm 7'de hiç gönderme almayan etiketler:** `sec:gt-gereksinimler`, `sec:gt-yapi`, `sec:gt-modlar`, `sec:gt-gecis-guvenlik`, `sec:gt-karsilastirma` (kesim etiketleri, olağan). Alt şekil etiketleri `fig:gt-primer` (çatı), `fig:gt-sekonder-gerilim`, `fig:gt-sekonder-akim` (çatı `fig:gt-sekonder` gönderme alıyor, olağan).

**Başka bölümlerden gönderme alan tek Bölüm 7 etiketi:** `chap:gttipi` (01:100, 03:20, 06:4, 06:608, 08:27, 08:65).

**Çıkarılması önerilen etiketler** dış gönderme almıyor: `eq:gt-soc-guncelleme` (iç gönderme yalnız 07:181, B7-A02), `eq:gt-roundtrip-verim` (yalnız 07:411, B7-A03).

**`\kirmizinot` bağımlılığı:** satır 70 `tab:gt-calisma-modlari`'ye gönderme yapıyor; not kalırken etiket korunmalı.

**Bölümler arası gönderme (kural 11):** 07:4'teki `chap:gttipi` bölümün kendi etiketi (rapor 26 §3). B7-T01 uygulanırsa 07:8'deki `chap:deney` göndermesi korunur, 07:383'teki üç gönderme ikiye iner.

---

## 5. Bulgu listesi

Biçim: **Kimlik — tür — öncelik — tahmini kazanç**, ardından yer, alıntı ve öneri.

### 5.1 Tekrarlar

**B7-T01 — tekrar — yüksek — ~150 kelime (Bölüm 7) + ~40 kelime (öteki bölümler)**
- **Konu:** "Evirici kipi deneyle, şarj yönü benzetimle, çalışma kipleri ve koruma tasarım tanımıyla gösterildi."
- **Yer:** **07:8** (cümle 2–3, birincil), 07:348 (cümle 1), 07:371 (tablo hücresi), **07:383** (cümle 1–4), 07:394–399 (doğrulama matrisi, ikinci birincil), 07:415 (cümle 4–5), 07:419 (cümle 3) ↔ 01:45 (cümle 4), 08:4 (cümle 4), 08:36 (cümle 2–3), 08:65 (hücre), 08:80 (cümle 3), Özet, Summary.
- **Alıntı:** 07:8 "Evirici kipinin düşük güç davranışı Bölüm~\ref{chap:deney} altındaki deneylerle, şarj yönünün işlevsel bütünlüğü…" ↔ 07:415 "Şarj zinciri ise benzetim kayıtlarıyla nitel olarak gösterilmiştir."
- **Öneri:** Bilgi 07:8'de (giriş) ve doğrulama matrisinde (07:394–399) kalsın. 07:348 cümle 1, 07:383 cümle 1–4 ("GT-tipi mimarinin kanıtı iki gruptadır… ortaya koymaktadır.") ve 07:415 cümle 4–5 çıksın. 07:383 "Tablo~\ref{tab:gt-dogrulama-matrisi}, her doğrulama katmanında gösterilen işlevi ve dayandığı kanıt türünü vermektedir." cümlesine iner. 07:371 hücresi tabloda kalabilir (karşılaştırmanın bir ölçütü). Bölüm 8'de 08:36 ve 08:80 aynı cümleyi taşıyor; 08:80 cümle 3 çıkabilir (AS4 yanıtında var).

**B7-T02 — tekrar — orta — ~90 kelime**
- **Konu:** Yeniden yapılandırılabilir batarya sistemleri: arıza yalıtımı ve esneklik ↔ ek anahtar, iletim kaybı, sürücü ve denetim karmaşıklığı.
- **Yer:** 07:13 (cümle 4–5), **07:354** (cümle 1–4, birincil) ↔ 02:50 (cümle 1–3), 02:136 (cümle 1–2). Üç yerde aynı atıf üçlüsü (`Momayyezan2016`, `Farakhor2023`, `Huang2024`).
- **Alıntı:** 07:13 "İlave yarı iletkenler ise iletim kaybını, sürücü sayısını, koruma gereksinimini ve denetim karmaşıklığını artırmaktadır." ↔ 07:354 "…ek anahtar ve sürücü kullanımı, iletim kaybı ile kontrol karmaşıklığı doğurmaktadır"
- **Öneri:** 07:13 cümle 1–3 (batarya dizisinin ideal kaynak olmaması) ve son cümle ("Dolayısıyla tasarım değerlendirmesi…") kalsın; cümle 4–5 çıksın, atıflar son cümleye taşınsın. 07:354 tek cümleye insin: "Geleneksel ve yeniden yapılandırılabilir EDS mimarilerinin ödünleşimleri Alt Bölüm~\ref{…}'de verilmiştir; Tablo~\ref{tab:gt-mimari-karsilastirma} GT-tipi yapıyı iki yaklaşımla yan yana koymaktadır." (Bölüm 2'nin ilgili alt bölüm etiketi kullanılır.)

**B7-T03 — tekrar — orta — ~80 kelime**
- **Konu:** GT-tipi mimarinin tanımı: aynı T-tipi yarı iletkenler evirici, Vienna PFC ve batarya yönetiminde.
- **Yer:** 07:4 (cümle 4), **07:6** (birincil), 07:15 (cümle 2), 07:22 (cümle 1–2), 07:376 (cümle 2), 07:415 (cümle 1–2), 07:419 (cümle 1) ↔ 01:21 (cümle 4–5), 01:45, 08:80, 08:127 (son cümle).
- **Alıntı:** 07:15 "Mimarinin amacı, ayrı bir şarj dönüştürücüsü eklemek yerine aynı faz kollarını şarj yönünde de kullanmaktır." ↔ 01:21 "Mimarinin amacı evirici, Vienna PFC ve aktif batarya yönetimi işlevlerini ortak bir donanım üzerinde birleştirmektir."
- **Öneri:** Tanım 07:6'da, işlev eşlemesi 07:22 ve Tablo `tab:gt-eleman-gorevleri`'de kalsın. 07:15 cümle 2 ve 07:376 cümle 2 çıksın. 07:415 ve 07:419 B7-T05 ile birlikte kısalır.

**B7-T04 — tekrar — orta — ~60 kelime**
- **Konu:** Güvenli kip geçişinin dört koşulu (PWM durdurma, akım sıfıra yakın, DA bara dengesi, röle geri bildirimi).
- **Yer:** 07:135 (son cümle), 07:157 (tablo hücresi), **07:186** (cümle 3), **eş. `eq:gt-gecis-izni`** (birincil), 07:254 (tablo hücresi), 07:417 (son cümle) ↔ 08:36 (son cümle), 08:64 (hücre), Summary.
- **Alıntı:** 07:186 "Kip geçişi için PWM'nin durdurulması, faz akımlarının sıfıra yaklaşması ve DA bara yarılarının dengede olması birlikte aranmalıdır." ↔ 07:417 "Güvenli geçiş için PWM'nin durdurulması, sıfıra yakın faz akımı, DA bara dengesi ve röle geri bildirimi birlikte şart koşulmuştur."
- **Öneri:** Denklem ve 07:157 tablo hücresi kalsın. 07:186 cümle 3 "Önerilen izin koşulu" ile birleşsin: "Kip geçiş izni … şeklinde ifade edilmiştir." 07:417 son cümle çıksın (B7-T05).

**B7-T05 — tekrar (ve üst-anlatı) — orta — ~90 kelime**
- **Konu:** Değerlendirme kesimi bölümü yeniden sayıyor.
- **Yer:** 07:415–419 ↔ 07:6, 07:22, 07:142–160 (kip tablosu), 07:186–199.
- **Alıntı:** 07:417 "Bütün parametreler ilk geçtikleri yerde açıklanmıştır."
- **Öneri:** 07:417'nin ilk cümlesi (kip listesi, tabloyu tekrarlıyor), üçüncü cümlesi (üst-anlatı) ve dördüncü cümlesi (B7-T04) çıksın; ikinci cümle "CC–CV referansı ve güvenli kip geçişi için denklemler tanımlanmıştır." olarak kalsın (B7-A02, A03 uygulanırsa SoC ve gidiş–dönüş verimi düşer). 07:415 iki cümleye insin: tanım + kanıt (B7-J01 biçimiyle). 07:419 cümle 1–2 (tanım tekrarı) çıksın, kanıt ve yöntem cümleleri kalsın.

**B7-T06 — tekrar — orta — ~25 kelime**
- **Konu:** "\SI{20}{\kilo\volt\ampere} anma görünür gücü (\num{20}--\SI{25}{\kilo\watt} tasarım güç aralığı)".
- **Yer:** 07:4 (cümle 5), **07:15** (cümle 1, birincil), 07:378 (cümle 2), 07:415 (cümle 1).
- **Öneri:** Güç tabanı 07:15'te bir kez kalsın. 07:4'te "Deney düzeneği GT-tipi olarak kurulmuştur." yeterli; 07:378 ve 07:415'teki parantezler çıksın. Sayısal tutarlılık B7-N01'de.

**B7-T07 — tekrar — düşük — ~35 kelime**
- **Yer:** 07:4 (son iki cümle) ↔ 03:24 (cümle 5–6).
- **Alıntı:** 07:4 "Şeklin alt kısmındaki transformatörler ise şarj yönündeki batarya yönetim sistemi (BYS) transformatörleridir." ↔ 03:24 "Şemanın altındaki $TR1$--$TR3$, şarj yönünde kullanılan batarya yönetim sistemi (BYS) transformatörleridir."
- **Öneri:** 07:4'te tek cümle: "Şekil~\ref{fig:gelen-tam-topoloji} üzerindeki faz hücresi röleleri, PFC yükseltici diyotları ve BYS transformatörleri bu yeniden görevlendirmenin donanım karşılığıdır." (Ayrıca "kip değişimini … diyotlar sağlamaktadır" ifadesindeki teknik sorun kalkar; diyotlar kip seçmez, B7-S02.) BYS kısaltması 02:8'de tanımlı; 07:4'teki yeniden açılım çıkabilir.

**B7-T08 — tekrar (üst-anlatı) — düşük — ~70 kelime**
- **Yer ve öneri:**
  - 07:8 son cümle "Devre şemaları ve benzetim ekranları … özgün çözünürlükleriyle verilmiştir." → çıksın (rapor 23 B6-T14; çözünürlüğe dikkat çekiyor, K-25).
  - 07:140 son cümle "Tablo…, Şekil… işlevleri güvenli bir durum dizisine dönüştürmektedir." → "Tablo~\ref{tab:gt-calisma-modlari} izin verilen kipleri vermektedir."
  - 07:266 cümle 3 "Şarj yönü benzetimi, … S1--S4 zincirinden ayrı tutulmuş ve … tanımlandıktan sonra verilmiştir." → çıksın (metnin kendi sırasını anlatıyor).
  - 07:348 cümle 2 (doğrulama matrisi duyurusu) → çıksın; matris 07:383'te tanıtılıyor.
  - 07:383 "İki kanıt grubu, bölümün çıktısını bir \emph{mimari tanım, kanıt kaydı ve doğrulama yöntemi} bütünü olarak ortaya koymaktadır." → çıksın (B7-T01 ile kalkar).

**B7-T09 — tekrar — düşük — ~35 kelime**
- **Konu:** Batarya başına şarj düzenlemesi ve dengeleme.
- **Yer:** 07:51 (son cümle), **07:97** (birincil), 07:135 (cümle 2), 07:366–368 (tablo).
- **Öneri:** 07:51 son cümle ve 07:97 son cümle çıksın; 07:97'nin ilk iki cümlesi şarj/deşarj enerji yolunu veriyor, kalsın (B7-J06 ile birlikte).

**B7-T10 — tekrar — düşük — ~0**
- **Yer:** `tab:gt-mimari-karsilastirma` orta sütun ("Yeniden yapılandırılabilir literatür örnekleri", 07:363–371) ↔ 02:367–369 (`tab:literatur-karsilastirma` aynı üç çalışma).
- **Öneri:** Değişiklik isteğe bağlı. Sütun nitel karşılaştırmanın parçası; kalabilir. İstenirse 07:371 hücresindeki atıf üçlüsü yerine "Tablo~\ref{tab:literatur-karsilastirma}" gönderimi.

### 5.2 Gereksiz ayrıntı

**B7-A01 — gereksiz ayrıntı (standartlar) — orta — ~90 kelime**
- **Yer:** 07:17 (cümle 5–7, üç IEC standardının kapsamı), 07:261 (paragraf).
- **Alıntı:** 07:17 "IEC~62477-1'in odağı, güç elektroniği dönüştürücülerindeki elektrik çarpması, yangın, ısıl ve enerji tehlikeleridir."
- **Gerekçe:** Standartların kapsam özeti, tezde hiçbir standart maddesine karşı test ya da değerlendirme yapılmadığı için kanıta dönüşmüyor. Jüri "IEC 62477-1'in hangi maddesini sınadınız?" diye sorabilir. 07:261 de nihai uygunluğun neler gerektirdiğini sayıyor; tez kapsamıyla ilgisi zayıf.
- **Öneri:** 07:17 cümle 5–7 tek cümle olsun: "Koruma işlevleri IEC~62619, IEC~62477-1 ve IEC~62933-5-2'nin kapsadığı batarya, dönüştürücü ve sistem tehlikelerinden türetilmiştir \citep{…}." 07:261 çıksın ya da tablo duyurusuna insin: "Tablo~\ref{tab:gt-koruma-dogrulama}, asgari koruma işlevlerini ve kabul ölçütlerini vermektedir."

**B7-A02 — gereksiz ayrıntı (denklem) — orta — ~70 kelime, 1 denklem**
- **Yer:** 07:175–181 (Coulomb sayımıyla SoC güncellemesi, eş. `eq:gt-soc-guncelleme`).
- **Gerekçe:** Ders kitabı bilgisi (atıf Plett2015). Benzetimde kullanılmıyor: `fig:gt-batarya-soc`'taki SoC, Simulink batarya bloğunun kendi çıktısı. Metin sürüklenme ve kestirim gereksinimini anlatıp bırakıyor; jürinin "SoC kestiriminiz nedir?" sorusunu doğuruyor. İşaret kuralı da benzetim kaydıyla çelişiyor (B7-J04).
- **Öneri A (önerilen):** Paragraf ve denklem çıksın. Doğrulama matrisindeki "SoC güncellemesi" (07:398) "CC--CV algoritması, sıcaklık sınırları" olsun. SoC kestirimi 08:121'de gelecek çalışma olarak zaten var.
- **Öneri A2 (denklem korunmak istenirse):** Denklem kalsın, son iki cümle (07:181 "Akım sensörü ofseti … ayrıca tanımlanmalıdır.") çıksın; B7-J04 cümlesi eklensin.

**B7-A03 — gereksiz ayrıntı (tanımlanıp kullanılmayan ölçütler) — orta — ~110 kelime, 1 denklem**
- **Yer:** 07:378 (karşılaştırma ölçütleri listesi), 07:404–411 (gidiş–dönüş verimi denklemi `eq:gt-roundtrip-verim`), 07:419 son cümle ↔ 08:119 (aynı ölçütler gelecek çalışma olarak).
- **Alıntı:** 07:378 "Nitel karşılaştırmayı sayısal düzeye taşıyacak ölçütler de tanımlanmıştır:"
- **Gerekçe:** İkisi de hesaplanmadı. Bir doktora bölümünde tanımlanıp hiç kullanılmayan bir verim denklemi jüriye eksik iş izlenimi verir. Bölüm 8 aynı bilgiyi gelecek çalışma olarak zaten söylüyor (08:119).
- **Öneri:** 07:378 ve 07:404–411 çıksın. 08:119'un son cümlesi şöyle genişlesin: "…tasarımın sayısal karşılaştırmasına; yarı iletken ve sürücü sayısı, manyetik kütle ve gidiş--dönüş verimiyle birlikte eklenmelidir." 07:419 son cümle (yöntemsel temel) çıksın ya da "Mimari karşılaştırma ölçütleri Bölüm~\ref{chap:sonuc}'da gelecek çalışma olarak verilmiştir." olsun.

**B7-A04 — gereksiz ayrıntı (tablo) — düşük — ~0**
- **Yer:** `tab:gt-koruma-dogrulama` (07:240–259, 194 kelime, 8 satır).
- **Öneri:** Tablo tasarım tanımı olarak kalabilir. Altyazı için B7-J13. İsteğe bağlı: "Kabul kanıtı" sütun başlığı "Kabul ölçütü" olsun; sekiz satır hiçbir sonuca bağlanmadığı için ileride kısaltma adayıdır.

### 5.3 Şekil, tablo, altyazı ve terim

**B7-S01 — altyazı (proje kuralı) — orta — ~20 kelime**
- **Yer:** 07:93.
- **Alıntı:** "Her fazda $Q_4$ DA bara orta noktası (NÖTR) tarafındaki, $Q_3$ faz düğümü tarafındaki nötr IGBT'dir."
- **Öneri:** Altyazı "Nötr IGBT gruplarıyla oluşturulan üç fazlı PFC bölümü." olsun. Adlandırma 03:24'te var; gerekiyorsa 07:88 sonuna yan cümle: "($Q_4$ orta nokta, $Q_3$ faz düğümü tarafındadır)".

**B7-S02 — terim ($D_1$–$D_2$) — orta — 0**
- **Yer:** "doğrultucu/boost diyotları" 07:22, 07:376, 07:415; "doğrultucu diyotlar" 07:4; "PFC yükseltici diyotları" 07:35, 07:88 ↔ 03:24, 03:39, 03:510, 03:544, 06:48, 06:81, 08:119, Summary. Karar: K-36 ("PFC yükseltici (boost) diyotları").
- **Sorun:** Okur "doğrultucu" diyotları BYS sekonderindeki doğrultucu diyotlarla (`fig:gt-cok-sekonderli-bys`) ya da Vienna'nın "altı doğrultma diyodu" (07:42) ile ayrı eleman sanabilir. 07:4 ayrıca kip değişimini diyotlara bağlıyor.
- **Öneri:** Bölüm 7 ve 08:119'da tek ad: "PFC yükseltici diyotları ($D_1$--$D_2$)" (ilk geçişte), sonra "$D_1$--$D_2$". 07:42 "altı doğrultma diyodundan" → "altı yükseltici diyottan ($D_1$--$D_2$)". Summary "boost diodes" zaten uyumlu. 03:24 "doğrultucu ve yükseltici diyotlar" da aynı geçişte.

**B7-S03 — terim (kip/mod, buck, trafo, röle) — düşük — 0**
- **Yer ve öneri:**
  - **kip/mod:** kesim başlıkları 07:137 "Şarj ve Deşarj Çalışma Modları" → "…Çalışma Kipleri"; 07:183 "Mod Geçişleri…" → "Kip Geçişleri…"; tablo sütunu 07:149 "Mod" → "Kip"; altyazılar 07:75 "evirici çalışma modu" → "evirici kipi", 07:144 "çalışma modları" → "çalışma kipleri"; 08:27 "çalışma modu" → "çalışma kipi". Etiket adları (`sec:gt-modlar`, `tab:gt-calisma-modlari`) değişmeden kalabilir.
  - **buck:** tez genelinde karar (rapor 23 B6-S09). Öneri: ilk geçişte "alçaltıcı (buck)", sonra "alçaltıcı"; TikZ 07:114 "doğrultucu--alçaltıcı".
  - **trafo:** TikZ 07:113 "BYS trafoları" ve tablo 07:153 "BYS trafosu" → "transformatör".
  - **röle:** "RL1 fonksiyon anahtarı" / "RL1 rölesi" / "kip değişim röleleri" (03) / "Fonksiyon değiştirme röleleri" (06) → tek ad, örneğin "kip seçme rölesi". B7-J05 ile birlikte.

**B7-S04 — şekil (benzetim ekranları) — düşük — 0**
- **Yer:** `fig:gt-pfc-akimlari`, `fig:gt-da-bara`, `fig:gt-primer-*`, `fig:gt-sekonder-*`, `fig:gt-batarya-soc`.
- **Sorun:** Görüntüler MATLAB pencere çerçevesiyle (File/Tools menüleri, "Ready" satırı) gelmiş; şekil içi başlıklar metinde olmayan bilgi taşıyor: "(kontrol öncesi)", "(kontrol sonrası)", "Sekonder tarafta 7 adet batarya…", "(AB fazları arası)". Eksen adları ve birimleri yok.
- **Öneri:** K-25 sınıflamasında bu ekranlar yeniden üretilemeyen sınıftadır (model paketi yok, K-12). Kırpma (çerçeveyi atma) yeni sayı gerektirmez. Şekil içi "kontrol öncesi/sonrası" ifadesi metinde bir kez karşılanabilir: 07:317 "sekonder sargının doğrultma öncesi" zaten "kontrol öncesi"nin anlamını veriyor; 07:339'a "buck çıkışındaki" eklenmesi yeter. Altyazı değişmez.

**B7-S05 — tablo — düşük — 0**
- **Yer:** `tab:gt-dogrulama-matrisi` 07:395 "Düşük güçte verim, akım THD'si, güç faktörü".
- **Öneri:** "temel bileşen güç faktörü" (rapor 23 B6-J04; K-29 toplam PF okumasını değerlendirme dışında tutuyor).

### 5.4 Sayı tutarlılığı

**B7-N01 — sayı (kVA ↔ kW) — düşük — 0**
- **Yer:** 07:4, 07:15, 07:378, 07:415 ↔ 03 tablo, 06:10, 08:80, Summary. Karar: K-08, K-30.
- **Sorun:** Aktif güç görünür gücü aşamaz; 25 kW, 20 kVA anma ile birlikte okunamaz (rapor 23 B6-J13).
- **Öneri A:** B7-T06 ile tek geçişe insin; kalan tek yerde (07:15) "\SI{20}{\kilo\volt\ampere} anma görünür gücü" yeterli. Tez sahibi aralığı korumak isterse değişiklik yok; savunma yanıtı: "20–25 kW pano ve soğutma tasarım hedefi, 20 kVA akım sensörü boyutlandırmasından gelen anma değeridir."

**B7-N02 — sayı (şarj kipi anahtarlama frekansı) — düşük — ~3 kelime**
- **Yer:** 07:15 (son cümle) ↔ `fig:gt-primer-gerilim`, `fig:gt-sekonder-gerilim` (periyot ~67 µs → ~15 kHz [HESAP]) ↔ 03:515 (10 kHz).
- **Öneri A:** 07:15 son cümleden "ve anahtarlama frekansı" çıksın: "Gerilim ve akım sınırları Tablo~\ref{tab:sistem-parametreleri} içinde verilmiştir." Yeni sayı yok.

**B7-N03 — sayı (SoC birimi) — düşük — 0**
- **Yer:** eş. `eq:gt-soc-guncelleme` (0–1 doyumu) ↔ `fig:gt-batarya-soc` (61,3, yüzde).
- **Öneri:** B7-A02 uygulanırsa kalkar. Denklem kalırsa ek iş yok; savunmada yüzde gösterimi olduğu söylenir.

### 5.5 Jüri riski

**B7-J01 — jüri riski (iddia ↔ kanıt) — yüksek — ~0**
- **Yer:** 07:419 (cümle 3) ↔ 07:8, 07:383, 07:395–397; rapor 26 §6.1.
- **Alıntı:** "Evirici kipindeki deneyler ve şarj zinciri benzetim kayıtları, aynı donanımın iki enerji yönünde de işlevini yerine getirdiğini göstermiştir."
- **Sorun:** Donanım yalnız evirici kipinde, yaklaşık 2,3 A'de denendi. Şarj yönü benzetimle gösterildi ve benzetim GT-tipi donanımın modeli değil, şarj kipinin eşdeğer devresi (B7-J02). "Aynı donanımın … iki enerji yönünde" ifadesi jüriye donanım düzeyinde iki yönlü doğrulama gibi okunur. Rapor 26'nın önerisi ("iki enerji yönünün işlevini ortak yarı iletken tabanında göstermiştir") da benzetimin ortak tabanı içerdiğini ima ediyor.
- **Önerilen (yeni sayı yok):** "Evirici kipindeki deneyler deşarj yönünü, şarj kipi benzetim kayıtları ise şarj zincirinin işleyişini göstermiştir."
- **Savunmada sözlü yanıt:** "Donanım GT-tipi kuruldu; evirici kipinde ölçüldü. Şarj kipi aynı devre topolojisinin eşdeğeriyle benzetildi. Kip geçişi tasarım tanımıdır; doğrulaması gelecek çalışma planındadır (Bölüm 8)."

**B7-J02 — jüri riski (benzetim modelinin kapsamı) — yüksek — +~15 kelime**
- **Yer:** 07:266 (cümle 1–2), 07:268, 07:383 (cümle 3), 07:397 (tablo hücresi) ↔ `fig:gt-simulink-modeli` görüntüsü.
- **Alıntı:** 07:266 "GT-tipi topolojinin şarj yönündeki işlevsel bütünlüğü bir Simulink benzetimiyle gösterilmiştir."
- **Sorun:** Model görüntüsünde blok adları "KÖPRÜ DOĞRULTUCU" (altı diyot), "PFC DEVRESİ" (çift yönlü anahtarlar) ve ayrı "EVİRİCİ" bloğu okunuyor; RL1 ve evirici kipiyle paylaşılan $Q_1$–$Q_4$ yok. Yani benzetim GT-tipi yapının şarj kipindeki **eşdeğer devresi**dir: ortak yarı iletken kullanımını ve kip geçişini içermez. Jüri görüntüyü okuyup "GT-tipi topolojiyi mi, klasik Vienna + evirici zincirini mi benzettiniz?" diye sorabilir. Metin bunu açıkça söylerse soru kanıt sınıfının doğru tanımına döner.
- **Önerilen A (yeni sayı yok):**
  - 07:266 cümle 1–2 → "GT-tipi topolojinin şarj kipindeki eşdeğer devresi Simulink'te benzetilmiştir. Model, Vienna PFC'yi, iki seviyeli transformatör besleme katını ve batarya şarj kollarını aynı devrede birleştirmektedir."
  - 07:383 cümle 3 → "Şarj yönü ise topoloji şemaları ve şarj kipi eşdeğer devresinin benzetim kayıtlarıyla gösterilmiştir." (B7-T01 uygulanırsa bu cümle zaten kalkar.)
  - 07:397 hücre → "Benzetim kaydı, şarj kipi eşdeğer devresi (Alt Bölüm~\ref{sec:gt-benzetim})."
  - Bölüm 1, 8, Özet ve Summary'deki "şarj yönünün işlevsel bütünlüğü benzetim kayıtlarıyla gösterilmiştir" ifadesi yanlış değil (zincir şebekeden bataryaya işliyor); değişiklik gerekmez.
- **Altyazı:** 07:273 "Şarj yönündeki Vienna PFC, iki seviyeli evirici ve transformatör tabanlı BYS Simulink modeli." model içeriğini doğru veriyor; değişmez.

**B7-J03 — jüri riski (denklem hatası) — yüksek — −~20 kelime**
- **Yer:** eş. `eq:gt-cccv-referansi` (07:164–171), 07:173.
- **Sorun:** İkinci satır $v_{b,k}\geq V_{\mathrm{CV},k}$ koşulunda $K_{v,k}(V_{\mathrm{CV},k}-v_{b,k})\leq0$ olduğu için $\operatorname{sat}[\cdot,0,I_{\mathrm{CC},k}]=0$ verir. Denklem CV kipini değil, eşikte aç–kapa davranışını tanımlıyor; tablo satırındaki "akım azalıncaya kadar sabit gerilim" (07:155) gerçekleşmiyor. Ayrıca ikinci satırda sıcaklık koşulu yok; sıcaklık sınır dışındayken ikinci ve üçüncü satır birlikte geçerli olabiliyor. Kontrol uzmanı jüri üyesi bunu hemen görür.
- **Önerilen A (yeni sayı yok, denklem kısalır):**
  $$i_{b,k}^{\star}=\begin{cases}\operatorname{sat}\!\left[K_{v,k}\left(V_{\mathrm{CV},k}-v_{b,k}\right),0,I_{\mathrm{CC},k}\right], & T_{\min,k}<T_{b,k}<T_{\max,k},\\ 0, & \text{koruma koşulu}\end{cases}$$
  07:173'e tek cümle: "Gerilim hatası büyükken referans $I_{\mathrm{CC},k}$ sınırında kalmakta (CC), $v_{b,k}$ eşiğe yaklaştıkça akım azalmaktadır (CV)." Simge açıklamaları aynı kalır.
- **İsteğe bağlı:** Oransal düzenleyicide CV kipinde kalıcı gerilim farkı oluşur; istenirse $K_{v,k}$ yerine PI düzenleyici yazılır. Yeni sayı gerekmez.

**B7-J04 — jüri riski (akım işareti) — yüksek — +~20 kelime**
- **Yer:** 07:181 (cümle 3) ↔ `fig:gt-batarya-soc` (batarya akımı $-9{,}96$ A, SoC 61,3 sabit), 07:339.
- **Alıntı:** 07:181 "Akım işareti şarj yönünde pozitif seçilmiştir." ↔ 07:339 "Kayıtta bir bataryanın şarj durumu (State of Charge, SoC), uç gerilimi ve akımı aynı zaman ekseninde verilmiştir."
- **Sorun:** Bölümün şarj yönü kanıtının son halkası olan kayıtta akım negatif. Simulink batarya bloğunun işaret kuralında pozitif akım deşarjdır, yani kayıt şarjı gösteriyor; ama metin bunu söylemiyor ve kendi kuralıyla tersini tanımlıyor. 0,4 s'lik kayıtta SoC görünür biçimde değişmediğinden şarjı yalnız akım işareti gösteriyor.
- **Önerilen A (yeni sayı yok):** 07:339'a: "Benzetim modelinin batarya bloğunda şarj akımı negatif işaretlidir. Kayıt, şarj akımının sabit akım düzeyinde düzenlendiğini göstermektedir." B7-A02 uygulanmazsa 07:181'deki işaret cümlesinin yanına "(benzetim kaydındaki işaretin tersi)" eklenebilir.
- **Önerilen B [HESAP]:** "yaklaşık 10 A sabit akım" sayısı şekilden okunup cümleye eklenir.

**B7-J05 — jüri riski (röle adları, `\kirmizinot` satır 70) — yüksek — +~30 kelime**
- **Yer:** 07:69 ("RL1 ve RL2 evirici konumundayken"), 07:70 (`\kirmizinot`), 07:6, 07:60, 07:79 ↔ `fig:gt-ana-topoloji` (tek SPDT röle, etiket RL1), `fig:gt-evirici-lcl` (aynı konumda tek röle, etiket RL2 / RELAY_2), `fig:gt-iki-seviye-trafo` (RL1, RL2, RL3 = L1, L2, L3 fazlarının röleleri), 03:39 (L3 hücresinde "kip değişim röleleri $RL1$--$RL2$"), `guc_yapi_10.pdf` (RL1–RL6).
- **Bulgu:** Proteus şemasında (`fig:gelen-faz1-hucresi`'nin kaynağı) her faz hücresinde iki röle var. L3 hücresinde RL2, $Q_1$–$Q_2$ orta noktasını $D_1$–$D_2$ ve $Q_3$ düğümüne bağlayan seri kontaktır. RL1 aynı orta noktayı aşağıdaki transformatör hattına bağlıyor. Öteki fazlarda çiftler RL3/RL4 ve RL5/RL6. Bölüm 7'nin sadeleştirilmiş şekilleri bu çifti tek bir SPDT röleyle çiziyor, ama etiketi şekilden şekle değişiyor. Aynı bölümde "RL2" bir şekilde hücre içi ikinci röle, öteki şekilde L2 fazının rölesi anlamına geliyor.
- **Metin notu yanıtlıyor mu:** Hayır. Not kalmalı.
- **Önerilen (tez sahibinin onayıyla, yeni sayı yok):**
  - 07:60'tan sonra iki cümle: "Donanımda her faz hücresinde iki röle bulunmaktadır (Şekil~\ref{fig:gelen-faz1-hucresi}). RL2, $Q_1$--$Q_2$ orta noktasını $D_1$--$D_2$--$Q_3$ düğümüne bağlamakta, RL1 ise aynı orta noktayı BYS transformatörüne aktarmaktadır."
  - 07:69 → "Şekil~\ref{fig:gt-evirici-lcl}, röleler evirici konumundayken oluşan deşarj yolunu göstermektedir."
  - `fig:gt-iki-seviye-trafo`'daki faz sıralı numara için 07:79'a yan cümle: "(şekilde röleler faz sırasıyla numaralandırılmıştır)". Daha temiz çözüm: tez sahibi şekil etiketlerini tek düzene çeker.
  - Böylece tablo `tab:gt-calisma-modlari`, durum makinesi ve eş. `eq:gt-gecis-izni`'deki "RL1" bir röle çiftinin kısaltması olarak okunur; $h_{\mathrm{RL1}}$ iki rölenin geri bildirimini kapsar.
- **Karar defterine:** K-41'in RL2 kutusu bu önerinin onayıyla çözülür. Onay gelmezse kutu kalır.

**B7-J06 — jüri riski (batarya–DA bara bağlantısı) — yüksek — +~20 kelime (A)**
- **Yer:** TikZ `fig:gt-sentez-mimarisi` (07:109–129: deşarj oku "dc → inv", bataryadan DA baraya ok yok), 07:97 (cümle 2), 07:140 ("kontaktörler"), 07:151 ↔ 03:11 ("Deşarj yönünde enerjinin kaynağı batarya veya ayarlanabilir DA kaynaktır").
- **Sorun:** Şarjda DA barayı Vienna PFC kuruyor, transformatörler DA baradan bataryaları besliyor. Deşarjda bataryalar ortak DA barayı besliyor. Şarj sırasında batarya dizisinin DA baradan ayrılması gerekir; ayrılmazsa PFC çıkışı diziye doğrudan bağlanır ve batarya başına düzenleme anlamını yitirir. Bölümde bu ayırma ve bağlama düzeni tanımlı değil. Sentez şekli de deşarj yönünde enerjinin nereden geldiğini göstermiyor. Seri deşarj ve baypas devresi K-30 ile tezden çıkarıldığı için boşluk bilinçli, ama jürinin sorusu kalıyor.
- **Önerilen A (yeni bilgi yok, mevcut metinle tutarlı):** TikZ'e "battery → dc" yönünde, "deşarj" etiketli bir ok. 07:97 cümle 2 → "Deşarjda batarya grupları ortak DA barayı beslemekte, enerji T-tipi evirici üzerinden şebekeye aktarılmaktadır."
- **Önerilen B [YENİ SAYI değil, tez sahibi bilgisi]:** Şarj kipinde dizinin DA baradan hangi elemanla (ana kontaktör) ayrıldığı tek cümleyle yazılır; tablo 07:153 "Şebekeden şarj" satırına "batarya dizisi DA baradan ayrılmış" eklenir.
- **Savunmada sözlü yanıt:** "Şarjda batarya dizisi ana kontaktörle DA baradan ayrılır; bataryalar yalnız yalıtılmış alçaltıcı kollardan beslenir. Deşarj yolu patent başvurusunda tanımlıdır; tezde kapsam evirici kipiyle sınırlandı." (Yanıtın içeriği tez sahibince doğrulanmalı.)

**B7-J07 — jüri riski ($D_1$–$D_2$'nin evirici kipindeki durumu) — orta — ~0**
- **Yer:** 07:35 (tablo hücresi "Kararlı çalışmada iletimde değil") ↔ 03:544 ("Faz gerilimi DA raylarını aşmadığından kararlı çalışmada $D_1$--$D_2$ iletime girmemektedir") ↔ `fig:gt-evirici-lcl`, `guc_yapi_10.pdf`.
- **Sorun:** Evirici konumunda röle $Q_1$–$Q_2$ orta noktasını $D_1$–$D_2$ düğümüne bağlıyor; $D_1$ ve $D_2$ böylece $DS_1$ ve $DS_2$'ye paralel. Akım dış anahtarın ters paralel diyodundan DA rayına döndüğünde (klasik anahtarlamada ters akım aralıkları, Bölüm 4'ün konusu; reaktif akım) düğüm gerilimi rayı bir diyot düşümü kadar aşar ve $D_1$–$D_2$ akımı paylaşır. Veri sayfası değerleri ($V_f$ 1,58 V ↔ 1,50 V; $r_F$ 8,5 ↔ 10,2 mΩ, 03:508–510) paylaşımın akıma bağlı olduğunu gösteriyor. "Faz gerilimi DA raylarını aşmaz" gerekçesi bu aralıkları kapsamıyor. Hesapla doğrulanmadı.
- **Önerilen A (yeni sayı yok):** 07:35 hücresi → "Görevi şarj kipindedir". 03:544'teki gerekçe cümlesi çıksın ya da "Susturmalı çalışmada ters akım yolu bulunmadığından …" biçiminde susturmayla sınırlandırılsın (Bölüm 4: susturmada ters yönde yol yok).
- **Önerilen B [YENİ SAYI]:** S1 benzetim kaydından $D_1$–$D_2$ akımı okunur (diyot blokları modelde var, 03:630).

**B7-J08 — jüri riski (eleman sayısı ve maliyet iddiası) — orta — ~0**
- **Yer:** 01:45 (son cümle), 08:64 (hücre), 08:80 (son cümle), Özet (son cümle), Summary ↔ 07:370 ("röle, diyot ve buck kolları eklenir"), 07:376 (cümle 3–4, bedeller), 07:378 (ölçütler tanımlı, hesap yok).
- **Alıntı:** 08:80 "…sürücü, koruma ve soğutma altyapısını ortak kullanma ve maliyet ile hacmi azaltma olanağı sunmaktadır."
- **Sorun:** Bölüm 7 ortak kullanımı nitel olarak gösteriyor ve eklenen elemanları dürüstçe sayıyor; sayım ya da maliyet karşılaştırması yok. "Eleman sayısını azaltma" (01, 08, Özet) eklenen röle, diyot ve alçaltıcı kollarla birlikte okunduğunda jürinin "net sayım nerede?" sorusunu doğurur. "Maliyet ile hacmi azaltma" Bölüm 7'de hiç geçmiyor.
- **Önerilen A (yeni sayı yok, Bölüm 7'deki tabloya dayanır):** 01:45, 08:64, Özet → "…ayrı PFC ve şarj katlarının aktif anahtarlarını ve sürücülerini ortak kullanma olanağı sunmaktadır." 08:80 → "…sürücü, koruma ve soğutma altyapısını ortak kullanma olanağı sunmaktadır." Summary aynı biçimde.
- **Önerilen B [HESAP]:** 07:370 hücresine aktif anahtar sayımı (ayrı Vienna + ayrı yarım köprü ↔ GT-tipi). Sayım topoloji şemalarından yapılır, tez sahibi onayı gerekir.

**B7-J09 — jüri riski (AS4 ↔ kip tablosu) — orta — ~0**
- **Yer:** 01:34 (AS4 "şarj--deşarj ve hücre dengeleme kiplerinde") ↔ 07:142–160 (dengeleme kipi yok), 07:97, 07:367 ("Şarjda batarya başına bağımsız akım/gerilim düzenlemesi"), 08:36 (AS4 yanıtında dengeleme yok).
- **Sorun:** Soru dengeleme kipini soruyor; yanıt ve bölüm dengelemeyi ayrı bir kip olarak değil, şarjdaki batarya başına düzenlemenin sonucu olarak veriyor. "Hücre" de bölümde geçmiyor; benzetim batarya düzeyinde.
- **Önerilen A:** 01:34 → "…şarj--deşarj ve batarya bazlı şarj denetimi kiplerinde…" (08:127'deki üçlüyle aynı). Ya da 08:36'ya bir cümle: "Batarya dengeleme, şarj kipindeki batarya başına akım ve gerilim düzenlemesiyle sağlanmaktadır."

**B7-J10 — jüri riski (benzetim koşulları) — orta — ~0 (A)**
- **Yer:** 07:266–346 (hiçbir çalışma koşulu yazılmamış) ↔ şekillerden okunan değerler [HESAP]: DA bara yarıları ~225 V (`fig:gt-da-bara`), primer ±~450 V ve ~15 kHz (`fig:gt-primer-gerilim`), PFC akımı tepe ~28 A (`fig:gt-pfc-akimlari`), batarya 3,46 V ve 7 batarya/transformatör (şekil içi başlık), ↔ 07:15 ("sınırları evirici kipiyle ortaktır"), 03 tablo (230/400 V şebeke).
- **Sorun [HESAP]:** Vienna doğrultucu yükseltici tiptir; DA bara gerilimi hat arası tepe gerilimin üstünde olmalıdır (400 V şebekede ≈566 V). Şekillerdeki ~450 V bara, benzetimin 230/400 V anma şebekesinde değil, daha düşük bir şebeke geriliminde yapıldığını gösteriyor. 3,46 V'luk "batarya" da hücre ölçeğinde. Metin bu koşulları vermediği için çelişki metinde yok; ama jüri eksen değerlerini okursa "şarj kipini anma koşulunda benzettiniz mi?" diye sorar.
- **Önerilen A (yeni sayı yok):** B7-N02'deki 07:15 düzeltmesi (benzetimin anma sınırlarında yapıldığı izlenimini kaldırır). Metne sayı eklenmez; K-12 ile uyumlu.
- **Önerilen B [YENİ SAYI]:** Tez sahibinde model ya da kayıt varsa 07:266'ya tek cümle: şebeke gerilimi, DA bara referansı, transformatör başına batarya sayısı ve batarya gerilimi.
- **Savunmada sözlü yanıt:** "Şarj benzetimi işlevsel zinciri ölçekli bir çalışma noktasında gösterir; anma gücündeki şarj tasarım hedefidir."

**B7-J11 — jüri riski (primer bağlantısı ve yorum) — orta — +~5 kelime**
- **Yer:** 07:79, 07:295 (cümle 2) ↔ `fig:gt-iki-seviye-trafo` (TR1 L1–L2, TR2 L2–L3, TR3 L3–L1 arasında: üçgen), `fig:gt-primer-gerilim` şekil içi başlık "(AB fazları arası)", patent şekli (AB/BC/CA).
- **Alıntı:** 07:295 "Primer geriliminin pozitif, sıfır ve negatif seviyeler arasında değişmesi, görev oranı üzerinden transformatöre aktarılan gücün ayarlanabildiğini göstermektedir."
- **Sorun:** Metin her fazda "iki seviyeli yarım köprü" diyor; jüri "yarım köprü sıfır seviyesini nasıl üretir?" diye sorar. Yanıt şekilde var: primerler iki faz kolu arasına bağlı. Ayrıca tek bir görev oranındaki dalga biçimi gücün "ayarlanabildiğini" göstermez.
- **Önerilen (yeni sayı yok):** 07:79 cümle 2 → "Bağlantıda üç fazın $Q_1$--$Q_2$ yarım köprüleri, faz arası (üçgen) bağlı üç çok sekonderli BYS transformatörünün primerlerini beslemektedir." 07:295 cümle 2 → "Faz arası bağlı primerin gerilimi pozitif, sıfır ve negatif seviyelerden oluşmakta, sıfır aralığının genişliği aktarılan gücü belirlemektedir."

**B7-J12 — jüri riski (güvenli durumun anlatımı) — orta — 0**
- **Yer:** 07:151 (tablo hücresi).
- **Alıntı:** "Bütün PWM'ler ve ana kontaktörler kapalı"
- **Sorun:** Türkçe elektrik dilinde "kontaktör kapalı" kontakların kapalı, yani devrenin iletimde olması anlamına da gelir. Güvenli kapalı durumun tanımı tam tersini söylüyor gibi okunabilir.
- **Öneri:** "PWM'ler durdurulmuş, ana kontaktörler açık (enerji yolu kesik)".

**B7-J13 — jüri riski (koruma tablosunun altyazısı) — orta — 0**
- **Yer:** 07:242 ↔ 07:399 ("Tasarım tanımı: koruma işlevleri ve kabul testi planı").
- **Alıntı:** "GT-tipi mimari için asgari koruma işlevleri ve doğrulama kanıtları."
- **Sorun:** "Doğrulama kanıtları" elde edilmiş kanıt gibi okunuyor; tablonun sütunu yapılacak kabul testini tanımlıyor. Doğrulama matrisi doğru biçimde "kabul testi planı" diyor.
- **Öneri (altyazıda sözcük değişikliği, cümle eklenmez):** "GT-tipi mimari için asgari koruma işlevleri ve kabul ölçütleri." Sütun başlığı "Kabul ölçütü".

**B7-J14 — jüri riski (geçiş izninde geri bildirim) — düşük — ~0**
- **Yer:** eş. `eq:gt-gecis-izni` ($h_{\mathrm{RL1}}=1$), 07:199 ↔ 07:157 ("geri bildirim doğrulanmadan yeni kip başlatılmaz"), durum makinesi "röle doğrulandı" oku.
- **Sorun:** $h_{\mathrm{RL1}}=1$ "rölenin beklenen konumu doğruladığını" söylüyor; geçiş başlamadan röle yeni konumda olamaz. Ön koşul (eski konum doğru) ile son koşul (yeni konum doğrulandı) aynı simgede.
- **Öneri:** 07:199 → "$h_{\mathrm{RL1}}=1$ ise röle konum geri bildiriminin $k$ kipine ait konumu doğruladığını göstermektedir. Yeni konumun doğrulanması Şekil~\ref{fig:gt-durum-makinesi}'deki ayrı geçiştir."

**B7-J15 — jüri riski (durum makinesi) — düşük — 0**
- **Yer:** `fig:gt-durum-makinesi` (07:213–232).
- **Sorun:** Olağan durdurma yolu yok: "Hazır", "Şarj" ya da "Deşarj"dan "Güvenli kapalı"ya yalnız "Kilitli hata" üzerinden gidiliyor. Şarj sonunda (CV bitince) "Hazır"a dönüş de yalnız RL1 geçişinden geçiyor.
- **Öneri (TikZ, yeni bilgi yok):** "ready → off" yönünde "durdur" oku; isteğe bağlı "charge → ready" ve "dis → ready" yönünde "akım sıfırda dur" okları.

**B7-J16 — jüri riski (aşırı yorum) — düşük — −~10 kelime**
- **Yer:** 07:317 (cümle 3).
- **Alıntı:** "…sekonder doğrultucunun ve buck girişinin primer anahtarlamasıyla eşzamanlı çalıştığını göstermektedir."
- **Öneri:** Diyot doğrultucu doğası gereği eşzamanlıdır. "Akım, primer anahtarlamasının enerji aktarım aralıklarında akmaktadır." yeterli.

**B7-J17 — jüri riski (güç dengesi, yalnız savunma) — düşük — 0**
- **Yer:** `fig:gt-pfc-akimlari` ↔ `fig:gt-primer-*`, `fig:gt-batarya-soc`.
- **Sorun [HESAP]:** PFC akımı (~20 A RMS) hangi şebeke geriliminde olursa olsun birkaç kW giriş gücü verir; transformatör ve batarya tarafı ~0,75 kW (3 × ~250 W). Model görüntüsünde DA barada dirençler var; fark büyük olasılıkla bu yüklerden. PFC ve DA bara kayıtları 0–0,2 s, öteki kayıtlar 0,4 s anına ait; kayıtlar farklı koşulara ait olabilir.
- **Öneri A:** Metinde değişiklik yok; metin güç sayısı vermiyor. Savunma yanıtı: "PFC kaydı DA barada ek yükle alınmıştır; batarya zinciri kayıtları aynı modelin 0,4 s anındaki değerleridir." (Tez sahibince doğrulanmalı.)

**B7-J18 — jüri riski (katkı tanımı ↔ bölüm içeriği) — düşük — 0**
- **Yer:** 01:45 (cümle 2) ↔ `tab:gt-mimari-karsilastirma` ölçütleri.
- **Alıntı:** 01:45 "Katkı, klasik ayrık mimariyle çalışma kipleri, anahtarlama durumları, enerji akış yolları ve güvenlik kısıtları üzerinden karşılaştırılmaktadır."
- **Sorun:** Bölüm 7'nin karşılaştırma tablosu şebeke arayüzü, şarj, dengeleme, arıza ayırma, yalıtım, yarı iletken yükü ve kanıt düzeyini karşılaştırıyor; anahtarlama durumu karşılaştırması yok.
- **Öneri:** 01:45 → "Katkı, klasik ayrık mimariyle şebeke arayüzü, batarya şarjı, galvanik yalıtım ve yarı iletken yükü üzerinden nitel olarak karşılaştırılmaktadır." Ayrıca 07:395 için B7-S05.

**B7-J19 — jüri riski (savunmacı başlık) — düşük — 0**
- **Yer:** 07:380 "Doğrulama Durumu ve Mevcut Kanıt Düzeyi".
- **Öneri:** "Doğrulama Matrisi" ya da "Doğrulama Durumu". "Mevcut" sözcüğü eksiği vurguluyor (rapor 26 §5, kural 8).

**B7-J20 — jüri riski (ad) — düşük — 0**
- **Yer:** 07:6 "\emph{geliştirilmiş/değiştirilmiş T-tipi}".
- **Öneri:** Tez başlığıyla aynı tek sözcük: "geliştirilmiş T-tipi". Patentlerdeki "Değiştirilmiş T Tipi" adı istenirse ayrı bir yan cümleyle verilir: "(patent belgelerinde ``değiştirilmiş T tipi'')".

**B7-J21 — jüri riski (işlevsel ilke) — düşük — 0**
- **Yer:** 07:17 cümle 2 "Enerji yolu çift yönlü olabilmeli" ↔ yapı: şarjda tek yönlü Vienna, deşarjda evirici, röleyle seçiliyor.
- **Öneri:** "Enerji iki yönde aktarılabilmeli" (aynı dönüştürücüde çift yönlü akım iddiası çağrıştırmaz).

---

## 6. Yeni sayı ya da tez sahibi bilgisi gerektiren öneriler

| Kimlik | Ne gerekir | Gerekmezse yapılacak (A) |
|---|---|---|
| B7-J04 (B) | [HESAP] "yaklaşık 10 A" şekilden okunur | İşaret kuralı cümlesi, sayısız |
| B7-J05 | Tez sahibi onayı: RL1/RL2 görevleri (Proteus şemasından okundu) | `\kirmizinot` kalır |
| B7-J06 (B) | Tez sahibi bilgisi: şarjda batarya dizisini ayıran eleman | TikZ oku ve 07:97 cümlesi |
| B7-J07 (B) | [YENİ SAYI] S1 kaydından $D_1$–$D_2$ akımı | Hücre "Görevi şarj kipindedir"; 03:544 gerekçesi çıkar |
| B7-J08 (B) | [HESAP] aktif anahtar sayımı (topoloji şemalarından) | "aktif anahtarlarını ve sürücülerini ortak kullanma" |
| B7-J10 (B) | [YENİ SAYI] şarj benzetiminin şebeke gerilimi, bara referansı, batarya sayısı | 07:15 düzeltmesi; metne sayı eklenmez |
| B7-J17 | Tez sahibi bilgisi: PFC kaydındaki DA bara yükü | Savunma yanıtı |
| B7-N01 | K-08'in güncellenmesi (tez sahibi kararı) | Tek geçiş, "20 kVA" |

---

## 7. Önerilen uygulama sırası

1. **Jüri riski düzeltmeleri (önce, kısaltılacak paragraflara dokunuyor):**
   - B7-J03 (CC–CV denklemi), B7-J04 (07:339), B7-J01 (07:419), B7-J02 (07:266, 07:383, 07:397), B7-J06 (TikZ oku, 07:97), B7-J11 (07:79, 07:295), B7-J12 (07:151), B7-J13 (07:242).
   - B7-J05: tez sahibinin onayı gelirse iki cümle ve `\kirmizinot` silinir; gelmezse not kalır.
   - B7-J07 (07:35, 03:544), B7-J08 (01:45, 08:64, 08:80, Özet, Summary), B7-J09 (01:34 ya da 08:36), B7-J18 (01:45).
2. **Gereksiz ayrıntı:** B7-A02 (SoC denklemi), B7-A03 (07:378, gidiş–dönüş verimi → 08:119), B7-A01 (IEC cümleleri, 07:261).
3. **Bölüm içi tekrarlar:** B7-T01, T03, T04, T05, T06, T08, T09; B7-T02 (Bölüm 2 göndermesiyle).
4. **Altyazı, terim, tablo:** B7-S01 (07:93), B7-S02 ($D_1$–$D_2$ adı, 03:24 ve 08:119 dahil), B7-S03 (kip/mod başlıkları, trafo, röle adı; buck tez geneli kararıyla), B7-S05 (07:395).
5. **Düşük öncelikli:** B7-N01–N03, B7-J14–J17, J19–J21, B7-S04, B7-T07, T10.
6. **Kararlar** `01_KARAR_DEFTERI.md`'ye yazılır: K-41 RL2 kutusu (B7-J05), K-36'nın Bölüm 7 ve 8'e uygulanması (B7-S02), K-12'nin şarj benzetimi için "eşdeğer devre" ifadesiyle güncellenmesi (B7-J02).
7. **Her adımdan sonra** Ayakaleaf'te derlenmeli ve tanımsız gönderme kalmadığı denetlenmeli. Derlemeyi ana oturum yapar.

**Korunması gereken etiketler:** `chap:gttipi` (01:100, 03:20, 06:4, 06:608, 08:27, 08:65). `\kirmizinot` kaldıkça `tab:gt-calisma-modlari`. Çıkarılabilecek etiketler: `eq:gt-soc-guncelleme`, `eq:gt-roundtrip-verim` (dış gönderme yok).
