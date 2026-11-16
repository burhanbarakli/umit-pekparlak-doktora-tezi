# Bölüm 3 (Sistem, Model ve Metodoloji) yazım düzenlemesi

- **Dosya:** `yeni_tez/bolumler/03-sistem-model-metodoloji.tex`. Satır sayısı değişmedi (732). Başka dosyaya dokunulmadı (`sekiller/t_tipi_vektor_cizimler.tex` dahil).
- **Görev kipi:** uygula (`.claude/agents/tez-yazim-editoru.md`, kural 1–11).
- **Tarih:** 16.11.2026
- **Örnek alınan üslup:** Bölüm 2'nin sonuçlanmış hâli ve rapor 10.
- Derleme ve commit yapılmadı. 78 satır değişti: 66 düz metin paragrafı (madde ve `\paragraph` satırları dahil), 4 `\caption`, 8 tablo satırı.

## 1. Önce/sonra sayımları

Sayım betiği rapor 10'daki yöntemi izliyor. TikZ blokları, `\ttypevector` içindeki `\draw` satırları, `%` yorumları ve yalnız komut içeren satırlar dışarıda kaldı. Cümleler `. ? !` işaretinden bölündü. `\cite`, `\ref` ve `$...$` birer sözcük sayıldı. "Düz metin" paragrafları ve `enumerate` maddelerini kapsıyor.

| Ölçüt | Önce (HEAD) | Sonra |
|---|---:|---:|
| Cümle sayısı, düz metin / metin + başlık | 317 / 350 | 409 / 446 |
| Ortalama cümle uzunluğu, düz metin / metin + başlık | 16,3 / 15,9 kelime | 12,6 / 12,5 kelime |
| 30 kelimeyi aşan cümle (metin + başlık) | 23 (21 metin, 2 başlık) | **0** |
| 25 kelimeyi aşan cümle | 47 | 7 |
| En uzun cümle | 74 kelime (satır 75) | 28 kelime (satır 703) |
| Noktalı virgül, düz metin | 71 | **0** |
| Noktalı virgül, `\caption` | 1 | **0** |
| Noktalı virgül, tablo hücreleri | 105 | 98 (bkz. §6) |
| Geniş zamanla biten fiilli yüklem, düz metin | 76 | **0** |
| Geniş zamanla biten fiilli yüklem, tablo hücresi | 5 | **0** |
| Yasak gösterme sözcüğü | 0 | **0** |
| Bölümler arası gönderme (`\ref` başka dosyadaki etikete) | 38 | 30 |
| `\label` / `\ref` / `\eqref` / `\cite*` komutu | 39 / 83 / 18 / 12 | 39 / 75 / 18 / 12 |

**Yöntem farkı.** Görevi veren oturum 480 cümle, 17,7 ortalama ve yaklaşık 94 geniş zaman bulmuştu. Bu betik tablo hücrelerini ayrı sayıyor (364 kısa birim, ortalama 4,9 kelime) ve metin sayımına katmıyor. Yalnız cümle sonundaki yüklemi geniş zaman sayıyor. Noktalı virgülle bağlanmış yan cümle sonları ("... alır; ...") bölününce yeni cümle sonu oldu. Bunlar da çevrildi ve sonraki sayıma girdi. Betik geniş zaman için yalnız bir yanlış pozitif buluyor: satır 233'teki "ideal gerilimler". Bu sözcük denklemden önce gelen bir addır. Tablo sayımında da 6 ad yanlış pozitif çıkıyor ("elemanlar", "emetör", "ölçütler", "kutuplar", "değer").

