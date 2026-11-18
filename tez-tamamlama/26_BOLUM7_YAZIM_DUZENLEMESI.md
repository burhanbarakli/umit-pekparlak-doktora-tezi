# Bölüm 7 (GT-Tipi Yeniden Yapılandırılabilir Enerji Depolama Mimarisi) yazım düzenlemesi

- **Dosya:** `yeni_tez/bolumler/07-gt-tipi-mimari.tex`. Satır sayısı değişmedi (419). Başka dosyaya dokunulmadı.
- **Görev kipi:** uygula (`.claude/agents/tez-yazim-editoru.md`, kural 1–14).
- **Tarih:** 18.11.2026
- **Örnek alınan üslup:** Bölüm 5 ve 6'nın düzenlenmiş hâli, rapor 16 ve 22.
- Derleme ve commit yapılmadı. 30 satır değişti, hepsi düz metin paragraf satırı. `\caption` satırlarına, tablo satırlarına, TikZ koduna ve denklem bloklarına dokunulmadı. Satır 70'teki `\kirmizinot` (RL2) bloğu birebir aynı. Bölümde `%` yorum satırı ve `\umitnot` bloğu yok.
- Görev tanımı gereği paragraf sırası, kesim yapısı (7.3/7.6 sırası dahil), `\ref`/`\label` kümesi ve tablo hücreleri korundu. Rapor 22'deki gibi bölümler arası gönderme **kaldırılmadı** (bkz. §3).

## 1. Önce/sonra sayımları

Sayım betiği rapor 16 ve 22'deki yöntemi izliyor. TikZ ve denklem blokları, `\kirmizinot` bloğu ve yalnız komut içeren satırlar dışarıda kaldı. Cümleler `. ? !` işaretinden bölündü. `\ref`, `\cite`, `$...$`, `\SI`, `\num` birer sözcük sayıldı. Düz metin, `\caption` ve tablo hücreleri ayrı sayıldı. "Önce" sütunu HEAD (f6c0af3) sürümüdür. Dosya düzenleme öncesinde HEAD ile aynıydı.

| Ölçüt | Önce (HEAD) | Sonra |
|---|---:|---:|
| Cümle sayısı: düz metin / `\caption` / tablo hücresi | 122 / 24 / 122 | 158 / 24 / 122 |
| Ortalama cümle uzunluğu: düz metin / `\caption` | 16,2 / 7,5 kelime | 12,7 / 7,5 kelime |
| 30 kelimeyi aşan cümle: düz metin / `\caption` / tablo | 9 / 0 / 0 | **0 / 0 / 0** |
| En uzun cümle: düz metin / `\caption` | 52 kelime (satır 199) / 15 kelime (satır 93) | 29 kelime (satır 6) / 15 kelime |
| Noktalı virgül: düz metin / `\caption` / tablo | 20 / 0 / 6 | **0 / 0** / 6 |
| Geniş zamanla biten cümle: düz metin / `\caption` / tablo | 11 / 0 / 8 | **0 / 0** / 8 |
| Yasak gösterme sözcüğü (istenen grep) | 0 | **0** |
| "değil" geçen yapı: düz metin / tablo | 3 / 1 | **0** / 1 |
| Art arda üçten fazla "-mektedir" ile biten paragraf | 0 | **0** |
| Bölümler arası gönderme, `\ref`+`\eqref` | 17 | 17 |
| `\label` / `\ref` / `\eqref` / `\cite*` komutu | 35 / 55 / 4 / 7 | 35 / 55 / 4 / 7 |
| Toplam kelime (metin + başlık + tablo, betik sayımı) | 2840 | 2873 |

