# Bölüm 6 (Deneysel Doğrulama) yazım düzenlemesi

- **Dosya:** `yeni_tez/bolumler/06-deneysel-dogrulama.tex`. Satır sayısı değişmedi (606). Başka dosyaya dokunulmadı.
- **Görev kipi:** uygula (`.claude/agents/tez-yazim-editoru.md`, kural 1–14).
- **Tarih:** 18.11.2026
- **Örnek alınan üslup:** Bölüm 4 ve 5'in düzenlenmiş hâli, rapor 16.
- Derleme ve commit yapılmadı. 41 satır değişti, hepsi düz metin paragraf satırı. `\caption` satırlarına, tablo satırlarına, TikZ koduna ve `\umitnot` bloğuna dokunulmadı. Bölümde `%` yorum satırı ve `\kirmizinot` bloğu yok.
- Görev tanımı gereği paragraf sırası, kesim yapısı, `\ref`/`\label` kümesi ve tablo hücreleri korundu. Bu nedenle rapor 16'dan farklı olarak bölümler arası gönderme **kaldırılmadı** (bkz. §3).

## 1. Önce/sonra sayımları

Sayım betiği rapor 16'daki yöntemi izliyor (`olc.py` temel alındı). TikZ blokları, `\umitnot` bloğu (ayraç dengesiyle bulundu) ve yalnız komut içeren satırlar dışarıda kaldı. Cümleler `. ? !` işaretinden bölündü. `\ref`, `\cite`, `$...$` birer sözcük sayıldı. Düz metin, `\caption` ve tablo hücreleri ayrı sayıldı. "Önce" sütunu HEAD (415d727) sürümüdür.

| Ölçüt | Önce (HEAD) | Sonra |
|---|---:|---:|
| Cümle sayısı: düz metin / `\caption` / tablo hücresi | 218 / 43 / 126 | 278 / 43 / 126 |
| Ortalama cümle uzunluğu: düz metin / `\caption` | 15,3 / 7,5 kelime | 12,2 / 7,5 kelime |
| 30 kelimeyi aşan cümle: düz metin / `\caption` / tablo | 6 / 0 / 2 | **0 / 0** / 2 |
| En uzun cümle: düz metin / `\caption` | 70 kelime (satır 116) / 22 kelime (satır 534) | 27 kelime (satır 605) / 22 kelime |
| Noktalı virgül: düz metin / `\caption` / tablo | 51 / 0 / 7 | **0 / 0** / 7 |
| Geniş zamanla biten cümle: düz metin / `\caption` / tablo | 8 / 0 / 1 | **0 / 0** / 1 |
| Yasak gösterme sözcüğü (istenen grep) | 0 | **0** |
| "değil" geçen yapı (düz metin, başlık, tablo) | 0 | 0 |
| Art arda üçten fazla "-mektedir" ile biten paragraf | 1 (satır 586, dörtlü) | **0** |
| Bölümler arası gönderme, `\ref`+`\eqref` | 23 (21 + 2) | 23 (21 + 2) |
| `\label` / `\ref` / `\eqref` / `\cite*` komutu | 40 / 79 / 2 / 0 | 40 / 79 / 2 / 0 |
| Toplam kelime (metin + başlık + tablo, betik sayımı) | 4789 | 4836 |

**Sayım notları.**
- "Sonra" sürümünde betiğin geniş zaman diye yakaladığı iki aday, kural 9'un izin verdiği "-ebilir" yüklemleridir: satır 143 "eşitsizleştirebilir" (özgün "-ebileceğinden" yan cümlesi bölününce cümle sonu oldu) ve satır 590 "sürebilir" (özgün).
- `\caption` için betiğin işaretlediği beş aday ("bileşenler", "grafikler", "sonuçlar") çoğul addır, yanlış eşleşmedir.
- Tablo sütunundaki 2 uzun "cümle" ve 1 geniş zaman (satır 443 "dalgalanır") tablo hücresidir. Görev tanımı gereği hücrelere dokunulmadı (bkz. §5).

