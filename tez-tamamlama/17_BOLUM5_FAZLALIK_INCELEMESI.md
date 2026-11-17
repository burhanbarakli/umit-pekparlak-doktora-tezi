# Bölüm 5 fazlalık, gereksiz ayrıntı, tekrar ve jüri riski incelemesi

- **Kapsam:** `yeni_tez/bolumler/05-sin3-kompanzasyon.tex` (567 satır). Tekrar karşılaştırması için 01, 02, 03, 04, 06, 08 ve `onkisim/ozet.tex` okundu. `onkisim/simgeler.tex`, `tezpaketleri.sty` (`\graphicspath`, ondalık ayırıcı), `jüri istekleri/ümit pekparlak yorumları.txt`, `tez-tamamlama/00_TAMAMLAMA_PLANI.md` (jüri maddeleri 7 ve 8), review notları `2026-10-28_S4_KAPALI_CEVRIM.md`, `2026-10-28_KARARLILIK_BODE.md` ve `results/sin3_rescan_20260901/*.csv` denetlendi.
- **Bakış açısı:** jüri üyesi, tez danışmanı, güç elektroniği ve denetim uzmanı. Yalnız içerik ve yapı incelendi. Bölüm 5 dil açısından az önce sadeleştirildiği için (rapor 16) dil önerisi yok.
- **Görev kipi:** incele (yalnız rapor). Hiçbir `.tex` dosyası değişmedi. Derleme ve commit yapılmadı.
- **Tarih:** 17.11.2026. Satır numaraları dosyaların bugünkü hâline aittir. Alıntılar en çok 20 kelimedir.
- **Kelime sayımı:** `wc -w` ile, `%` yorum satırları dışarıda, LaTeX komutları dahil (rapor 12 ve 14 ile aynı yöntem). Sayfa kestirimi ~300 kelime/sayfa.
- **Göz önünde tutulan jüri istekleri:** madde 7 "Sin³ için kapalı çevrim ve Bode analizi (analitik ispat + L/S/T Bode, K3 açık/kapalı + marj tablosu)" ve madde 8 "Nominal güçte kapalı çevrim (2,3 / 10 / 25 A; akım izleme, THD, η, doyum, geçici rejim)". Bu iki maddenin kabul kanıtı olan öğelerin (analitik katman, `tab:kararlilik-marjlar`, L/S/T şekilleri, `tab:s4-tarama`, basamak sonucu) çıkarılması önerilmiyor; yalnız çevreleri sadeleştiriliyor.

---

## 1. Özet

### 1.1 Kelime sayısı