**Sayım notları.**
- Düz metindeki 11 geniş zaman adayı: satır 135 "belirler", "verir"; 140 "açıklanamaz", "gerekir"; 173 "atanır"; 186 "açar"; 199 "gösterir"; 261 "kanıtlamaz"; 295 "gösterir"; 317 "gösterir"; 378 "uygulanır". Noktalı virgülden önce kalan yan cümle yüklemleri de (ör. satır 13 "değişir", satır 135 "gerekmez") bölünmeyle cümle sonu oldu ve çevrildi.
- Tablo sütunundaki 8 geniş zaman (satır 151–157, 368, 370) ve 6 noktalı virgül tablo hücresidir. Betiğin ayrıca işaretlediği "ölçümler", "sınır", "dönüştürücüler", "denklemler" ad olduğu için yanlış eşleşmedir. Görev tanımı gereği hücrelere dokunulmadı (bkz. §5).
- "Sonra" sürümünde kalan "-ebilir" yüklemleri kural 9 gereği aynen kaldı: "sınırlandırılabilir" (13), "tanımlanabilir" (173, 411), "sürüklenebilir" (181), "oluşturabilir" (186), "gerektirebilir", "sağlayabilir" (354).

**Bütünlük denetimi (betikle, HEAD sürümüne karşı):**
- `$...$` (70), `\SI{}{}` (8), `\num{}` (4), `\label` (35), `\ref` (55), `\eqref` (4), `\cite*` (7 komut; anahtarlar dahil), `\includegraphics` (14) ve `\caption` (23 satır) dizileri **sıralarıyla birlikte** birebir aynı.
- Metindeki çıplak sayılar 38 → 38, dizi sırası da aynı. Sayı eklenmedi, çıkarılmadı. Simge tanım cümleleri bölünürken `$...$` sırası korundu (satır 173, 199, 411).
- TikZ kodu (2 blok), denklem blokları (4), tablolar (5 `tabularx`), komut satırları (156) ve `\kirmizinot` bloğu birebir aynı.
- Kalan her `\ref`/`\eqref` hedefinin `\label`'ı `yeni_tez/bolumler` altında var (eksik hedef 0).
- Yasak sözcük taraması: istenen `grep -n -i -w -E 'bu|bunun|...|söz konusu|adı geçen'` 0 satır. "şöyle", "orada", "onu", "onun", "onları" ve gösterme sıfatı "o" da 0.
- "kalibre" yalnız iki tablo hücresinde "kalibre edilmiş" fiil biçiminde geçiyor (satır 251, 395; kural 12). `\caption` ve başlıklarda yok.
- "doğrusal olmayanlık" bölümde yok (kural 14). "eski tez", "önceki tez" metinde yok (kural 10). Görüntü dosya adlarındaki `onceki_tez_6_*` öneki derlenen metne girmiyor, dosya adlarına dokunulmadı.
- Kapanış kesimi "Değerlendirme" başlığını taşıyor (kural 13).

## 2. Yapılan değişiklik türleri

### 2.1 Noktalı virgül (kural 2)
Düz metindeki 20 noktalı virgülün hepsi kaldırıldı. Çoğu iki cümleye bölündü. Bir kısmı "ise", "Dolayısıyla", "Ancak" ya da virgülle yeniden kuruldu.
- **Özneden sonra gelen noktalı virgül:** satır 6 "Mimari; T-tipi faz kollarını, ..." → "Mimari, tek bir donanımda T-tipi faz kollarını, ... birleştirmektedir". Satır 42 "Vienna doğrultucu; üç faz giriş endüktansları, ..." → ayrılma durum ekleriyle ("üç fazın giriş endüktanslarından, altı doğrultma diyodundan, ..."). Satır 266 "işlevsel bütünlüğü; Vienna PFC, ..." → iki cümle ("... bir Simulink benzetimiyle gösterilmiştir. Benzetim, Vienna PFC'yi, ... çalıştırmaktadır."). Satır 417 "Çalışma modları; güvenli kapalı, ..." → noktalama kaldırıldı.
- **Standart sıralaması (satır 17):** üç IEC standardını ayıran iki noktalı virgül, her standart için ayrı cümle oldu. Standart numaraları ve atıf sırası değişmedi.
- **Bedel sıralaması (satır 376):** "çok sayıda yalıtılmış kanal, sürücü ve algılayıcı; RL1 rölesi ...; kip geçiş sırası ..." iki cümle oldu ("Mimarinin başlıca bedelleri ise ... algılayıcıdır. RL1 rölesinin ve doğrultucu/boost diyotlarının kayıpları, ... de öteki bedellerdir.").