**Bütünlük denetimi (betikle, HEAD sürümüne karşı):**
- `$...$` (178), `\SI{}{}` (104), `\num{}` (13), `\label` (40), `\ref` (79), `\eqref` (2) ve `\includegraphics` (26) dizileri **sıralarıyla birlikte** birebir aynı. Bölümde `\cite` yok.
- Metindeki çıplak sayılar 519 → 519. Tek sıra farkı satır 116'da: "PIC32MK" içindeki 32 ile "(5)" numarası yer değiştirdi (numaralı liste yeniden kuruldu, bkz. §2.2). Sayı eklenmedi, çıkarılmadı.
- TikZ kodu (24 satır), tablo satırları (72), komut satırları (287) ve `\umitnot` bloğu (satır 592–595) birebir aynı. `\caption` satırları değişmedi.
- Kalan her `\ref`/`\eqref` hedefinin `\label`'ı `yeni_tez/bolumler` altında var (eksik hedef 0).
- Yasak sözcük taraması: istenen `grep -n -i -w -E 'bu|bunun|...|söz konusu|adı geçen'` 0 satır. "şu", "şöyle", "orada", "onu", "onun", "onları" ve gösterme sıfatı "o" da 0. Satır 590'daki "onları" kaldırıldı.
- "kalibre" yalnız "kalibre edilmiş/edilen/edilmiştir/edilmemiştir" fiil biçimlerinde geçiyor (kural 12). `\caption` ve başlıklarda yok.
- "doğrusal olmayanlık" bölümde yok (kural 14). "eski tez", "önceki tez" metinde yok (kural 10). Görüntü dosya adlarındaki `onceki_tez_sekil_*` öneki derlenen metne girmiyor, dosya adlarına dokunulmadı.

## 2. Yapılan değişiklik türleri

### 2.1 Noktalı virgül (kural 2)
Düz metindeki 51 noktalı virgülün hepsi kaldırıldı. Çoğu iki cümleye bölündü. Bir kısmı "Dolayısıyla", "ise", "-dığından" ya da virgülle yeniden kuruldu.
- **Özneden sonra gelen noktalı virgül** (TDK'ya göre olası, kural 2'ye göre gereksiz): satır 12 "Şekil~...; varyak modülü, ..." → nesne durum ekleriyle ("varyak modülünü, evirici panosunu, bilgisayarı ve osiloskopları"). Satır 58 ve 90 "İki görüntünün ayrı tutulması; ..." / "Giriş bölümünün ayrı verilmesi; ..." → "-dığından" yan cümlesi ve tamlayan ekleri ("boost diyotlarının, fonksiyon değiştirme rölelerinin, ..."). Satır 165 "Şekil~...; HLSR akım sensörleri, ..." → iki cümle. Satır 283 "PC ana kumanda yazılımı; ..." → "PC ana kumanda yazılımının amacı, ... oluşturmaktır". Satır 603 "Deney düzeneği; ..." → iki cümle.
- **Ayraç içi:** satır 526 "($K_{1x}$; S3'te ...)" → "($K_{1x}$, S3'te ise ...)".
- Satır 116'daki dokuz noktalı virgüllü numaralı liste dört cümle oldu (bkz. §2.2).

### 2.2 Uzun cümle (kural 3)
30 kelimeyi aşan 6 cümlenin hepsi bölündü:
- **Satır 116 (70 kelime):** "Fotoğraftaki numaralar sırasıyla aşağıdaki işlevleri gösterir: (1) ...; (2)--(3) ...; ... (11) ..." listesi, numara sırası korunarak dört cümleye bölündü: (1)–(4), (5)–(6), (7)–(9), (10)–(11). Liste öğesi (5) kendi içinde virgül taşıdığı için ("ölçüm, haberleşme ve kontrol algoritmalarını yürüten") ad öbeği önce, numara sonra yazıldı.
- **Satır 127 (46 kelime):** sürücü seçiminin dört gerekçesi bir cümlede, üç işlevi ayrı cümlelerde verildi. Desatürasyon cümlesi "-mektedir" birikmesini önlemek için ad cümlesi oldu ("Desatürasyon korumasının işlevi, ... kesmektir").
- **Satır 205 (33 kelime):** kalibrasyon ölçümünün yeri, oran ve faz hatası, belirsizliğe etkisi üç cümle oldu ("İki hata da ... ihmal edilebilir düzeydedir").
- **Satır 603 (34 kelime):** belgelenen donanım ile analizör, yazılım ve ekran kayıtları iki cümle oldu.
- **Satır 605 (32 ve 33 kelime):** mekanizma cümlesi üç cümleye, benzetim sonucu cümlesi iki cümleye bölündü. Son cümledeki noktalı virgül de nokta oldu.
- Aynı cümlede iki "ve ... ve" dizisi kalan yerler bölündü ya da virgülle kuruldu (satır 4, 528, 605).

