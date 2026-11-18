# Bölüm 8 (Sonuçlar ve Gelecek Çalışmalar) yazım düzenlemesi

- **Dosya:** `yeni_tez/bolumler/08-sonuc.tex`. Satır sayısı değişmedi (129). Başka dosyaya dokunulmadı.
- **Görev kipi:** uygula (`.claude/agents/tez-yazim-editoru.md`, kural 1–14).
- **Tarih:** 18.11.2026
- **Örnek alınan üslup:** Bölüm 6 ve 7'nin bugünkü hâli, rapor 26.
- Derleme ve commit yapılmadı. 15 satır değişti: 14 düz metin paragraf satırı ve 1 tablo satırı (satır 25, yalnız bir noktalı virgül). `\caption` satırlarına, patent tablosuna (Tablo `tab:fikri-mulkiyet`, satır 86–103) ve öteki tablo hücrelerine dokunulmadı. Bölümde `\kirmizinot`, `\umitnot`, `%` yorum satırı, TikZ ve denklem bloğu yok.
- Görev tanımı gereği paragraf sırası, kesim yapısı, `\ref`/`\label` kümesi ve tablo sayıları korundu. Bölümler arası gönderme **kaldırılmadı** (bkz. §3).
- Bölüm, düzenleme öncesinde de görece temizdi: düz metinde noktalı virgül ve 30 kelimeyi aşan cümle yoktu. İşin ağırlığı yasak sözcük, "değil" yapıları, iç içe ortaç zincirleri, bir cümlede birden çok "ve" dizisi ve özne kayması üzerindeydi.

## 1. Önce/sonra sayımları

Sayım betiği rapor 26'daki betiğin (`olc7.py`) uyarlamasıdır. İki ek yapıldı: `longtable` ortamı tablo sayıldı (Tablo `tab:arastirma-sorusu-kanit`) ve `\caption[]{...}` biçimi başlık olarak tanındı. Cümleler `. ? !` işaretinden bölündü. `\ref`, `\cite`, `$...$`, `\SI`, `\num` birer sözcük sayıldı. Düz metin, `\caption` ve tablo hücreleri ayrı sayıldı. "Önce" sütunu HEAD (cd74093) sürümüdür. Dosya düzenleme öncesinde HEAD ile aynıydı.

| Ölçüt | Önce (HEAD) | Sonra |
|---|---:|---:|
| Cümle sayısı: düz metin / `\caption` / tablo hücresi | 100 / 5 / 70 | 112 / 5 / 70 |
| Ortalama cümle uzunluğu: düz metin / `\caption` | 16,5 / 9,4 kelime | 15,0 / 9,4 kelime |
| 30 kelimeyi aşan cümle: düz metin / `\caption` / tablo | 0 / 0 / 0 | **0 / 0 / 0** |
| En uzun cümle: düz metin / `\caption` / tablo | 30 kelime (satır 129) / 19 kelime (satır 44) / 25 kelime (satır 26) | 29 kelime (satır 4) / 19 / 25 |
| 26–30 kelimelik cümle, düz metin | 10 (satır 4, 32, 34, 76, 80, 84, 109, 113, 127, 129) | 4 (satır 4, 76, 84, 127) |
| Noktalı virgül: düz metin / `\caption` / tablo | 0 / 0 / 16 | **0 / 0** / 15 |
| Geniş zamanla biten cümle: düz metin / `\caption` / tablo | 0 / 0 / 0 | **0 / 0 / 0** |
| Yasak gösterme sözcüğü (istenen grep) | 1 ("bunlara", satır 84) | **0** |
| Genişletilmiş tarama ("ondan", "onu", "onun", "onları", "şöyle", "orada") | 1 ("ondan", satır 34) | **0** |
| "değil" geçen yapı: düz metin / tablo | 2 (satır 76, 117) / 0 | **0** / 0 |
| Art arda üçten fazla "-mektedir" ile biten paragraf | 0 | **0** |
| Bölümler arası gönderme (`\ref`, bölüm dışı hedef) | 34 | 34 |
| `\label` / `\ref` / `\eqref` / `\cite*` komutu | 4 / 38 / 0 / 0 | 4 / 38 / 0 / 0 |
| Toplam kelime (metin + başlık + tablo, betik sayımı) | 2267 | 2294 |

