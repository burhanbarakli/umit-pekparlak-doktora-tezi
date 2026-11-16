# Bölüm 4 (Düşük Güç Analizi ve Yeni Anahtarlama Yöntemi) yazım düzenlemesi

- **Dosya:** `yeni_tez/bolumler/04-dusuk-guc-anahtarlama.tex`. Satır sayısı değişmedi (211). Başka dosyaya dokunulmadı.
- **Görev kipi:** uygula (`.claude/agents/tez-yazim-editoru.md`, kural 1–11).
- **Tarih:** 17.11.2026
- **Örnek alınan üslup:** Bölüm 3'ün sonuçlanmış hâli ve rapor 11.
- Derleme ve commit yapılmadı. 44 satır değişti: 33 düz metin paragraf satırı, 8 `\caption` (2 alt şekil başlığı dahil), 3 tablo satırı.

## 1. Önce/sonra sayımları

Sayım betiği rapor 11'deki yöntemi izliyor. TikZ ve denklem blokları, `%` yorumları, `\umitnot` bloğu ve yalnız komut içeren satırlar dışarıda kaldı. Cümleler `. ? !` işaretinden bölündü. `\ref`, `\cite` ve `$...$` birer sözcük sayıldı. Tablo hücreleri ayrı sayıldı.

| Ölçüt | Önce (HEAD) | Sonra |
|---|---:|---:|
| Cümle sayısı: düz metin / `\caption` / tablo hücresi | 159 / 17 / 20 | 211 / 24 / 21 |
| Ortalama cümle uzunluğu: düz metin / `\caption` | 17,1 / 17,2 kelime | 12,8 / 12,2 kelime |
| 30 kelimeyi aşan cümle: düz metin / `\caption` | 11 / 2 | **0 / 0** |
| En uzun cümle | 51 kelime (satır 157) | 30 kelime |
| Noktalı virgül: düz metin / `\caption` / tablo | 33 / 5 / 1 | **0 / 0 / 0** |
| Geniş zamanla biten fiilli yüklem: metin / `\caption` / tablo | 48 / 4 / 3 | **0 / 0 / 0** |
| Yasak gösterme sözcüğü | 0 | **0** |
| "değil" geçen yapı | 3 | 0 |
| Bölümler arası gönderme, `\ref`+`\eqref` (umitnot dahil) | 43 | 28 |
| Bölümler arası gönderme, `\umitnot` dışında | 39 | 24 |
| `\label` / `\ref` / `\eqref` / `\cite*` komutu | 17 / 54 / 8 / 5 | 17 / 39 / 8 / 5 |

**Yöntem farkı.** Görevi veren oturumun sayımı (207 cümle, 17,9 ortalama, 21 uzun cümle, 42 noktalı virgül, yaklaşık 55 geniş zaman) metin, başlık ve tabloyu birlikte, kısmen `\umitnot` dahil ölçmüş olmalı. Bu betik üç türü ayrı sayıyor. Geniş zaman sayımı yalnız cümle sonundaki yüklemi kapsıyor. Noktalı virgülle bağlı yan cümle sonları ("... alır; ...") bölününce yeni cümle sonu oldu ve onlar da çevrildi. Sonra kalan yan cümle yüklemleri ayrıca tarandı. Geriye yalnız sıfat ve ad kullanımları kaldı ("güvenilir", "görünür", "anahtar", "sınır").

**Bütünlük denetimi (betikle, `git show HEAD:...` sürümüne karşı):**
- `\label` (17), `\eqref` (8), `\cite`/`\citep` (5 komut; anahtarlar ve sıra dahil) dizileri birebir aynı.
- `$...$` matematik (123), `\SI{}{}` (28), `\num{}` (5) ve `\si{}` (1) kümeleri aynı. `\SI`, `\num` ve `\si` dizilerinin sırası da aynı. Matematik dizisinde yalnız Şekil `fig:s3-simulink-modeli` başlığında bir sıra değişikliği var: "$Q_1$--$Q_4$" öğesi blok listesinden sonraya alındı.
- Metindeki çıplak sayılar 238 → 238, küme aynı. Sıra farkı yine aynı başlıktaki öğe yer değiştirmesinden geliyor.
- `%` yorum satırları ve `\umitnot` bloğu birebir aynı. TikZ kodu, tablo yapısı, şekil ortamları değişmedi.
- `\ref`: 54 → 39. Eksilen 15 `\ref`'in hepsi §3'teki bölümler arası göndermeler. Bölüm içi şekil, tablo ve denklem göndermelerinin hepsi kaldı.
- Kalan her `\ref`/`\eqref` hedefinin `\label`'ı `yeni_tez/bolumler` altında var (betikle denetlendi).
- Yasak sözcük taraması: istenen `grep -n -i -w -E 'bu|bunun|...|söz konusu'` 0 satır buldu. "şöyle", "orada", "onu" ve gösterme sıfatı "o" da 0. Taramada görünen "O" eşleşmeleri `$O$` durum simgesi.
- Hiçbir paragrafta art arda üçten fazla "-mektedir/-maktadır" ile biten cümle yok (betikle denetlendi).