### 2.2 Uzun cümle (kural 3)
30 kelimeyi aşan 9 cümlenin hepsi bölündü:
- **Satır 199 (52 kelime):** geçiş izni simge listesi üç cümle oldu: geçiş izni ve akım büyüklükleri, DA bara gerilimleri ("... gerilimleri, $\Delta V_{\mathrm{tr}}$ izin verilen gerilim farkıdır"), kapı ve röle geri bildirim işaretleri.
- **Satır 17 (44 ve 38 kelime):** beş işlevsel ilke, "-malı/-meli" gereklilik kipiyle üç kısa cümleye bölündü ("Enerji yolu çift yönlü olabilmeli, şarj sırasında şebeke akım kalitesi gözetilmelidir." ...). İlke sayısı ve sırası aynı. Standart cümlesi üç cümle oldu.
- **Satır 4 (43 ve 32 kelime):** ilk iki katkının konuları ad cümlesi oldu ("İncelenen konular ... deney düzeneğidir"). Üçüncü katkı ayrı cümle oldu ("Tezin üçüncü katkısı, ... yeniden görevlendirilmesidir"). Düzenek tanımı, kip değişimini sağlayan elemanlar ve transformatörler üç cümle oldu.
- **Satır 173 (42 kelime):** CC–CV simge listesi üç cümle oldu.
- **Satır 22 (37 kelime):** üç işlev ayrı cümlede verildi. Faz kolu aynı anda tek işlevde çalıştığı için "ve" yerine "ya da" yazıldı ("evirici, ... yarım köprü ya da ... Vienna PFC olarak çalışmaktadır").
- **Satır 181 (32 kelime) ve 411 (31 kelime):** simge listesinden sonraki ek bilgi ayrı cümle oldu.
- Sınırın altında kalan ama iç içe tamlama zinciri taşıyan cümleler de bölündü: satır 69 ("RL1 ve RL2'nin evirici konumunda ... oluşturduğu deşarj yolunu"), 79 ("üç fazın ... yarım köprülerinin üç ... transformatörünün primerlerini beslediği bağlantıyı"), 97, 317, 354, 415.
- Aynı cümlede iki "ve" dizisi kalan yer düzeltildi: satır 238 "röle ve kontaktör açma süresi ve DA bara boşalma süresi" → "... açma süresi ile DA bara boşalma süresi".

### 2.3 Kip birliği (kural 9)
- Cümle sonundaki geniş zaman yüklemleri çevrildi: satır 13 "değişir / hedefler" → "değişmektedir / hedeflemektedir"; 135 "belirler / gerekmez" → "belirlemektedir / gerekmemektedir"; 140 "gerekir" → "tanımlanmalıdır"; 173 "atanır" → "atanmaktadır"; 186 "yol açar" → "yol açmaktadır"; 199, 295, 317 "gösterir" → "göstermektedir"; 261 "gerektirir" → "gerektirmektedir"; 354 "doğurur" → "doğurmaktadır".
- Art arda "-mektedir" birikmesini önlemek için ad cümlesi kullanıldı:
  - Satır 135: "Deşarj yönünde T-tipi evirici, ... şebekeye güç verir" → "Deşarj yönünde şebekeye güç veren kat, ... akım denetimiyle çalışan T-tipi eviricidir" (dörtlü zincir kırıldı).
  - Satır 173, 199, 411: simge listelerinin ikinci ve üçüncü cümleleri "-dır/-dir" ile bitti ("... sıcaklık sınırlarıdır", "... gerilim farkıdır", "... şebekeye verilen enerjidir").
  - Satır 4: "transformatörlerini oluşturmaktadır" → "transformatörleridir".
  - Satır 17: IEC~62477-1 cümlesi "... odağı, ... tehlikeleridir" biçiminde ad cümlesi oldu.
  - Satır 378: "Ölçütler, ... aynı güç ve gerilim tabanında uygulanır" → "Ölçütlerin uygulama tabanı, ... aynı güç (...) ve gerilimdir". "uygulanmaktadır" karşılaştırmanın yapılmış olduğu izlenimi vereceği için ad cümlesi seçildi (bkz. §6).