**Sayım notları.**
- Geniş zaman için betik yalnız cümlenin son sözcüğüne bakıyor. Cümle sonundaki `(Alt Bölüm~\ref{...})` gibi ayraçlar yüklemi gizlediği için cümle sonu yüklemleri ayraçlar atılarak ayrıca elle listelendi. Önce ve sonra düz metinde geniş zamanla biten cümle yok. Kalan yüklemler "-mektedir/-maktadır", "-mıştır/-miştir", ad cümlesi ("-dır/-dir"), gereklilik ("-malıdır/-melidir") ve olasılık ("-ebilir") kipindedir.
- Betiğin tabloda işaretlediği "marjlar" (satır 26) ad olduğu için yanlış eşleşmedir.
- Tablodaki 16 noktalı virgülün 12'si patent tablosunda (satır 95–100), 3'ü iç öğelerinde virgül bulunan sıralamalarda (satır 24, 27, 60) duruyor. Kural 2 bu üç kullanıma izin veriyor. Satır 25'teki noktalı virgülün iki yanında virgül yoktu, virgüle çevrildi (bkz. §2.1).
- "Sonra" sürümünde kalan "-ebilir" yüklemleri kural 9 gereği aynen kaldı: "genişletilebilir" (121), "araştırılabilir", "kurulabilir", "destekleyebilir" (123). Tablo hücresindeki "kullanılabilir" (64) de kaldı.
- Paragraf başına en uzun "-mektedir" zinciri sonra satır 30'da ve 34'te üçtür ("inmektedir, vermektedir, üretmektedir"). Satır 129'da düzenleme öncesi zincir "görevlendirilmektedir, korumaktadır, koymaktadır" idi. Son cümle geçmiş zamanla kurulduğu için zincir ikiye indi.

**Bütünlük denetimi (betikle, HEAD sürümüne karşı):**
- `$...$` (23), `\SI{}{}` (25), `\num{}` (2), `\label` (4), `\ref` (38) ve `\caption` (3 satır) dizileri **sıralarıyla birlikte** birebir aynı. `\eqref`, `\cite*` ve `\includegraphics` bölümde yok.
- Metindeki çıplak sayılar 167 → 167, dizi sırası da aynı. Sayı eklenmedi, çıkarılmadı. Bölünen cümlelerde sayıların sırası korundu (satır 32, 34).
- İki `tabularx` tablosu (katkı tablosu ve patent tablosu) birebir aynı. `longtable` yalnız satır 25'teki tek noktalı virgül değişikliği nedeniyle farklı. Hücredeki sayılar ve göndermeler aynı.
- Komut satırları (27: `\chapter`, `\section`, `\subsection`, `\label`, `\begin`, `\end` vb.) birebir aynı.
- Kalan her `\ref` hedefinin `\label`'ı `yeni_tez/bolumler` altında var (eksik hedef 0).
- Yasak sözcük taraması: istenen `grep -n -i -w -E 'bu|bunun|buna|bunu|bunlar|bunların|bunlara|bundan|bunda|bununla|böyle|böylece|şu|şunun|söz konusu|adı geçen|o'` ve "bu nedenle/bu sayede/bu kapsamda/bu durumda" taraması 0 satır. "şöyle", "orada", "onu", "onun", "ondan", "onları" da 0.
- "kalibre" yalnız "kalibre edilmiş" (10) ve "kalibre edilen" (3) fiil biçiminde geçiyor (kural 12). Çekimsiz sıfat kullanımı yok. Satır 34'teki "kalibre edilmeden" yeniden kurulurken kalktı (bkz. §2.5).
- "doğrusal olmayanlık", "eski tez", "önceki tez" bölümde yok (kural 10, 14).

## 2. Yapılan değişiklik türleri