## 2. Yapılan değişiklik türleri

1. **Noktalı virgül (kural 2):** Düz metindeki 33, başlıklardaki 5 ve tablo hücresindeki 1 noktalı virgülün hepsi kaldırıldı. Çoğu iki cümleye bölündü. Kalanlar "ise", "ancak", "-dığından" ve "Dolayısıyla" ile yeniden kuruldu. Şekil başlıklarındaki panel listeleri ("(a) ...; (b) ...") virgül ya da nokta ile ayrıldı (satır 188, 195). Tablo `tab:klasik-onerilen-islevsel` içindeki "kesilebilir; süreksiz iletim oluşabilir" hücresi iki cümle oldu (satır 53).
2. **Uzun cümle (kural 3):** 30 kelimeyi aşan 13 cümlenin hepsi bölündü. Başlıcaları:
   - Satır 157 (51 kelime): süreksiz iletimde akım zarfı cümlesi üç cümleye ayrıldı: zarfın sinüsten ayrılması, alternans ortasındaki çökmenin nedeni, sıfır geçişlerindeki yükselme hızı.
   - Satır 106 (43 kelime): iki iki nokta üst üste içeren yol betimi dört kısa cümle oldu.
   - Satır 13 (39 kelime): senkron-buck eşdeğeri ve ters akım eşiği cümlesi ikiye ayrıldı.
   - Satır 166, 155, 8, 108, 204, 85, 41, 31 (31–37 kelime): noktalı virgül ya da iki nokta yerinden bölündü. Satır 31'deki ortaç zinciri ("... azalırken ... sürenin artması, ... dağılmasına yol açar") "azalmakta, ... artmaktadır. Sonuç olarak ... dağılmaktadır" biçiminde çözüldü.
   - Başlık satır 150 (44 kelime): blok listesi iki cümleye ayrıldı. Anahtar etiketi açıklaması ayrı cümle oldu.
   - Başlık satır 195 (34 kelime): panel listesi iki cümle oldu.
   - Satır 202'deki "İşaret kuralı üreticidir: ..." cümlesi üç cümleye ayrıldı.
3. **Kip birliği (kural 9):** 55 cümle sonu ve noktalı virgülle bağlı yaklaşık 25 yan cümle yüklemi "-mektedir/-maktadır" kipine çevrildi. Tablo hücreleri ve başlıklar da çevrildi: "izin verir" → "izin vermektedir", "engellenir" → "engellenmektedir", "gerekir" → "gerekmektedir", "$Q_1$ anahtarlanır, $Q_3$ susturulur" → "anahtarlanmakta, ... susturulmaktadır". Geçişlilik korundu: "akar" → "akmaktadır", "kalır" → "kalmaktadır", "iner" → "inmektedir", "taşınır" → "taşınmaktadır". "ile gösterilsin", "ile tanımlansın", "olarak ele alınsın" kalıpları ve "-ebilir/-abilir" yüklemleri ("tanımlanabilir", "yaklaştırılabilir", "izin verebilir", "artırabilir", "dönüşebilir") kural gereği aynen kaldı. "-malıdır/-melidir" yüklemleri de kaldı. Dörtten fazla "-mektedir" oluşan yerlerde bazı cümleler ad cümlesine çevrildi:
   - Satır 15: "ek yük oluşturur" → "ek bir yüktür".
   - Satır 37: "P durumu, serbest dolaşım O durumu üzerinden gerçekleşir" → "aktif enerji aktarımının yolu P durumu, serbest dolaşımın yolu O durumudur" (yalnız pozitif alternans cümlesi).
   - Satır 85: "S3, S2'den yalnız ... Sin3 terimiyle ayrılır" → "S3'ün S2'den tek farkı, ... Sin3 terimidir".
   - Satır 108: "faz kolu ... senkron olmayan alçaltıcıya dönüşür" → "Faz kolunun her yarım periyottaki eşdeğeri, ... senkron olmayan alçaltıcıdır".
   - Satır 144: "yalnız modülasyon ve kapı mantığı farklıdır" ad cümlesi olarak ayrı kaldı.
   - Satır 157: "üçüncü harmonik payını büyütür" → "... büyüten etkenlerdir". "çökme oluşturur" → "çökmenin nedeni ... azalmasıdır".
   - Satır 208: "karşılığında ... ceza oluşturmaktadır" → "Yöntemin bedeli ise süreksiz iletim ve üçüncü harmonik cezasıdır".
   - Yeni "değildir" yapısı üretilmedi. Var olan üç "değil" yapısının üçü de olumlu kuruldu (bkz. §4).
