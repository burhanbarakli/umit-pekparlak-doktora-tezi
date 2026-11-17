# Bölüm 5 (Sin³ İleri Besleme Kompanzasyonu ve Kapalı Çevrim Analizi) yazım düzenlemesi

- **Dosya:** `yeni_tez/bolumler/05-sin3-kompanzasyon.tex`. Satır sayısı değişmedi (566). Başka dosyaya dokunulmadı.
- **Görev kipi:** uygula (`.claude/agents/tez-yazim-editoru.md`, kural 1–14).
- **Tarih:** 17.11.2026
- **Örnek alınan üslup:** Bölüm 4'ün düzenlenmiş hâli ve rapor 13.
- Derleme ve commit yapılmadı. 75 satır değişti: 63 düz metin paragraf satırı, 12 `\caption`. Tablo satırlarına, TikZ koduna, `%` yorumlarına ve `\umitnot` bloğuna dokunulmadı.

## 1. Önce/sonra sayımları

Sayım betiği rapor 11 ve 13'teki yöntemi izliyor. TikZ ve denklem blokları, `%` yorumları, `\umitnot` bloğu ve yalnız komut içeren satırlar dışarıda kaldı. Cümleler `. ? !` işaretinden bölündü. `\ref`, `\cite` ve `$...$` birer sözcük sayıldı. Düz metin, `\caption` ve tablo hücreleri ayrı sayıldı.

| Ölçüt | Önce (HEAD) | Sonra |
|---|---:|---:|
| Cümle sayısı: düz metin / `\caption` / tablo hücresi | 322 / 31 / 51 | 435 / 37 / 51 |
| Ortalama cümle uzunluğu: düz metin / `\caption` | 15,3 / 16,4 kelime | 11,4 / 13,9 kelime |
| 30 kelimeyi aşan cümle: düz metin / `\caption` | 18 / 3 | **0 / 0** |
| En uzun cümle: düz metin / `\caption` | 54 kelime (satır 566) / 43 kelime (satır 299) | 29 / 28 kelime |
| Noktalı virgül: düz metin / `\caption` / tablo | 66 / 8 / 1 | **0 / 0 / 1** |
| Geniş zamanla biten cümle: düz metin / `\caption` | 72 / 7 | **0 / 0** |
| Yasak gösterme sözcüğü (istenen grep) | 0 | **0** |
| "değil" geçen yapı (düz metin ve başlık) | 10 | **0** |
| Bölümler arası gönderme, `\ref`+`\eqref` (`\umitnot` içinde gönderme yok) | 28 (25 + 3) | **18 (15 + 3)** |
| `\label` / `\ref` / `\eqref` / `\cite*` komutu | 50 / 62 / 38 / 9 | 50 / 52 / 38 / 9 |
| Toplam kelime (metin + başlık + tablo, betik sayımı) | 6316 | 6366 |

**Yöntem farkı.** Görevi veren oturumun sayımı (yaklaşık 7100 kelime, 441 cümle, 41 uzun cümle, 79 noktalı virgül, yaklaşık 83 geniş zaman) metin, başlık, tablo ve büyük olasılıkla `\umitnot` içeriğini birlikte ölçmüş olmalı. Bu betik üç türü ayrı sayıyor ve `\umitnot` bloğunu dışarıda bırakıyor. Geniş zaman sayımı cümle sonundaki yüklemi kapsıyor. Betiğin "sonra" sürümünde yakaladığı beş aday, kural gereği kalan "-ebilir" yüklemleri ("ilişkilendirilebilir", "birleştirilebilir", "azaltabilir", "yazılabilir") ve bir yanlış eşleşmedir (satır 499 başlığındaki "değerler" sözcüğü). Noktalı virgülle bağlı yan cümle yüklemleri bölününce cümle sonu oldu ve onlar da çevrildi. Kalan "-ar/-er" biçimleri tarandı. Yalnız ad ve sıfat kullanımları kaldı ("aittir ve", "kayıplar ve", "marjlar ve" gibi).