### 2.1 Noktalı virgül (kural 2)
Düz metinde noktalı virgül yoktu. Tabloda yalnız satır 25'teki noktalı virgül kural dışıydı: "Tablo~\ref{tab:kalibrasyon-karsilastirma} ve Tablo~\ref{tab:deney-dusuk-guc-ozeti}; \SI{10}{\ampere} ..." → "...ozeti}, \SI{10}{\ampere} ...". Satır 24, 27 ve 60'taki noktalı virgüller iç öğelerinde virgül bulunan iki öbeği ayırdığı için kaldı.

### 2.2 Uzun cümle ve iç içe yapı (kural 3)
30 kelimeyi aşan cümle yoktu. Sınırda kalan ya da tamlama zinciri, birden çok "ve" dizisi ve özne kayması taşıyan cümleler bölündü:
- **Satır 129 (30 kelime):** üç ortaçlı sıfat zinciri ("artıran, ... koruyan ve ... birleştiren bütünlüklü bir yaklaşım") iki cümle oldu: "Sonuç olarak tez, T-tipi dönüştürücü için bütünlüklü bir yaklaşım ortaya koymuştur. Yaklaşım, düşük güç verimini artırırken ... korumakta ve aynı donanımı ... şarj--deşarj işlevlerinde birleştirmektedir."
- **Satır 32 (29 kelime):** deney ve benzetim verim artışları iki cümle oldu. Tablo göndermesi ikinci cümlenin sonunda, özgün konumunda kaldı.
- **Satır 80 (27 kelime, iki "ve" dizisi):** "yeniden görevlendirerek ... ortak kullanma ve maliyet ile hacmi azaltma olanağı sunmaktadır" → "... yeniden görevlendirmektedir. Yeniden görevlendirilen IGBT'ler sürücü, koruma ve soğutma altyapısının ortak kullanılmasına, maliyet ile hacmin azaltılmasına olanak sağlamaktadır."
- **Satır 34:** S3 kalibrasyon cümlesi (24 kelime, "deneyin %14 akım THD'sini kalibre edilmeden %14,8 ile, verimini ...") iki cümle oldu. Kararlılık cümlesindeki "... yer almadığını ve $L$, $S$ ve $T$'nin $K_{34}$ açık ve kapalıyken aynı kaldığını" üçlü "ve" dizisi iki cümleye bölündü.
- **Satır 109 (28 kelime):** iki ayrı özneli yüklem ("S4 modeli ... kurulmuş ve ... benzetimleri ... yürütülmüştür") iki cümle oldu.
- **Satır 113, 115, 117, 119:** Gelecek Çalışmalar'da virgülle bağlanmış iki gereklilik ("tasarlanmalı, ... hesaplanmalıdır"; "tasarlanmalı, ... raporlanmalıdır") ve iki liste taşıyan cümleler ayrı cümle oldu. Satır 119'da transformatör özellikleri ile röle ve diyot kayıpları iki cümleye ayrıldı.
- **Satır 127:** "Tezin ulaştığı genel sonuç, ... davranışının ... olanağı sunduğu ve ... ödünleşiminin ... dengelendiğidir" ortaç zinciri iki yüklemli cümle oldu.

### 2.3 Kip birliği (kural 9)
- Düz metinde cümle sonu geniş zaman yoktu. Bölünen cümlelerde yeni yüklemler bölümün kipine uyduruldu: "kurulmuştur" (109), "tasarlanmalıdır" (113), "yapılmalıdır" (117), "görevlendirmektedir" (80), "vermektedir" (34).
- Art arda "-mektedir" birikmesini önlemek için ad cümlesi ve geçmiş zaman kullanıldı:
  - Satır 4: art arda iki "dayanmaktadır" → ikincisi "... incelemelerinin dayanakları ... prototip deney kayıtlarıdır".
  - Satır 34: kararlılık sonucu "Analize göre $L$, $S$ ve $T$ fonksiyonları ... aynıdır" biçiminde ad cümlesi oldu.
  - Satır 129: son cümle "ortaya koymaktadır" → "ortaya koymuştur". Yapılmış iş geçmiş zamanla anlatıldı.