4. **Gösterme sözcüğü (kural 1):** Bölümde yasak sözcük yoktu. Satır 183'teki "bir sonraki darbeye kadar orada kalır" ("orada" bir gösterme biçimi) → "bir sonraki darbeye kadar ara seviyede kalmaktadır". Satır 183'ün son cümlesindeki "Şekil, ..." öznesi (göndermesiz, gösterme işlevli) → "Akım kaydı, ...".
5. **Bağlam onarımı (Bölüm 3 temizliği):** Satır 41'deki "ters akım alanı ve RMS akım bakımından elverişsizdir" ifadesi, Bölüm 3'ten çıkarılan $A_{\mathrm{rev}}$ alan ölçütüne dayanıyordu. Bölümde tanımlı ölçüte bağlamak için "ters akım yükü ve RMS akım bakımından" yazıldı (Eşitlik `eq:ters-akim-yuku`, $Q_{\mathrm{rev}}$). $N_{\mathrm{sw}}$ ya da yarı iletken eşleme tablosuna dayanan başka cümle bulunmadı. Bölüm 3'teki "Düşük Akımda Benzetim Modelleme" kesimi S3 kayıp ayrıştırmasını (\%7) ve diyot toparlanma duyarlılığını hâlâ içeriyor. Satır 17 ve 31'deki göndermeler geçerli kaldı. "Benzetim Modelinin Doğrulanması" kesimi S2 kapı yolu satırını hâlâ içeriyor. Satır 126'daki gönderme geçerli.
6. **Dolgu ve yazım:**
   - Satır 208: "Modelden okunan kapı mantığı, susturmanın iki yöntem arasındaki tek farkın ... olduğunu doğrulamıştır" cümlesindeki dilbilgisi bozukluğu giderildi ("susturmanın" fazlalığı çıkarıldı).
   - Satır 75: "durum korunarak ... önlenir" → "durum korunduğundan ... önlenmektedir".
   - Satır 24: "amper--saniye birimindedir; tek başına kayıp enerjisi veya gücü vermez, ..." → "Ters akım yükünün birimi amper--saniyedir. Ters akım yükü, kayıp enerjisi ya da güç yerine ... karşılaştırmak için kullanılmaktadır."
   - Satır 204'te tümce başına sayı gelmemesi için "\num{20}--\SI{25}{kW} aralığı ... aralığıdır" → "Tasarım güç aralığı ise donanım tasarım belgesine göre \num{20}--\SI{25}{kW}'tır".

Sayılar, birimler, kaynak sırası, `\cite` yerleri ve iddia gücü değişmedi. Bölünen cümlelerde atıf özgün yerinde, son parçanın sonunda kaldı. Başlık yapısı, kesim sırası ve paragraf sınırları korundu. Paragraf birleştirilmedi ya da taşınmadı.

## 3. Kaldırılan bölümler arası göndermeler (kural 11)

Satır numaraları HEAD'e göredir. Dosyanın satır sayısı değişmediği için güncel dosyayla aynı.