| Kesim | Satır | Kelime | Pay |
|---|---|---:|---:|
| Bölüm girişi | 1–5 | 148 | %2 |
| 5.1 Sin³ bileşeninin matematiksel tanımı | 6–29 | 284 | %4 |
| 5.2 Basitleştirilmiş türetimlerin geçerlilik sınırı | 30–46 | 388 | %5 |
| 5.3 Düşük güçte harmonik oluşum mekanizması (1 şekil) | 47–126 | 724 | %10 |
| 5.4 Analitik katsayıların doğru özdeşlikle hesabı (1 tablo, 1 şekil) | 127–176 | 565 | %8 |
| 5.5 Önerilen yapı ve ileri besleme mekanizması (TikZ 147 dahil) | 177–218 | 379 | %5 |
| 5.6 Senaryo 3 benzetim kayıtları (1 şekil) | 219–232 | 177 | %2 |
| 5.7 Senaryo 4: giriş ve model şekli | 233–244 | 153 | %2 |
| 5.7.1 Model ve denetleyici yapısı | 245–257 | 312 | %4 |
| 5.7.2 Düşük, orta, anma akımı taraması (1 tablo, 2 şekil, `\umitnot`) | 258–311 | 866 | %12 |
| 5.7.3 Basamak yanıtı (1 tablo, 1 şekil) | 312–342 | 195 | %3 |
| 5.8 Kararlılık: giriş | 343–347 | 84 | %1 |
| 5.8.1 Analitik katman | 348–370 | 286 | %4 |
| 5.8.2 Frekans alanı (2 tablo, 4 şekil) | 371–492 | **1 372** | **%19** |
| 5.8.3 Zaman alanı (2 tablo, 2 şekil) | 493–555 | 837 | %12 |
| 5.8.4 Dayanılan model ve varsayımlar | 556–559 | 129 | %2 |
| 5.9 Değerlendirme | 560–567 | 247 | %3 |
| **Toplam** | | **7 146** | |
| `\umitnot` hariç (PDF'te görünen) | | 6 969 | |

Öbekler: Sin³ özü (tanım, mekanizma, katsayı) ~1 570 kelime (%22); Sin³'ün çevrim dışı olduğunun kanıtı (analitik katman + zaman alanındaki $K_{34}$ kısımları) ~540 (%8); S3 sonucu 177 (%2); S4 izleme sonuçları ~1 530 (%21); akım çevriminin kendi kararlılığı (marjlar, gecikme, $L_g$, $\lambda$, Padé, ayrık model, doğrusallaştırma) ~1 960 (%27); çevre anlatım (geçerlilik sınırı, eşpotansiyel, giriş, değerlendirme, varsayımlar) ~1 290 (%18).

### 1.2 Bulgu sayısı

| Tür | Yüksek | Orta | Düşük | Toplam |
|---|---:|---:|---:|---:|
| Tekrar | 2 | 8 | 8 | 18 |
| Gereksiz ayrıntı | 1 | 6 | 3 | 10 |
| Yanlış yer | 0 | 3 | 0 | 3 |
| Oran | 0 | 1 | 0 | 1 |
| Şekil/tablo | 0 | 3 | 3 | 6 |
| Jüri riski | 4 | 9 | 8 | 21 |
| **Toplam** | **7** | **30** | **22** | **59** |

### 1.3 Önerilerin hepsi uygulanırsa tahmini kazanç

- **Bölüm 5 içinde ~1 700 kelime (~%24).** Bulgulardaki tek tek kazançların toplamı ~1 975 kelimedir. Örtüşmeler (H-19 ile H-13, H-14, H-29, H-30; H-10 ile H-11; H-08 ile H-26) düşülünce ~1 700 kalır.
- **Şekil ve tablo:** dört birleştirme ya da çıkarma (H-33, H-34, H-35, H-22) ~1,9 sayfa kazandırır.
- **Jüri riski düzeltmelerinin ekleri:** ~120 kelime (H-39, H-41, H-45, H-44, H-49 koşul cümleleri). Kazanca dahil edilmedi.
- **PDF'te görünen net kazanç:** Bölüm 5'te ~5,3 sayfa metin + ~1,9 sayfa şekil/tablo − ~0,4 sayfa ek = **~6,8 sayfa**.
- **Diğer bölümler:** Bölüm 5 ile çakışan tekrarlar (Bölüm 3'te ~130, Bölüm 6'da ~45, Bölüm 4'te ~20 kelime) da kaldırılırsa ek ~0,7 sayfa.
- **Tez geneli:** ~7–7,5 sayfa.
- Önerilerden sonra Bölüm 5 ~5 400 kelime, 12 şekil ve 6 tablo olur (bugün 15 şekil, 8 tablo). Sin³ özü ile çevrim dışı kanıtının payı %30'dan ~%38'e çıkar (H-32).
- **Başlık:** Yalnız "Basitleştirilmiş Türetimlerin Geçerlilik Sınırı" kesiminin kalkması öneriliyor (H-19). Gerekçe güçlü: kesim tezde bulunmayan bir türetimi çürütüyor, bir paragrafı tezin kendi kalibrasyon yöntemiyle çelişiyor (H-40), kalan içerik Bölüm 2'nin literatürü ile Alt Bölüm 5.8.4'ün varsayımıdır. Kesimin etiketi yoktur, hiçbir yerden gönderme almıyor.

### 1.4 En önemli 5 öneri

1. **Kararlılık sonucunun geçerli olduğu gerçeklemeyi açık yaz (H-39).** `tab:kararlilik-marjlar` içindeki (B) ve (B2) satırlarında Nyquist sayımı 1, GM negatif; `tab:kararlilik-lg` son sütununda (B) için $\max|z|=1{,}175$–$1{,}277$. Bir periyot hesaplama gecikmeli sayısal gerçeklemede aynı kazançlarla çevrim kararlılığını yitiriyor. Metin bunu "gecikme duyarlılığı" diye geçiyor ve sonucu söylemiyor (05:433, 05:455). Denetim uzmanı jüri üyesi ilk bunu soracak: $L_1$ akımı geri beslemesi ve $f_{\mathrm{res}}>f_s/6$ ile bilinen kural, aktif sönümlemesiz çevrimin gecikmeli gerçeklemede kararsız olduğudur. 08:115 doğru gelecek çalışmayı zaten yazıyor. Bölüm 5'e tek bir olumlu koşul cümlesi yeter. Yeni sayı gerekmez.
2. **"Basitleştirilmiş Türetimlerin Geçerlilik Sınırı" kesimini kaldır (H-19, H-40, H-30, H-29).** 05:32 "sabit bir $k_1/k_3$ oranından daha kapsamlı bir modelle belirlenmelidir" diyor; tezin kalibrasyonu ise tam olarak sabit oranla yapılmış (06:522 "S3'te $K_{33}/K_{13}$ oranı sabit tutularak", 03:538). 05:41 katsayıların HTF ile "belirlenmelidir" dediği yöntem tezde kullanılmıyor. Kesimin geri kalanı Bölüm 2'yi (02:317, 02:319) tekrarlıyor ve 05:43, S4'ü tanıtılmadan önce S4 sonucu veriyor. Kazanç ~330 kelime. 08:76'daki "tek bir cebirsel iptal koşulundan türetilemeyeceği gerekçelendirilmiş" cümlesi de buna göre düzeltilmeli.
3. **Analitik katmanın karşılaştırma tabanını düzelt (H-41, H-42, H-50).** Tarama S1 noktasında ($V_m/V_h=0{,}785$), mekanizma şekli S2'de ($0{,}866$), kıyaslanan kalibre edilmiş katsayılar S3'te ($0{,}822$) tanımlı. Eşitlik `eq:dcm-sinus-zarfi` ile S3 noktasında saf sinüs oranı ~%46 olur, %39,96 değil (elle hesap). 05:154'teki üç katsayı çifti veri dosyasının adına göre "eski aday noktalar"dır (`eski_aday_noktalarin_kontrolu.csv`); metin bunları "farklı bir çalışma noktası için elle seçilmiş" diye veriyor ve "dört katı" karşılaştırması tepe akımı ile RMS akımı karıştırıyor. Paragraf çıkarılmalı; "doğru özdeşlik" ve "düzeltilmiş aday" ifadeleri de önceki bir yanlışı çağrıştırdığı için kalkmalı.
4. **Tanım ve sonuç tekrarlarını tek yere indir (H-01, H-03, H-04, H-06, H-11).** Sin³ özdeşliği, harmonik eşdeğeri, "pozitif işaretli, normalizasyonsuz" ve $K_{1x}$/$K_{3x}$ adlandırması 03:355–370'te ve 05:8–28'de iki kez tanımlanıyor (03'teki `eq:sin3-ozdeslik` hiç gönderme almıyor). 05:247 denetim yapısını 03:355–365'ten aynen yineliyor. 05:231'in tamamı Bölüm 6'nın kalibrasyon içeriği. "En uygun genlik akım düzeyine bağlıdır" bölüm içinde beş kez geçiyor. Kazanç ~420 kelime.
5. **Aynı veriyi iki kez gösteren şekil-tablo çiftlerini birleştir (H-33, H-34, H-35, H-26).** `fig:s4-tarama-ozet` = `tab:s4-tarama`; `tab:s4-basamak` + `fig:s4-basamak` ile `tab:kararlilik-basamak` + `fig:kararlilik-basamak` aynı 10→25 A PI basamağı (aynı koşu, `KC_PI_basamak_10_25A`) ve yerleşme süresi 0,44 ile 0,43 ms olarak iki farklı değerle veriliyor; `fig:kararlilik-lg` = `tab:kararlilik-lg`. $\lambda$ paragrafı ve Padé eşitliği kazanç marjının ve tek bir yan cümlenin taşıyabileceği bilgiyi yineliyor. Kazanç ~1,6 sayfa şekil/tablo + ~150 kelime.

### 1.5 Jüri riski taşıyan noktalar

| Kimlik | Konu | Yer |
|---|---|---|
| H-39 | Sayısal gerçeklemede (B, B2) Nyquist = 1 ve $\max|z|>1$; metin sonucu söylemiyor | 05:381–391, 05:433, 05:455, `tab:kararlilik-marjlar`, `tab:kararlilik-lg` |
| H-40 | "Sabit $k_1/k_3$ oranı yetmez" önermesi ile sabit oranlı kalibrasyon çelişiyor; HTF ile "belirlenmelidir" denen yöntem uygulanmamış | 05:32, 05:41 ↔ 06:522, 03:538 |
| H-41 | Tarama, mekanizma ve kalibre katsayı üç farklı çalışma noktasında; "doğru büyüklükte öngörmektedir" yargısı bu farkı taşımıyor | 05:74, 05:90, 05:130, 05:156, 05:175 |
| H-42 | "Eski aday" katsayı çiftleri kaynağı gizli; "%1–2" iddiası dayanaksız; tepe/RMS karışımı | 05:154, `tab:dcm-saf-sinus-harmonikleri` |
| H-43 | "Ölçülen bütün noktalarda faz analitik değerden önde ya da eşit" önermesi tabloyla çelişiyor (2025 Hz) | 05:526 ↔ `tab:kararlilik-olcum` |
| H-44 | 2,3 A'de kritik bölgede (2–3,4 kHz) ölçüm yok; kararlılık hükmü düşük frekans faz öndeliğinden çıkarılıyor | 05:526, 05:558 |
| H-45 | Çevrim dışı ayrımı ideal PLL ve sert şebekeye dayanıyor; 05:217 ölçülen gerilimli ileri beslemenin sanal empedans etkisini anıyor | 05:217, 05:367 ↔ 01:19, 02:317 |
| H-46 | $|u|_{\max}=1{,}49$, oysa $u=\operatorname{sat}_{\pm1}(\cdot)$ | `tab:s4-basamak` (05:330) ↔ 03:358 |
| H-47 | Aynı noktada THD %9,4 ve %9,2; S4 THD'sinin hangi akıma (i_L1 / faz akımı) ait olduğu yazmıyor | 05:528 ↔ 05:280, 03:617, `\umitnot` |
| H-48 | "7,2 W kayıp farkı" ile verilen verimlerden çıkan fark ~6,0 W | 05:260 |
| H-49 | Büyütülmüş bara hangi S4 koşularında; üç faz gerekçesi zayıf | 05:256, 03:512, 08:111 ↔ `tab:s4-tarama` başlığı; 06:389 |
| H-50 | "Doğru özdeşlik", "doğru trigonometrik", "düzeltilmiş aday": önceki bir yanlışı çağrıştırıyor (kural 10'un ruhu) | 05:4, 05:127 başlık, 05:156, 05:562; 08:58 |
| H-51 | Yapılmamış işi yapılmış gibi okutan cümleler | 05:41, 05:45, 05:217, 05:528, 05:564 |

---

## 2. Önceki raporlardan Bölüm 5'e değen bulguların durumu

### 2.1 Rapor 15 (kontrol ve topoloji)

Rapor 15'in satır numaraları eski hâle aittir; aşağıda bugünkü satırlar verildi. Yüksek öncelikli maddeler (S-42, S-44–S-47, D-12, D-13, D-14, J-03, J-06) uygulanmış ve burada tekrarlanmadı.

| Bulgu | Konu | Bugünkü durum | Bu rapordaki karşılığı |
|---|---|---|---|
| S-40 | S4 alt bölümünün kendine göndermesi | **Uygulandı.** | – |
| S-41 / T-09 | "S4 denetimi analog eşdeğer" | **Açık.** 03:456, 03:552, 05:254, 05:373, 05:558 | H-08 |
| S-43 / K-12 | Antirezonans tanımı | **Açık, artık tekrar.** D-06 ile Bölüm 3'e girdi (03:343); 05:350'deki tanım duruyor | H-16 |
| S-48 / T-12 | 44 µs ve $T_d=2$ µs tekrarı | **Açık.** 05:409, 05:455, 05:558 (iki kez), 05:566, 08:76 | H-08 |
| T-07 / T-08 | S1–S4 tanımları, S1–S3 açık çevrim | **Açık.** 05:4, 05:26, 05:90, 05:236 | H-17 |
| T-10 / F-13 | PI sıfırı 60 Hz / 586 Hz | **Kısmen.** 03:548 tablo hücresi gerekçeyi de taşıyor, 05:254 aynı gerekçeyi veriyor | H-18 |
| T-11 / F-02 | Sin³ çevrim dışı | **Açık.** Bölüm 5 içinde beş yer (4, 346, 367, 369, 566), dışarıda 01:44, 02:317, 02:319, 03:438, 08:34, 08:59, 08:129 | H-06 |
| T-13 | 9 A tepe–tepe / 4,5 A | **Açık.** 04:11 ↔ 05:310 | H-10 |
| T-16 | L/S/T tanımları | **Büyük ölçüde uygulandı.** 05:346 adları İngilizce karşılıklarıyla veriyor, ardından denklemler | – |
| T-17 | "$K_{34}$ açık/kapalı aynı" | **Açık.** 05:367, 05:413 başlık, 05:440 başlık, 05:453, S/T şekil içi başlığı | H-07 |
| D-04 | Köprünün ortalama kutup gerilimi | **Açık.** Terim de tutarsız: 05:175 "yumuşak gerilim kaynağı", 05:526 "akım kaynağına yakın" | H-58 |
| D-11 | Orta nokta salınımı denklemi | **Açık.** 05:256 hâlâ sözel | H-49 |
| J-02 | $C$ / $C_i$ ikiliği | **Metinde kapandı, şekilde açık.** `kararlilik_L_bode_K34.pdf` başlığı "L = C Kpwm G Hm e-sTd" | H-37 |
| J-07 | PM ≳ 45°, GM ≳ 6 dB, ‖S‖∞ ≲ 6 dB kaynaksız | **Açık.** 05:433 | H-53 |

### 2.2 Rapor 16 (Bölüm 5 yazım düzenlemesi) "kontrol edilmeli" maddeleri

| No | Konu | Durum | Karşılık |
|---|---|---|---|
| 1 | $d_m=0{,}8$ değeri tabloda yok | **Açık.** Değer `saf_sinus_dcm_harmonikleri.csv` içinde var: $I_1=31{,}25$ A (tepe), $I_3/I_1=\%29{,}32$. Yeni koşu gerekmez | H-54 |
| 2 | "bir denetleyici değil" → "denetleyiciden ayrı" | Anlam korunmuş; alt kesim başlığı mesajı taşıyor. Ek iş yok | – |
| 3 | "Geçerlilik Sınırı" başlığı | Kesimin kaldırılması öneriliyor; başlık sorunu da kapanır | H-19 |
| 4–7 | 381, 391, 409, 435 anlam denetimi | Anlam doğru. Ek iş yok | – |
| 8 | 310 son cümle | **Kapandı.** "tamamlayabilir" yazılmış | – |
| 9 | 05:4 `chap:anahtarlama` göndermesi | Sorun yok | – |
| 10, 11 | 236, 254 | Sorun yok | – |
| 12, 13 | Cümle başı sayı, "denetim eforu" | Dil konusu, kapsam dışı. "denetim eforu" 03:438 ve 05:45'te tekrarın parçası | H-14 |
| 14 | 247 ve 350 paragraflarında iki bölümler arası gönderme | H-03 uygulanırsa 247'deki sorun kalkar | H-03 |
| §6 | Şekil içi yazılar | **Açık**, yeni bulgularla genişletildi | H-37 |

---

## 3. `\label`–`\ref` taraması

**Yöntem:** Betik (`refs.py`, oturum geçici dizininde) `yeni_tez/bolumler/`, `onkisim/` ve `sekiller/` altındaki bütün `.tex` dosyalarında `\ref`, `\eqref`, `\autoref`, `\pageref` ve `\cite*` komutlarını saydı. Kaçışsız `%` ile başlayan yorumlar sayılmadı.

**Bölüm 5'te hiç `\ref` almayan şekil ya da tablo yok.** Tezin bütününde gönderme almayan beş şekil var (bilgi için): `fig:deney-susturma-pc` (06:275), `fig:deney-sin3-pc` (06:304), `fig:gt-primer` (07:185), `fig:gt-sekonder-gerilim` (07:196), `fig:gt-sekonder-akim` (07:202).

**Bölüm 5'te gönderme almayan denklem ve kesim etiketleri** (zararsız, ama çıkarma adayı olduklarını gösteriyor): `eq:ccm-akim-cozumu` (05:108, H-21), `eq:s4-denetleyiciler` (05:252), `eq:sin3-duyarlilik` (05:360), `eq:pade-yaklasimi` (05:394, H-26), `sec:sin3-senaryo3-kayitlari` (05:220). Bölüm 3'teki `eq:sin3-ozdeslik` (03:368) de hiç gönderme almıyor (H-01).

**Başka bölümlerden gönderme alan, korunması gereken Bölüm 5 etiketleri:**

| Etiket | Yer | Dış göndermeler |
|---|---|---|
| `chap:sin3` | 05:2 | 01:89, 03:365, 03:681, 04:75, 04:166, 06:4, 06:298, 07:134, 07:377, 07:390 |
| `sec:harmonik-mekanizma` | 05:48 | 04:133 |
| `sec:sin3-yeniden-tarama` | 05:128 | 08:34, 08:60, 08:119 |
| `fig:sin3-yeniden-tarama` | 05:172 | 08:26 |
| `sec:s4-kapali-cevrim` | 05:234 | 01:90, 03:355, 03:588–591, 04:170, 06:225, 06:387, 06:389, 08:34, 08:60 |
| `tab:s4-tarama` | 05:265 | 06:463, 06:464, 08:25, 08:26, 08:32, 08:55 |
| `tab:s4-basamak` | 05:319 | 06:465 (**H-34 birleştirmesinde etiket birleşik tabloya taşınmalı**) |
| `sec:kararlilik-bode` | 05:344 | 01:90, 03:351, 03:438, 03:569, 03:592, 08:34, 08:60 |
| `eq:sin3-acik-cevrim` | 05:353 | 03:438 |
| `tab:kararlilik-marjlar` | 05:414 | 08:26, 08:60 |
| `tab:kararlilik-olcum` | 05:500 | 08:26 |

**Çıkarılması önerilen yerlerdeki atıflar:** Bölüm 5'teki 11 atıf anahtarının biri yalnız Bölüm 5'te geçiyor: `Du2013` (05:72). 05:72'deki literatür cümlesine dokunulmuyor. H-19 ile çıkan `Wereley1991` (02:319, 02:323), `Liao2022` (02:319, 05:558), `Holmes2003` (yedi yer) ve H-20 ile çıkan `Oppenheim1997` (02:317) başka yerlerde kalıyor. Tezden düşen atıf yok.

**Bölümler arası gönderme (kural 11):** Bölüm 5'te `\umitnot` dışında 18 gönderme var. H-01, H-03, H-04, H-17 uygulanınca ~13'e iner (`tab:sistem-parametreleri` 26'dan, `eq:s4-denetim-yapisi` 247'den, `sec:kalibrasyon` 231'den, `fig:s3-simulink-modeli` 241 başlığından çıkar).

---

## 4. Bulgu listesi

Biçim: **Kimlik — tür — öncelik — tahmini kazanç**, ardından yer, alıntı ve öneri. **[YENİ SAYI]** işareti, önerinin yeni benzetim ya da yeni sayısal sonuç gerektirdiğini gösterir. **[HESAP]** işareti, yeni benzetim gerektirmeyen elle hesabı gösterir.

### 4.1 Tekrarlar

**H-01 — tekrar — yüksek — Bölüm 5'te ~150, Bölüm 3'te ~60 kelime**
- **Konu:** Sin³ özdeşliği, harmonik eşdeğeri, tepe değeri, "pozitif işaretli, normalizasyonsuz" ve $K_{1x}$/$K_{3x}$ adlandırması.
- **Yer:** **05:8–24** (birincil), 05:26, 05:28 ↔ 03:365 (son iki cümle), **03:366–370** (`eq:sin3-ozdeslik`, açılım ve tepe değer cümlesi) ↔ 03:541 (tablo satırı) ↔ 01:19 ↔ 02:317 ↔ 05:562 (cümle 2) ↔ `simgeler.tex`:34 ↔ 06:298 (son cümle).
- **Alıntı:** 05:26 "Terim pozitif işaretli ve normalizasyonsuzdur. Modelde $\sin(3\theta)$ üreten blok bulunmamaktadır." ↔ 03:365 "Birim genlikli referans sinüsünün küpü, pozitif işaretle ve ayrı bir normalizasyon olmadan".
- **Öneri:**
  - Birincil yer Bölüm 5 (katkının matematiksel tanımı). Bölüm 3'te `eq:s4-denetim-yapisi` kalsın; `eq:sin3-ozdeslik` (gönderme almıyor) ve 03:370'in ilk iki cümlesi çıksın, yerine "Sin³ teriminin harmonik eşdeğeri Bölüm~\ref{chap:sin3} içinde verilmektedir" ya da hiç gönderme.
  - 05:26: "Uygulamanın yürütülebilir tanımı Simulink benzetim modelleridir. Gösterim, modelin blok yapısından okunmuştur." cümleleri, "pozitif işaretli ve normalizasyonsuz" cümlesi ve parametre dosyasının ilk değerleriyle ($0{,}45$, $0{,}39$; $0{,}7425$, $0{,}0975$, $0{,}84$) yapılan örnek çıksın. Kalibre edilmiş S3 değerleriyle harmonik eşdeğer cümlesi kalsın. İlk değerler kalibrasyon öncesi süreç bilgisidir ve 05:154'teki "eski aday" çiftlerine çok yakın olduğu için okuru karıştırıyor (H-42).
  - 05:28: ilk üç cümle `simgeler.tex`:34 ve 03:365 ile aynı. "S3 ve S4 değerleri kalibre edilmiş değerlerdir; analitik model değerleri adaydır" cümlesine indir (H-02 ile birlikte).
  - 05:562 cümle 2 ("Benzetim modelinde terim birim sinüsün küpü olarak…") Değerlendirme'de sonuç değil, tanım. Çıkar.
  - 01:19 ve 02:317'deki satır içi özdeşlik kısa ve konumlandırıcı; düşük öncelikle 02:317'den çıkarılabilir (literatür bölümü tezin yöntemini formülle vermesin).

**H-02 — tekrar — orta — ~70 kelime**
- **Konu:** "Analitik aday ile kalibre edilmiş model değeri farklı katmanlara aittir."
- **Yer:** 05:28 (son iki cümle), 05:97 (cümle 2), 05:130 (son cümle), **05:175** (cümle 1, birincil), 05:562.
- **Alıntı:** 05:97 "Analitik modelden bulunan $(k_1,k_3)$ değerleri tek endüktanslı kayıpsız modele aittir ve benzetim modelindeki … ayrılmaktadır."
- **Öneri:** Ayrım bir kez, karşılaştırmanın yapıldığı 05:175'te kalsın. 05:28'de tek yan cümle, 05:97'deki cümle çıksın.

**H-03 — tekrar — orta — ~55 kelime**
- **Yer:** **05:247** (cümle 1–4) ↔ 03:355–365 (denetim yapısı, $i_{\mathrm{ref}}$, ideal PLL, $H_m$).
- **Alıntı:** 05:247 "S4'te geri beslenen akım $i_{L1}$, akım referansı $i_{\mathrm{ref}}=\sqrt2\,I_{\mathrm{ref}}\sin\theta$, $\theta$ şebekeye kilitli açı (ideal PLL)".
- **Öneri:** Paragrafı "İleri besleme kazançları $K_{14}$, $K_{34}$ ve faz $\varphi_4$ kalibre edilmiş S3 değerleridir. Akım denetleyicisi $C_i(s)$ üç seçenekle … gerçeklenmiştir:" ile başlat. 247'deki iki bölümler arası göndermeden biri kalkar (rapor 16, madde 14).

**H-04 — tekrar ve yanlış yer — yüksek — ~90 kelime**
- **Yer:** **05:231** ↔ 06:340–347 (`tab:deney-dusuk-guc-ozeti`, %15 → %47 → %14), 06:568 (DA bara gerilimleri), 06:580 (%14,8 / %14), 06:593 (S1→S3 +2,0 puan), 04:170 ("Her senaryo kendi deneyinin DA bara ve şebeke gerilimiyle benzetilmiştir"), 03:574, 08:34.
- **Alıntı:** 05:231 "S1, S2 ve S3 deneylerinin DA bara gerilimleri (431,5, 395,0 ve 427,5 V) … birbirinden farklıdır."
- **Öneri:** Tek cümle bırak: "Kalibre edilmiş S3 modeli deneydeki %14 akım THD'sini kalibrasyon hedefi olmadan %14,8 ile yeniden üretmektedir (Alt Bölüm~\ref{sec:kalibrasyon})." Gerilim listesi, "aynı koşuldadır" ve 2,0 puan cümleleri Bölüm 6'nın kalibrasyon içeriğidir ve orada var.

**H-05 — tekrar — düşük — ~35 kelime**
- **Yer:** 05:4 (cümle 3, 5) ↔ 04:179, 04:205, 06:347, 08:32, 08:34, `ozet.tex`.
- **Alıntı:** 05:4 "şebeke akımı THD'si deneyde %15'ten %47'ye, kalibre edilmiş benzetimde %39,5'ten %56,7'ye çıkmaktadır".
- **Öneri:** Girişte yalnız deney sayıları (%15 → %47 → %14) kalsın. Benzetim çifti Bölüm 4 ve 6'da var. Tablo göndermesi kalabilir.

**H-06 — tekrar — orta — Bölüm 5'te ~60, Bölüm 3'te ~25 kelime**
- **Konu:** "Sin³ çevrimin dışındadır, karakteristik denklemi değiştirmez" (T-11).
- **Yer:** 05:4 (son cümle), 05:346 (cümle 2), **05:367** (birincil), 05:369 (son iki cümle), 05:566 ↔ 03:438 (cümle 1–2) ↔ 01:44, 02:317, 02:319, 08:34, 08:59, 08:76, 08:129.
- **Alıntı:** 05:369 "Çevrim açısından ileri besleme bilinen bir dış giriştir ve çevrimin kendisi, yani $L$, $S$ ve $T$, aynı kalmaktadır."
- **Öneri:** Bölüm 5 içinde kanıt 05:367'de, sonuç 05:566'da kalsın. 05:369'un son iki cümlesi ve 05:346'nın ikinci cümlesi çıksın. 05:4'ün son cümlesi "Sin³ teriminin kararlılığa etkisi Alt Bölüm~\ref{sec:kararlilik-bode} içinde incelenmektedir" boyuna insin. 03:438'de ilk iki cümle tek cümleye insin.

**H-07 — tekrar — düşük — ~30 kelime**
- **Yer:** 05:367 ("$K_{34}$ yalnız dış girişin genliğini değiştirmektedir"), 05:413 (tablo başlığı "bit düzeyinde aynıdır"), 05:440 (şekil başlığı), 05:453 (son cümle), `kararlilik_S_T.pdf` şekil içi başlığı.
- **Öneri:** Tablo başlığı ve 05:453 kalsın; 05:440 başlığındaki cümle ve 05:367'deki tekrar cümlesi kısalsın (T-17).

**H-08 — tekrar — orta — Bölüm 5'te ~60, Bölüm 3'te ~15 kelime**
- **Konu:** Analog eşdeğer denetim, 1 µs adım, $T_d=2$ µs, gecikme marjı 44 µs (T-09, T-12).
- **Yer:** **05:254** (cümle 8–10), 05:373, 05:381 (cümle 2–3), 05:409 (44,5 µs hesabı), 05:455 (cümle 2–3), **05:558** (cümle 6–7), 05:566 ↔ 03:456, 03:552 ↔ 08:76.
- **Alıntı:** 05:558 "Analog eşdeğerin kararlılığı 0–10 µs gecikme aralığında doğrulanmış ve gecikme marjı 44 µs bulunmuştur."
- **Öneri:** Model tanımı 05:254'te, varsayım 05:558'de kalsın. 05:455'in "0–10 µs" cümlesi ile 05:558'deki aynı cümlenin biri çıksın. 05:409'daki "Tablodaki değerle fark yuvarlamadan gelmektedir" çıkabilir. 03:456'daki cümle çıkabilir (03:552 tablo satırı yeter). Ayrıca $T_d=2$ µs'nin kaynağı (1 µs örnekleme + tutucu?) tek yan cümleyle yazılmalı; bugün "üst sınırdır" deniyor ama nereden geldiği yok.

**H-09 — tekrar — orta — Bölüm 5'te ~25, Bölüm 6'da ~25 kelime**
- **Konu:** Büyütülmüş DA bara.
- **Yer:** **05:256** (birincil), 05:558 (son cümle), 05:564 (cümle 4) ↔ 06:389 (cümle 2), 06:464, 08:111, 08:129, 03:512.
- **Alıntı:** 06:389 "üç fazlı donanımda toplam bara kapasitansı faz payının üç katıdır" ↔ 05:256 aynı cümle.
- **Öneri:** Gerekçe 05:256'da kalsın. 06:389'daki gerekçe cümlesi çıksın (Bölüm 6 deney bölümüdür, S4 benzetim varsayımını açıklaması gerekmez). 05:558'in son cümlesi `tab:s4-tarama` başlığıyla ve 05:256 ile aynı; çıksın. İçerik düzeltmesi için H-49.

**H-10 — tekrar — orta — ~60 kelime**
- **Konu:** Orta akımda süreksiz iletim.
- **Yer:** **05:310** (cümle 3–4: "$L_1$ akım dalgalanması yaklaşık 9 A tepeden tepeye…", "senkron olmayan alçaltıcı gibi davranmaktadır") ↔ 04:11 (T-13), 04:15, 04:106 ↔ 05:289 (`\umitnot`), 05:564, 08:32.
- **Öneri:** 9 A / 4,5 A hesabı Bölüm 4'te var; 05:310'da "anlık akımın mutlak değeri sınır akımının (yaklaşık 4,5 A) altına indiği bölgelerde" yan cümlesi yeter. "Süreksiz iletimde köprü senkron olmayan alçaltıcı gibi davranmaktadır" cümlesi Bölüm 4'ün tanımıdır, çıksın.

**H-11 — tekrar — orta — ~60 kelime**
- **Konu:** "En uygun Sin³ genliği akım düzeyine bağlıdır" ve "nötr susturma düşük güç için tasarlanmıştır."
- **Yer:** 05:154 (son cümle), 05:310 (cümle 9–10 ve son iki cümle), **05:528** (son cümle, birincil), 05:562 (son cümle), 05:564 (son iki cümle), `\umitnot` 05:290–291 ↔ 08:76, 08:115, 08:129.
- **Alıntı:** 05:564 "Nötr susturma düşük güç bölgesi için tasarlanmıştır. En uygun Sin³ genliği ise akım düzeyiyle ölçeklenmektedir."
- **Öneri:** Gerekçe 05:528'de (anma akımında üçüncü harmonik bedeli) bir kez dursun. 05:310'da "Sin³ katsayıları 2,3 A noktasındaki bozulmaya göre kalibre edilmiştir" cümlesi kalsın, öteki iki cümle çıksın. 05:564'teki ifade için H-51.

**H-12 — tekrar — düşük — ~30 kelime**
- **Konu:** 54° / +35 dB.
- **Yer:** `tab:kararlilik-marjlar`, 05:435 (cümle 1–3), 05:464 (cümle 4), 05:491 (cümle 2), 05:517 ("Analitik değer 54,2°'dir"), 05:566.
- **Öneri:** Tablo, 05:435 ve 05:566 yeter. 05:517'deki cümle ve 05:435'teki "57 katına kadar" yan cümlesi (05:491 aynı bilgiyi $\lambda$ ile veriyor; H-26) kısalabilir.

**H-13 — tekrar — düşük — H-19 içinde**
- **Yer:** 05:45 (son iki cümle) ↔ 02:317 (cümle 2).
- **Alıntı:** 05:45 "klasik üçüncü harmonik PWM'deki gibi DA bara kullanımını artırmaktan farklı olarak" ↔ 02:317 "DA bara kullanım oranını artırmayı … hedeflemektedir".
- **Öneri:** Konumlandırma literatür bölümünde var. H-19 ile birlikte çıkar. `Holmes2003` yedi yerde kalır.

**H-14 — tekrar — orta — Bölüm 5'te H-19 içinde, Bölüm 3'te ~30 kelime**
- **Konu:** Katsayı seçiminde THD dışında doyum, RMS, denetim eforu, süreklilik.
- **Yer:** 05:45 (cümle 1–2) ↔ 03:438 (son cümle) ↔ **08:119** (cümle 3, birincil).
- **Öneri:** Önerinin yeri Gelecek Çalışmalar'dır ve 08:119'da var. 05:45 (H-19) ve 03:438'in son cümlesi çıksın. 03:438 "değerlendirilmektedir" diyor; tezde S3 katsayıları P ve Q'ya kalibre edilmiştir, çok ölçütlü bir seçim yapılmamıştır (H-51).

**H-15 — tekrar — düşük — dış bölümlerde ~40 kelime**
- **Konu:** S2 akım zarfı: alternans ortasında çöküş, sıfır geçişlerinin iki yanında tepe.
- **Yer:** **05:72 (cümle 2), 05:74** (birincil, mekanizma) ↔ 04:183 (cümle 2–3) ↔ 06:582 (cümle 2).
- **Öneri:** Mekanizma Bölüm 5'te. 04:183 ve 06:582'de betim tek yan cümleye insin, `sec:harmonik-mekanizma`'ya gönderme ya da hiç gönderme. Bölüm 5'te değişiklik yok.

**H-16 — tekrar — düşük — ~20 kelime**
- **Yer:** 05:350 (cümle 4) ↔ 03:343 (cümle 1).
- **Alıntı:** 05:350 "Antirezonans, evirici geriliminden $L_1$ akımına giden yolun kazancının çöktüğü frekanstır." ↔ 03:343 "Antirezonansta evirici geriliminden $L_1$ akımına giden yolun kazancı çökmektedir."
- **Öneri:** K-12 tanımın silinmemesini istiyordu; D-06 ile tanım artık Bölüm 3'te `eq:lcl-rezonans` yanında duruyor. 05:350'deki tekrar çıkabilir. Karar tez sahibinin (K-12 kapsamı).

**H-17 — tekrar — düşük — ~40 kelime**
- **Konu:** Senaryo adlarının Bölüm 5'te yeniden tanıtılması (T-07, T-08).
- **Yer:** 05:4 ("akım geri beslemeli Senaryo~4 (S4) modelinde"), 05:26 ("Senaryo~3 (S3) modelinde"), 05:90 ("Senaryo~1 (S1) çalışma noktasının"), 05:236 (cümle 1–2; S4 ikinci kez tanıtılıyor) ↔ 03:574, `tab:senaryo-denetim`, 01:57.
- **Öneri:** Kısaltmalar Bölüm 3'te tanımlı. Bölüm 5'te yalnız "S3", "S4" yazılsın. 05:236'nın ilk cümlesi ("Senaryo 1–3 açık çevrim modülasyonla…") çıksın; S4'ün tanımı tek cümle kalsın.

**H-18 — tekrar — düşük — ~50 kelime**
- **Yer ve öneri:**
  - $f_s/6$ ve $L_g$ taraması: 05:455 (cümle 5) ↔ 03:569 (cümle 3–4). Bölüm 3'teki cümleler çıksın; konu Bölüm 5'in.
  - PI sıfırı 60 Hz ve geçişin onda biri: 05:254 (cümle 2–5) ↔ 03:548 (tablo hücresi). Tablo hücresi "PI sıfırı 60 Hz" boyuna insin (T-10).
  - PIR benzetim süresi 0,06 / 0,2 s: 05:260 (cümle 3), 05:264 (başlık), 05:451 (son cümle), 03:558. Nedeni 05:451'de, değeri başlıkta kalsın; 05:260'taki cümle çıksın.

### 4.2 Gereksiz ayrıntı

**H-19 — gereksiz ayrıntı (ve jüri riski) — yüksek — ~330 kelime (net)**
- **Konu:** "Basitleştirilmiş Türetimlerin Geçerlilik Sınırı" kesiminin tamamı.
- **Yer:** 05:30–45.
- **Alıntı:** 05:32 "Anahtarlamalı dönüştürücüde kompanzasyon katsayıları, tek bir cebirsel iptal koşulundan, örneğin sabit bir $k_1/k_3$ oranından daha kapsamlı…"
- **Gerekçe (başlık silmek için):**
  1. 05:32 tezde bulunmayan bir türetimi çürütüyor. Okur "sabit $k_1/k_3$ oranı"nı hiçbir yerde görmedi. Kesim önceki bir sürümün katsayı hatasına yanıt gibi okunuyor (kural 10'un ruhu, rapor 16 madde 3).
  2. 05:32 ile tezin kalibrasyonu çelişiyor (H-40).
  3. 05:34–41 HTF literatürüdür; 02:319 aynı kavramı aynı atıflarla veriyor. 05:41'in "belirlenmelidir" önermesi uygulanmayan bir yöntemi şart koşuyor (H-51).
  4. 05:43 S4 anma akımı sonucudur ve S4 tanıtılmadan (05:236) önce geliyor (H-29). Aynı sayılar 05:558'de tekrar ediliyor.
  5. 05:45 Bölüm 2'yi (H-13) ve Bölüm 8'i (H-14) tekrarlıyor.
- **Öneri:**
  - Kesimi kaldır. Etiketi yok, gönderme almıyor.
  - 05:43'ün özü ("anma akımında köşegen dışı katkı temel bileşende en çok %1,5, üçüncü harmonikte %3,8") 05:558'de zaten var; anahtarlamalı ve ortalama modelin karşılaştırma sayıları (4,44 / 4,51 A, 2,32 / 2,23 A) gerekirse 05:558'e tek cümle olarak taşınsın. `eq:htf-matris-iliskisi` çıkınca 05:558'deki `\eqref` yerine "HTF çerçevesi \citep{Liao2022}" yazılsın.
  - Katsayıların çalışma noktasına bağlılığı 05:154 ve `tab:dcm-saf-sinus-harmonikleri` ile sayısal olarak zaten gösteriliyor.
  - 08:76'daki "Katsayıların tek bir cebirsel iptal koşulundan türetilemeyeceği gerekçelendirilmiş" cümlesi "Katsayıların çalışma noktasına bağlı olduğu parçalı model taramasıyla gösterilmiş" biçimine dönmeli.

**H-20 — gereksiz ayrıntı — orta — ~70 kelime + 1 denklem**
- **Yer:** 05:119–125 (`eq:akim-fourier-katsayisi`, tek gönderme 05:125).
- **Alıntı:** 05:125 "Yarım dalga simetrisi sağlanmadığında DA ve kosinüs katsayıları da ayrıca hesaplanmalıdır."
- **Öneri:** Fourier sinüs katsayısı ders kitabı tanımıdır ve sonraki hiçbir hesapta açıkça kullanılmıyor. Denklemi ve iki cümleyi çıkar; gerekirse "harmonik genlikler parçalı modelin bir şebeke periyodundaki Fourier ayrışımından hesaplanmıştır" yan cümlesi. `Oppenheim1997` 02:317'de kalır.

**H-21 — gereksiz ayrıntı ve tekrar — orta — ~80 kelime + 2 denklem**
- **Yer:** 05:92–97 (`eq:ccm-gorev-harmonik`, `eq:sin3-genel-komut` ile aynı ifade), 05:103–110 (`eq:ccm-akim-cozumu`, gönderme almıyor).
- **Alıntı:** 05:94 "$d(\theta)=k_1\sin\theta+k_3\sin^3\theta$" ↔ 05:15 "$u_{\mathrm{ff},\sin^3}(\theta)=k_1\sin\theta+k_3\sin^3\theta$".
- **Öneri:** `eq:ccm-gorev-harmonik` yerine "Analitik modelde görev oranı $d(\theta)=u_{\mathrm{ff},\sin^3}(\theta)$ alınmıştır (Eşitlik~\eqref{eq:sin3-genel-komut})." CCM ortalama denklemi (`eq:ccm-diferansiyel`) parçalı modelin tanımı için kalsın. Kapalı biçim çözüm (`eq:ccm-akim-cozumu`) hiçbir sonuçta kullanılmıyor, tarama sayısaldır; denklem ve açıklama cümleleri çıkabilir. Not: J-06 düzeltmesi bu denklemi yeni düzeltti; çıkarmak düzeltmeyi boşa çıkarmaz, gönderme almayan bir denklemi kaldırır.

**H-22 — gereksiz ayrıntı (şekil/tablo) — orta — ~0,3 sayfa**
- **Yer:** `tab:dcm-saf-sinus-harmonikleri` (05:134–152).
- **Gerekçe:** Yedi satırın hepsi aynı oranı (%39,96) veriyor; genliklerin $d_m^2$ ile ölçeklenmesi `eq:dcm-sinus-zarfi`'den doğrudan okunuyor ve metin bunu 05:132'de söylüyor. Tablonun taşıdığı yeni bilgi, beşinci ve yedinci harmonik oranlarıdır.
- **Öneri:** Tabloyu üç satıra indir: $d_m=0{,}1$, $0{,}7$ ve $0{,}8$ (CSV'de var; H-54). Sütun başlığında $I_n$'in **tepe** değer olduğunu yaz (CSV ve elle hesap: $d_m=0{,}1$ için $I_1=0{,}0764$ A tepe, RMS 0,054 A; bölümün geri kalanı RMS kullanıyor, H-42). Başlıktaki "(01.09.2026 hesabı)" çıksın (H-24). Etiket 05:74 ve 05:132'den gönderme alıyor, kalır.

**H-23 — gereksiz ayrıntı — orta — ~100 kelime**
- **Yer:** 05:74 (paragrafın ikinci yarısı: panel (a)–(e) betimi).
- **Alıntı:** 05:74 "Görev oranı en büyük olduğu hâlde tepe akım alternans ortasında çökmekte ve en büyük değerlerine yaklaşık 2 ms ve 8 ms çevresinde ulaşmaktadır (c)."
- **Öneri:** Paragraf şekli panel panel anlatıyor; aynı bilgi şekil başlığında ve şeklin kendisinde var (rapor 15'in (b) türü). Kalması gerekenler: $d_m=0{,}768=K_{12}$ eşleşmesi, %55,6 / %55,9 oranı, $V_m/V_h$ bağımlılığı ve son cümle (verim kazancı ile harmonik cezanın aynı darbe biçiminden doğması). Panel (b), (c), (e) betimleri ve asimetri cümlesi çıkabilir.

**H-24 — gereksiz ayrıntı — düşük — ~90 kelime**
- **Konu:** Çalışma süreci, betik, koşu ve tarih bilgisi.
- **Yer ve öneri:**
  - 05:136 tablo başlığı ve 05:171 şekil başlığı: "(01.09.2026 hesabı)", "01.09.2026 hesabı" → çıkar.
  - 05:236 (son iki cümle): "Model çiziminde geri besleme oransal kazançla gösterilmiştir. … denetleyici S3 tabanına betikle eklenmiş" → K-09 bu farkın korunmasını istiyor; tek cümleye indir: "Şekildeki oransal kazanç bloğu, benzetimlerde P, PI ve PIR seçenekli denetleyici alt sistemiyle gerçeklenmiştir."
  - 05:254 (cümle 1): "Oransal kazanç parametre dosyasındaki değerdir." → çıkar; değer ve kaynağı parametre tablosunda.
  - 05:260 (cümle 2, 4): "Kararlı durum büyüklükleri son tam şebeke periyodundan alınmıştır" (03:555'te tanımlı) ve "Oturma ölçütü … %0,12" → tek yan cümle.
  - 05:453 (cümle 3): göreli farkların üç ayrı değeri ($1{,}6\cdot10^{-11}$, $3{,}5\cdot10^{-10}$, $6{,}4\cdot10^{-4}$) → "en çok $6{,}4\cdot10^{-4}$ (faz ≤ 0,04°)".

**H-25 — gereksiz ayrıntı ve yanlış başlık — orta — ~150 kelime**
- **Yer:** 05:177–217 ("Önerilen Yapı ve İleri Besleme Mekanizması", 379 kelime, TikZ 147 dahil).
- **Gerekçe:**
  - Başlık "Önerilen Yapı" diyor ama önerilen yapının blok şeması Bölüm 3'te (`fig:denetim-modulasyon-blok`); kesimde yapı yok.
  - Eşpotansiyel açıklama (05:179) şebeke gerilimi ileri beslemesinin ders kitabı anlatımıdır ve S1–S3 açık çevrimde "akım komutu uygulanmadan önce" durumu yoktur.
  - 05:217'nin ilk cümlesi Alt Bölüm 5.6 ve 5.7'yi duyuruyor (kural 11 iç gönderme, ama işlevsiz). 05:217'nin Lu2016 cümlesi H-45'teki çelişkiyi doğuruyor.
  - Şekil, ilk tezin Şekil 4.19'undan gelen tez sahibi içeriğidir (rapor 05, Ş 4.19 → Ş 5.2); çıkarılması önerilmiyor.
- **Öneri:** Kesimi ~80 kelimeye indir, başlığı "İleri Beslemenin İşlevi" yap ya da içeriği Alt Bölüm 5.1'in sonuna taşı: ileri besleme evirici eşdeğer kaynağını şebeke gerilimine yaklaştırır, denetleyiciye yalnız empedans düşümü kalır, düşük akımda ileri beslemenin göreli önemi artar (05:179 cümle 1, 4, 6). 05:217'deki Lu2016 ve "daha geniş bir çerçevede ele alınmıştır" cümleleri çıksın (H-45, H-51). `Lu2016` 05:455'te ve beş başka yerde kalır.

**H-26 — gereksiz ayrıntı — orta — ~150 kelime + ~0,4 sayfa**
- **Konu:** Frekans alanı kesiminin çevre ayrıntısı (1 372 kelime, bölümün en uzun alt kesimi).
- **Yer ve öneri:**
  - **05:491 ($\lambda$ paragrafı, 58 kelime):** "çevrim $\lambda=0{,}05$–50 aralığında kararlıdır" ile "+35,2 dB ile tutarlıdır" kazanç marjının ve 05:435'teki "57 katına kadar" yan cümlesinin yinelemesi. Kazanç azalması yönü (düşük akımdaki etkin kazanç düşüşü) 05:526'da ölçümle zaten var. Paragrafı tek yan cümleye indir ya da 05:526'ya kat.
  - **05:392–396 (`eq:pade-yaklasimi`, gönderme almıyor):** ikinci mertebe Padé ders kitabı formülüdür. J-03'ün istediği "Padé kullanıldığının yazılması"dır; denklem gerekmez: "Kapalı çevrim kutuplarında gecikme ikinci mertebe, gecikme taramasında altıncı mertebe Padé yaklaşımıyla temsil edilmiştir."
  - **`fig:kararlilik-lg`:** H-35.
  - **05:409 (son yarı):** "PI satırındaki değer … yeniden üretilmektedir … fark yuvarlamadan gelmektedir" ve "LCL rezonansında … tanımın dışında kalmaktadır" açıklamaları okuru tablonun nasıl okunacağı konusunda adım adım yönlendiriyor; birer yan cümleye inebilir.
  - Ayrık model (`eq:kararlilik-ayrik-model`) ve marj bloğu (`eq:marj-tanimlari`) rapor 15'in yüksek öncelikli önerisiyle eklendi; dokunulmasın.

**H-27 — gereksiz ayrıntı (ve jüri riski) — düşük — ~50 kelime**
- **Yer:** 05:260 (son üç cümle).
- **Alıntı:** 05:260 "Yaklaşık 280 W çıkışta S4 verimi %96,2, S3 benzetiminin verimi %94,25'tir. Aradaki yaklaşık 7,2 W'lık kayıp farkı…"
- **Öneri:** S4 verimi yalnız S4 içinde karşılaştırılıyorsa S3 ile karşılaştırma cümleleri gereksiz; "S4, $L_1$ çekirdek kaybı için S1–S3'ten farklı bir paralel direnç kullandığından (Tablo …) verim sütunu S4 benzetimleri arasında karşılaştırılmaktadır" cümlesi tablo başlığına taşınsın. Sayısal tutarsızlık için H-48.

**H-28 — gereksiz ayrıntı — düşük — ~40 kelime**
- **Yer:** 05:256 (cümle 5: küçük baralı PI sonucunun dört sayısı).
- **Alıntı:** "evirici darbe yüksekliği pozitif alternans boyunca yaklaşık 270 V'tan 100 V'a inmiş, modülasyon zamanın %20,6'sında doyuma girmiş".
- **Öneri:** Önkoşulun gerekçesi için genlik hatası ve THD (−%31,9, %57,4) yeter; darbe yüksekliği ve doyum süresi çıkabilir. Paragrafın sözel salınım hesabı D-11 denklemiyle verilirse (H-49) kısalır.

### 4.3 Yanlış yer

**H-29 — yanlış yer — orta — 0 (taşıma)**
- **Yer:** 05:43 ↔ 05:236 (S4 tanımı) ↔ 05:558.
- **Gerekçe:** Anahtarlamalı S4 modelinde $K_{34}$ açık/kapalı fark akımları, S4 tanıtılmadan iki kesim önce veriliyor.
- **Öneri:** H-19 ile 05:558'e taşınsın.

**H-30 — yanlış yer — orta — ~60 kelime (H-19 ile örtüşen ~40)**
- **Konu:** Bölüm 5'te gelecek çalışma niteliğindeki "-malıdır/-melidir" önerileri.
- **Yer:** 05:41 (cümle 3–4: HTF modeli "belirtilmelidir", katsayılar "belirlenmelidir"), 05:45 (cümle 2), 05:90 (son cümle: "ölü zaman, en küçük darbe süresi ve sonlu akım eşiği de uygulanmalıdır").
- **Öneri:** 08:119 HTF modelini ve çok ölçütlü katsayı seçimini zaten gelecek çalışma olarak sayıyor. 05:41 ve 05:45 H-19 ile gider. 05:90'ın son cümlesi "Sıfır geçiş çevresinde ideal ifadenin geçerliliğini ölü zaman ve en küçük darbe süresi sınırlamaktadır" biçiminde betimleyici olsun.

**H-31 — yanlış yer (ve jüri riski) — orta — 0 (düzeltme, Bölüm 3)**
- **Yer:** 03:592 (`tab:dogrulama-matrisi`, Kararlılık satırı), 03:538–540 (parametre tablosu).
- **Alıntı:** 03:592 "$K_3$ açık ve kapalı … Ortalama model ve anahtarlamalı model doğrusallaştırması."
- **Gerekçe:** Bölüm 5 anahtarlamalı modelin doğrusallaştırılamadığını ve çevrim kazancının enjeksiyonla ölçüldüğünü söylüyor (05:495). Bölüm 3 yöntemi yanlış adlandırıyor. Simge de tutarsız: Bölüm 3'te $K_1$, $K_3$, $\varphi$; Bölüm 5'te $K_{14}$, $K_{34}$, $\varphi_4$.
- **Öneri:** 03:592: "$K_{34}$ açık ve kapalı. Ortalama modelin doğrusallaştırılması ve anahtarlamalı modelde enjeksiyon ölçümü." 03:537–540'ta $K_{1x}$, $K_{3x}$, $\varphi_x$ yazılsın.

### 4.4 Oran

**H-32 — oran — orta — (H-19, H-25, H-26, H-33–H-35 ile)**
- **Durum:** Tezin ikinci katkısının özü dört öğedir: Sin³ mekanizması (DCM zarfı), katsayı seçimi, Sin³'ün çevrimin dışında olduğunun kanıtı ve S3/S4 sonuçları. Bunların payı ~%32 (tanım + mekanizma + katsayı ~%22, çevrim dışı kanıtı ~%8, S3 ~%2). Akım çevriminin kendi kararlılığı (Sin³'ten bağımsız, $L_1$ geri beslemeli bir PI tasarımının marjları, gecikme, $L_g$, $\lambda$, Padé, ayrık model) ~%27; çevre anlatım ~%18.
- **Değerlendirme:** Jüri maddesi 7 marj tablosunu ve Bode eğrilerini istediği için çevrimin kendi kararlılığı kalmalı. Ancak kesimin ağırlığı, okura Sin³'ün değil PI çevriminin incelendiği izlenimini veriyor. Çevrim dışı kanıtı tek paragrafta (05:367) ve kanıtın anahtarlamalı modeldeki karşılığı dağınık (05:517 son üç cümle, 05:528, 05:530).
- **Öneri:** H-19, H-25, H-26, H-33–H-35 uygulanınca Sin³ öz payı ~%38'e, çevrimin kendi kararlılığı ~%22'ye iner. Ek olarak, 05:517'nin $K_{34}$ ile ilgili son üç cümlesi, 05:528 ve 05:530'un $K_{34}$ karşılaştırması tek bir "$K_{34}$ açık ve kapalı ölçümler" paragrafında toplanabilir; Sin³'ün kararlılığa etkisi okurca tek yerde bulunur. Başlık değişikliği gerekmez.

### 4.5 Şekil ve tablo

**H-33 — şekil/tablo — orta — ~0,5 sayfa**
- **Yer:** `fig:s4-tarama-ozet` (05:303–308) ↔ `tab:s4-tarama`.
- **Gerekçe:** Şekil, tablodaki verim, THD ve genlik hatası sütunlarını akım referansına göre çiziyor; her denetleyici için üç (PIR için iki) nokta. Yeni bilgi yok. Tek gönderme 05:294.
- **Öneri:** Şekli çıkar, 05:294'teki son cümleyi sil. Jüri maddesi 8'in istediği değerler tabloda kalıyor.

**H-34 — şekil/tablo (ve tekrar) — orta — ~0,7 sayfa**
- **Yer:** `tab:s4-basamak` + `fig:s4-basamak` (05:312–341) ↔ `tab:kararlilik-basamak` + `fig:kararlilik-basamak` (05:530–554).
- **Gerekçe:** İki tablo ve iki şekil aynı PI 10 → 25 A basamağını veriyor (anahtarlamalı, $K_{34}$ açık koşusu her ikisinde de `KC_PI_basamak_10_25A`, review `2026-10-28_KARARLILIK_BODE.md`:356). Aynı koşu için aşım %0,2 ve %0,17, yerleşme 0,44 ve 0,43 ms veriliyor (H-55).
- **Öneri:** Tek tablo: satırlarda anahtarlamalı/ortalama × $K_{34}$ açık/kapalı; sütunlarda aşım, yerleşme, geçici fark; altına `tab:s4-basamak`'ın özgün satırları (öncesi/sonrası $I_{L1,1}$, doyum, THD). Birleşik tabloya `tab:s4-basamak` etiketi verilsin (06:465 gönderme alıyor). Şekillerden `fig:kararlilik-basamak` kalsın (geçici bileşeni ve $K_{34}$ karşılaştırmasını gösteriyor); `fig:s4-basamak`'taki modülasyon komutu paneli gerekiyorsa alt şekil olarak eklensin. Alt kesim "Basamak yanıtı" ile 05:530'daki kalın başlık birleşir.

**H-35 — şekil/tablo — düşük — ~0,4 sayfa**
- **Yer:** `fig:kararlilik-lg` (05:484–489) ↔ `tab:kararlilik-lg`.
- **Gerekçe:** Tablo kritik büyüklükleri (rezonans, antirezonans, birinci geçiş, PM, GM) sayıyla veriyor; şekil aynı beş eğriyi gösteriyor. Şekil içi gösterge noktalı ondalıklı ("Lg = 0.5 mH").
- **Öneri:** Şekli çıkar ya da EK'e taşı. Tek gönderme 05:464.

**H-36 — şekil/tablo — düşük — 0 (karar)**
- **Yer:** `fig:kararlilik-olcum` ↔ `tab:kararlilik-olcum`.
- **Değerlendirme:** Tablo altı frekansta sayıları, şekil analitik eğri üzerinde ölçüm noktalarını veriyor. Kısmen aynı bilgi; ama şekil ölçümün sürekli eğriye göre konumunu gösteriyor ve 2,3 A noktalarının ne kadar ayrıldığını görsel olarak taşıyor. Kalabilir. Sayfa sıkışırsa tablo kalsın (08:26'dan gönderme alıyor), şekil çıksın.

**H-37 — şekil/tablo (şekil içi yazı) — orta — 0 (şekil yeniden üretimi)**
- **Yer ve sorun:**
  1. `tez-latex-v2/figures/sin3/harmonik_olusum_mekanizmasi.pdf`: (d) ve (e) göstergelerinde "kalibre S2 benzetimi" (kural 12) → "S2 benzetimi".
  2. `tez-matlab-simulink/results/sin3_rescan_20260901/sin3_katsayi_taramasi_20260901_k.pdf`: Türkçe karakter yok ("Ucuncu harmonik orani", "bolge", "yildiz", "akim zarfi", "Saf sinus", "Temel bilesen", "katsayi"); ondalık nokta ("k1=0.34", "40.0%"); göstergede "I3/I1=0.1%", metinde %0,15 (yuvarlama farklı); sol panel başlığı kesik.
  3. S4 şekilleri (`s4_akim_izleme_25A_KC.pdf`, `s4_tarama_ozet_KC.pdf`): panel başlıklarında iç koşu kodları ("KC P 25A", "KC PIR 25A 02s"), Simulink blok adı ("η (Display)", "η2 (Display)"), ondalık nokta ("22.15 A", "-11.41 %", "96.5"). "KC" ve "02s" okur için anlamsız, çalışma süreci bilgisidir.
  4. `kararlilik_L_bode_K34.pdf` başlığı "L = C Kpwm G Hm e-sTd": $C$ yerine $C_i$ (J-02'nin şekilde kalan kısmı).
  5. `kararlilik_Lg_taramasi.pdf` göstergesi noktalı ondalık ("Lg = 0.0 mH").
  6. `kararlilik_L_olcum_karsilastirma.pdf` göstergesi "2,3 A" virgüllü; öteki şekillerle tutarsız (kendi içinde doğru, ötekiler düzeltilince tutarlı olur).
  7. `kararlilik_nyquist_A_B.pdf`: "(B) sayısal, Ts = 100 µs, 1 Ts gecikme"; metin (B)'nin toplam gecikmesini $2T_s$ veriyor (05:389, 05:455). "1 Ts hesaplama gecikmesi" yazılmalı.
- **Öneri:** Şekiller ana oturumda yeniden üretilmeli. `fig:s4-tarama-ozet` H-33 ile çıkarsa 3'ün yarısı düşer.

**H-38 — şekil/tablo — düşük — ~0,05 sayfa**
- **Yer:** `tab:s4-tarama`, "Doyum" sütunu (sekiz satırda da %0).
- **Öneri:** Jüri maddesi 8 doyumu istiyor; bilgi korunmalı ama sabit sütun bilgi taşımıyor. Sütunu kaldır, başlığa "Kararlı durumda modülasyon doyuma girmemiştir; $|u|_{\max}$ son sütundadır" ekle. Tablo daralır, `\footnotesize` ve `\tabcolsep=2.6pt` sıkışıklığı azalır.

### 4.6 Jüri riski

**H-39 — jüri riski (kanıtın iddiayı desteklemesi) — yüksek — +~30 kelime**
- **Yer:** 05:381–391 (gerçekleme B, B2), 05:433 (son cümle), 05:455, `tab:kararlilik-marjlar` (B, B2 satırları: Nyquist 1, GM −20…−30 dB), `tab:kararlilik-lg` son sütunu ($\max|z|=1{,}175$–$1{,}277$), `fig:kararlilik-nyquist` başlığı.
- **Alıntı:** 05:433 "(B) ve (B2) satırlarındaki negatif GM, eklenen gecikmenin faz geçişinde $|L|>1$ yaptığını göstermektedir."
- **Gerekçe:** Tablo ve şekil, bir periyot hesaplama gecikmeli sayısal gerçeklemede aynı kazançlarla çevrimin kararlılığını yitirdiğini gösteriyor; metin bunu adlandırmıyor. Rezonans $f_s/6$'nın üstünde ve geri besleme $L_1$ akımından; aktif sönümlemesiz böyle bir çevrimin gecikmeli gerçeklemede kararsız olması literatürde bilinen sonuçtur (05:455 aynı literatürü anıyor). Jüri "donanımın 10 kHz DSP'sinde bu denetleyici çalışır mı?" diye soracaktır. 08:115 doğru yanıtı (aktif sönümleme ya da şebeke akımı geri beslemesi) gelecek çalışma olarak veriyor; ama Bölüm 5 ile 08:115 arasındaki bağ yok. Kural 8 "kararsızdır" yazmayı yasaklıyor; zorunlu koşul tek olumlu cümleyle verilebilir.
- **Öneri:** 05:455'in sonuna (yaklaşık): "Kararlılık sonucu analog eşdeğer gerçekleme (A) için elde edilmiştir. Bir periyot hesaplama gecikmeli sayısal gerçeklemede (B, B2) aynı kazançlarla Nyquist sayımı 1'dir; sayısal gerçekleme, aktif sönümleme ya da şebeke akımı geri beslemesiyle yeniden tasarlanmalıdır (Bölüm~\ref{…})." Bölüm 8 göndermesi kural 11'e göre atlanabilir. Sin³'ün çevrim dışı olduğu sonucu (B) ve (B2) için de geçerlidir, çünkü $K_{34}$ karakteristik denklemde yine yoktur; bunu belirtmek, katkıyı korur. Yeni sayı gerekmez.

**H-40 — jüri riski (bölümler arası çelişki) — yüksek — 0 (H-19 ile kapanır)**
- **Yer:** 05:32 ↔ 06:522 ↔ 03:538.
- **Alıntı:** 05:32 "sabit bir $k_1/k_3$ oranından daha kapsamlı bir modelle belirlenmelidir" ↔ 06:522 "S3'te $K_{33}/K_{13}$ oranı sabit tutularak $K_{13}$ ile $K_{33}$ birlikte".
- **Gerekçe:** Tez, kendi kullandığı yöntemin yetersiz olduğunu söylüyor. Ayrıca 05:41 HTF ile katsayı belirlemeyi şart koşuyor; tezde katsayılar P ve Q'ya kalibre edilmiştir.
- **Öneri:** H-19. Kesim kalacaksa 05:32 ve 05:41'in "-malıdır" önermeleri çıkmalı, kalibrasyonun sabit oranla yapıldığı ve oranın taramadan değil ilk parametre setinden geldiği tek cümleyle yazılmalı.

**H-41 — jüri riski (karşılaştırma tabanı) — yüksek — +~30 kelime; seçenek (b) [YENİ SAYI]**
- **Yer:** 05:74 (S2, $V_m/V_h=0{,}866$), 05:90 ve 05:130 (tarama S1 noktasında, $0{,}785$), 05:156 (bant "deney özetindeki 2,26 A" = S1 deney akımı; S3 deney akımı 2,31 A, 06:566), 05:175 (kıyas S3 kalibre katsayılarıyla; S3 noktası $124{,}3\sqrt2/213{,}75=0{,}822$).
- **Alıntı:** 05:175 "İki katsayı takımının karşılaştırması, analitik katmanın üçüncü harmonik ihtiyacını doğru büyüklükte öngördüğünü göstermektedir."
- **Gerekçe:**
  - Zarfın biçimi yalnız $V_m/V_h$'ye bağlı (05:74). Eşitlik `eq:dcm-sinus-zarfi` ile saf sinüs görev oranında $I_3/I_1$: $0{,}785$ için %39,9, $0{,}822$ için **~%46,2**, $0{,}866$ için %55,5 **[HESAP]**. Aday S1 noktasında bulunmuş, S3 noktasındaki katsayıyla kıyaslanıyor.
  - Taramanın en iyi noktası bant sınırında ($I_{\mathrm{rms}}=2{,}02$ A, bant 2,0–2,6 A). Temel katsayı bu sınırla belirleniyor, yani karşılaştırmada serbest olan tek büyüklük üçüncü harmonik katsayısı.
  - Neden S1 noktasının seçildiği yazmıyor.
- **Öneri:** (a) Yeni sayı olmadan: taramanın S1 noktasında yapıldığını ve S3 noktasında gerilim oranının 0,822 olduğunu tek cümleyle yaz; 05:175'in son cümlesini "Üçüncü harmonik katsayısı iki katmanda %4 içinde örtüşmektedir" boyuna indir (yargı yerine ölçü). (b) **[YENİ SAYI]** Taramayı S3 noktasında ($V_{\mathrm{dc}}=427{,}5$ V, $V_g=124{,}3$ V) yinele; analitik model hızlı (dakikalar), betik `results/sin3_rescan_20260901/` üretmiş. Tez sahibi yeni koşu yapmayacaksa (a) yeterli.

**H-42 — jüri riski (kaynağı belirsiz iddia, birim karışımı) — yüksek — ~60 kelime**
- **Yer:** 05:154; `tab:dcm-saf-sinus-harmonikleri`.
- **Alıntı:** 05:154 "Farklı bir çalışma noktası için elle seçilmiş $(0{,}45,\ 0{,}37)$, $(0{,}44,\ 0{,}38)$ ve $(0{,}41,\ 0{,}41)$ çiftleri".
- **Gerekçe:**
  - Değerler `results/sin3_rescan_20260901/eski_aday_noktalarin_kontrolu.csv` dosyasından geliyor; yani önceki sürümün aday noktalarıdır. Metin kaynağı "elle seçilmiş" diye örtüyor (kural 10'un gizli biçimi).
  - "Aynı çiftler kendi çalışma noktalarında %1–2 düzeyinde üçüncü harmonik oranı vermektedir" için tezde dayanak yok.
  - $(0{,}44,\ 0{,}38)$ kalibre edilmiş S3 katsayılarına ($0{,}4434$, $0{,}3843$) neredeyse eşit. Okur, anahtarlamalı modelde %14,8 THD veren katsayının analitik modelde 4 kat akım ve %68 THD verdiğini görüyor; analitik katmanın güvenilirliği sorgulanır. Fark büyük ölçüde S1 noktasında $k_1+3k_3/4\simeq0{,}73$'ün kritik görev oranını (0,785) tepe çevresinde aşıp CCM'ye girmesinden doğuyor, ama metin bunu söylemiyor.
  - "$I_1\simeq8{,}5$–9,2 A (düşük güç çalışma noktasının yaklaşık dört katı)": CSV'de $I_1$ **tepe** değer (RMS akım 7,3–7,8 A). 9,2 A tepe ile 2,3 A RMS karşılaştırılmış. Aynı belirsizlik `tab:dcm-saf-sinus-harmonikleri` başlığında var (H-22).
- **Öneri:** Paragrafı çıkar; ikinci bulguyu "Uygun $(k_1,k_3)$ çifti gerilim oranına, endüktansa ve akım düzeyine bağlıdır (Şekil~\ref{fig:sin3-yeniden-tarama})" cümlesine indir. Paragraf kalacaksa: kaynak nötr biçimde ("tezde ilk incelenen aday noktalar"), tepe/RMS açık, %1–2 iddiası çıkarılmış, CCM'ye geçiş nedeni yazılmış olmalı.

**H-43 — jüri riski (tabloyla çelişen önerme) — orta — 0**
- **Yer:** 05:526 (son iki cümle) ↔ `tab:kararlilik-olcum`.
- **Alıntı:** 05:526 "Kararlılık sonucu korunmaktadır, çünkü ölçülen bütün noktalarda faz analitik değerden önde ya da ona eşittir."
- **Gerekçe:** 2025 Hz'te analitik +63,9°; 10 A ölçümü +49,1° (belirsizlik ±5°, 15° geride), 25 A $K_{34}=0$ +54,4° (10° geride), 25 A $K_{34}$ açık +60,5°. 3362,5 Hz'te 25 A $K_{34}$ açık −126,7° (analitik −125,6°, belirsizlik içinde). 2025 Hz antirezonans bölgesinde $|L|\approx-11$ dB olduğundan kararlılığa etkisi yok, ama önerme olduğu gibi yanlış.
- **Öneri:** "kazanç geçişleri çevresinde (587,5 ve 3362,5 Hz) ölçülen faz analitik değerden önde ya da belirsizlik içinde ona eşittir" biçiminde daralt.

**H-44 — jüri riski (kanıtın kapsamı) — orta — +~15 kelime; seçenek [YENİ SAYI]**
- **Yer:** 05:526 (cümle 3–6), 05:558 (cümle 4), `tab:kararlilik-olcum` (2,3 A sütununda 587,5, 2025, 3362,5 Hz boş).
- **Alıntı:** 05:526 "Çevrim yavaş ama kararlıdır."
- **Gerekçe:** 2,3 A'de çevrim kazancı ölçülen aralıkta −7 ile −10 dB; kazanç geçişi ve kritik bölge (2–3,4 kHz) ölçülmemiş. Kararlılık hükmü düşük frekans faz öndeliğinden çıkarılıyor. Oysa 2,3 A'de kararlılığın doğrudan kanıtı var: P ve PI kapalı çevrim benzetimleri oturmuş (`tab:s4-tarama`, son iki periyot farkı <%0,12).
- **Öneri:** "2,3 A'de kararlılık, kapalı çevrim benzetiminin oturmasıyla (Tablo~\ref{tab:s4-tarama}) gösterilmiştir; enjeksiyon ölçümü 212–1037 Hz aralığında köprü kazancının düşüşünü nicelemektedir." **[YENİ SAYI, isteğe bağlı]** 2,3 A'de 2–3,4 kHz enjeksiyonu.

**H-45 — jüri riski (varsayım) — orta — +~25 kelime, −~40 kelime**
- **Yer:** 05:367 (cümle 1–2), 05:217 (cümle 3–5) ↔ 01:19 ("ölçülen şebeke geriliminin faz bilgisinden"), 02:317 ("ölçülen şebeke işaretinden"), 03:365, 03:546 ("ideal faz bilgisi").
- **Alıntı:** 05:367 "$\theta$ yalnız zamana bağlıdır ve şebekeye kilitlidir. Dolayısıyla $\sin^3\theta$ işaretinin bütün girişleri çevrimin dışındadır." ↔ 05:217 "aynı yol sanal empedans ile aktif sönümleme etkisi de oluşturabilir \citep{Lu2016}".
- **Gerekçe:** Çevrim dışı ayrımı, $\theta$'nın ideal PLL ile şebeke kaynağına kilitli olmasına dayanıyor. Gerçek uygulamada $\theta$ ortak bağlantı noktası geriliminden PLL ile üretilir; zayıf şebekede bu gerilim akıma bağlıdır ve ileri besleme yolu PLL üzerinden bir geri besleme yoluna dönüşür. 05:217, Lu2016'nın ölçülen gerilimli ileri besleme sonucunu anarak tam bu etkiyi kabul ediyor ve 05:367 ile çelişiyor. $L_g$ taraması (05:464) da ideal PLL ile yapılmış. (Bağlam: tez sahibinin jüri notunda Sin³ genliğinin "şebeke Vrms değerinden" etkilendiği yazıyor; bu da ölçülen bir büyüklüğe bağlılık demek.)
- **Öneri:** 05:367'ye koşul: "Analizde $\theta$ ideal PLL ile şebeke kaynağına kilitli kabul edilmiştir; PLL dinamiği ve ölçülen gerilime bağlı genlik, zayıf şebekede ileri besleme yolunu çevrime bağlayabilir." 05:217'deki Lu2016 cümlesini çıkar (H-25). PLL dinamiği 08:115/119'a bir yan cümleyle eklenebilir.

**H-46 — jüri riski (simge tutarsızlığı) — orta — 0**
- **Yer:** 05:330 (`tab:s4-basamak`: "zamanın %0,8'i; $|u|_{\max}=1{,}49$") ↔ 03:358 ($u=\operatorname{sat}_{\pm1}(u_{\mathrm{ff}}+u_{\mathrm{fb}})$) ↔ `tab:s4-tarama` son sütunu ($|u|_{\max}\le0{,}93$).
- **Gerekçe:** Tanım gereği $|u|\le1$. 1,49 doyum öncesi toplamdır. Aynı simge iki tabloda iki farklı büyüklük.
- **Öneri:** Basamak tablosunda "$|u_{\mathrm{ff}}+u_{\mathrm{fb}}|_{\max}=1{,}49$ (doyum öncesi)" yaz.

**H-47 — jüri riski (sayı tutarsızlığı, tanımsız büyüklük) — orta — 0; kısmen [YENİ SAYI]**
- **Yer:** 05:528 ("THD sırasıyla %9,4 ve %5,6") ↔ `tab:s4-tarama` PI 25 A (THD$_I$ %9,2) ↔ 03:617 ↔ `\umitnot` 05:290 ↔ review `2026-10-28_KARARLILIK_BODE.md`:344 ("THD_I_L1 %9,4 … 20 ms pencerede küçük ton sızıntısı dahil").
- **Gerekçe:** Aynı çalışma noktası için iki THD. Ayrıca S4 THD'si $i_{L1}$ akımına ait (review notu), S1–S3 THD'si ise faz (şebeke) akımına (Bölüm 6). `tab:s4-tarama` sütun başlığı "THD$_I$" hangi akım olduğunu söylemiyor. `\umitnot` bu değeri IEEE 1547'nin şebeke akımı sınırıyla karşılaştırıyor. 2,3 A'de S4 THD'si %7,0, S3 THD'si %14,8: okur ikisini aynı büyüklük sanıp kapalı çevrimin THD'yi yarıya indirdiğini düşünebilir.
- **Öneri:** 05:528'de tablodaki %9,2'yi kullan ya da pencere farkını yaz. `tab:s4-tarama` başlığına "THD$_I$: $i_{L1}$ akımı, $h\le50$" ekle. Şebeke akımı THD'si `metrik.csv` içinde varsa bir sütun olarak verilebilir; yoksa **[YENİ SAYI]** (koşu çıktılarından hesap, yeni benzetim gerektirmeyebilir; `logsout` kayıtları duruyorsa).

**H-48 — jüri riski (sayı tutarsızlığı) — orta — 0**
- **Yer:** 05:260 (son iki cümle).
- **Gerekçe:** $P_{\mathrm{ac}}=280{,}7$ W, $\eta=\%96{,}24$ → kayıp ~10,97 W. S3: 279,90 W, %94,25 → ~17,07 W. Fark ~6,1 W; metin 7,2 W diyor. 7,2 W büyük olasılıkla yalnız çekirdek kaybı direnci farkının hesabı; öteki kayıplar S4'te ~1,1 W yüksek **[HESAP]**.
- **Öneri:** H-27 ile cümle çıkarsa sorun kalkar. Kalacaksa "çekirdek kaybı parametresi farkı ~7,2 W, toplam kayıp farkı ~6,1 W" yaz. Kontrol edilmeli.

**H-49 — jüri riski (tutarsız kapsam, zayıf gerekçe) — orta — ~0; [HESAP]**
- **Yer:** 05:256 ("S4 orta ve anma akımı benzetimlerinde bara kapasitansı … büyütülmüş"), 03:512 ("S4 orta ve anma akımı benzetimleri"), 08:111 ↔ `tab:s4-tarama` başlığı ("büyütülmüş DA bara", bütün satırlar), 05:260 (cümle 1) ↔ review `2026-10-28_S4_KAPALI_CEVRIM.md` (kesin tarama `KC_*` bütünüyle 2×5,6 mF).
- **Gerekçe:**
  - 2,3 A satırlarının hangi barayla koşulduğu metinde ve tablo başlığında farklı söyleniyor. Review notuna göre bütün `KC_*` koşuları 5,6 mF ile.
  - Gerekçe "üç fazlı donanımda toplam kapasitans faz payının üç katıdır" (05:256, 06:389) jüriyi ikna etmez: üç katı bile 25 A'de ~40 V salınım verir. Fiziksel gerekçe başka: dengeli üç faz dört telli çalışmada temel bileşen nötr akımları birbirini götürür; orta noktadan yalnız üçlü harmonikler (susturmanın ve Sin³'ün üçüncü harmoniği) akar. 25 A PI'de $I_{L1,3}=2{,}13$ A; nötrde $3\times2{,}13=6{,}4$ A RMS, 150 Hz. D-11 bağıntısıyla ($\hat v_N\simeq\hat I/(\omega(C_A+C_B))$), toplam $2\times1410$ µF ile ~3,4 V **[HESAP]**. Yani gerçek üç fazlı donanımda orta nokta salınımı faz başına modeldekinden çok küçüktür ve büyütülmüş bara, faz başına modelin bu farkını temsil eden bir modelleme seçimidir.
- **Öneri:** Kapsamı tabloyla eşitle ("bütün S4 benzetimlerinde"). 05:256'daki sözel salınım hesabını D-11 bağıntısıyla ver ve üç faz gerekçesini yukarıdaki biçimde yaz (elle hesap, yeni benzetim gerekmez; hesabın tez sahibince onaylanması gerekir). 06:389'daki tekrarı çıkar (H-09).

**H-50 — jüri riski (kural 10 ruhu) — orta — ~10 kelime**
- **Yer:** 05:4 ("doğru trigonometrik özdeşlikle verilmektedir"), 05:127 (başlık "Analitik Katsayıların Doğru Özdeşlikle Hesabı"), 05:156 ("düzeltilmiş bir aday"), 05:562 ("Doğru özdeşlikle yapılan analitik tarama") ↔ 08:58 ("Doğru özdeşlikle parçalı DCM–CCM katsayı taraması"), 08:76 ("doğru özdeşlikle … yeniden hesaplanmıştır").
- **Gerekçe:** "Doğru", "düzeltilmiş", "yeniden hesaplanmış" sözcükleri okura önceki bir yanlışı çağrıştırıyor; jüri "yanlışı neydi?" diye sorar. Tezde yanlış özdeşlik yok. (Görünmeyen etiket ve dosya adları, `sec:sin3-yeniden-tarama`, `eq:sin3-duzeltilmis-optimum`, `sin3_rescan`, sorun değil.)
- **Öneri:** Başlık "Analitik Katsayı Taraması". 05:4 "kompanzasyon katsayıları trigonometrik özdeşlikle verilmektedir"; 05:156 "düşük güç çalışma noktası için bir aday"; 05:562 "Analitik tarama". 08:58 ve 08:76'da "doğru" ve "yeniden" çıksın.

**H-51 — jüri riski (gelecek çalışmayı yapılmış iş gibi okutma) — orta — ~0**
- **Yer ve öneri:**
  - 05:564 "En uygun Sin³ genliği ise akım düzeyiyle ölçeklenmektedir." Tezde genlik sabittir ($K_{34}=K_{33}$); okur ölçekleme yapıldığını sanır. → "En uygun Sin³ genliği akım düzeyine bağlıdır."
  - 05:528 "en uygun ileri besleme genliği, akım düzeyiyle ölçeklenen bir büyüklüktür" → "… akım düzeyine bağlı bir büyüklüktür."
  - 05:217 "İleri besleme yolunun etkisi, gerilim düşümü hesabından daha geniş bir çerçevede ele alınmıştır." Tezde sanal empedans etkisi incelenmemiştir. → Çıkar (H-25).
  - 05:41, 05:45: H-19 ve H-30.
  - 03:438 "akım izleme hatası, kararlılık marjı, denetim eforu, doyum süresi ve anma akımındaki etkisiyle birlikte değerlendirilmektedir": denetim eforu tezde hiç ölçülmüyor. → H-14.

**H-52 — jüri riski (simge çakışması) — düşük — 0**
- **Yer ve öneri:**
  - $d$: görev oranı (05:50, `simgeler.tex`:10) ve enjeksiyon işareti (05:495 "küçük bir işaret $d$ eklenmiştir"). → enjeksiyon için $u_{\mathrm{inj}}$ ya da $w$.
  - $L$: eşdeğer endüktans (05:50, 05:52–68, 05:99–107) ve çevrim kazancı $L(s)$ (05:352 sonrası). → analitik modelde $L$ yerine $L_1$ (05:74 zaten "$L=L_1$" diyor).
  - $N$, $P$, $Z$ (`eq:marj-tanimlari`): T-tipi durumlar $P/O/N$, P denetleyicisi, orta nokta $N$ (`simgeler.tex`:44) ve $Z_1$, $Z_2$ (05:179) ile çakışıyor. → $N_{\mathrm{c}}$, $P_{\mathrm{aç}}$, $Z_{\mathrm{kç}}$ ya da $N_{\mathrm{Ny}}$ gibi.
  - $i_g$: 05:119 tek endüktanslı analitik modelde "şebeke akımı" deniyor; modelde $C_f$–$L_2$ yok. → $\bar i_L$.
  - $K_3$ / $K_{34}$: H-31.
  - THD$_I$ (Bölüm 5) / THD$_{i,\mathrm{faz}}$ (Bölüm 6): H-47.

**H-53 — jüri riski (kaynaksız ölçüt) — düşük — 0**
- **Yer:** 05:433 (cümle 2–3). J-07 açık.
- **Öneri:** PM ≳ 45°, GM ≳ 6 dB, ‖S‖∞ ≲ 6 dB için künyesi doğrulanmış bir denetim kaynağı ekle ya da "yaygın" sözcüğünü çıkarıp ölçütü tezin kendi seçimi olarak ver.

**H-54 — jüri riski (sayısız önerme) — düşük — +1 tablo satırı**
- **Yer:** 05:132 ("$d_m=0{,}8$ değerinde oran değişmekte ve akım hızla büyümektedir"). Rapor 16 madde 1.
- **Öneri:** `saf_sinus_dcm_harmonikleri.csv` 0,8 satırını veriyor ($I_1=31{,}25$ A tepe, $I_3=9{,}16$ A, $I_3/I_1=\%29{,}32$). Satırı tabloya ekle (H-22) ve cümleye sayıyı koy. Yeni koşu gerekmez.

**H-55 — jüri riski (sayı tutarsızlığı) — düşük — 0**
- **Yer:** `tab:s4-basamak` (aşım %0,2, yerleşme 0,44 ms) ↔ `tab:kararlilik-basamak` (anahtarlamalı $K_{34}$ açık: %0,17, 0,43 ms) ↔ 05:564, 06:465 (0,44 ms).
- **Öneri:** Aynı koşu; H-34 birleştirmesinde tek değer kalsın. Fark yerleşme bandı tanımından geliyorsa tanım yazılsın.

**H-56 — jüri riski (iddia gücü) — düşük — 0**
- **Yer:** 05:566 (cümle 3: "Anahtarlamalı modelde ise farklar ölçüm belirsizliği düzeyindedir") ↔ 05:517 ("Fark her noktada iki ölçümün birleşik belirsizliği içinde ya da sınırındadır"; PM $53\pm3°$ ve $57\pm3°$).
- **Öneri:** Değerlendirme 05:517'nin ifadesini kullansın ("birleşik belirsizlik içinde ya da sınırında, fark iki benzetimin farklı akımda çalışmasından").

**H-57 — jüri riski (karşılaştırma koşulu) — düşük — 0**
- **Yer:** 05:231 ("verimi klasik anahtarlamadan 2,0 puan yüksek"), 08:34 ↔ 06:563, 06:568 (S1: 431,5 V, 249,6 W; S3: 427,5 V, 281,2 W).
- **Öneri:** Rapor 14 G-30'un S3 eşi. H-04 ile cümle Bölüm 5'ten çıkar. 08:34'te kalırsa "farklı DA bara gerilimi ve güçte" yan cümlesi.

**H-58 — jüri riski (terim tutarsızlığı) — düşük — 0**
- **Yer:** 05:175 ("köprünün süreksiz iletimdeki yumuşak gerilim kaynağı davranışından") ↔ 05:526 ("akım kaynağına yakın davranmaktadır") ↔ 06:545, 03:673, 04:181. D-04 açık.
- **Öneri:** Tek terim: "yumuşak kaynak" (Bölüm 3 ve 6 ile aynı). D-04 denklemi uygulanırsa iki ifade tek bağıntıya bağlanır.

**H-59 — `\umitnot` (kural 10) — düşük — 177 kelime (PDF'te görünmüyor)**
- **Yer:** 05:286–292, tek iç not ("İstenen THD sınırına ulaşıldı mı?").
- **Kural 10:** "eski tez", "ilk tez", "önceki sürüm", "eski Şekil/Tablo" ya da e-posta göndermesi **yok**.
- **Not:** İlk cümle ("Tezde şebeke standardıyla sayısal karşılaştırma yoktur") kural 8'e göre kendini zayıflatan bir yapı; not yalnız `tez_notlu.pdf`'te görünür. TDD hesapları temel bileşen akımıyla yeniden üretildi ve doğru (S1 1,3, S2 4,0, benzetim 4,8, S3 1,3, 10 A ~7,8). Notun içeriği bir jüri riskini işaret ediyor: 10 A ve 25 A'de THD IEEE 1547 sınırının üstünde ve Sin³ anma akımında üçüncü harmoniği artırıyor. Ana metin bu karşılaştırmayı yapmıyor, 08:115 akıma göre genlik ayarını gelecek çalışma olarak veriyor. Savunma hazırlığı için not yerinde; teslimde `\umitnotlarifalse` (K-28). H-47'deki akım tanımı belirsizliği nottaki karşılaştırmayı da etkiliyor.

---

## 5. Yeni sayısal sonuç gerektiren öneriler (tez sahibi kararı)

| Kimlik | Ne gerekir | Gerekmezse yapılacak |
|---|---|---|
| H-41 (b) | Parçalı analitik taramanın S3 noktasında yinelenmesi (dakikalar süren betik) | (a) koşulu tek cümleyle yaz, 05:175 yargısını ölçüye indir |
| H-44 | 2,3 A'de 2–3,4 kHz enjeksiyon ölçümü | Kararlılığı zaman alanı benzetiminin oturmasına dayandır |
| H-47 | S4 şebeke akımı THD'si (kayıtlar duruyorsa hesap, durmuyorsa yeni koşu) | Sütun başlığına "$i_{L1}$" yaz |
| H-49 | Yeni benzetim yok; üç fazlı orta nokta salınımının elle hesabı (~3,4 V), tez sahibinin onayı | Kapsamı düzelt, gerekçeyi olduğu gibi bırak |
| H-48 | Yeni benzetim yok; mevcut sayılarla kayıp farkı hesabı | Cümleyi çıkar (H-27) |
| H-54 | Yeni benzetim yok; CSV'deki 0,8 satırı | – |

---

## 6. Önerilen uygulama sırası

1. **Jüri riski düzeltmeleri (önce, çünkü kısaltılacak paragraflara dokunuyor):**
   - H-39 (05:455 koşul cümlesi), H-45 (05:367 koşul, 05:217), H-43 (05:526), H-44 (05:526), H-46 (05:330), H-50 (başlık ve dört yer, 08:58, 08:76), H-51 (05:528, 05:564).
   - H-40 ve H-19 birlikte: kesimin kaldırılması, 05:43'ün 05:558'e taşınması, 08:76'nın düzeltilmesi.
   - H-41 (a) ve H-42: 05:154 paragrafı, 05:175 son cümle.
   - H-31 (Bölüm 3 doğrulama matrisi ve simgeler).
2. **Büyük çıkarmalar ve birleştirmeler:** H-25 (eşpotansiyel kesimi), H-33 (`fig:s4-tarama-ozet`), H-34 (basamak tablo/şekil birleştirmesi, `tab:s4-basamak` etiketi birleşik tabloya), H-35 (`fig:kararlilik-lg`), H-26 ($\lambda$, Padé), H-22 (tablo üç satıra, 0,8 satırı H-54), H-20, H-21, H-23.
3. **Bölüm içi tekrarlar:** H-01 (05:26, 05:28, 05:562), H-02, H-03, H-04, H-06, H-07, H-08, H-10, H-11, H-12, H-17, H-18 (Bölüm 5 tarafı).
4. **Bölümler arası tekrarlar:** H-01 (03:366–370, `eq:sin3-ozdeslik`), H-09 (06:389), H-14 (03:438), H-15 (04:183, 06:582), H-16 (K-12 kararıyla), H-18 (03:569, 03:548), H-05.
5. **Küçük tutarlılık düzeltmeleri:** H-47, H-48, H-49 (kapsam), H-52, H-53, H-55, H-56, H-57, H-58, H-38, H-24, H-27, H-28, H-30.
6. **Şekil yeniden üretimi (ana oturum):** H-37 (yedi şekil; H-33 ve H-35 uygulanırsa ikisi düşer).
7. **Yeni sayı kararları:** §5 tablosu.
8. **Her adımdan sonra** Ayakaleaf'te derlenmeli ve tanımsız gönderme kalmadığı denetlenmeli. Derlemeyi ana oturum yapar.

**Korunması gereken etiketler** (başka bölümlerden gönderme alıyor): `chap:sin3`, `sec:harmonik-mekanizma` (04:133), `sec:sin3-yeniden-tarama` (08:34, 08:60, 08:119), `fig:sin3-yeniden-tarama` (08:26), `sec:s4-kapali-cevrim` (12 dış gönderme), `tab:s4-tarama` (06, 08), `tab:s4-basamak` (06:465; H-34'te birleşik tabloya taşınmalı), `sec:kararlilik-bode` (01, 03, 08), `eq:sin3-acik-cevrim` (03:438), `tab:kararlilik-marjlar` (08:26, 08:60), `tab:kararlilik-olcum` (08:26). Kaldırılması önerilen etiketlerin hiçbiri dış gönderme almıyor: `eq:htf-matris-iliskisi`, `eq:akim-fourier-katsayisi`, `eq:ccm-gorev-harmonik`, `eq:ccm-akim-cozumu`, `eq:pade-yaklasimi`, `fig:espotansiyel` (yalnız kısaltılıyor, çıkmıyor), `fig:s4-tarama-ozet`, `fig:s4-basamak`, `tab:kararlilik-basamak`, `fig:kararlilik-lg`; Bölüm 3'te `eq:sin3-ozdeslik`. `eq:htf-matris-iliskisi` çıkarsa 05:558'deki `\eqref` güncellenmeli.