- "tanımlanabilir", "sınırlandırılabilir", "sürüklenebilir" gibi "-ebilir" yüklemleri ve "-malıdır/-melidir" gereklilikleri aynen kaldı.

### 2.4 Gösterme sözcüğü (kural 1)
İstenen listedeki sözcüklerden bölümde yoktu. Yeni cümlelerde bağ adın tekrarıyla kuruldu ("Deşarj yolunda ...", "Bağlantıda ...", "Benzetim, ...", "Şarj yönü benzetimi, ...", "Sekonder gerilimi ...", "Düzenek, ...", "Mimari, ...").

### 2.5 Terim ve yazım (kural 5, 6)
- Satır 135: "PWM'ninden" → "PWM'den" (iyelik ve ayrılma eki üst üste binmişti. Bölümdeki "PWM'nin" okunuşuyla uyumlu ek).
- Satır 411: "dahil" → "dâhil" (TDK, kural 6). Tezin öteki dosyalarında üç "dahil" daha var (bkz. §5).
- Satır 51: "Şekil~..., ... her bataryaya ayrı doğrultucu--buck kolu sağlamaktadır" → "Şekil~... üzerindeki aktif BYS devresi, ... sağlamaktadır" (şekil değil devre sağlıyor). "diyot doğrultma ... bulunmaktadır" → "diyotlu doğrultucu ... bulunmaktadır" (bir işlem değil eleman sayılıyor).
- Satır 13: "arıza yalıtımı, gerilim uyarlama ve kapasite kullanımını iyileştirmeyi hedefler" → "arıza yalıtımını, gerilim uyarlamayı ve kapasite kullanımının iyileştirilmesini hedeflemektedir" (nesne ekleri eşitlendi). "iletim kaybı, sürücü sayısı, ... oluşturduğundan" → "iletim kaybını, sürücü sayısını, koruma gereksinimini ve denetim karmaşıklığını artırmaktadır" ("sürücü sayısı oluşturmak" anlamsızdı).
- Satır 317: "gerilim ve akımını" → "gerilimini ve akımını". Satır 295: "eşdeğer endüktans ve manyetik devre dinamiğinin" → "eşdeğer endüktansın ve manyetik devre dinamiğinin".
- Satır 97: "dengeleme hedefi ... sağlanmaktadır" → "karşılanmaktadır".
- Satır 4: "alt bölümdeki transformatörler" → "Şeklin alt kısmındaki transformatörler" ("Alt Bölüm" kesim adıyla karışıyordu; bkz. §6).
- Satır 8: "Bölüm boyunca" üst-anlatı kalıbı → "metin boyunca".

### 2.6 Olumlu yazım (kural 8)

| Satır | Önce | Sonra |
|---|---|---|
| 6 | "... kullanılan bir adlandırmadır; literatürde standartlaşmış bağımsız bir çok seviyeli dönüştürücü ailesi değildir." | "... kullanılan, teze özgü bir adlandırmadır." |
| 13 | "... batarya dizisi sabit ve ideal bir DA kaynak değildir." | "... batarya dizisi, sabit ve ideal bir DA kaynaktan farklı davranmaktadır." |
| 13 | "... tasarım değerlendirmesi yalnız işlev sayısına değil, kayıp ve güvenlik bedeline de dayanmalıdır." | "Dolayısıyla tasarım değerlendirmesi, işlev sayısıyla birlikte kayıp ve güvenlik bedeline de dayanmalıdır." |
| 22 | "... ile verildiğinden yeniden basılmamıştır." | "... ile verilmiştir." |
| 140 | "GT-tipi yapının çalışması tek bir ``çift yönlü'' komutla açıklanamaz." | "GT-tipi yapının çalışması, tek bir ``çift yönlü'' komuttan daha ayrıntılı bir durum tanımı gerektirmektedir." |
| 261 | "IEC standartları tek başına belirli bir devrenin güvenli olduğunu kanıtlamaz." | "IEC standartları, belirli bir devrenin güvenliğini göstermek için gereken kanıtın çerçevesini belirlemektedir." |