**Bütünlük denetimi (betikle, `git show HEAD:...` sürümüne karşı):**
- `\label` (50), `\eqref` (38), `\cite`/`\citep` (9 komut; anahtarlar ve sıra dahil) dizileri birebir aynı.
- `$...$` matematik (507) ve `\SI{}{}` (210) dizileri **sıralarıyla birlikte** aynı. Metindeki çıplak sayılar 649 → 649, dizi sırası da aynı.
- `%` yorum satırları (2), `\umitnot` bloğu (satır 286–292) ve TikZ kodu birebir aynı. Tablo satırları değişmedi.
- `\ref`: 62 → 52. Eksilen 10 `\ref`'in hepsi §3'teki bölümler arası göndermeler. Bölüm içi şekil, tablo ve alt bölüm göndermelerinin hepsi kaldı.
- Kalan her `\ref`/`\eqref` hedefinin `\label`'ı `yeni_tez/bolumler` altında var (betikle denetlendi, eksik hedef 0).
- Yasak sözcük taraması: istenen `grep -n -i -w -E 'bu|bunun|...|söz konusu'` 0 satır buldu. "şöyle", "orada", "onu", "onun" ve gösterme sıfatı "o" da 0.
- Hiçbir paragrafta art arda üçten fazla "-mektedir/-maktadır" ile biten cümle yok (betikle denetlendi; satır 435'te çıkan beşli zincir ad cümlesiyle kırıldı).
- "temsilî" sözcüğü bölümde yoktu. Kalan "temsil etmektedir" ve "temsil edilmiştir" fiil kullanımları (satır 381, 391, 396, 453) doğru.
- "kalibre" yalnız "kalibre edilmiş/edilen/edilmiştir" biçiminde geçiyor (kural 12). `fig:s3-kalibre-l1` etiket adı ve dosya adı değişmedi.
- Ad biçiminde "doğrusal olmayanlık" yok. Satır 32'deki "doğrusal olmayan ... sistem" sıfat kullanımı kaldı (kural 14).

## 2. Yapılan değişiklik türleri

1. **Noktalı virgül (kural 2):** Düz metindeki 66 ve başlıklardaki 8 noktalı virgülün hepsi kaldırıldı. Çoğu iki cümleye bölündü. Bir kısmı "ise", "ancak", "-dığından", "Dolayısıyla" ya da virgülle yeniden kuruldu. Başlıklardaki panel ve açıklama listeleri nokta ya da ayraçla ayrıldı (satır 171, 227, 306, 440, 447, 499, 552). Satır 299 başlığındaki eksen açıklaması ikinci bir cümle oldu.
2. **Uzun cümle (kural 3):** 30 kelimeyi aşan 21 cümlenin hepsi bölündü. Başlıcaları:
   - Satır 566 (54 kelime): kararlılık sonucunun üç gerekçesi "Birincisi / İkincisi / Üçüncüsü" ile ayrı cümlelere bölündü.
   - Satır 175 (50 kelime): katmanlar arası katsayı farkı üç cümle oldu: farkın kaynağı, akım düzeyi koşulu ve karşılaştırmanın sonucu.
   - Satır 4 (40, 39 ve 31 kelimelik üç cümle): susturmanın yararı, bedeli ve sayıları ayrı cümlelere bölündü. Bölümün iki amacı iki cümle oldu.
   - Satır 346 (40 kelime): ikinci katmanın tanımı ve hesapladığı büyüklükler iki cümle oldu.
   - Satır 217, 350, 90, 495, 74, 179, 26, 32, 517, 564, 562 (31–38 kelime): noktalı virgül, iki nokta ya da bağlaç yerinden bölündü.
   - Başlık satır 299 (43 kelime), 79 (38 kelime) ve 171 (31 kelime) ikişer cümleye ayrıldı.
   - Aynı cümlede iki "ve ... ve" dizisi kalan yerlerde biri "ile" yapıldı (satır 217 "sanal empedans ile aktif sönümleme", 299, 350, 373, 530, 566).
3. **Kip birliği (kural 9):** Cümle sonundaki 79 geniş zaman yüklemi ve bölünen yan cümle yüklemleri "-mektedir/-maktadır" kipine çevrildi. Geçişlilik korundu: "çıkar" → "çıkmaktadır" (satır 528), "iner" → "inmektedir", "söner" → "sönmektedir", "yansır" → "yansımaktadır". Denklem öncesi bağlaçlar da çevrildi: "elde edilir" → "elde edilmektedir", "olarak bulunur" → "olarak bulunmaktadır", "yazılır" → "yazılmaktadır", "olur" → "biçimindedir" (satır 55). "ile gösterilsin", "olarak tanımlansın", "yazılsın" kalıpları ve "-ebilir/-abilir", "-malıdır/-melidir" yüklemleri aynen kaldı. Art arda "-mektedir" birikmesini önlemek için bazı cümleler ad cümlesine çevrildi:
   - Satır 24: "temel sinüs katsayısını ... gösterir" → "temel sinüs katsayısı, ... üçüncü harmonik katsayısıdır".
   - Satır 26: "pozitif işaretlidir, ek bir normalizasyon içermez" → "pozitif işaretli ve normalizasyonsuzdur".
   - Satır 74: "iki tepeli bir biçim alır" → "iki tepelidir".
   - Satır 125: "sinüs katsayılarını verir" → "sinüs katsayılarıdır".
   - Satır 154: "Katsayılar ... göre belirlenir" → "Katsayılar ... bağlıdır".
   - Satır 166: "Sin3 terimi ... şekillendirir" → "Sin3 teriminin şekillendirdiği bileşenler ise yapısı gereği temel ve üçüncü harmoniktir".
   - Satır 294: "sonlu çevrim kazancı kalıcı hatayı sıfırlamaz" → "Kalıcı hatanın nedeni, \SI{50}{\hertz}'teki sonlu çevrim kazancıdır".
   - Satır 435: "rezonans tepesi $-1$ noktasını çevrelememektedir" → "Rezonans tepesi de $-1$ noktasının dışındadır".
   - Satır 464: "kazanç marjı değişmez, çünkü ... belirlenir" → "Yüksek frekansta $L$, $L_1$ ile belirlendiğinden kazanç marjı sabittir".
   - Satır 528: "en uygun ileri besleme genliği akım düzeyiyle ölçeklenir" → "... akım düzeyiyle ölçeklenen bir büyüklüktür".
   - Satır 4 ve 231: deneyde yapılmış işler geçmiş zamanla verildi ("THD'yi \%14'e ... indirmiştir").
   - Yeni "değildir" yapısı üretilmedi. Var olan 10 "değil" yapısının hepsi olumlu kuruldu (bkz. §4).
4. **Gösterme sözcüğü (kural 1):** İstenen listedeki sözcüklerden bölümde yoktu. Satır 32'deki gösterme sıfatı "o" ("oran yalnız **o** dalga biçimini ve **o** çalışma noktasını tarif eder") → "Oran, ... yalnız gözlendiği dalga biçimini ve çalışma noktasını tarif etmektedir". Satır 528'deki "çevrim **onu** ... bastırır" → "Çevrim, üçüncü harmonik bileşeni ... bastırmaktadır".
5. **Terim ve yazım birliği (kural 5, 6, 14):**
   - Satır 310: "senkron olmayan buck" → "senkron olmayan alçaltıcı" (satır 50 ve Bölüm 4 ile aynı terim).
   - Satır 45: "modülasyon doygunluğu" → "modülasyon doyumu" (bölümün geri kalanındaki "doyum" terimi).
   - Satır 350: "Normalize modülasyon komutunu" → "Normalize edilmiş modülasyon komutunu" (çekimsiz sıfat, kural 12/14 ilkesi).
   - Satır 74: "olduğu halde" → "olduğu hâlde" (TDK).
   - Satır 110: "integrasyon" cümle başında "İntegrasyonda" biçiminde açıklayıcı özne olarak kullanıldı.
   - Denetleyici adı her yerde $C_i(s)$; doğru özdeşlik (Eşitlik `eq:sin3-acilimi`) değişmedi.
6. **Dolgu ve savunmacı cümleler (kural 8):**
   - Satır 217: "İleri besleme yolunun etkisi yalnız gerilim düşümü hesabıyla sınırlandırılmamıştır" → "İleri besleme yolunun etkisi, gerilim düşümü hesabından daha geniş bir çerçevede ele alınmıştır".
   - Satır 314: "aşım referans tepesine göre tanımlansaydı kararlı durumdaki dalga biçimi aşım gibi sayılırdı" → "Zarfa göre tanım, kararlı durumdaki dalga biçiminin aşım olarak sayılmasını önlemektedir".
   - Satır 236: "anma akımına taşınıp taşınamayacağı ve ... nasıl davrandığı" → "anma akımına taşınması ve akım denetimiyle birlikte davranışı".
   - Satır 381: "ayrıca tablolanmamıştır" → "Dolayısıyla ayrık karşılığı da gerçekleme (A) satırları temsil etmektedir".
   - Satır 451: "\SI{0.06}{\second}'de oturmayıp \SI{0.2}{\second} gerektirmesinin" → "oturması için \SI{0.06}{\second} yerine \SI{0.2}{\second} gerekmesinin".

Sayılar, birimler, kaynak sırası, `\cite` yerleri ve iddia gücü değişmedi. Bölünen cümlelerde atıf özgün yerinde, son parçanın sonunda kaldı (satır 45 `Holmes2003`, satır 217 `Lu2016`). Başlık yapısı, kesim sırası ve paragraf sınırları korundu. Paragraf birleştirilmedi ya da taşınmadı. İçerik çıkarılmadı.

## 3. Kaldırılan bölümler arası göndermeler (kural 11)

Satır numaraları HEAD'e göredir. Dosyanın satır sayısı değişmediği için güncel dosyayla aynı.

| Satır | Kaldırılan gönderme | Hedef | Gerekçe |
|---:|---|---|---|
| 4 | "Bölüm~\ref{chap:anahtarlama}, nötr anahtar susturma yönteminin ... göstermiştir" → "Nötr anahtar susturma yöntemi, ... artırmaktadır" | `chap:anahtarlama` (Bölüm 4) | Paragrafta üç bölümler arası gönderme vardı. Susturmanın THD bedelinin sayısal kaynağı olan `tab:kalibrasyon-karsilastirma` kaldı. |
| 4 | "(Alt Bölüm~\ref{sec:kalibrasyon})" (THD %14 cümlesinin sonu) | `sec:kalibrasyon` (Bölüm 6) | Aynı paragrafta üçüncü gönderme. %14 değeri aynı paragrafta göndermesi kalan tabloda da yer alıyor. |
| 26 | "Alt Bölüm~\ref{sec:kalibrasyon} içinde deney özetine kalibre edilen" → "Deney özetine kalibre edilen" | `sec:kalibrasyon` (Bölüm 6) | Paragrafta ikinci gönderme. Katsayı değerlerinin kaynağı `tab:sistem-parametreleri` kaldı. |
| 74 | "($K_{12}=0{,}768$, Alt Bölüm~\ref{sec:kalibrasyon})" → "($K_{12}=0{,}768$)" | `sec:kalibrasyon` (Bölüm 6) | Paragrafta ikinci gönderme. Şekil parametrelerinin kaynağı `tab:sistem-parametreleri` kaldı. |
| 130 | "değerleriyle (Tablo~\ref{tab:sistem-parametreleri}) yapılmıştır" → "değerleriyle yapılmıştır" | `tab:sistem-parametreleri` (Bölüm 3) | Paragrafta ikinci gönderme. Taramanın model katmanını tanımlayan `tab:model-katmanlari` kaldı. Aynı S1 değerlerine satır 90'da tabloyla gönderme var. |
| 175 | "yumuşak gerilim kaynağı davranışından (Alt Bölüm~\ref{sec:kalibrasyon})" | `sec:kalibrasyon` (Bölüm 6) | Aynı paragrafta aynı hedefe ikinci gönderme. İlk gönderme ("Alt Bölüm~\ref{sec:kalibrasyon} içinde ... kalibre edilmiştir") kaldı. |
| 231 | "birbirinden farklıdır (Tablo~\ref{tab:sistem-parametreleri}, Tablo~\ref{tab:deney-kosullari})" → "birbirinden farklıdır" | `tab:sistem-parametreleri` (Bölüm 3), `tab:deney-kosullari` | Paragrafta üç gönderme vardı. Gerilim değerleri cümlenin kendisinde sayısal olarak veriliyor. THD yeniden üretiminin kaynağı `sec:kalibrasyon` kaldı. |
| 247 | "kalibre edilmiş S3 değerleridir (Tablo~\ref{tab:sistem-parametreleri})" → "kalibre edilmiş S3 değerleridir" | `tab:sistem-parametreleri` (Bölüm 3) | Paragraf 247–254 tek paragraf (denklem arada). Aynı tabloya satır 254'te ("Kazançların tamamı Tablo~... içindeki S4 akım denetimi grubundadır") daha özgül bir gönderme kalıyor. |
| 350 | "$L_2$ ve şebeke (Tablo~\ref{tab:sistem-parametreleri})" → "$L_2$ ve şebeke" | `tab:sistem-parametreleri` (Bölüm 3) | Paragraf 350–367 iki `\eqref` (Bölüm 3 eşitlikleri) taşıyor. `\eqref` kümesi görev gereği korunduğu için tablo göndermesi çıkarıldı. |

Toplam 10 `\ref` kaldırıldı. Bölümde "Bölüm X'te verilecektir" türü bölümler arası ileriye dönük duyuru yoktu. Satır 4 sonundaki ve satır 217'deki duyuru niteliğindeki göndermeler bölüm içi (`sec:kararlilik-bode`, `sec:s4-kapali-cevrim`) olduğu için kaldı.

**Bırakılan 18 gönderme:**
- **Paragraf başına bir `\ref` (15):** satır 4 `tab:kalibrasyon-karsilastirma`; 26, 74, 90, 256, 260 `tab:sistem-parametreleri`; 50 `fig:susturma-esdeger`; 130 `tab:model-katmanlari`; 175, 231 `sec:kalibrasyon`; 217 `fig:denetim-modulasyon-blok`; 236 `fig:s3-simulink-modeli`; 241 (`\caption`) `fig:s3-simulink-modeli`; 254 `tab:sistem-parametreleri`; 310 `sec:ters-akim-mekanizmasi`.
- **`\eqref` (3):** satır 247 `eq:s4-denetim-yapisi`; satır 350 `eq:lcl-rezonans` ve `eq:s4-denetim-yapisi`. `\eqref` kümesi görev gereği korundu. Dolayısıyla paragraf 247–254 bir `\eqref` ile bir `\ref`, paragraf 350–367 iki `\eqref` taşıyor.
- **`\umitnot` içinde:** bölümler arası gönderme yok.

**Not:** `tab:deney-kosullari` etiketine tezde başka `\ref` kalıp kalmadığı bu görevde denetlenmedi. Etiket yerinde duruyor, silinmedi. Göndermesiz etiket derleme uyarısı üretmez.

## 4. Olumlu yazım (kural 8)

| Satır | Önce | Sonra |
|---|---|---|
| 4 | "Sin3 teriminin bir denetleyici değil, modülasyon toplamına çevrim dışından eklenen bir ileri besleme girişi olduğu ve kararlılık marjlarını değiştirmediği" | "Sin3 teriminin denetleyiciden ayrı, modülasyon toplamına çevrim dışından eklenen bir ileri besleme girişi olduğu ve kararlılık marjlarını koruduğu" |
| 13 | "$\sin^3\theta$ terimi yalnız üçüncü harmonikten oluşmaz; temel bileşen ile ... birlikte taşır." | "$\sin^3\theta$ terimi, temel bileşen ile ters işaretli üçüncü harmonik bileşenini sabit bir oranla birlikte taşımaktadır." |
| 24 | "Doğrudan $\sin(3\theta)$ enjeksiyonu ile $\sin^3\theta$ terimi aynı işlem değildir" | "... iki farklı işlemdir." |
| 28 | "... farklı model katmanlarına aittir ve birbirinin yerine kullanılmamaktadır." | "... farklı model katmanlarına aittir ve her biri kendi katmanında kullanılmaktadır." |
| 32 | "Kompanzasyon katsayılarının tek bir cebirsel iptal koşulundan ... türetilmesi anahtarlamalı dönüştürücüde geçerli değildir." | "Anahtarlamalı dönüştürücüde kompanzasyon katsayıları, tek bir cebirsel iptal koşulundan ... daha kapsamlı bir modelle belirlenmelidir. Gerekçeler üçtür." |
| 32 | "... girişten bağımsız bir sistem aktarım fonksiyonu olmamasıdır" / "kanıtlanmadan uygulanamamasıdır" / "aynı büyüklük olmamasıdır" / "yalnız trigonometrik özdeşlikten çıkarılamaz" | "... genlik oranının girişe bağlı olmasıdır" / "ancak kanıtlandıktan sonra uygulanabilmesidir" / "ayrı büyüklükler olmasıdır" / "trigonometrik özdeşliğin yanında denetlenen sistemin dinamiğini ve harmonikler arası bağlaşımı da gerektirmektedir" |
| 45 | "Uygulama kazancı yalnız THD eniyilemesiyle seçilmemeli; ..." | "Uygulama kazancı seçilirken THD eniyilemesinin yanında ... birlikte değerlendirilmelidir." |
| 45 | "tezdeki amaç ise ... DA bara kullanımını artırmak değil, ... azaltmaktır" | "Tezdeki amaç ise ... DA bara kullanımını artırmaktan farklı olarak, ... azaltmaktır" |
| 72 | "ortalama akımın saf sinüs kalmadığını" | "ortalama akımın saf sinüsten ayrıldığını" |
| 74 | "üçgen darbeler ... sıfıra iner ve ters yöne geçmez" | "... sıfıra inmekte ve ters yöne geçmeden sona ermektedir" |
| 90 | "kritik görev oranı ... bağlıdır; tek bir evrensel sayı değildir." | "kritik görev oranı, tek bir evrensel sayı yerine faz açısına ve gerilim oranına bağlı bir fonksiyondur." |
| 90 | "ideal ifadenin tek başına kullanılması uygun değildir; ölü zaman, ... ayrıca uygulanmalıdır." | "ideal ifadeye ek olarak ölü zaman, en küçük darbe süresi ve sonlu akım eşiği de uygulanmalıdır." |
| 97 | "$K_{1x}$, $K_{3x}$ değerlerine bire bir eşit değildir" | "$K_{1x}$, $K_{3x}$ değerlerinden sayısal olarak ayrılmaktadır" |
| 213 (`\caption`) | "empedanslarından akım akmaz" | "empedanslarından akan akım sıfırdır" |
| 222 | "Kompanzasyon süreksiz iletimi ortadan kaldırmaz; darbe genişliklerini ... değiştirir." | "Kompanzasyon, süreksiz iletimi koruyarak darbe genişliklerini ... değiştirmektedir." |
| 254 | "\SI{60}{\hertz} değerinin şebeke frekansıyla ilgisi yoktur" | "Seçilen \SI{60}{\hertz} değeri geçiş frekansına göre belirlenmiştir ve şebeke frekansından bağımsızdır" |
| 294 | "sonlu çevrim kazancı kalıcı hatayı sıfırlamaz" | "Kalıcı hatanın nedeni, \SI{50}{\hertz}'teki sonlu çevrim kazancıdır" |
| 310 | "genlik hatasının bir kararlılık sorunu değil, köprünün etkin kazancındaki düşüşten doğan bir izleme sorunu olduğunu" | "\SI{10}{\ampere}'de çevrimin kararlı olduğunu ve genlik hatasının köprünün etkin kazancındaki düşüşten doğan bir izleme hatası olduğunu" |
| 346 | "karakteristik denklemde yer almadığını" | "karakteristik denklemin dışında kaldığını" |
| 367 | "$\sin^3\theta$ işaretinin hiçbir girişi çevrimdeki bir büyüklükten gelmez" | "Dolayısıyla $\sin^3\theta$ işaretinin bütün girişleri çevrimin dışındadır" |
| 367 | "Doyum sınırı bütün kararlı durum pencerelerinde aşılmamıştır" | "Bütün kararlı durum pencerelerinde modülasyon doyum sınırının altında kalmıştır" |
| 369 | "çevrimin kendisi, yani $L$, $S$ ve $T$, değişmez" | "... aynı kalmaktadır" |
| 391 | "$L_{\mathrm{B}}$ içinde ayrı bir $H_m$ yer almamaktadır" | "$L_{\mathrm{B}}$ içinde süzme işlevini $H_m$ yerine periyot ortalaması üstlenmektedir" |
| 409 | "Nokta pozitif gerçel eksendedir ve faz geçişi değildir." | "Nokta pozitif gerçel eksendedir ve faz geçişi tanımının dışında kalmaktadır." |
| 409 | "Açık çevrimde kararsız kutup bulunmadığından ($P=0$)" | "Açık çevrimin bütün kutupları kararlı olduğundan ($P=0$)" |
| 435 | "$-121^{\circ}$'ye iner ama $-180^{\circ}$'ye ulaşmaz" | "$-121^{\circ}$'ye inmekte ve $-180^{\circ}$'nin üstünde kalmaktadır" |
| 464 | "kazanç marjı değişmez" | "kazanç marjı sabittir" |
| 491 | "Kazanç azalması kararlılığı bozmaz, yalnız birinci geçişi aşağı çeker" | "Kazanç azalmasında kararlılık korunmakta, birinci geçiş aşağı inmekte" |
| 495 | "Anahtarlamalı model doğrudan doğrusallaştırılamaz: ..." | "Anahtarlamalı modelde PWM karşılaştırıcısının ve kip mantığının yerel türevi hemen her yerde sıfırdır. Doğrudan doğrusallaştırma, denetlenen sistemin yolunu kesmektedir. Dolayısıyla çevrim kazancı ... enjeksiyonla ölçülmüştür." |
| 495 | "enjeksiyon çalışma noktasını bozmamıştır" | "Dolayısıyla enjeksiyon çalışma noktasını korumuştur" |
| 562 | "doğrudan $\sin(3\theta)$ enjeksiyonuyla aynı katsayı anlamını taşımamaktadır" | "Dolayısıyla terimin katsayı anlamı, doğrudan $\sin(3\theta)$ enjeksiyonundan ayrılmaktadır" |
| 562 | "sinüzoidal görev oranının neden sinüzoidal akım üretmediğini" | "sinüzoidal görev oranıyla akımın neden sinüsten ayrıldığını" |
| 566 | "Sin3 teriminin bir denetleyici değil, çevrim dışından eklenen bilinen bir giriş olduğunu" | "Sin3 teriminin denetleyiciden ayrı, çevrim dışından eklenen bilinen bir giriş olduğunu" |

**Ödünleşim olarak kalanlar (sayılarıyla):**
- Satır 4: susturmanın bedeli, "Yöntemin bedeli, akımın süreksiz iletime girmesi ve özellikle üçüncü harmoniğin büyümesidir" cümlesiyle ve THD %15 → %47 ile %39,5 → %56,7 sayılarıyla verildi.
- Satır 528: Sin³'ün anma akımındaki üçüncü harmonik artışı ödünleşim olarak kaldı: $I_{L1,3}$ \SI{2.13}{\ampere} ve \SI{0.43}{\ampere}, THD %9,4 ve %5,6, $K_{34}=0$ iken genlik hatası −%2,1 → −%12,3. Son cümle "Temel bileşendeki yarar ile üçüncü harmonikteki **bedel** birlikte gözetildiğinde en uygun ileri besleme genliği, akım düzeyiyle ölçeklenen bir büyüklüktür" biçiminde ödünleşim diliyle kuruldu ("etki" → "bedel").
- Satır 310 ve 564: orta akımda (\SI{10}{\ampere}) THD %19,6/%20 ve "Nötr susturma düşük güç bölgesi için tasarlanmış bir yöntemdir" koşul cümlesi kaldı.

**Teknik betim olarak kalan olumsuz yapılar** tezin aleyhine konuşmadığı için korundu ya da yalnız kipi çevrildi:
- satır 24 "ayrı bir simgeyle gösterilmemektedir" (gösterim kuralı)
- satır 26 "Modelde $\sin(3\theta)$ üreten blok bulunmamaktadır" (model betimi)
- satır 43 "Ortalama modelde çapraz harmonik terimi bulunmadığından" (model betimi)
- satır 222 "Ters akım aralığı yoktur" (yöntemin sonucu)
- satır 254 "hesaplama gecikmesi olmaksızın" (model betimi)
- satır 367 "$K_{34}$'ü içermemektedir" ve satır 566 "terimi içermemektedir" (bölümün temel kararlılık sonucu; kural 9 örneğindeki "değiştirmez → değiştirmemektedir" çevirisi)
- satır 460 (`\caption`) "$-1$ noktasını çevrelememektedir" (kararlılığın kanıtı)
- satır 526 "köprü kazancındaki azalma kararlılığı bozmamaktadır"
- satır 433 ve 455'te gecikmeli (B, B2) gerçeklemelerin negatif GM değerleri, gecikme duyarlılığı incelemesinin sonucu olarak aynen kaldı.

## 5. `\umitnot` temizliği (kural 10)

Satır 286–292'deki iç not ("İstenen THD sınırına ulaşıldı mı?") tarandı. Notta "eski tez", "ilk tez", "önceki tez/sürüm", "eski Şekil/Tablo" ya da e-posta göndermesi **yok**. Dolayısıyla nota dokunulmadı. Jüri hazırlık içeriği olduğu gibi duruyor: IEEE 1547/IEC 61727 sınırları, akım düzeylerine göre TDD hesabı ve gelecek çalışma önerisi.

Not: İç notun ilk cümlesi ("Tezde şebeke standardıyla sayısal karşılaştırma yoktur; ...") kural 8'e göre kendini zayıflatan bir yapı. Görev yalnız kural 10 temizliğini istediği için dokunulmadı. Not yalnız `tez_notlu.pdf`'te göründüğü sürece sorun yok.

Düz metinde, başlıklarda ve tablolarda da "eski tez", "ilk tez" ya da önceki sürüme gönderme yok.

## 6. Şekil içi yazılar (kural 10 ve 12)

Bölümdeki 13 görüntü şeklinin metin katmanı PyMuPDF ile çıkarıldı. Raster içeren iki dosya (S4 anahtarlama girişi ekran görüntüsü ve katsayı tarama haritası) görüntüye çevrilip gözle denetlendi. Hiçbir şekilde "eski tez", "ilk tez", "önceki" ya da "temsilî" yazısı **yok**. Dosyalara dokunulmadı. Ana oturumun yeniden üretmesi önerilen noktalar:

1. **`sin3/harmonik_olusum_mekanizmasi.pdf`** (Şekil `fig:harmonik-mekanizma`, yol `tez-latex-v2/figures/`): (d) ve (e) panellerinin göstergesinde **"kalibre S2 benzetimi"** yazıyor. Kural 12'ye göre "S2 benzetimi" olmalı. Şekil yeniden üretilmeli.
2. **`../tez-matlab-simulink/results/sin3_rescan_20260901/sin3_katsayi_taramasi_20260901_k.pdf`** (Şekil `fig:sin3-yeniden-tarama`): yazılar Türkçe karaktersiz ("Ucuncu harmonik orani", "bolge", "yildiz", "akim zarfi", "Saf sinus", "Temel bilesen", "katsayi"). Ondalık ayırıcı nokta ("0.34", "40.0%"). Sol panelin başlığı sol kenarda kesik görünüyor. Kural 10 ihlali değil, biçim sorunu.
3. **S4 şekilleri** (`s4_akim_izleme_25A_KC.pdf` gibi): panel başlıklarında ondalık nokta ("22.15 A", "-11.41 %") var. Tezin geri kalanıyla tutarlılık için ondalık virgül düşünülebilir.

## 7. Kontrol edilmeli (teknik ya da anlam)

1. **Satır 132, "$d_m=0{,}8$ satırında" → "değerinde":** Tablo `tab:dcm-saf-sinus-harmonikleri` yalnız $d_m=0{,}1$–$0{,}7$ satırlarını içeriyor. Özgün metin tabloda olmayan bir "0,8 satırına" gönderme yapıyordu. "değerinde" yazıldı. Tabloya 0,8 satırı eklenmesi mi isteniyor, yoksa değer taramanın tablo dışı kısmından mı geliyor, denetlenmeli.
2. **Satır 4 ve 566, "bir denetleyici değil" → "denetleyiciden ayrı":** Vurgu korunuyor ama jüri sorusu "Sin³ bir denetleyici midir?" biçiminde gelirse eski karşıtlık daha keskindi. Alt kesim başlığı ("Analitik katman: Sin3 terimi çevrimin dışındadır") aynı mesajı veriyor.
3. **Satır 32:** "geçerli değildir" yargısı "daha kapsamlı bir modelle belirlenmelidir" önerisine çevrildi. Kesim başlığı ("Basitleştirilmiş Türetimlerin Geçerlilik Sınırı") değişmedi. Başlık ile metnin tonu uyumlu ama başlık da olumlu kurulmak istenirse ayrı bir karar gerekir (bu görevde başlıklara dokunulmadı).
4. **Satır 381:** "ayrık karşılığı ... ayrıca tablolanmamıştır" → "Dolayısıyla ayrık karşılığı da gerçekleme (A) satırları temsil etmektedir". Anlam aynı olmalı: ayrık karşılığın marjları (A) satırlarından en çok 0,02° ve 0,1 dB farklı.
5. **Satır 391:** "$L_{\mathrm{B}}$ içinde ayrı bir $H_m$ yer almamaktadır" → "süzme işlevini $H_m$ yerine periyot ortalaması üstlenmektedir". Teknik içerik aynı. Periyot ortalamasının süzgeç işlevi Eşitlik `eq:kararlilik-ayrik-model` içindeki $1/s$ ve $(1-z^{-1})/T_s$ çarpanlarıdır.
6. **Satır 409:** "faz geçişi değildir" → "faz geçişi tanımının dışında kalmaktadır". GM tanımı $\angle L=-180^{\circ}$ istediği için $0^{\circ}$'daki nokta faz geçişi sayılmıyor. Anlam doğru.
7. **Satır 435:** "$-180^{\circ}$'ye ulaşmaz" → "$-180^{\circ}$'nin üstünde kalmaktadır". Negatif açılarda "üstünde" ($-121^{\circ}>-180^{\circ}$) doğru ama okur için "ulaşmadan" daha sezgisel olabilir.
8. **Satır 310, son cümle:** "Orta ve anma akımında tamamlayıcı anahtarlamaya dönüş ya da akım düzeyine göre ayarlanan ileri besleme yöntemi tamamlar" → "Orta ve anma akımında yöntemin tamamlayıcısı, tamamlayıcı anahtarlamaya dönüş ya da akım düzeyine göre ayarlanan ileri beslemedir". İki seçenek iç notta "gelecek çalışma olarak önerilmiştir" diye geçiyor. Ad cümlesi bunları yapılmış iş gibi okutabilir. Gerekirse "tamamlayabilir" (kural 9'un izin verdiği olasılık kipi) yazılabilir. "tamamlayıcısı, tamamlayıcı" tekrarı da üslup açısından gözden geçirilebilir.
9. **Satır 4, `chap:anahtarlama` göndermesinin çıkması:** Bölümün açılışı artık önceki bölümün adını vermiyor. Göndermesi kalan tablo (`tab:kalibrasyon-karsilastirma`) Bölüm 6'da. Okurun susturma yöntemini Bölüm 4'te bulması daha önemli sayılırsa tablo yerine `chap:anahtarlama` bırakılabilir.
10. **Satır 236, "anma akımına taşınıp taşınamayacağı" → "anma akımına taşınması":** Özgün açık soru biçimiydi. Yeni biçim incelemenin konusunu olumlu adlandırıyor. Sonuç bölümün kendisinde (büyütülmüş bara koşuluyla) verildiği için iddia değişmiyor.
11. **Satır 254, "\SI{60}{\hertz} değerinin şebeke frekansıyla ilgisi yoktur" → "geçiş frekansına göre belirlenmiştir ve şebeke frekansından bağımsızdır":** Cümlenin dayanağı aynı cümlenin önündeki "geçiş frekansının yaklaşık onda biri" bilgisi. Şebeke frekansı tezde 50 Hz (PIR rezonansı \SI{50}{\hertz}). Anlam aynı.
12. **Satır 495, `\SI{80}{\milli\second}` cümlesi:** Cümle başına sayı gelmemesi için "Tonlar \SI{80}{\milli\second} pencerede ..." biçiminde sıra değiştirildi. Benzer biçimde satır 517 ("Fark \SI{3362.5}{\hertz}'te ..."), 526 ("Etkin kazanç \SI{10}{\ampere}'de ...", "Köprü \SI{2.3}{\ampere}'de ...") ve 310 ("Süreksiz bölge \SI{25}{\ampere}'de ...") düzenlendi. Satır 310, 528, 530 ve 558'de cümle başında `\SI` ile başlayan birkaç cümle kaldı (özgün metindeydi).
13. **"denetim eforu" (satır 45):** Terim kaldı. "denetim çabası" daha Türkçe bir karşılık olabilir (kural 14'ün "zorlama karşılık" ilkesine göre değerlendirilebilir).
14. **Paragraf 247–254 ve 350–367:** Her biri bölümler arası iki gönderme taşıyor (bir ya da iki `\eqref`). `\eqref` kümesi görev gereği korundu. Kural 11 sıkı uygulanacaksa Bölüm 3 eşitlikleri metne gömülebilir, ancak denetim yapısı ve LCL rezonans eşitliği tanım niteliğinde olduğu için kalmaları uygun görünüyor.

## 8. Kalan noktalı virgüller

- **Düz metin:** 0.
- **`\caption`:** 0. Sekiz noktalı virgülün hepsi nokta, ayraç ya da virgüle çevrildi. Satır 227'deki (a)/(b) panel listesi iç virgül içerdiği için kural 2'ye göre kalabilirdi. Okunuş için nokta seçildi.
- **Tablo hücreleri:** 1. Satır 330, tablo `tab:s4-basamak`, "zamanın \%0,8'i; $|u|_{\max}=1{,}49$". Hücre iki ayrı değeri (doyum süresi oranı ve en büyük modülasyon) ayıran bir değer listesi. Görev tanımı gereği kaldı.
- **`\umitnot`:** satır 288–291'de 6 noktalı virgül. İç nota ait, dokunulmadı ve sayımlara girmedi.