| Satır | Kaldırılan gönderme | Hedef | Gerekçe |
|---:|---|---|---|
| 13 | "Alt Bölüm~\ref{sec:dusuk-guc-esdeger} içindeki senkron-buck eşdeğerine göre" → "Senkron-buck eşdeğerine göre" | `sec:dusuk-guc-esdeger` (Bölüm 3) | Paragrafta üç `\ref` vardı. Aynı eşdeğerin iki eşitliğine `\eqref` zaten gidiyor. Sayıların türetildiği `sec:dusuk-akim-modelleme` kaldı. |
| 13 | "Tablo~\ref{tab:sistem-parametreleri} değerleriyle" → "Sistem parametre değerleriyle" | `tab:sistem-parametreleri` (Bölüm 3) | Aynı paragrafta üçüncü gönderme. Tabloya satır 144 ve 204'te gönderme kalıyor. |
| 31 | "(Tablo~\ref{tab:kalibrasyon-karsilastirma})" | `tab:kalibrasyon-karsilastirma` (Bölüm 6) | Paragrafta ikinci gönderme. Değerler satır 168'deki göndermeyle veriliyor. Kayıp ayrıştırmasının dayanağı (`sec:dusuk-akim-modelleme`) kaldı. |
| 106 | "(Alt Bölüm~\ref{sec:dusuk-akim-modelleme})" | `sec:dusuk-akim-modelleme` (Bölüm 3) | Paragrafta ikinci gönderme. Yol betimi paragrafın kendisinde tam. S1 kapı mantığının ideal durum tablosuyla eşliğini gösteren `tab:t-tipi-durumlar` kaldı. |
| 108 | "; ikinci sonucun harmonik etkisi Alt Bölüm~\ref{sec:harmonik-mekanizma} içinde incelenmiştir" (yan cümle) | `sec:harmonik-mekanizma` (Bölüm 5) | Duyuru niteliğinde yan cümle ve paragrafta ikinci gönderme. Eşdeğer devre göndermesi (`fig:senkron-buck-esdeger`) kaldı. |
| 131 (`\caption`) | "Kayıt, Alt Bölüm~\ref{sec:model-dogrulama-duzeltme} içinde doğrulanan benzetim modelinden alınmıştır" → "Kayıt, doğrulanmış benzetim modelinden alınmıştır" | `sec:model-dogrulama-duzeltme` (Bölüm 3) | Aynı hedefe hemen önceki paragrafta (satır 126) gönderme var. Başlık, S1 şeklinin başlığıyla ("Kayıt, kalibre S1 benzetim modelinden alınmıştır") koşut oldu. |
| 144 | "Faz kolunun devre yapısı Şekil~\ref{fig:t-tipi-akim-yollari}, elemanların değerleri ..." → "Faz kolunun eleman değerleri ..." | `fig:t-tipi-akim-yollari` (Bölüm 3) | Paragrafta dört bölümler arası gönderme vardı. Devre yapısı aynı paragraftaki Şekil `fig:s3-simulink-modeli` (bölüm içi) ile de görülüyor. |
| 144 | "(Şekil~\ref{fig:s4-anahtarlama-girisi})" | `fig:s4-anahtarlama-girisi` (Bölüm 5) | Aynı paragrafta ikinci gönderme. S4 bu bölümün konusu değil. |
| 144 | "Alt Bölüm~\ref{sec:model-dogrulama-duzeltme} içinde doğrulanan" → "doğrulanan" | `sec:model-dogrulama-duzeltme` (Bölüm 3) | Aynı paragrafta üçüncü gönderme. Satır 126'da aynı hedefe gönderme kalıyor. |
| 155 | "(Tablo~\ref{tab:sistem-parametreleri})" | `tab:sistem-parametreleri` (Bölüm 3) | Paragrafta ikinci gönderme. Ölü zamanın akım hatasına giden `sec:kalibrasyon` göndermesi `\citep{Zhang2014Deadtime}` ile birlikte kaldı. |
| 166 | "Alt Bölüm~\ref{sec:kalibrasyon} ile Tablo~\ref{tab:kalibrasyon-karsilastirma} içinde" → "Alt Bölüm~\ref{sec:kalibrasyon} içinde" | `tab:kalibrasyon-karsilastirma` (Bölüm 6) | Aynı cümlede iki gönderme. Tablo, gösterilen alt bölümün içinde. Bir sonraki paragraf tabloyu adıyla açıyor. |
| 168 | "(Alt Bölüm~\ref{sec:dusuk-akim-modelleme})" | `sec:dusuk-akim-modelleme` (Bölüm 3) | Paragrafta ikinci gönderme. Paragrafın konusu olan tablo göndermesi kaldı. |
| 170 | "... Alt Bölüm~\ref{sec:kalibrasyon} altında ele alınmaktadır" → "... kalibrasyon incelemesinde ele alınmıştır" | `sec:kalibrasyon` (Bölüm 6) | Paragrafta ikinci gönderme ve duyuru kalıbı. THD tutarlılığının kanıtı olan `tab:thd-kaynaklar` kaldı. Mutlak farkların incelendiği bilgisi göndermesiz korundu. |
| 183 | "Şekil, Alt Bölüm~\ref{sec:dusuk-akim-modelleme} içindeki süreksiz iletim açıklamasının ..." → "Akım kaydı, süreksiz iletim açıklamasının ..." | `sec:dusuk-akim-modelleme` (Bölüm 3) | Aynı paragrafta aynı hedefe ikinci gönderme. İlk gönderme kaldı. |
| 204 | "(Alt Bölüm~\ref{sec:s4-kapali-cevrim})" | `sec:s4-kapali-cevrim` (Bölüm 5) | Paragrafta ikinci gönderme. Anma değerlerinin kaynağı olan `tab:sistem-parametreleri` kaldı. |

