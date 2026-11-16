# Bölüm 2 (Literatür) yazım düzenlemesi

- **Dosya:** `yeni_tez/bolumler/02-literatur.tex` (445 satır, satır sayısı değişmedi). Başka dosyaya dokunulmadı.
- **Görev kipi:** uygula (`.claude/agents/tez-yazim-editoru.md`, kural 1–9).
- **Tarih:** 16.11.2026
- **Örnek alınan üslup:** Bölüm 1'in sonuçlanmış hâli (`01-giris.tex`), raporlar 07 ve 09.
- Derleme ve commit yapılmadı. 65 satır değişti: 49'u düz metin paragrafı, 4'ü `\caption`, 12'si karşılaştırma tablosu (Tablo `tab:literatur-karsilastirma`) satırı.

## 1. Önce/sonra sayımları

Sayım betiğiyle yapıldı. TikZ blokları, `%` yorumları ve yalnız komut içeren satırlar dışarıda bırakıldı. Cümleler `. ? !` işaretinden bölündü. `\cite` ve `\ref` birer sözcük, `$...$` tek sözcük sayıldı. "Düz metin" yalnız paragrafları kapsar. "Metin + başlık" sütununa `\caption` metinleri de eklenmiştir.

| Ölçüt | Önce (HEAD) | Sonra |
|---|---:|---:|
| Cümle sayısı, düz metin / metin + başlık | 193 / 216 | 249 / 275 |
| Ortalama cümle uzunluğu, düz metin / metin + başlık | 19,8 / 18,8 kelime | 15,5 / 15,0 kelime |
| 30 kelimeyi aşan cümle | 18 | **0** |
| 25 kelimeyi aşan cümle | 44 | 14 |
| En uzun cümle | 46 kelime | 30 kelime (satır 8, terim sıralaması) |
| Noktalı virgül, düz metin | 34 | **0** |
| Noktalı virgül, başlık ve tablo dahil | 61 | **0** |
| Geniş zamanla biten fiilli yüklem (düz metin + başlık) | 53 | **0** |
| "-ebilir/-emez" ile biten cümle (kural gereği değişmez) | 16 | 18 |
| Yasak gösterme sözcüğü | 0 | **0** |
| `\label` / `\ref` / `\eqref` / `\cite*` | 20 / 32 / 3 / 79 | 20 / 32 / 3 / 79 |

**Yöntem farkı.** Görevi veren oturumun ölçümü 310 cümle, 16,6 ortalama, 28 uzun cümle ve yaklaşık 70 geniş zaman bulmuştu. Bu betik tablo hücrelerini ayrı birim saydığında 475 cümle ve 10,2 ortalama buluyor. Yalnız düz metni saydığında ise yukarıdaki değerler çıkıyor. Değerler arasındaki fark birim seçiminden geliyor. Önce/sonra karşılaştırması aynı betikle yapıldığı için tutarlıdır. Geniş zaman sayısındaki fark da sezgisel arama yönteminden kaynaklanıyor: önceki sayım tablo hücrelerindeki "Var" sözcüklerini ve "-ebilir" biten cümleleri de sayıyordu.