- Satır 32'de ikinci cümlede geçişsiz fiil kullanıldı: "benzetimde verim ... yükselmiştir" (özne verim olduğu için "yükseltmiştir" değil).

### 2.4 Gösterme sözcüğü (kural 1)
- Satır 84: "Ulusal patentler ve bunlara dayanan üç PCT başvurusu" → "Ulusal patentler ve aynı buluşlara dayanan üç PCT başvurusu" (bkz. §6).
- Satır 34: "verim ondan 2,0 puan yüksek kalmıştır" → "verim klasik anahtarlamadakinden 2,0 puan yüksek kalmıştır". "ondan" istenen listede yok, ancak rapor 26'daki genişletilmiş tarama gereği adla değiştirildi.
- Yeni cümlelerde bağ adın tekrarıyla kuruldu ("Model, ...", "Marjlar, ...", "Tasarımın ...", "Ölçüm, ...", "Yaklaşım, ...", "Yeniden görevlendirilen IGBT'ler ...").

### 2.5 Terim ve yazım (kural 5, 6)
- Satır 34: "S3 modeli deneyin %14 akım THD'sini kalibre edilmeden %14,8 ile ... yeniden üretmektedir" → "S3 modeli, kalibrasyon hedefi olmayan akım THD'sini deneydeki %14 değerine karşılık %14,8 olarak vermektedir. Model, deneyin verimini 0,25 puan, AA akımını %1,4 içinde yeniden üretmektedir." "kalibre edilmeden %14,8 ile" yapısı, THD'nin kalibre edilmediği hâlde %14,8 verdiği biçiminde okunabiliyordu. Yeni ifade aynı bölümdeki katkı tablosunun (satır 59) "kalibrasyon hedefi olmayan THD" ifadesiyle aynıdır.
- Satır 34: "anma akımında (25 A) PI ve PIR denetimi ... $-$%2,1 ve $-$%1,0" → "PI ve PIR denetimi, anma akımında (25 A) doyuma girmeden sırasıyla $-$%2,1 ve $-$%1,0 ...". Çift bulunma eki ("modelinde anma akımında") çözüldü. "sırasıyla" katkı tablosundaki PI = $-$%2,1 eşleşmesine ve Bölüm 5'teki S4 tablosuna dayanıyor (bkz. §6).
- Satır 127: "susturma verimi 1,7 puan artırmış ve şebeke akımı THD'si ... çıkmıştır" (bir cümlede iki özne, "ve" ile bağlı) → "susturma verimi 1,7 puan artırmış, şebeke akımı THD'sini ise ... çıkarmıştır". Özne tek kaldı, fiil geçişli biçime geçti.
- Satır 113: "PLL dinamiği dahil marjlar" → "Marjlar, örnekleme ve hesaplama gecikmesi ile PLL dinamiğini de içerecek biçimde yeniden hesaplanmalıdır". "dahil/dâhil" seçimi tez genelinde açık olduğu için sözcük cümleden çıktı (bkz. §5).
- Satır 113: "histerezis" → "Tasarımın etkinleşme eşiği, histerezisi ve geçiş sürekliliği" (iyelik eki öteki öğelerle eşitlendi).
- Satır 76: "veya" → "ya da" (bölümdeki öteki kullanımlarla aynı). "genel amaçlı harmonik süzgeç" → "genel amaçlı bir harmonik süzgeç" (önceki öğedeki "bir" ile eşitlendi).
- Satır 76: "Katkının iki ayağından harmonik etkinin ... büyüklüğü ile kararlılık marjları Tablo ...'te verilmiştir" → "Harmonik etkinin ... büyüklüğü ile kararlılık marjları, katkının iki ayağı olarak Tablo ...'te verilmiştir" (ayrılma ekiyle kurulan belirsiz bağ çözüldü).

### 2.6 Olumlu yazım (kural 8)