### 2.3 Kip birliği (kural 9)
Cümle sonundaki 8 geniş zaman yüklemi ve bölünme sonucu cümle sonu olan yan cümle yüklemleri "-mektedir/-maktadır" ya da "-mıştır/-miştir" kipine çevrildi:
- Satır 116 "gösterir" → "gösterilmiştir / göstermektedir"; satır 127 "sağlar / keser / azaltır" → "sağlamaktadır / kesmektir / azaltmaktadır"; satır 285 "çalışır ... bulunur" → "çalışmakta, ... bulunmaktadır".
- Satır 528 "gelir / verir / doğurur" → "gelmektedir / vermektedir / doğurmaktadır"; satır 553 "taşır" → "taşımaktadır"; satır 588 "iner / yükselir / geçer / izler" → "inmekte / yükselmekte / geçmektedir / izlemektedir"; satır 590 "içerir" → "içermektedir"; satır 599 "oluşturur" → "oluşturmaktadır".
- "-ebilir" yüklemleri aynen kaldı ("ayarlanabilmektedir" özgün biçimiyle kaldı).
- Art arda "-mektedir" birikmesini önlemek için ad cümleleri ve geçmiş zaman kullanıldı:
  - Satır 12: "Varyak modülünde ... bulunmakta" → "Enerji bağlantıları, ... AA enerji analizörü varyak modülündedir".
  - Satır 127: "hata yönetim zinciri oluşmaktadır" → "kurulmuştur".
  - Satır 165: "... içeren ölçüm kartını göstermektedir" → "... iletkenleri kartın üzerindedir".
  - Satır 300: "özetteki \%15 kaydın ortalama düzeyini, ekrandaki \%11,1 ise tek bir anlık okumayı göstermektedir" → "... ortalama düzeyi, ... tek bir anlık okumadır".
  - Satır 530: "köprü çıkış gerilimi ... olmaktadır" → "biçimindedir" (Bölüm 5 satır 55 ile aynı çözüm).
  - Satır 586 (dörtlü zincir): "AA akımı $+$\%3,7, THD $+9{,}7$ puan farkla yeniden üretilmektedir" → "AA akımındaki fark $+$\%3,7, THD'deki fark $+9{,}7$ puandır".
  - Satır 553: belirsizlik değerleri "'dir" ekiyle ad cümlesi oldu.

### 2.4 Gösterme sözcüğü (kural 1)
İstenen listedeki sözcüklerden bölümde yoktu. Satır 590'daki kişi zamiri "onları" ("evirici harmonikleriyle toplanır ya da **onları** kısmen söndürür") → "Faz ilişkisine göre evirici harmonikleri, gerilim bozulmasının etkisiyle büyümekte ya da kısmen sönmektedir". Bağlantılar adın tekrarıyla kuruldu ("Harmonik gerilim, ...", "Harmonik akım, ...", "Gerilim bozulması, ...", "Osiloskop kayıtları ...").

### 2.5 Terim ve yazım birliği (kural 5, 6, 14)
- Satır 329: "kesintili iletim" → "süreksiz iletim" (bölümün geri kalanı ve Bölüm 3–5 ile aynı terim).
- Satır 549: "senkron olmayan buck eşdeğeriyle" → "senkron olmayan alçaltıcı eşdeğeriyle" (Bölüm 4 ve 5 ile aynı).
- Satır 298: "senkron-buck benzeri" → "senkron alçaltıcı benzeri" (bölüm içi birlik).
- Satır 6: "diğer büyüklükler" → "öteki büyüklükler" (Bölüm 5 üslubu). "üretici toleransları ve okuma çözünürlüğünden" → "üretici toleranslarından ve okuma çözünürlüğünden" (ek eksikliği).
- Satır 139: "ölçüm kartının ofset, ADC aralığı" → "ofseti" (iyelik eki). "anlık yaklaşık \SI{387}{\volt}'tur" → "anlık değerde yaklaşık ...".
- Satır 553: "darbe genişliğinden yediği süre" → "eksilttiği süre" (konuşma dili).
- Satır 584: "susturmalı çalışmanın düşük akımdaki dalga biçimi bozulmasının" → "susturmalı çalışmada ..." (art arda iki tamlayan).
- Satır 176: üretici toleransı ad cümlesiyle verildi ("Üreticinin bildirdiği hata toleransı ... yüzde 0,5'tir").