**Göndermesiz duyuru cümlesi:** Satır 210'daki "Sonraki bölümde harmonik cezayı azaltan Sin3 kompanzasyonunun matematiksel tanımı, kapalı çevrim içindeki konumu, Bode analizi ve çalışma noktasına bağlı sonuçları ele alınmaktadır." cümlesi `\ref` içermiyor ama ileriye dönük bir duyuru. Yerine bölümün sonucunu sonraki katkıya bağlayan bir ad cümlesi yazıldı: "Harmonik cezayı azaltma gereksinimi, önerilen anahtarlamayı tamamlayan Sin\textsuperscript{3} kompanzasyonunun gerekçesidir." (Kural 8: ödünleşim sonraki katkının gerekçesidir.)

**Bırakılan 24 gönderme (`\umitnot` dışında):**
- **Paragraf başına bir `\ref` (21):**
  - satır 4 `chap:sistem`
  - 13, 17, 31, 183 `sec:dusuk-akim-modelleme`
  - 39 `sec:denetim-modelden`
  - 41, 155, 166, 202 `sec:kalibrasyon`
  - 106 `tab:t-tipi-durumlar`
  - 108 `fig:senkron-buck-esdeger`
  - 126 `sec:model-dogrulama-duzeltme`
  - 144, 204 `tab:sistem-parametreleri`
  - 157 `chap:sin3`
  - 161 `sec:s4-kapali-cevrim`
  - 168, 210 `tab:kalibrasyon-karsilastirma`
  - 170 `tab:thd-kaynaklar`
  - 181 `tab:kopru-ic-empedansi`
- **`\eqref` (3):** satır 13 `eq:ters-akim-esigi` ve `eq:sinir-akimi`, satır 202 `eq:guc-ortalama-tanimlari`. Görev tanımı `\eqref` kümesinin değişmemesini istediği için denklem göndermeleri korundu. Satır 13 ve 202 bu yüzden bir `\ref` ile bir ya da iki `\eqref` taşıyor.
- **`\umitnot` içinde (4):** satır 175–178. İç nota dokunulmadı.

**Not:** Kaldırma sonrasında `sec:dusuk-guc-esdeger` ve `sec:harmonik-mekanizma` etiketlerine tezde hiçbir `\ref` kalmadı. Etiketler yerinde duruyor, silinmedi. Göndermesiz etiket derleme uyarısı üretmez.

## 4. Olumlu yazım (kural 8)