**Bütünlük denetimi (betikle, HEAD'e karşı):**
- 79 `\cite`/`\citep`/`\citet` komutunun her birinin anahtar kümesi, sırası da dahil olmak üzere aynı kaldı. Anahtar kaybı yok.
- `\ref`/`\eqref` dizisi (35), `\label` dizisi (20), `$...$` matematik dizisi, `\SI{}{}` dizisi (34) ve `%` yorum satırları birebir aynı. Bölümde `\umitnot` yok.
- TikZ blokları (`diff`) birebir aynı.
- Yasak sözcük taraması (`grep -i -w`, TikZ ve yorum dışı, gösterme sıfatı "o" dahil): 0.

## 2. Yapılan değişiklik türleri

1. **Noktalı virgül (kural 2):** 61'in hepsi kaldırıldı.
   - Düz metindeki 34 noktalı virgül iki cümleye bölündü ya da "ancak", "ise", "ve", "-ken" ile yeniden kuruldu. Özneden sonra gelen gereksiz noktalı virgüller ("ömrü;", "manyetik bağ;") yükleme bağlandı.
   - Başlıklardaki 4 noktalı virgül cümleye bölündü (Şekil `batarya-omur-guvenlik`, `ticari-evirici-thd`, `de-ccm-akim`).
   - Karşılaştırma tablosunda iki tür vardı. "Yapı ve odak" sütunundaki "yapı; odak" ayırıcıları "yapı (odak)" biçimine çevrildi, örneğin "Senkron buck (diyot benzetimi ve sürekli iletim)". "Tez açısından kalan sınır" sütunundaki cümle düzeyi noktalı virgüller iki cümleye bölündü.
2. **Uzun cümle (kural 3):** 30 kelimeyi aşan 18 cümlenin hepsi bölündü. Dört sınır cümle (30 kelime) de ayrıca bölündü. Bunlar Hizarci, Wang 2024 ve Le 2019 cümleleriydi. Çözülen ortaç zincirleri:
   - Haghbin cümlesi (46 kelime) üç cümleye ayrıldı.
   - Dong cümlesi (44) üç cümleye ayrıldı.
   - "Tezlerin ortak yapısı ... kuran, ... sınayan ve ... sunan bir akıştır" cümlesi bölündü.
   - Araştırma boşluğu sav cümlesi (44) bölündü. İki nokta ve noktalı virgüllerle kurulu bu cümle üç ad cümlesine dönüştü ("Savın ilk bileşeni ...").
3. **Kip birliği (kural 9):** 53 geniş zaman yüklemi "-mektedir/-maktadır" kipine çevrildi. Geçişlilik korundu, örneğin "neden olur" → "neden olmaktadır", "akar" → "akmaktadır", "iner" → "inmektedir". Art arda dörtten fazla "-mektedir" oluşan yerlerde bazı cümleler ad cümlesine ya da geçmiş zamana çevrildi:
   - Satır 52: "... aktarılması anlamına gelir" → "... aktarılmasıdır".
   - Satır 161: "temel sınırlılıklarını oluşturur" → "temel sınırlılıklarıdır".
   - Satır 192: "Çok seviyeli dönüştürücüler ... amaçlar" → "Çok seviyeli dönüştürücülerin amacı ... azaltmaktır".
   - Satır 225: "yüzey oluşturur" → "yüzeyidir". "... ışınımı gösterir" → "... ışınımdır".
   - Satır 227: "ifade etmektedir" → "bir değerdir".
   - Satır 286: "destekler" → "destekleyen bir bulgudur".
   - Satır 319: "gerekçelendirir" → "gerekçesidir".
   - Satır 321: "dayanır" → "dayalıdır".
   - Satır 383: "ortak bir ilkeye dayanır: ..." → "Dört çalışmanın ortak ilkesi ...dir". "belirlenir" → "bağlıdır".
   - Satır 441: "incelemektedir" → "Üçüncü kümenin konusu ...dir". "göstermektedir" → "göstermiştir".
   - Satır 323: "göstermektedir" → "göstermiştir" (dış literatür bulgusu).
   - Betikle denetlendi: hiçbir paragrafta üçten fazla art arda "-mektedir" yok.
   - Yeni "değildir" yapısı üretilmedi. Var olan "... değil, ...dir" karşıtlıkları korundu. Satır 385'teki "denetleyicisi yapmaz" cümlesi Bölüm 1'deki gibi "... bağımsız bir geri besleme denetleyicisi değil, bir kompanzasyon bileşenidir" biçiminde kuruldu.
4. **Terim birliği (kural 5, Bölüm 1 ile uyum):**
   - "kontrolcü" → "denetleyici" (satır 387).
   - "akım kontrol döngüsü" ve "akım döngüsü" → "akım çevrimi" (satır 375, 387).
   - Tabloda "İlaveli" → "İlave" (satır 435).
   - Başlıkta geçtiği için "Şebeke Akım Kontrolü" ve "şebeke akım kontrolü" olduğu gibi bırakıldı. Standart terim olduğu için "Faz kilitlemeli döngü (PLL)" de bırakıldı.
5. **Küçük açıklık düzeltmeleri:**
   - Satır 391: "Tez, bir özet rapor ile ..." öznesi tezin kendisiyle karışabiliyordu. Cümle "Kerekes'in tezi, ..." diye yazıldı.
   - Satır 286: rakamla başlayan cümle "Kayıttaki \SI{5}{kW} sınıfı ..." ile başlatıldı.
   - Satır 379: "yalnızca X değil; Y" → "X'in yanında Y'nin de".

Sayılar, birimler, kaynak sırası, `\cite`/`\citep`/`\citet` yerleri ve iddia gücü değişmedi. Bölünen cümlelerde atıf, özgün cümlenin sonundaki yerinde, yani bölünmüş son parçanın sonunda kaldı. Başlık yapısı, kesim sırası ve paragraf sınırları korundu.

## 3. Olumlu yazım (kural 8)

**Tezin kendi aleyhine konuşan ve olumlu yazılan cümleler:**

| Satır | Önce | Sonra |
|---|---|---|
| 76 | "... temsilî ilişkileri gösterdiğinden tasarım sınırı olarak kullanılmamalıdır." | "... literatürden uyarlanmış temsilî ilişkileri göstermektedir. Eğriler, belirli bir hücre kimyasının veri sayfası yerine nitel başvuru olarak kullanılmaktadır." |
| 148 | "``doğrudan'' ifadesi bir ömür kazancı yüzdesi değil, hücrenin güç yoluna ayrı ayrı müdahale edilebilmesini tanımlar." | "``doğrudan'' ifadesi, hücrenin güç yoluna ayrı ayrı müdahale edilebilmesini tanımlamaktadır." Ardından gelen "Sayısal ömür artışı ise ... ileri sürülebilir" cümlesi korundu ve aynı sınırı olumlu biçimde veriyor. |
| 387 | "... Sin³ teriminin kontrolcü olarak adlandırılması değil; ... açıkça doğrulanmasıdır." | "... Sin³ terimine denetleyici adı vermek değil, terimin ... etkisini açıkça doğrulamaktır." (Anlam aynı. Yalnız noktalı virgül ve terim düzeltildi.) |

**Literatür değerlendirmesi olarak korunan sınırlılık cümleleri** (anlam aynı, yalnız dil sadeleştirildi). Bu cümleler araştırma boşluğunu gerekçelendirdiği için kaldı:
- Satır 161: pasif dengelemenin temel sınırlılıkları.
- Satır 163, 165, 167: kapasitif, endüktif ve transformatörlü yapıların bedelleri.
- Satır 205: karşılaştırma ölçütlerinde düşük akımın yer almaması.
- Satır 207: çalışmaların düşük akım mekanizmasını merkeze almaması.
- Satır 369: süreksiz iletim bilgisinin T-tipi etkisini tek başına açıklamaması.
- Satır 443: "ele alınmamıştır" boşluk cümleleri.
- Karşılaştırma tablosunun "kalan sınır" sütunu.

Tezin kendi bulgularına ilişkin motivasyon cümleleri (satır 211, 227, 288, 321, "motivasyon amaçlı gözlem kaydı" başlıkları) zaten olumlu kurulduğu için değiştirilmedi.

## 4. Kontrol edilmeli (teknik ya da anlam)

1. **Satır 227, sayı tutarlılığı:** Metinde "İlk iki güç sınıfında toplam 34 nokta" yazıyor. Tablo `tab:fv-guc-dagilimi` ise 34 noktayı tek sınıfta (0–10 %) veriyor. Şekil (c) panelinde daha ince sınıflar (ör. 0–5 ve 5–10) varsa metin doğrudur. Yoksa "İlk güç sınıfında" olmalıdır. Metin değiştirilmedi.
2. **Satır 325, "açık tutulursa":** Türkçe güç elektroniğinde "açık" hem iletimde hem kesimde anlamına gelebiliyor. Kastedilen iletimde tutmaktır. Bölüm 1 "iletimde tutulursa" kullanıyor. Kural 4 gereği değiştirilmedi. "iletimde tutulursa" önerilir.
3. **Satır 192, NPC kısaltması:** "NPC" ikinci cümlede kullanılıyor, açılımı ("Neutral Point Clamped") ise paragrafın son cümlelerinde veriliyor. Bu sıra özgün metinde de vardı. Açılımın ilk geçtiği yere alınması önerilir.
4. **Satır 371, yeniden kurulan cümle:** "kutup gerilimi üç seviyeden hiçbirinde bulunmaz" cümlesi "kutup gerilimi üç seviyenin dışında kalmaktadır" diye yazıldı. Fiziksel anlam aynı olmalı: akım söndüğünde ve anahtar sürülmediğinde kutup gerilimi çıkış ya da şebeke tarafındaki gerilimi izler. Bölüm 4'teki anlatımla tutarlı olup olmadığına bakılmalı.
5. **Satır 381, Le ve Itoh:** "... görev oranıyla, endüktans değerinden bağımsız biçimde kompanze etmiştir" ifadesi iki cümleye ayrıldı: "Kompanzasyon, bir önceki hesaplama periyodunun görev oranını kullanmakta ve endüktans değerinden bağımsızdır." Kaynağın iddiasıyla örtüşüp örtüşmediğine bakılmalı.
6. **Satır 383:** "Katsayı değeri, çalışma noktasına göre belirlenir" cümlesi "Katsayı değeri çalışma noktasına bağlıdır" diye yazıldı (kip hafifletmesi). Bölüm 5'te katsayının çalışma noktasına göre kalibre edildiği anlatılıyorsa anlam aynıdır.
7. **Tablo satır 413:** Wang 2020 tabloda "çekiş eviricisi" diye nitelenmiş, metinde (satır 205) ise yalnız "\SI{250}{kW} SiC T-tipi evirici" geçiyor. Kaynakla tutarlılığına bakılmalı. Değiştirilmedi.
8. **Satır 323:** "Saha ve laboratuvar ölçümleri ... göstermektedir" cümlesi, art arda dört "-mektedir" zincirini kırmak için "göstermiştir" diye yazıldı. Dış kaynak bulgusu olduğu için geçmiş zaman uygun görüldü.

## 5. Kalan noktalı virgüller

Yok. Düz metinde, başlıklarda ve tablolarda 0. Kural 2'nin izin verdiği tablo istisnasına da gerek kalmadı. "Yapı ve odak" sütununda iç öğelerinde virgül bulunan iki hücre (De Gussemé ve Schweizer karşılaştırması) parantezle çözüldü.

## 6. Kalan geniş zaman benzeri sonlar (gerekçeli)

Fiilli geniş zaman yüklemi kalmadı. Aşağıdaki 18 cümle, kural 9'un "değişmeyenler" maddesine göre olasılık ya da yeterlilik kipinde bırakıldı:

| Satır | Son | Gerekçe |
|---|---|---|
| 50 | bulunabilir | olasılık "-ebilir" |
| 50 | ihmal edilemez | yeterlilik olumsuzu ("-ebilir" ile aynı kip) |
| 148 | ileri sürülebilir | olasılık |
| 150 | sınırlandırabilir | olasılık |
| 163 | sağlayabilir, uzatabilir | olasılık |
| 167 | sağlayabilir | olasılık |
| 194 | sağlayabilir | olasılık |
| 211 | gerekçelendirilebilir | olasılık |
| 325 | açıklanabilir, oluşturabilir | olasılık |
| 369 | gösterebilir | olasılık |
| 375 | çözülemez | yeterlilik olumsuzu |
| 375 | azaltabilir, kullanılabilir | olasılık. Noktalı virgül bölününce iki cümle oldu (bu yüzden 16 → 18). |
| 377 | zayıflatabilir | "zayıflatabilmesine karşılık ... oluşturur" yapısı bölününce oluştu |
| 387 | değiştirmeyebilir, kullanılabilir | olasılık |

Tablo hücrelerindeki "Var" sözcükleri ve "Tez açısından kalan sınır" başlığı, sayım betiğinde yalnız biçimce geniş zamana benzedikleri için çıkıyor. Bunlar yüklem değildir.