| Satır | Önce | Sonra |
|---|---|---|
| 72 | "... ters akım sorunu genel bir hafif yük kaybı olarak bırakılmamıştır. Ters akım, ... üzerinden topolojiye özgü bir mekanizma olarak açıklanmıştır." | "... ters akım sorunu, genel bir hafif yük kaybının ötesinde topolojiye özgü bir mekanizma olarak ele alınmıştır. Ters akım, ... üzerinden açıklanmıştır." |
| 76 | "Sin³ terimi bağımsız bir geri besleme denetleyicisi veya genel amaçlı harmonik süzgeç olarak değil, ... olarak konumlandırılmıştır." | "Sin³ terimi, bağımsız bir geri besleme denetleyicisi ya da genel amaçlı bir harmonik süzgeç yerine, ... olarak konumlandırılmıştır." |
| 117 | "Sin³ katsayıları yalnız düşük güç THD minimumuna göre değil, temel akım, ... birlikte gözetilerek seçilmelidir." | "Sin³ katsayıları, düşük güç THD minimumunun yanında temel akım, ... de birlikte gözetilerek seçilmelidir." |

**Teknik betim olarak kalan olumsuz yapılar** (tezin aleyhine konuşmuyor):
- Satır 34 "Sin³ teriminin karakteristik denklemde yer almadığını göstermiştir" ve satır 127 "kararlılık marjlarını değiştirmediği" (kararlılık sonucunun kendisi).
- Satır 76 "mevcut akım denetleyicisi değiştirilmeden uygulanabilmektedir" (uygulama kolaylığı).
- Satır 34 ve 127 "doyuma girmeden", "doyumsuz", satır 129 "kararlılığını bozmadan" (başarım betimi).

### 2.7 Değişen satırların listesi

| Satır | Kesim | Değişiklik |
|---:|---|---|
| 4 | Giriş paragrafı | İkinci "dayanmaktadır" ad cümlesine çevrildi |
| 25 | Tablo `tab:arastirma-sorusu-kanit`, AS2 | Noktalı virgül → virgül |
| 32 | AS2 | 29 kelimelik cümle ikiye bölündü |
| 34 | AS3 | "ondan" kaldırıldı. Kalibrasyon cümlesi ve kararlılık cümlesi bölündü. PI/PIR cümlesi yeniden sıralandı, "sırasıyla" eklendi |
| 72 | 8.2.1 | "bırakılmamıştır" olumlu kuruldu, iki cümle yeniden dağıtıldı |
| 76 | 8.2.2 | "olarak değil" → "yerine". Tablo göndermeli cümle yeniden kuruldu |
| 80 | 8.2.3 | İki "ve" dizili cümle ikiye bölündü |
| 84 | 8.2.4 | "bunlara" → "aynı buluşlara" |
| 109 | 8.3 | İki özneli cümle ikiye bölündü |
| 113 | 8.4 | İki gereklilik cümlesi bölündü. "dahil" çıktı. "histerezisi" |
| 115 | 8.4 | Geçici durum sınaması cümlesi ikiye bölündü |
| 117 | 8.4 | $L$, $S$, $T$ ölçüm cümlesi ikiye bölündü. "değil" yapısı olumlu kuruldu |
| 119 | 8.4 | Transformatör ve röle/diyot kayıpları iki cümleye ayrıldı |
| 127 | 8.5 | İlk cümlenin ortaç zinciri çözüldü. "susturma ... artırmış ve THD'si çıkmıştır" özne kayması düzeltildi |
| 129 | 8.5 | 30 kelimelik son cümle ikiye bölündü, "koymuştur" |

Sayılar, birimler, simgeler, `\ref` yerleri ve iddia gücü değişmedi. Paragraf birleştirilmedi ya da taşınmadı. İçerik çıkarılmadı. Satır 80'de "olanağı sunmaktadır" → "olanak sağlamaktadır" aynı olasılık düzeyini taşıyor.

## 3. Bölümler arası göndermeler (kural 11): dokunulmadı

Görev tanımı `\ref` kümesinin değişmemesini istediği için hiçbir gönderme kaldırılmadı. Sonuç bölümü bütün tezi özetlediği için göndermelerin çoğu okurun sayıyı kaynağında bulması için gerekli. Kural 11'in "paragrafta birden fazla bölümler arası gönderme kurma" sınırını aşan düz metin paragrafları:

| Satır | Göndermeler | Not |
|---:|---|---|
| 30 | `chap:sistem`, `chap:anahtarlama` | AS1 paragrafı. İki bölüm göndermesi aynı cümlede. Tablo `tab:arastirma-sorusu-kanit` satır 24 aynı iki bölümü zaten veriyor. Metin göndermeleri çıkarılabilir. |
| 32 | `tab:kalibrasyon-karsilastirma`, `tab:s4-tarama` | Sayıların kaynağı. Kalmaları doğal. |
| 34 | `sec:thd-kaynaklar`, `sec:kalibrasyon`, `sec:sin3-yeniden-tarama`, `sec:s4-kapali-cevrim`, `sec:kararlilik-bode` | Paragrafta beş Alt Bölüm göndermesi var. Hepsi sayının kaynağını gösteriyor. Katkı tablosunun satır 60'ı aynı dört alt bölümü listelediği için metindeki göndermeler bire indirilebilir. |

Tablo hücrelerindeki göndermeler (satır 24–27, 55, 60, 65) tablo işlevinin parçasıdır. Satır 72 ve 117'de birer gönderme var. "Bölüm X'te ayrıntılı verilecektir" türü ileriye dönük duyuru yok.

## 4. Patent tablosu ve patent paragrafı

Tablo `tab:fikri-mulkiyet` (satır 86–103) birebir aynı. Tablodaki 12 noktalı virgül, numara ve tarihler değişmedi. Tablo öncesindeki düz metin paragrafında (satır 84) yalnız yasak "bunlara" sözcüğü değişti. Tablo sonrasındaki paragraf (satır 105) dil kurallarına uyduğu için değişmedi.

## 5. Bilerek dokunulmayanlar