| Satır | Önce | Sonra |
|---|---|---|
| 8 | "Düşük güç bölgesi yalnız laboratuvar için seçilmiş bir test noktası değildir: ... ortaya çıkan gerçek bir işletme koşuludur." | "Düşük güç bölgesi, laboratuvar test noktasının ötesinde gerçek bir işletme koşuludur. Düşük güç koşulu, ... ortaya çıkmaktadır." |
| 33 | "Ters akımın yalnız akım işaretine bakılarak belirlenmesi yeterli değildir." | "Ters akımın güvenilir biçimde belirlenmesi, akım işaretinin yanında ek ölçütler gerektirmektedir." |
| 24 | "... tek başına kayıp enerjisi veya gücü vermez, farklı anahtarlama yöntemlerindeki dolaşımı karşılaştırmak için kullanılır." | "Ters akım yükü, kayıp enerjisi ya da güç yerine farklı anahtarlama yöntemlerindeki dolaşımı karşılaştırmak için kullanılmaktadır." |
| 126 | "Nötr anahtarlar yarım periyot içinde hiç anahtarlanmaz; anahtarlama kaybı yalnız dış anahtarlarda oluşur." | "Nötr anahtarlar yarım periyot boyunca anahtarlama yapmadan sabit konumda kalmaktadır. Dolayısıyla anahtarlama kaybı yalnız dış anahtarlarda oluşmaktadır." |
| 161 | "S1--S3 senaryolarında akım denetleyicisi kullanılmamıştır; modülasyon referansı açık çevrimde uygulanmış ..." | "S1--S3 senaryolarında modülasyon referansı, akım denetleyicisi olmadan açık çevrimde uygulanmıştır." |
| 157 | "... akım zarfı ... saf sinüs biçimini koruyamaz" | "... akım zarfı saf sinüs biçiminden ayrılmaktadır" |
| 195 (`\caption`) | "S2'de akım söndüğünde kutup gerilimi üç seviyeden hiçbirinde değildir." | "S2'de akım söndüğünde kutup gerilimi ara bir seviyeye geçmektedir." |
| 6 | "... yalnızca aktarılan aktif gücün azalmasıyla açıklanamaz." | "... davranışını aktarılan aktif gücün azalması tek başına açıklamamaktadır." (kip çevirisi; anlam aynı) |

Susturmanın THD bedeli ödünleşim diliyle ve sayılarıyla kaldı: satır 6 "ödünleşimin yönetilmesi", satır 157 "harmonik ceza", satır 170 "İkinci bulgu harmonik cezadır", satır 208 "Yöntemin bedeli ise süreksiz iletim ve üçüncü harmonik cezasıdır", satır 210'da THD %15 → %47 ve %39,5 → %56,7.

Teknik betim olarak kalan olumsuz yapılar tezin aleyhine konuşmadığı için korundu:
- satır 41 "doğal bir diyot kesimi bırakmamaktadır" (klasik yöntemin özelliği)
- satır 41 "elverişsizdir" (klasik yöntem için)
- satır 56 tablo hücresi "Özel düşük güç müdahalesi yoktur" (klasik yöntem)
- satır 85 "Hiçbir kapı çiftinde örtüşme yoktur" (olumlu bulgu)
- satır 106 ve 122 "Ters yönde ise akım yolu yoktur" (yöntemin işlevi)
- satır 183 "S2'de ters akım aralığı yoktur" (yöntemin sonucu)

**Kural 10:** Düz metinde, başlıklarda ve tablolarda "eski tez" ya da önceki sürüme gönderme yok. Satır 175'teki `\umitnot` iç notunda "İlk tezin Şekil~5.18'indeki faz akımı izi" ve satır 176'da "Tablo~5.4" geçiyor. Kural 7 gereği iç nota dokunulmadı. Not, `tez_notlu.pdf` dışında görünmüyorsa sorun yok. Nihai teslimden önce notların kaldırıldığı doğrulanmalı.

## 5. Kontrol edilmeli (teknik ya da anlam)