### 2.6 Olumlu yazım (kural 8)

| Satır | Önce | Sonra |
|---|---|---|
| 156 | "Kayıt, koruma mantığının işlevsel örneğidir; gecikme süresi ve gerçek kısa devre kesme enerjisi aynı görüntüden çıkarılamaz." | "Kayıt, koruma mantığını işlevsel olarak örneklemektedir. Gecikme süresi ve gerçek kısa devre kesme enerjisi ise ayrı bir ölçümün konusudur." |
| 526 | "... faz akımı THD'si kalibre edilmemiştir ve bağımsız doğrulama ölçütüdür." | "... faz akımı THD'si bağımsız doğrulama ölçütü olarak kalibrasyonun dışında tutulmuştur." |
| 553 | "S2 ve S3 fazları faz belirsizliğinin içindedir ve fiziksel bir gecikme olarak yorumlanmamıştır." | "S2 ve S3 fazları faz belirsizliğinin içindedir. Dolayısıyla faz kaymaları, fiziksel bir gecikme yerine faz belirsizliği kapsamında değerlendirilmiştir." |
| 584 | "THD kalibre edilmemiştir: kalibrasyon öncesinde ..." | "THD, kalibrasyonda bağımsız ölçüt olarak kalmıştır. Kalibrasyon öncesinde ..." |
| 590 | "Ölçüm noktası şebekenin kendisi olmadığından ..." | "Ölçüm noktası şebekenin kendisinden farklı olduğundan ..." |
| 605 | "... ve kalibre edilmemiş akım THD'sini 0,8 puan içinde ..." | "... ve kalibrasyonun dışında kalan akım THD'sini 0,8 puan içinde ..." |

**Teknik betim olarak kalan olumsuz yapılar** (tezin aleyhine konuşmuyor):
- Satır 526 "Devre, yarı iletken ve filtre parametreleri kalibrasyonda değiştirilmemiştir" (yöntem betimi; kalibrasyonun yalnız iki serbest değişkenle yapıldığını söylüyor).
- Satır 553 "Kalibrasyon S1'de genliği değiştirmemiş (\%0,0003)" (sayısal sonuç).
- Satır 549 "senkron olmayan" (terim).
- Satır 586 ve 588'deki THD farkları (S1'de $+24{,}5$ puan, S2'de $+9{,}7$ puan) ve olası kaynakları sayılarıyla aynen kaldı.

### 2.7 Öteki cümle düzeltmeleri
- Satır 4: "denetim ve ölçüm zinciri testleri yeniden üretecek ayrıntıda" belirsizdi ("ölçüm zinciri testleri" tamlaması gibi okunuyordu). "denetim ve ölçüm zinciri, testlerin yeniden üretilebileceği ayrıntıda tanıtılmaktadır" yazıldı. S4 ve GT-tipi cümlesi iki cümleye bölündü ("GT-tipi şarj yönü ise ... ele alınmıştır").
- Satır 285: "Haberleşme hızı ... 38400 baud seçilmiş" → "Haberleşme hızı olarak ... seçilmiştir" (özne-yüklem uyumu).
- Satır 494, 597: "kullanılmış, ... yapılmıştır" ve "puan; ... puandır" yapıları iki cümle oldu, ikinci cümleye "ise" eklendi.

Sayılar, birimler, simgeler, `\ref` yerleri ve iddia gücü değişmedi. Bölünen cümlelerde göndermeler özgün yerinde kaldı. Kesim sırası ve paragraf sınırları korundu. Paragraf birleştirilmedi ya da taşınmadı. İçerik çıkarılmadı.

## 3. Bölümler arası göndermeler (kural 11): dokunulmadı

Görev tanımı `\ref` ve etiket kümesinin değişmemesini istediği için hiçbir gönderme kaldırılmadı. Kural 11 açısından sonraki tur için adaylar:

| Satır | Göndermeler | Not |
|---:|---|---|
| 4 | `chap:anahtarlama`, `chap:sin3`, `chap:gttipi` | Paragrafta üç bölümler arası gönderme var. Açılış paragrafı olduğu için yöntemlerin incelendiği bölümleri adlandırması doğal. Sıkı uygulamada `chap:gttipi` (satır 605'te de var) çıkarılabilir. |
| 294 | `eq:verim-tanimi`, `eq:thd-rmse-tanimlari` | İki `\eqref`. Verim ve THD tanımı olduğu için kalmaları uygun. |
| 522 | `sec:model-dogrulama-duzeltme`, `tab:sistem-parametreleri` | İki gönderme. İkisi de okurun kaynağı bulması için gerekli (taban model ve kalibre edilmiş değerler). |
| 605 | `chap:deney`, `chap:gttipi` | `chap:deney` bölümün **kendi** etiketidir: "kanıt zinciri Bölüm~\ref{chap:deney} ile tamamlanmaktadır" cümlesi Bölüm 6'nın içinde Bölüm 6'yı adlandırıyor. Gösterme sözcüğü yasağı yüzünden "bu bölümle" yazılamıyor. "Faz kolu ölçeğindeki iki katkının kanıt zinciri deneysel doğrulamayla tamamlanmaktadır" biçimi önerilir, ancak `\ref` kümesi değişeceği için uygulanmadı. |
| 10, 125, 139, 145, 147 | `tab:sistem-parametreleri` | Her paragrafta bir gönderme. Değerler o tabloda olduğu için kalmalı. |
| 285, 413 | `sec:s4-kapali-cevrim` | Paragraf başına bir. |
| 338, 358, 549, 586, 588 | `chap:anahtarlama`, `chap:sin3`, `sec:dusuk-akim-modelleme`, `fig:s1-s2-kalibre-dalga` | Paragraf başına bir. |
| 466–469 (tablo) | `tab:kalibrasyon-karsilastirma` (bölüm içi), `tab:s4-tarama`, `tab:s4-basamak` | Tablo hücresi, dokunulmadı. |

"Bölüm X'te ayrıntılı verilecektir" türü ileriye dönük duyuru bölümde yok. Satır 4 ve 387'deki `sec:kalibrasyon` göndermeleri bölüm içidir.

## 4. `\umitnot` bloğu

Satır 592–595'teki iç not ("Jüri sorusuna hazırlık: S1 THD") sayımlara girmedi ve değiştirilmedi. Notta "eski tez" ya da önceki sürüm göndermesi yok. Notta 2 noktalı virgül, bir "değil mi?" sorusu ve "Tezde PF tartışılmıyor" yapısı var. İç not yalnız `tez_notlu.pdf`'te göründüğü için bırakıldı.

## 5. Bilerek dokunulmayanlar

- **Tablo hücreleri (görev tanımı):** 7 noktalı virgül (satır 269, 273, 274, 427, 443, 447, 451) ve satır 443'teki geniş zaman "dalgalanır" kaldı. Kural 9'a göre hücre metni de "-mektedir" almalı ("dalgalanmaktadır"). Ayrıca satır 268 ve 466'daki hücreler 30 kelimeyi aşıyor. Satır 269, 273 ve 274'teki noktalı virgüller iki ayrı değeri ayıran değer listesidir. Satır 427, 443, 447 ve 451'dekiler iki cümlecik bağlıyor ve noktaya çevrilebilir.
- **`\caption` (görev tanımı, yalın başlık kuralı):** dil hatası bulunmadığı için hiçbir başlık değişmedi. Satır 557'deki başlık "İlk iki satır kalibrasyon hedefidir, öteki satırlar bağımsız karşılaştırmadır. Fark: \% göreli, ``p'' yüzde puan." açıklama ve gösterge niteliğinde iki cümle taşıyor. Proje kuralına göre başlıktan çıkarılması gerekebilir. Birinci cümle satır 582'de metinde zaten var. Görev başlığa açıklama eklemeyi ya da çıkarmayı kapsamadığı için bırakıldı.
- **Fazlalık:** satır 4 ile 10 ve 413 (deney akımı yaklaşık \SI{2.3}{\ampere}, düşük güç noktası), satır 387 ile 582 (kalibrasyon hedefi), satır 300 ile 411 (anlık okuma ve ortalama) aynı bilgiyi tekrarlıyor. Görev tanımı gereği hiçbiri silinmedi, sonraki fazlalık incelemesine bırakıldı.
- **Karışık terimler:** metinde ve tablolarda "kondansatör" ile "kapasitör" birlikte geçiyor (satır 58 "snubber kapasitörleri", 143 "DA bara kondansatörünün", 528 "filtre kapasitörüdür"; tablolarda "Snubber kapasitörleri" ve "Snubber kondansatörleri"). Tablo hücreleri değişmeyeceği için birleştirme yapılmadı. Tez genelinde bir terim seçilirse tek geçişte düzeltilmeli. "boost", "snubber", "inrush", "buffer" alıntı terimleri tablo hücreleriyle uyumlu kalsın diye metinde de bırakıldı.
- **Yazım:** "Thevenin" (TDK/özgün ad "Thévenin"), satır 205 "Class~0.1" (sınıf adı, ondalık nokta standarttaki gibi), satır 201 başlığındaki "\SI{20}{\ampere}--\SI{60}{\milli\volt}" ile metindeki "/" ayrımı. Satır 141 ("12 bit ADC gösterimi") ve 499'daki sayıyla başlayan cümleler özgün metinden kaldı.

## 6. Anlamı belirsiz olup tahmin edilmeyen ya da kontrol edilmesi gereken noktalar

1. **Satır 528, "İşaret kuralı üreticidir":** Cümlenin devamı (evirici→şebeke yönü pozitif, $Q_{g,1}>0$ eviricinin reaktif güç verdiği durum) **üretici (generator) işaret kuralını** tarif ediyor. Metin "Üretici işaret kuralı kullanılmıştır" diye yazıldı. Kastedilen "analizör üreticisinin (Entes) işaret kuralı" ise "Analizör üreticisinin işaret kuralı kullanılmıştır" yazılmalı. Tez sahibinin denetlemesi gerekiyor.
2. **Satır 526, THD'nin rolü:** Aynı paragrafta THD hem "bağımsız doğrulama ölçütü / kalibrasyonun dışında" hem de "THD hedefi olarak deney özetinin \%15, \%47 ve \%14 değerleri alınmış, ... ikincil ölçüt olarak değerlendirilmiştir" diye geçiyor. Satır 584 de "THD kalibre edilmemiştir" diyordu. İki ifade "THD serbest değişkenlerin ayarında kullanılmadı, yalnız sonuç karşılaştırmasında ikincil ölçüttü" anlamında okunabilir. Ancak "THD hedefi" sözü jüriye kalibrasyonda kullanılmış gibi görünebilir. Metin anlamı değiştirmemek için yalnız bölündü, ifade korundu.
3. **Satır 605, kendine gönderme:** `\ref{chap:deney}` Bölüm 6'nın kendi etiketi (bkz. §3).
4. **Satır 156:** "aynı görüntüden çıkarılamaz" olumlu yazım kuralıyla "ayrı bir ölçümün konusudur" oldu. Anlam aynı, ancak "ayrı bir ölçüm yapılmıştır" diye okunmamalı. Cümle ölçümün yapıldığını söylemiyor.
5. **Satır 127:** "hata yönetim zinciri oluşmaktadır" → "kurulmuştur". Tasarımla kurulan bir zincir olduğu için anlam aynı. Yalnız "-mektedir" birikmesini kırmak için değişti.
6. **Satır 605:** "kayıtlar, ... mekanizmasını desteklemektedir" → "kayıtların desteklediği mekanizmada nötr susturma ... büyütmektedir". Mekanizmanın iki önermesi (susturma verimi artırıp THD'yi büyütüyor, Sin³ bozulmayı azaltıyor) aynı bölümde deney sayılarıyla doğrudan gösterildiği için iddia gücü değişmiyor. Daha temkinli biçim isteniyorsa özgün yapıya dönülebilir.
7. **Satır 116:** Numaralı liste yeniden kuruldu. Numaralar fotoğraftaki etiketlerle aynı sırada. Okuma kolaylığı için ileride liste bir tabloya (Tablo `tab:deney-alt-birimler` gibi) taşınabilir. Bu bir yapı kararı olduğu için uygulanmadı.

## 7. Kalan noktalı virgüller

- **Düz metin:** 0.
- **`\caption`:** 0 (önce de 0).
- **Tablo hücreleri:** 7 (bkz. §5). Görev tanımı gereği kaldı.
- **`\umitnot`:** 2. İç nota ait, dokunulmadı ve sayımlara girmedi.