**Bütünlük denetimi (betikle, HEAD'e karşı):**
- `\label` (39), `\eqref` (18), `\cite`/`\citep`/`\citet` (12 komut, anahtarlar ve sıra dahil) dizileri birebir aynı.
- `$...$` matematik dizisi (529), `\SI{}{}` (161) ve `\num{}` (86) dizileri birebir aynı.
- `%` yorum satırı, 3 `tikzpicture` bloğu ve 105 `\draw`/`\node`/vektör makrosu satırı birebir aynı. Bölümde `\umitnot` yok.
- Metindeki çıplak rakamlar 664 → 663. Eksilen tek rakam, satır 434'te kaldırılan gönderme yan cümlesindeki "S4"ün "4"ü (bkz. §3). Başka sayı değişmedi.
- `\ref`: 83 → 75. Eksilen 8 `\ref`'in hepsi §3'te listelenen bölümler arası göndermeler. Bölüm içi şekil, tablo ve denklem göndermelerinin hepsi kaldı.
- Yasak sözcük taraması: `grep -i -w` (TikZ ve yorum dışı) ile Python taraması ikisi de 0 buldu. Tarama "şöyle", "adı geçen" ve gösterme sıfatı "o"yu da kapsıyor. "onu" zamiri de kalmadı (3 → 0).
- Hiçbir paragrafta art arda üçten fazla "-mektedir/-maktadır" yok (betikle denetlendi).

## 2. Yapılan değişiklik türleri

1. **Noktalı virgül (kural 2):** Düz metindeki 71 noktalı virgülün ve başlıktaki 1 noktalı virgülün hepsi kaldırıldı. Bunlar iki cümleye bölündü ya da "ise", "ve", "-dığından", "-ken" ile yeniden kuruldu. Satır 590'daki "Tablo~\ref{...};" yapısı (tablodan sonra gelen noktalı virgül) "üç akım bölgesinde (düşük, orta ve anma)" diye kuruldu. Tablo hücrelerinde cümle düzeyindeki noktalı virgüller bölündü (satır 151, 497, 524, 545, 601, 675).
2. **Uzun cümle (kural 3):** 30 kelimeyi aşan 23 cümlenin hepsi bölündü. Başlıca çözümler:
   - Satır 75: 74 kelimelik şema betimi (noktalı virgülle dizilmiş beş öğe) yedi kısa cümleye ayrıldı: sol, orta, hücre, nötr hattı, alt kısım.
   - Satır 581: 44 kelimelik "$D_1$--$D_2$ ... gerektirir; nötr kol diyotları ... yeterlidir" cümlesi dört cümleye ayrıldı. Ortaç zinciri ("... konumundaki ve ... çalışan $D_1$--$D_2$ diyotları") çözüldü.
   - Satır 429: 39 kelimelik ileri besleme ve karakteristik denklem cümlesi üçe ayrıldı.
   - Satır 699: 39 kelimelik "klasik anahtarlamada akım ... işaret değiştirir; nötr kol ters akımı ..." cümlesi bölündü.
   - Satır 636: tanım cümlesi "Birinci ölçüt ... İkinci ölçüt ..." biçiminde kuruldu.
   - Satır 233 ve 611: uzun "tanımlansın" cümleleri iki tanım cümlesine bölündü ("... tanımlansın. ... olsun.").
   - Başlıklar (satır 81, 90): noktalı liste biçimindeki 39 ve 41 kelimelik ilk cümleler bölündü. İlk tümce kısa bir ad öbeği olarak kaldı. Şekil listesindeki başlık da kısaldı.
   - Satır 378: 28 kelimelik ortaç zinciri ("... olduğunu ve ... uygulandığını açıkça ayırmaktadır") iki ad cümlesine çevrildi.
3. **Kip birliği (kural 9):** 76 metin ve 5 tablo geniş zaman yüklemi "-mektedir/-maktadır" kipine çevrildi. Bölünen yan cümlelerden doğan yaklaşık 30 yüklem de çevrildi. Geçişlilik korundu: "akar" → "akmaktadır", "geçer" → "geçmektedir", "olur" → "olmaktadır", "verir" → "vermektedir". Tanım cümlelerinde "olarak hesaplanır", "ile tanımlanır", "ile bulunur" ve "olarak elde edilir" biçimleri "-maktadır" kipine çevrildi. "gösterilsin" ve "tanımlansın" olduğu gibi kaldı. Bölünen tanım cümlelerinde aynı kalıpla "olsun" kullanıldı. Art arda dörtten fazla "-mektedir" oluşan yerlerde bazı cümleler ad cümlesine ya da geçmiş zamana çevrildi:
   - Satır 11: "enerji ... tarafından sağlanan" → "enerjinin kaynağı ... DA kaynaktır". "terim ... karşı eklenen" → "Terimin hedefi ... bileşendir".
   - Satır 50: "doğrulama katmanı ise ... kapsamaktadır" → "Doğrulama katmanının kapsamı ise ... ölçütleridir".
   - Satır 139: "ifade etmektedir" → "kesim komutudur". "Tablo yalnızca ... göstermektedir" → "Tablonun kapsamı ideal kararlı durumlardır".
   - Satır 252: "belirler" → "belirleyen etkenlerdir".
   - Satır 273: "$i_1$ ... göstermektedir" → "$v_c$ ise filtre kapasitörü gerilimidir".
   - Satır 343: "temsil eder" → "filtre elemanlarıdır" ve "temsil etmektedir".
   - Satır 429: "gösterir" → "Laplace dönüşümleridir".
   - Satır 434: "yarım periyotları ayırır" → "... anahtarıyla ayrılmıştır" (model yapısı geçmiş zamanla).
   - Satır 581: "taşır" → "akımının yolu $DS_3$--$DS_4$ diyotlarıdır".
   - Satır 588, 619, 634, 693: yapılmış işler "yapılmıştır", "kullanılmıştır", "alınmıştır", "ölçülmüştür" biçiminde.
   - Satır 624: "farkı akım bozulmasından gelir" → "farkın kaynağı akım bozulmasıdır".
   - Satır 684: "uygun boyuttadır" ayrı ad cümlesi oldu.
   - Yeni "değildir" yapısı üretilmedi. "değil" sayısı 9'dan 7'ye indi.
   - "-ebilir/-abilir" yüklemleri (satır 100, 107, 157, 247, 259, 364, 695, 726) kural gereği aynen kaldı.
4. **Terim birliği (kural 5):**
   - "bağımsız bir kontrolcü" → "bağımsız bir yapı" (satır 11; aynı cümlede "akım denetleyicisi" geçtiği için "denetleyici" tekrarlanmadı).
   - "Akım döngüsü" → "Akım çevrimi" (satır 359).
   - "kontrol eforu" → "denetim eforu" (satır 429).
   - Tablodaki "Kontrol kartı açıklaması" bir kaynak belge adı olduğu için kaldı.
5. **Yazım ve küçük açıklık düzeltmeleri:**
   - Satır 233: "anık şebeke gerilimi" → "anlık şebeke gerilimi" (yazım hatası). Satır 267'de de "anlık" yazılıyordu.
   - Satır 434: "Modelden okunan zincir şöyledir." → "... adımları aşağıdaki gibidir." ("şöyle" listede yok ama bir gösterme biçimi.)
   - Satır 52 ve 649: "onu sınayan", "onu üreten" → "kendisini sınayan", "kendisini üreten". Satır 52'de "onu tamamlayan katmanı" → "tamamlayıcı katmanını".
   - Satır 267: "$I_{\mathrm{B}}$; DA bara gerilimi, ..." → "$I_{\mathrm{B}}$, DA bara gerilimine, ..." (özneden sonra gelen noktalı virgül kaldırıldı, ekler düzeltildi).
   - Satır 554: "$L_2$'den" yerine "şebeke tarafı endüktansından" yazıldı. Böylece matematik dizisi değişmedi.
   - Bağlaç tekrarını azaltmak için iki noktada bölünen cümle "-dığından" ile yeniden birleştirildi (satır 581, 695). Satır 684'te "Sonuç olarak" kullanıldı. Bölümde 4 "Dolayısıyla" kaldı.

Sayılar, birimler, kaynak sırası, `\cite` yerleri ve iddia gücü değişmedi. Bölünen cümlelerde atıf, özgün cümlenin sonundaki yerinde kaldı, yani bölünmüş son parçanın sonunda. Başlık yapısı, kesim sırası ve paragraf sınırları korundu. Paragraf birleştirilmedi ya da taşınmadı. Bölüm 3.8 "Benzetim Modelinin Doğrulanması" doğrulama diliyle kaldı. Yalnız kip ve cümle bölme yapıldı. "düzeltme" ya da "uyumsuzluk" anlatımı eklenmedi.

## 3. Kaldırılan bölümler arası göndermeler (kural 11)

Satır numaraları HEAD'e göredir (dosyanın satır sayısı değişmediği için güncel dosyayla aynı).

| Satır | Kaldırılan gönderme | Hedef | Gerekçe |
|---:|---|---|---|
| 73 | "Şekil~\ref{fig:t-tipi-faz-kolu} ile Bölüm~\ref{chap:literatur} içinde" → "Şekil~\ref{fig:t-tipi-faz-kolu} üzerinde" | `chap:literatur` (Bölüm 2) | Aynı cümlede iki gönderme vardı. Şekil göndermesi kaldı. |
| 75 | "(Bölüm~\ref{chap:gttipi})" | `chap:gttipi` (Bölüm 7) | Aynı hedefe iki paragraf önce (satır 50) gönderme var. |
| 267 | "Eşdeğer modelin T-tipi nötr koldaki karşılığı, ters akım yükü ve kayıp etkisi Alt Bölüm~\ref{sec:ters-akim-mekanizmasi} altında incelenmektedir." (tüm cümle) | `sec:ters-akim-mekanizmasi` (Bölüm 4) | İleriye dönük duyuru cümlesi. |
| 376 | "Katsayıların seçimi Bölüm~\ref{chap:sin3} içinde ele alınmıştır." (tüm cümle) | `chap:sin3` (Bölüm 5) | Aynı paragrafta ikinci gönderme ve duyuru cümlesi. $K_{1x}$/$K_{3x}$ tanımını veren ilk gönderme kaldı. |
| 434 | "..., S4 akım denetleyicisinin yapısı Alt Bölüm~\ref{sec:s4-kapali-cevrim} içinde" (yan cümle) | `sec:s4-kapali-cevrim` (Bölüm 5) | Aynı cümlede ikinci gönderme. S4 denetleyici değerleri zaten Tablo `tab:sistem-parametreleri` içinde. Kapı mantığı göndermesi (`sec:model-kapi-mantigi`) kaldı. |
| 554 | "Alt Bölüm~\ref{sec:kararlilik-bode} içinde taranmıştır" → "kararlılık analizinde taranmıştır" | `sec:kararlilik-bode` (Bölüm 5) | Paragrafta aynı hedefe ikinci gönderme. \SI{2.8}{kHz} değerini destekleyen ilk gönderme kaldı. Tarama bilgisi korundu. |
| 649 | "ve Bölüm~\ref{chap:deney} içinde ayrıntılı olarak sunulur" | `chap:deney` (Bölüm 6) | "ayrıntılı olarak sunulur" duyurusu. |
| 699 | "nötr kol ters akımı (Alt Bölüm~\ref{sec:model-kapi-mantigi})" | `sec:model-kapi-mantigi` (Bölüm 4) | Paragrafta iki gönderme vardı. S4 sonucunu destekleyen `sec:s4-kapali-cevrim` kaldı. |

**Bilinçli olarak bırakılan 30 gönderme:**
- **Düz metinde, paragraf başına en çok bir (15):**
  - satır 50 `chap:gttipi`
  - 73 `fig:t-tipi-faz-kolu` (şekil Bölüm 2'de)
  - 157 `sec:model-kapi-mantigi`
  - 252 `fig:de-ccm-akim`
  - 355, 429, 554, 684 `sec:kararlilik-bode` (sonuç ya da sayı dayanağı)
  - 364, 699 `sec:s4-kapali-cevrim`
  - 376 `chap:sin3` ($k_1$/$k_3$ tanımı)
  - 434 `sec:model-kapi-mantigi`
  - 656, 722, 726 `sec:kalibrasyon`
  - 701 `fig:s1-s2-kalibre-dalga`
  - 732 `chap:sin3` (bölüm sonucu bağlantısı)
- **Tablolarda (15):**
  - Parametre tablosunun "Kaynak" sütunu: satır 520–523 `chap:deney` ×4, 528 ve 535 `chap:sin3`. Bunlar kalibrasyon ve denetleyici tasarımının kaynağını gösteriyor.
  - Doğrulama matrisinin "Bölüm" sütunu: satır 601–606, 7 gönderme. Sütunun işlevi raporlandığı yeri vermek.
  - Kural 11 paragraf sınırını konuşuyor. Tablo sütunları gönderme işlevi taşıdığı için kaldı.

**Not:** Satır 267'deki cümle kaldırılınca `sec:ters-akim-mekanizmasi` etiketine tezde hiçbir `\ref` kalmadı (etiket `04-dusuk-guc-anahtarlama.tex` içinde duruyor, silinmedi). Derleme uyarısı üretmez.

## 4. Olumlu yazım (kural 8)

| Satır | Önce | Sonra |
|---|---|---|
| 139 | "... komütasyon yolları tabloda yer almaz; anahtarlamalı benzetimde ise ... kendiliğinden oluşur." | "Tablonun kapsamı ideal kararlı durumlardır. ... komütasyon yolları, anahtarlamalı benzetimde ... kendiliğinden oluşmaktadır." |
| 159 | "Kapı komutlarına bakmak, gerçek iletimde bulunan yarı iletkeni tanımlamak için yeterli değildir." | "Dolayısıyla gerçek iletimdeki yarı iletken, kapı komutlarının yanında akım yönüne de bağlıdır." |
| 209 | "... işlevsel güç topolojisidir; kart üretim veya bağlantı şeması niteliği taşımamaktadır." | "... işlevsel güç topolojisidir." Savunmacı yan cümle çıkarıldı. Sonraki cümle, sensör, koruma ve parça bilgisinin nerede olduğunu zaten olumlu biçimde veriyor. |
| 364 | "... \SI{60}{\hertz}'e yerleştirilmiştir; seçimin şebeke frekansıyla ilgisi yoktur." | "... yerleştirilmiştir. Seçim, şebeke frekansından bağımsız olarak kazanç geçiş frekansına dayanmaktadır." |
| 497 (tablo) | "laboratuvar kaynağının akım çekememesinin temsili, donanımda eleman yoktur" | "Yalnız modelde yer alan eleman, laboratuvar kaynağının akım çekememesini temsil etmektedir" |
| 545 (tablo) | "yalnız görüntülemede, hesaplara girmez" | "Yalnız görüntülemede kullanılmaktadır" |
| 699 | "... düşük güç çalışmasının genel durumudur, sıfır geçişleri çevresine özgü bir olay değildir." | "Nötr kol ters akımı, sıfır geçişleri çevresiyle sınırlı kalmayan, düşük güç çalışmasının genel bir durumudur." |

Teknik açıklama olarak kalan olumsuz yapılar tezin aleyhine konuşmadığı için korundu:
- satır 75: "$L2$ etiketi ... şebeke tarafı endüktansı değildir"
- satır 552: "$L_2$ ayrı bir filtre bobini değildir"
- satır 434: "$V_{\mathrm{dc}}$ normalizasyonu yoktur"
- satır 682: "hiçbir kapı çiftinde örtüşme yoktur" (olumlu bir sonuç)
- satır 686 ve 703: "sert bir gerilim kaynağı gibi davranmaması" (fiziksel bulgu)

Kural 10: bölümde "eski tez" ya da önceki sürüme gönderme yok. Satır 552'deki "daha erken tarihli parametre notları" ifadesi kaynak parametre belgelerini anlatıyor, önceki bir tez sürümünü değil. Kaldı (bkz. §5 madde 8).

## 5. Kontrol edilmeli (teknik ya da anlam)

1. **Satır 159:** "yeterli değildir" cümlesi "gerçek iletimdeki yarı iletken, kapı komutlarının yanında akım yönüne de bağlıdır" diye yazıldı. Önceki cümle akım yönünün serbest dolaşım yolunu belirlediğini söylüyor, dolayısıyla anlam aynı olmalı.
2. **Satır 701:** "kutup gerilimi üç seviyeden hiçbirinde bulunmaz, filtre tarafının gerilimini izler" cümlesi "kutup gerilimi ise üç seviyeden birine bağlanmayıp filtre tarafının gerilimini izlemektedir" diye kuruldu. Bölüm 2'de seçilen "üç seviyenin dışında kalmaktadır" yerine burada bu anlatım seçildi. "Dışında" sözcüğü gerilimin seviyelerin aralığını aştığı izlenimini verebiliyordu. Bölüm 4'teki anlatımla birlikte okunmalı.
3. **Satır 364:** "seçimin şebeke frekansıyla ilgisi yoktur" yerine "Seçim, şebeke frekansından bağımsız olarak kazanç geçiş frekansına dayanmaktadır" yazıldı. Bilgi aynı: \SI{60}{Hz}, \SI{586}{Hz}'in onda biri. Jürinin \SI{60}{Hz}'i şebeke frekansı sanmaması amacı korunuyor.
4. **Satır 695:** "dış anahtarların iletim kaybı anahtar başına yaklaşık \SI{1.37}{W}, anahtarlama kaybı \num{0.65}--\SI{0.66}{W}" ifadesinde anahtarlama kaybının da anahtar başına olup olmadığı özgün metinde de belirsizdi. Aynı cümlede tutuldu. Sayılarla doğrulanması önerilir: 2×1,37 + 2×0,66 + 2×0,41 + 2×0,63 ≈ 6,1 W ve 11,56 + 6,1 ≈ 17,7 W, toplam 18,94 W ise. Anahtarlama kaybının toplamın yaklaşık %7'si olması (≈ 1,3 W) anahtar başına okumayla tutarlı.
5. **Satır 645:** "verim değişiminin gerçekten ters enerji dolaşımı ... ile ilişkili olup olmadığını sınamak" → "... ilişkisini sınamak". "gerçekten" dolgu sözü olarak çıkarıldı. İddia gücü aynı kalmalı.
6. **Satır 434:** "S4 akım denetleyicisinin yapısı Alt Bölüm~\ref{sec:s4-kapali-cevrim} içinde verilmiştir" yan cümlesi gönderme kuralıyla kaldırıldı. S4 denetleyici değerleri Tablo `tab:sistem-parametreleri` ve satır 364'teki tek göndermede duruyor. Okur yapıyı bulamazsa satır 364'teki gönderme yeterli olmalı.
7. **Satır 7:** "örnekleme gecikmesi ise kararlılık analizinde ayrıca ele alınır" → "... ayrıca ele alınmıştır". Kip birliği için geçmiş zaman seçildi, çünkü analiz Bölüm 5'te yapılmış. Anlam değişmiyor.
8. **Satır 552:** "Kaynak belgelerde görülen \SI{200}{µH} ve \SI{400}{µH} değerleri daha erken tarihli parametre notlarına ... aittir." Kural 10'un kapsamında değil (tez sürümü değil, kaynak belge). Ancak jüri açısından gereksiz bulunursa fazlalık incelemesinde değerlendirilebilir. Bu görevde içerik çıkarılmadı.
9. **Satır 81 ve 90 (`\caption`):** İlk cümleler kısaldığı için Şekil Listesi'ndeki girdiler de kısaldı. İstenirse `\caption[kısa]{uzun}` biçimi ayrıca düşünülebilir. Biçim kilidi nedeniyle eklenmedi.

## 6. Kalan noktalı virgüller

- **Düz metin ve `\caption`:** 0.
- **Tablo hücreleri:** 98. Hepsi değer, kaynak ya da bağlantı sıralaması. Kural 2'nin ve görev tanımının izin verdiği teknik sıralamalar:
  - **Değer listeleri:** senaryo başına değerler (S1 …; S2 …; S3 …, satır 466, 468, 471, 520–522, 542) ve cihaz parametreleri ($V_f$ …; $r_F$ …; $Q_{rr}$ …, satır 509–512). Sayısal çözüm ayarları (satır 540–541) ve doğrulama tablosunun sonuç sütunu (satır 673, 676, 678) da bu gruba girer.
  - **İç öğelerinde virgül bulunan sıralamalar:** örneğin satır 459 "Üç faz, dört telli; nötr hattı …" ve satır 476 "AMC1200, 12 bit ADC; ofset …, ADC referansı …". Benzerleri satır 490, 503, 507, 518, 529, 531, 533, 543 ve 606'da.
  - **"Kaynak" sütununda birden çok kaynağın ayrılması:** örneğin "Parametre dosyası (\texttt{L1}); tam topoloji şeması". Bu kullanım bütün tabloda tutarlı. Değiştirilirse sütunun okunuşu bozulur.
  - **Yarı iletken eşleme tablosunda uç bağlantıları:** "C: DA$+$; E: dış orta düğüm", satır 570–576.
- Tablo hücrelerindeki cümle düzeyi noktalı virgüller bölündü: satır 151, 497, 524, 545, 601 ve 675. Satır 674'teki "S4 $=$ S3 $+$ … geri beslemesi; önce P (…), sonra PI" iç virgüllü bir sıralama olduğu için kaldı.