1. **Satır 41, "ters akım alanı" → "ters akım yükü":** Özgün ifade Bölüm 3'ten çıkarılan $A_{\mathrm{rev}}$ alan ölçütüne dayanıyordu. Bölümde tanımlı $Q_{\mathrm{rev}}$ (akım--zaman büyüklüğü) aynı fiziksel niceliği karşılıyor. Terim tezde bir yerde daha geçiyor: `08-sonuc.tex` satır 117, Gelecek Çalışmalar listesinde "ters akım alanı, anahtarlama geçiş sayısı". Bu iki ölçüt Bölüm 3'ten çıkan $A_{\mathrm{rev}}$/$N_{\mathrm{sw}}$ karşılıkları. Öneri dilinde oldukları için kalabilirler, ancak tanımları artık tezde yok. Bölüm 8 düzenlemesinde "ters akım yükü" ile eşlenmesi önerilir (bu görevde dokunulmadı).
2. **Satır 33:** "yeterli değildir" yerine "ek ölçütler gerektirmektedir" yazıldı. Sonraki iki cümle bu ölçütleri (eşik, histerezis, bekleme süresi, güvenli komütasyon) zaten sayıyor. İddia gücü aynı olmalı.
3. **Satır 195 (`\caption`):** "üç seviyeden hiçbirinde değildir" yerine "ara bir seviyeye geçmektedir" yazıldı. Metin (satır 183) ve Bölüm 3 aynı olayı "ara bir seviyeye sıçrar" ve "filtre tarafının gerilimini izler" diye anlatıyor. "Ara seviye", kutup geriliminin $0$ ile $\pm V_{\mathrm{dc}}/2$ arasında olduğu izlenimini veriyor. Şekilde gerilim bu aralığın dışına çıkıyorsa (filtre tarafı geriliminin anlık değeri) "filtre tarafının gerilimini izlemektedir" daha doğru olur.
4. **Satır 24:** "tek başına kayıp enerjisi veya gücü vermez" yerine "kayıp enerjisi ya da güç yerine ... karşılaştırmak için kullanılmaktadır" yazıldı. "Tek başına" vurgusu (kayıpla ilişkili ama kayıp ölçüsü olmadığı) biraz zayıfladı. Jüri sorusu beklenirse "tek başına" yeniden eklenebilir.
5. **Satır 161:** "Kapalı çevrim performansı Alt Bölüm~\ref{sec:s4-kapali-cevrim} içinde ayrıca ele alınmıştır" cümlesi paragraftaki tek gönderme olduğu için kaldı. Geçmiş zamanlı ama işlevi duyuru. Fazlalık incelemesinde çıkarılması düşünülebilir.
6. **Satır 170:** Göndermesi kaldırılan "mutlak değer farkları ... kalibrasyon incelemesinde ele alınmıştır" cümlesi göndermesiz kaldı. Okur kalibrasyon kesimini satır 166'daki göndermeden buluyor. İstenirse cümle tamamen çıkarılabilir (fazlalık incelemesi).
7. **Satır 144:** `fig:t-tipi-akim-yollari` göndermesi çıktı. Faz kolunun akım yolları Şekil `fig:susturma-esdeger` ve `fig:s3-simulink-modeli` ile bölüm içinde görülüyor. Okur akım yolu şekline ihtiyaç duyarsa satır 106'daki `tab:t-tipi-durumlar` göndermesi Bölüm 3'e götürüyor.
8. **Satır 13:** Paragrafta bir `\ref` ile iki `\eqref` (Bölüm 3) kaldı. `\eqref` kümesi görev gereği korundu. Kural 11 sıkı uygulanacaksa eşitlik göndermeleri metne gömülebilir, ancak bu iki eşitlik ters akım eşiğinin tanımı olduğu için kalmaları uygun görünüyor.
9. **Satır 108:** Harmonik mekanizma kesimine (Bölüm 5) giden duyuru yan cümlesi çıktı. Satır 157 Sin3 kompanzasyonuna (`chap:sin3`) gönderme yaptığı için okur harmonik incelemesine yine ulaşıyor.
10. **Satır 8:** "yalnız laboratuvar için seçilmiş bir test noktası değildir" → "laboratuvar test noktasının ötesinde gerçek bir işletme koşuludur". Vurgu aynı. Laboratuvar noktasının seçim gerekçesi korunuyor.

## 6. Kalan noktalı virgüller

- **Düz metin:** 0.
- **`\caption`:** 0. Panel listelerindeki iki noktalı virgül (satır 188, 195) virgül ve noktaya çevrildi. Satır 195'teki (a)/(b) öğesi iç virgül içerdiği için noktalı virgül kural 2'ye göre kalabilirdi. Okunuş için nokta seçildi.
- **Tablo hücreleri:** 0. Bölümdeki tek hücre içi noktalı virgül cümle düzeyindeydi ve bölündü (satır 53). Kapı mantığı tablosunda değer listesi yok.
- **`\umitnot`:** satır 177'deki "(\%2,1; \%8,3; \%46,3; \%7,8)" değer listesi iç nota ait, dokunulmadı ve sayımlara girmedi.