- **Tablo hücreleri (görev tanımı):** Tablo `tab:arastirma-sorusu-kanit` "Sonuç düzeyi" sütunundaki dört hücre "yanıtlandı." ile bitiyor (satır 24–27). Bu, "-dı" ile kurulan görülen geçmiş zamandır. Geniş zaman olmadığı için görev kapsamına girmedi. Bölümün kipiyle uyum için "yanıtlanmıştır" yazılması önerilir.
- **`\caption` (görev tanımı):** hiçbir başlık değişmedi. Satır 44'teki katkı tablosu başlığının ikinci cümlesi ("Deney değerleri yaklaşık 2,3 A faz akımı, 250–280 W AA güç ve yaklaşık 120 V şebeke gerilimindeki tek faz kolu içindir.") koşul açıklamasıdır. Proje kuralına (altyazılarda ek açıklama yok) göre gövdeye taşınması gerekebilir. Aynı koşul satır 109'da zaten var.
- **Kanıt düzeyi dili:** satır 4 (sonuçların "doğrulanmış mekanizma, raporlanmış sayısal bulgu, ..." olarak sınıflandırılması), satır 40 ("her katkının tezin sonunda ulaştığı kanıt düzeyi"), kesim başlığı "Fikrî Mülkiyet Çıktılarının Kanıt Konumu" ve tablo sütun adları "Kanıt türü", "Kanıtın yeri ve türü" kural 8'in "kanıt düzeyi tartışması" uyarısına yakın. İçerik ve başlık değişmeyeceği için kaldı.
- **Fazlalık:** AS2 ve AS3 paragraflarındaki sayılar (satır 32, 34) katkı tablosunda (satır 54, 59) ve Genel Sonuç'ta (satır 127) yineleniyor. S4 koşulları satır 109 ve 127'de iki kez anlatılıyor. Sonuç bölümünde yineleme doğal sayıldı, silinmedi.
- **Karışık terimler:**
  - "kip" ile "mod": metinde "evirici kipi", "kip geçişi", tabloda "çalışma modu/modları" (satır 27, 63'te "çalışma kipleri"). Tablo değişmeyeceği için birleştirme yapılmadı.
  - "senkron-buck" (satır 24, 30, 53) ve "doğrultucu/boost diyotları" (satır 119). Bölüm 4–6'da "senkron buck" karşılığı olarak "alçaltıcı" yazılmıştı. Bölüm 7'de de "buck" ve "boost" kaldı (rapor 26 §5). Tez genelinde karar verilirse tek geçişte düzeltilmeli.
  - "izolasyon" (satır 119). Bölüm 2, 7 ve eklerde "yalıtım" geçiyor. Tez genelinde tek terim seçilirse burada da değiştirilmeli.
- **"dahil" yazımı:** Bölüm 8'deki tek "dahil" cümle yeniden kurulurken çıktı. `04-dusuk-guc-anahtarlama.tex:139` ve `05-sin3-kompanzasyon.tex:351` (tablo) "dahil" yazımını koruyor.
- **Satır 4, ilk cümle (29 kelime):** sınırın altında ve tek yüklemli bir sıralama olduğu için bölünmedi.

## 6. Anlamı belirsiz olup tahmin edilmeyen ya da kontrol edilmesi gereken noktalar

1. **Satır 84, "aynı buluşlara dayanan":** Özgün "bunlara dayanan" ulusal patentleri gösteriyordu. Aynı paragrafın son cümlesine göre her PCT başvurusu bir ulusal başvurunun rüçhanını taşıyor ve başlıklar aynı. Bu yüzden "aynı buluşlara dayanan" yazıldı. Hukuki açıdan "ulusal başvurulara dayanan" ya da "ulusal başvuruların rüçhanını taşıyan" daha kesin olabilir. Tez sahibi seçmeli.
2. **Satır 34, "sırasıyla" (denetlendi):** Özgün metin "PI ve PIR denetimi ... $-$%2,1 ve $-$%1,0 genlik hatasında" diyordu. Eşleşme Bölüm 5'te doğrulandı: `05-sin3-kompanzasyon.tex:304` (Tablo `tab:s4-tarama`, PIR 25 A satırı $-$%1,0) ve `:588` ("sırasıyla $-$%2,1 ve $-$%1,0"). Yalnız bilgi için listede tutuldu.
3. **Satır 34, "kalibrasyon hedefi olmayan akım THD'si":** Özgün "kalibre edilmeden %14,8 ile" ifadesi, katkı tablosundaki "kalibrasyon hedefi olmayan THD" ile aynı anlamda okundu. Kastedilen başka bir şeyse (ör. kalibrasyon öncesi model değeri) düzeltilmeli.
4. **Satır 127, "verimi korumuş ve %94,5'e taşımıştır":** Verim %94,2'den %94,5'e çıktığı için "korumuş" ile "taşımış" yan yana hafif çelişkili okunuyor. İddia değiştirilmedi. "Sin³ ileri beslemesi THD'yi %14'e, yani klasik anahtarlama düzeyine indirmiş, verimi %94,5'e taşımıştır" önerilir.
5. **Satır 72, "orta akımda tamamlayıcı anahtarlama tercih edilmektedir":** Cümle bir tasarım önerisini yapılmış bir uygulama gibi anlatıyor. Kip geçişi Gelecek Çalışmalar'da (satır 113) öneri olarak geçtiği için "tercih edilmelidir" daha tutarlı olabilir. Kip değişikliği iddiayı değiştireceği için uygulanmadı.
6. **Satır 30, "iletim kaybı potansiyeli artmaktadır":** "potansiyel" sözcüğü belirsiz. Kastedilen "iletim kaybı artmaktadır" ise sadeleştirilebilir. İddia gücü değişeceği için dokunulmadı.
7. **Satır 115, "Her olayda":** Özgün cümlede "... açma/kapama anı için yerleşme süresi, aşım, doyum ve koruma davranışı ayrıca ölçülmelidir" yazıyordu. İkiye bölünürken üç olay ikinci cümlede "Her olayda" ile anıldı. Anlam aynı, ancak cümle sayısı arttı.
8. **Satır 129, "ortaya koymuştur":** Kipin "-mektedir"den geçmiş zamana geçmesi zincir kırmak içindir. Tez sahibi Genel Sonuç'un son cümlesinde "-mektedir" istiyorsa "ortaya koymaktadır" yazılabilir. O durumda paragrafta dört "-mektedir" art arda gelir.