**Teknik betim olarak kalan olumsuz yapılar** (tezin aleyhine konuşmuyor):
- Satır 135 "Bütün katların aynı anda hızlı anahtarlanması gerekmemektedir" (tasarım kuralı; özgün "gerekmez" kural 9'a göre çevrildi).
- Satır 35 tablo hücresi "Kararlı çalışmada iletimde değil" (hücre, dokunulmadı).
- Satır 411 "dâhil edilip edilmediği" (soru yapısı, olumsuzluk değil).

### 2.7 Öteki cümle düzeltmeleri
- Satır 8: "alınmış ve özgün çözünürlükleriyle verilmiştir" → "alınmış, özgün çözünürlükleriyle verilmiştir".
- Satır 186: noktalı virgülle bağlı iki risk ayrı cümle oldu ("Farklı gerilimdeki düğümlerin birleştirilmesi ise ...").
- Satır 238: "çalışmalı; üst seviye durum makinesi ..." → "çalışmalıdır. Üst seviye durum makinesi ise ...".
- Satır 419: "GT-tipi mimari, ... bir enerji depolama mimarisi sunmaktadır" (özne ile yüklemde aynı ad) → "GT-tipi enerji depolama mimarisi, ... ortak kullanmaktadır. Mimari, tanımlı çalışma kipleri ve güvenli geçiş kurallarıyla donatılmıştır."
- Satır 415: tanım cümlesi ikiye bölündü ("... yeniden görevlendirilmesi olarak tanımlanmıştır. Düzenek, RL1 rölesi ve doğrultucu/boost diyotlarıyla ... işlevlerini üstlenmektedir.").

Sayılar, birimler, simgeler, `\ref` ve `\cite` yerleri ve iddia gücü değişmedi. Bölünen cümlelerde göndermeler ve atıflar özgün cümle bağlamında kaldı. Satır 13'teki ilk atıf, bölünen iki önermenin ikincisinin sonunda, özgün konumunda duruyor. Kesim sırası ve paragraf sınırları korundu. Paragraf birleştirilmedi ya da taşınmadı. İçerik çıkarılmadı.

## 3. Bölümler arası göndermeler (kural 11): dokunulmadı

Görev tanımı `\ref` ve etiket kümesinin değişmemesini istediği için hiçbir gönderme kaldırılmadı. Kural 11 açısından sonraki tur için adaylar:

| Satır | Göndermeler | Not |
|---:|---|---|
| 4 | `chap:anahtarlama`, `chap:deney`, `fig:gelen-tam-topoloji`, ayrıca `chap:gttipi` | Paragrafta üç bölümler arası gönderme var. `chap:gttipi` bölümün **kendi** etiketidir: "Bölüm~\ref{chap:gttipi} sistem ölçeğine geçmektedir" cümlesi Bölüm 7'nin içinde Bölüm 7'yi adlandırıyor (rapor 22, satır 605 ile aynı durum). Gösterme yasağı yüzünden "bu bölüm" yazılamıyor. "Tezin üçüncü katkısı sistem ölçeğindedir" biçimi önerilir, ancak `\ref` kümesi değişeceği için uygulanmadı. |
| 8 | `chap:deney` | Kanıt ayrımı için gerekli. |
| 15 | `chap:sistem`, `tab:sistem-parametreleri` | Güç tabanı ve parametre tablosu. İkisi de okurun kaynağı bulması için gerekli. |
| 22 | `chap:sistem`, `fig:t-tipi-uc-seviye`, `fig:t-tipi-akim-yollari` | Üç gönderme. Şekiller yeniden basılmadığı için gerekli. `chap:sistem` çıkarılabilir (şekil numarası bölümü zaten gösteriyor). |
| 135 | `chap:sin3` | Paragraf başına bir. |
| 266 | `chap:anahtarlama`, `chap:deney` | Tek aralık göndermesi. |
| 383 | `chap:deney`, `chap:anahtarlama`, `chap:sin3` | Kanıt özetinde iki gönderme cümlesi. Doğrulama durumu kesimi olduğu için kalmaları doğal. |
| 395, 396 (tablo) | `chap:deney`, `chap:sin3` | Tablo hücresi, dokunulmadı. |

"Bölüm X'te ayrıntılı verilecektir" türü bölümler arası ileriye dönük duyuru yok. Satır 348'deki `sec:gt-dogrulama` duyurusu bölüm içidir.

## 4. `\kirmizinot` bloğu

Satır 70'teki RL2 notu sayımlara girmedi ve değiştirilmedi. Notun konusu olan satır 69'da RL2 adı korundu. Cümle yalnız ikiye bölündü ("RL1 ve RL2 evirici konumundayken oluşan deşarj yolunu göstermektedir"). Notta bir noktalı virgül var. Not iç işaret olduğu için bırakıldı.

## 5. Bilerek dokunulmayanlar

- **Tablo hücreleri (görev tanımı):** 6 noktalı virgül (satır 151, 156, 157, 368, 370, 371) ve cümle sonunda 8 geniş zaman ("denetlenir" 151, "edilir" 152, "korunur" 153, "uygulanır" 154 ve 155, "başlatılmaz" 157, "durdurulur" 368, "eklenir" 370) kaldı. Hücre içindeki "değiştirilir" (157) ve "kullanılır" (370) da geniş zamandır. Kural 9'a göre hücre metni de "-mektedir" almalı. Satır 35 "iletimde değil" de hücrededir.
- **`\caption` (görev tanımı, yalın başlık kuralı):** dil hatası bulunmadığı için hiçbir başlık değişmedi. Satır 93'teki başlığın ikinci cümlesi ("Her fazda $Q_4$ DA bara orta noktası (NÖTR) tarafındaki, $Q_3$ faz düğümü tarafındaki nötr IGBT'dir.") açıklama niteliğinde. Proje kuralına göre gövdeye taşınması gerekebilir. Görev başlığa açıklama eklemeyi ya da çıkarmayı kapsamadığı için bırakıldı.
- **Fazlalık:** satır 4 ile 15 ve 378 (\SI{20}{\kilo\volt\ampere}, \num{20}--\SI{25}{\kilo\watt} üç kez), satır 8 ile 383 ve 415 (kanıt ayrımı), satır 97 ile 51 (batarya başına düzenleme), satır 348 ile 383 (doğrulama matrisi duyurusu) aynı bilgiyi tekrarlıyor. Görev tanımı gereği hiçbiri silinmedi, sonraki fazlalık incelemesine bırakıldı.
- **Karışık terimler:**
  - "kip" ile "mod" birlikte geçiyor: metinde "evirici kipi", "kip geçişi", kesim başlıklarında ve tabloda "Çalışma Modları", "Mod Geçişleri", "Mod". Başlık ve tablo değişmeyeceği için birleştirme yapılmadı.
  - "buck" (21 geçiş; metin, TikZ ve tablo). Bölüm 4–6'da "senkron buck" karşılığı olarak "alçaltıcı" yazıldı. Burada terim TikZ ve tablo hücrelerinde de geçtiği için metinde bırakıldı. Tez genelinde karar verilirse tek geçişte düzeltilmeli.
  - "doğrultucu/boost diyotları" (3) ile "PFC yükseltici diyotları" (2) aynı elemanları anıyor olabilir (bkz. §6).
  - Metinde "transformatör", TikZ ve tabloda "trafo/trafoları/trafosu" (4).
- **"dahil" yazımı:** Bölüm 7'de "dâhil" yapıldı. `04-dusuk-guc-anahtarlama.tex:139`, `05-sin3-kompanzasyon.tex:351` (tablo) ve `08-sonuc.tex:113`'te "dahil" kalıyor. Tez genelinde tek biçim seçilmeli.
- **Kesim başlığı:** "Doğrulama Durumu ve Mevcut Kanıt Düzeyi" (satır 380) ve tablo satırı "Kanıt düzeyi" (satır 371) kural 8'in "kanıt düzeyi tartışması" uyarısına yakın. Kesim yapısı korunacağı için başlık değişmedi.
- **Üst-anlatı:** satır 8 "özgün çözünürlükleriyle verilmiştir", satır 266 "çalışma modları ile geçiş kısıtları tanımlandıktan sonra verilmiştir", satır 383 "bölümün çıktısını", satır 417 "Bütün parametreler ilk geçtikleri yerde açıklanmıştır" metnin kendisini anlatıyor. İçerik silinmeyeceği için kaldı, fazlalık turunda değerlendirilebilir.

## 6. Anlamı belirsiz olup tahmin edilmeyen ya da kontrol edilmesi gereken noktalar

1. **Satır 419, iddia gücü:** "Evirici kipindeki deneyler ve şarj zinciri benzetim kayıtları, aynı donanımın iki enerji yönünde de işlevini yerine getirdiğini göstermiştir." Şarj yönü yalnız benzetimle, evirici kipi düşük güç deneyiyle gösterildiği için cümle jüriye donanım düzeyinde iki yönlü doğrulama gibi okunabilir. Kural 4 gereği iddia değiştirilmedi. Önerilen biçim: "Evirici kipindeki deneyler ve şarj zinciri benzetim kayıtları, iki enerji yönünün işlevini ortak yarı iletken tabanında göstermiştir."
2. **Satır 4, "alt bölümdeki transformatörler":** Şekil `fig:gelen-tam-topoloji`'nin alt kısmı olarak okundu ve "Şeklin alt kısmındaki" yazıldı. Kastedilen başka bir alt devre ya da kesimse düzeltilmeli.
3. **Satır 6, "GT-tipi" adı:** "literatürde standartlaşmış bağımsız bir çok seviyeli dönüştürücü ailesi değildir" kısmı olumlu yazım kuralıyla "teze özgü bir adlandırmadır" oldu. Bilgi aynı, ancak jüri için açık ayrım istenirse "Ad, literatürde standartlaşmış çok seviyeli dönüştürücü ailelerinden ayrı olarak tezde önerilen mimariyi belirtmektedir." eklenebilir.
4. **Satır 186, "yol açar":** Özgün metin kesin geniş zamanla "sınırlanmamış dengeleme akımına yol açar" diyordu ve "yol açmaktadır" yapıldı. Aynı cümledeki ark riski "oluşturabilir" kipinde. Olası bir tehlike anlatıldığı için "yol açabilir" daha doğru olabilir. Ancak kip değişikliği iddiayı zayıflatacağı için uygulanmadı.
5. **Satır 378, karşılaştırma ölçütleri:** Ölçütler tanımlanmış, ancak sayısal karşılaştırma bölümde yapılmamış. "uygulanır" yüklemi "uygulanmaktadır" yapılsaydı karşılaştırma yapılmış gibi okunacaktı. Bu yüzden "Ölçütlerin uygulama tabanı ... gerilimdir" yazıldı. Ölçütler gelecek çalışma olarak düşünülüyorsa cümle Bölüm 8'in "Gelecek Çalışmalar" kesimine bağlanabilir.
6. **Satır 22 ve 88, diyot adları:** Satır 22 ve 376 "doğrultucu/boost diyotları", satır 88 ve Tablo `tab:gt-eleman-gorevleri` "PFC yükseltici diyotları ($D_1$--$D_2$)" diyor. İkisinin aynı eleman olup olmadığı metinden kesin çıkmıyor. Aynıysa tek terim seçilmeli.
7. **Satır 69, RL2:** `\kirmizinot` gereği RL2'nin görevi tanımsız. Cümle yalnız sadeleştirildi, RL2 hakkında bilgi eklenmedi ya da çıkarılmadı.
8. **Satır 135, "gerekmemektedir":** Özgün "gerekmez" çevrildi. Olumlu biçim ("Hızlı anahtarlama yalnız etkin kipteki katlarda gerekmektedir") teknik bir yorum ekleyeceği için seçilmedi.
