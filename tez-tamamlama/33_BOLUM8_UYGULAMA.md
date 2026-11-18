# Bölüm 8 düzeltmelerinin uygulanması (rapor 31 ve 32)

- **Tarih:** 19.11.2026
- **Onay:** tez sahibi. Rapor 31'in bütün Yüksek ve Orta maddeleri A seçenekleriyle uygulandı. Düşük maddelerden yalnız görevde sayılanlar uygulandı. [HESAP] ve [YENİ SAYI] seçenekleri uygulanmadı. `\kirmizinot` eklenmedi. Altyazıya cümle eklenmedi.
- **Değişen dosyalar:**
  - `yeni_tez/bolumler/08-sonuc.tex` (129 → 142 satır, satır artışı tablo kodunun bölünmesinden)
  - `yeni_tez/bolumler/01-giris.tex` (01:33, 01:34, 01:44)
  - `yeni_tez/onkisim/ozet.tex` (iki ifade)
  - `yeni_tez/onkisim/summary.tex` (aşım ve yerleşme)
  - `yeni_tez/bolumler/02-literatur.tex:377`, `yeni_tez/bolumler/04-dusuk-guc-anahtarlama.tex:167` ("senkron-buck")
- **Değişmeyenler:** deney ve benzetim sayıları. Yeni sayı girilmedi. Derleme, commit ve Ayakaleaf eşitlemesi yapılmadı.
- **Satır numaraları** dosyaların uygulama sonrası hâline aittir (08 için yeni numaralar).

## Sayımlar

| | Önce | Sonra |
|---|---:|---:|
| 08 kelime (`wc -w`, LaTeX dahil) | 2 387 | 2 192 (−195, ~%8) |
| 01 kelime | 2 065 | 2 063 |
| Özet kelime | 417 | 419 |
| Summary kelime | 1 653 | 1 653 |
| 08 `\ref` | 38 | 38 |
| 08 `\label` | 4 | 5 (+`sec:sonuc-kosullar`) |
| 08 `\cite` | 0 | 0 |
| 08 noktalı virgül (düz metin) | 0 | 0 |
| 08 tablo hücrelerinde noktalı virgül | 16 | 16 (Tablo 8.1 AS1 ve AS4 dayanak hücreleri ile Tablo 8.2 satır 2 gönderme listesi, iç öğelerinde virgül var; 13'ü patent tablosunun bilgi hücrelerinde, rapor 32 Y-3 kodu) |
| 30 kelimeyi aşan cümle | – | 0 |
| Yasak gösterme sözcüğü | 0 | 0 |

`\ref` değişimi: `chap:sistem` 2 → 1, `chap:anahtarlama` 2 → 1 (AS1 paragrafındaki gönderme cümlesi çıktı, Tablo 8.1'deki göndermeler kaldı), `tab:katki-yontem-kanit` 2 → 1 (08:45 kaldı), `sec:kalibrasyon` 2 → 3, `tab:kararlilik-marjlar` 2 → 3, `sec:sonuc-kosullar` 0 → 1. Etiket silinmedi. Bölüm 8'deki 21 `\ref` hedefinin her biri `yeni_tez/bolumler` altında tek tanımlı. `sec:sonuc-kosullar` tezde başka yerde yoktu.

## Rapor 31

### Yüksek

| Madde | Durum | Yer ve not |
|---|---|---|
| B8-H01 | uygulandı | 08:39 "verimi \%94,5 düzeyinde korumuştur". 08:140 "indirmiş, verimi \%94,5 düzeyinde korumuştur". 01:44 "verimi korumuştur" ("arttırmıştır" kalktı). Özet "yüzde 94,5 düzeyinde korumuştur". Summary "reaches 94.5 %" bir artış iddiası taşımadığı için değişmedi. |
| B8-H02 | uygulandı (A) | Tablo 8.1 AS2 (08:29): "Düşük güçte (yaklaşık 2,3 A) deney ve benzetimle yanıtlanmıştır. Orta akımda susturmalı köprünün süreksiz iletim bölgesi S4 benzetimiyle gösterilmiştir." Dayanak hücresi "orta akım için Tablo s4-tarama". |
| B8-H03 | uygulandı (A) | 08:80 son üç cümle: "Susturma düşük güç bölgesi için tasarlanmıştır. S4 benzetiminde 10 A'de süreksiz iletim THD'yi \%20 düzeyine taşımaktadır. Orta akım için tamamlayıcı anahtarlamaya akım düzeyine bağlı geçiş öngörülmüştür." |
| B8-H04 | uygulandı (A) | 08:142 cümle 3 ("Sin³ terimi, faz kolu değişikliğinin harmonik bedelini…") çıktı. Son cümleye "deney noktasında" eklendi. 08:140 cümle 2 "verim--harmonik ödünleşimi, deney noktasında Sin³ ileri beslemesiyle dengelenmektedir". |
| B8-H05 | uygulandı (A) | 08:84'teki 44 µs cümlesi çıktı. 08:126'ya iki cümle: "Analog eşdeğer çevrimin 44 µs gecikme marjı bir PWM periyodundan kısadır. Bir periyot hesaplama gecikmeli sayısal gerçeklemede LCL rezonansındaki faz payı yeniden kurulmalıdır (Tablo kararlilik-marjlar)." Rapor "aktif sönümleme gerektirmektedir" diyordu. Bölüm 5 bunu açıkça söylemediği için 05:479'daki "LCL rezonansındaki faz payı" ifadesi kullanıldı. Ardından gelen mevcut "aktif sönümleme … tasarlanmalıdır" cümlesi bağı kuruyor. |
| B8-H06 | uygulandı (A) | 08:140 son iki cümle: "…işlevlerinde yeniden görevlendiren bir enerji depolama mimarisi olarak tanımlanmıştır. Deşarj yönü deneyle, şarj zinciri benzetimle gösterilmiştir." |
| B8-H07 | uygulandı | §6.2 Yer 1 → 08:88, Yer 2 → 08:122 (aşağıda). Yer 3 uygulanmadı (görev gereği). |

### Orta

| Madde | Durum | Yer ve not |
|---|---|---|
| B8-T01 | uygulandı | Tablo 8.2 satır 1 (08:62): benzetim verimi ve benzetim THD'si çıktı. Satır 2 (08:67): "verimi 0,25 puan içinde" ve analitik \%39,96 → \%0,15 cümlesi çıktı, iki kararlılık cümlesi birleşti. Genel Sonuç (08:140): "Uygun ileri besleme katsayıları…", S3 kalibrasyon cümlesi ve S4 cümlesi çıktı. Satır 2'de \%14,8 ve $-$\%2,1 kaldı, çünkü rapor 31'in önerdiği hücre metni ikisini de içeriyor. İstenirse ikisi de çıkarılabilir (ikisi de AS3 paragrafında var). |
| B8-T02 | uygulandı | Tablo 8.1 "Kanıt türü" sütunu çıktı. 08:8 tek cümle: "…dört araştırma sorusunu yanıtlarıyla ve dayanaklarıyla eşleştirmektedir." |
| B8-T03 | uygulandı | 08:80 "Ters akım, sıfır gerilim durumu…" ve "(AS2)" cümle parçası çıktı. 08:84 tablo duyurusu ve 44 µs cümlesi çıktı. 08:88 cümle 3 Yer 1 ile kalktı. |
| B8-A01 | uygulandı | 08:4 beş sınıflı sınıflama cümlesi çıktı. |
| B8-A02 | uygulandı | 08:136 tek cümle: "Yöntemlerin elektrikli araç şarj altyapısı gibi çift yönlü uygulamalara aktarılabilirliği, T-tipi sistemde kurulan mekanizma ve ölçütler üzerine araştırılabilir." Yapay zekâ ve mikro şebeke ifadeleri çıktı. |
| B8-S01 | kısmen | 08:132 "doğrultucu/boost diyotları" → "PFC yükseltici diyotları", "izolasyon" → "yalıtım". 08:31 "çalışma modu" → "çalışma kipi". 08:128 "en yüksek/nominal güç" → "en yüksek güç". "senkron-buck → senkron alçaltıcı" tez geneli kararı uygulanmadı (görevde yok). |
| B8-Q01 | uygulandı (A) | 08:35 "iletim kaybı potansiyeli" → "iletim kaybı". Son cümle (iki bölüm göndermesi) çıktı, yerine: "Klasik anahtarlamada akımın her anahtarlama periyodunda sıfırı kesmesi, ölü zamanın akıma bağlı bir gerilim hatası üretmesine yol açmaktadır (Alt Bölüm kalibrasyon)." Kural 11 gereği paragrafta tek bölümler arası gönderme kaldı. Bölüm 3 ve 4 göndermeleri Tablo 8.1 AS1 satırında duruyor. |
| B8-Q02 | uygulandı (A) | 08:37 başına üç kısa cümle: sınır akımı tanımı (dalgalanmanın yarısı), "en çok yaklaşık 4,5 A", susturmanın etkili olduğu aralığın sınır akımıyla belirlenmesi. Yeni gönderme eklenmedi. |
| B8-Q03 | uygulandı | B8-J04 ile. |
| B8-Q04 | uygulandı | 01:34 "hücre dengeleme kiplerinde" → "batarya bazlı şarj denetimi kiplerinde". |
| B8-J01 | uygulandı | 08:84 "mevcut akım denetleyicisi" → "akım denetleyicisi". 01:33 "mevcut kapalı çevrim akım kontrolünün" → "kapalı çevrim akım denetiminin". 08:120'ye "S1--S3 deneyleri açık çevrim modülasyon referansıyla yapılmıştır." |
| B8-J02 | uygulandı (A) | 08:88'de "maliyet ile hacmin azaltılmasına" yok (Yer 1). Tablo 8.2 satır 3 hücresi rapor gereği kaldı. |
| B8-J03 | uygulandı | 08:41 "Kip değişim röleleriyle yapılan geçişin güvenliği…". 08:132 "röleli kip geçişi". 08:88 Yer 1'de RL1 yok. Bölüm 8'de "RL1" kalmadı. |
| B8-J04 | uygulandı (A) | 08:39: "Uygun katsayılar çalışma noktasıyla değişmektedir" cümlesi çıktı. S4 cümlesinden sonra: "Anma akımında üçüncü harmoniğin kaynağı, 2,3 A noktasına göre kalibre edilmiş Sin³ teriminin kendisidir. Uygun ileri besleme genliği akım düzeyine bağlıdır." `sec:sin3-yeniden-tarama` göndermesi analitik tarama cümlesine geçti. Yeni gönderme eklenmedi (05:552 `sec:kararlilik-bode` altında, paragrafın son göndermesi). |
| B8-J05 | uygulandı (A) | 08:128: "Şebeke akımı harmonikleri IEEE~1547 ve IEC~61727 standartlarının sınırlarına göre değerlendirilmelidir." Standartlar kaynakçada yok, atıf eklenmedi, sınır değeri yazılmadı. |
| B8-G01 | uygulandı | 08:128 cümle 1 "…en yüksek güç noktalarında üç fazlı çalışmayla ortak karşılaştırma yapılmalıdır." |
| B8-G02 | uygulandı | 08:128 cümle 2 "Karşılaştırma, S1, S2 ve S3 kapı mantıklarını aynı kapalı çevrim denetimiyle kapsamalıdır." |

### Ümit'in açıklaması

**Yer 1, 08:88 (GT-Tipi Mimari Katkısı paragrafının yerine):**

> GT-tipi yaklaşımın özgünlüğü, patentlerin de odak noktası olan yeniden görevlendirme ilkesidir. T-tipi eviricinin her faz hücresine iki kip değişim rölesi ve iki hızlı PFC yükseltici diyot ($D_1$--$D_2$) eklenmiştir. Şarj kipinde aynı IGBT'ler, $D_1$--$D_2$ ile birlikte bir Vienna PFC ve BYS transformatörünü besleyen iki seviyeli bir yarım köprü oluşturmaktadır. Yaklaşımın kullanım alanı, PFC, yarım köprü ve transformatör tabanlı BYS'den oluşan şarj zinciri üzerinden örneklenmiştir. Şarj zincirinin birlikte çalışması benzetimle gösterilmiştir. Yeniden görevlendirilen IGBT'ler sürücü, koruma ve soğutma altyapısının ortak kullanılmasına olanak sağlamaktadır.

**Yer 2, 08:122 (8.3'ün sonunda ayrı paragraf):**

> GT-tipi donanım deneylerde evirici kipinde çalıştırılmıştır. Tezin GT-tipi mimarideki yeniliği, literatürde yerleşik Vienna PFC ve iki seviyeli yarım köprü yapılarının aynı yarı iletkenlerle elde edilmesindedir. Şarj zincirinin deneysel doğrulaması, kendi başına proje ölçeğinde bir iş olarak gelecek çalışmalara alınmıştır.

Bölüm 7 ile denetim:
- "İki röle, iki diyot" faz hücresi başına okundu. 07:60 "Donanımda her faz hücresinde iki röle bulunmaktadır". 07:42 Vienna doğrultucusu üç fazda "altı yükseltici diyottan ($D_1$--$D_2$)", yani faz başına iki. Bölüm 7 bu okumayı doğruluyor.
- Terimler Bölüm 7'den: "kip değişim rölesi" (07:6, 07:22), "PFC yükseltici diyot ($D_1$--$D_2$)" (07:22, K-36), "şarj zinciri" (07:393).
- **Rapordan sapma:** rapor ve Ümit "bir iki seviyeli evirici" diyor. Bölüm 7 şarj kipindeki görevi "iki seviyeli yarım köprü, BYS transformatörü primer beslemesi" olarak veriyor (07:22 ve `tab:gt-eleman-gorevleri`, 07:33–35: şarjda $Q_1$--$Q_2$ iki seviyeli yarım köprü, $Q_3$--$Q_4$ Vienna PFC nötr anahtarları). Metin Bölüm 7'ye uyduruldu ("iki seviyeli yarım köprü"). Bölüm 7'de Şekil 7 altyazısında (07:263) "iki seviyeli evirici" de geçiyor. AS4 paragrafında (08:41) "iki seviyeli evirici--transformatör" ifadesi değişmedi.
- "Hızlı" sıfatı Ümit'in ifadesinden. 03:510'da $D_1$--$D_2$ DSEI2x61-12B, $t_{rr}$ = 190 ns (hızlı toparlanmalı diyot).
- Rapordaki "PFC--evirici--BYS zinciri" yerine Bölüm 7 ve 8'deki "şarj zinciri" terimi kullanıldı.
- Yer 2'de rapor metninin "Zincirin birlikte çalışması tezde benzetimle gösterilmiş…" cümlesi çıkarıldı, çünkü aynı bilgi Yer 1'de, AS4'te ve Genel Sonuç'ta var. Son cümle doğrulamanın ölçeğini ve gelecek çalışmaya alındığını tek cümlede veriyor.

### Düşük (görevde sayılanlar)

| Madde | Durum | Yer ve not |
|---|---|---|
| B8-S02 | uygulandı | Tablo 8.2 altyazısı tek cümle (08:49). Koşul cümlesi tabloyu duyuran paragrafa taşındı (08:45): "Tablodaki deney değerleri, prototipin tek faz kolunda, yaklaşık 2,3 A faz akımında, 250--280 W AA güçte ve yaklaşık 120 V şebeke geriliminde elde edilmiştir (Alt Bölüm sonuc-kosullar)." 08:118'e `\label{sec:sonuc-kosullar}`. Aynı paragraftaki "Alt kesimler, her katkının tezin sonunda ulaştığı kanıt düzeyini…" cümlesi de çıktı (kanıt düzeyi üst-anlatısı, rapor 30 §5'te açık madde). |
| B8-A03 | uygulandı | 08:92 cümle 3 (bilgilerin okunduğu kaynak) ve cümle 6 (rüçhan) çıktı. Cümle 2 "Ulusal patentler ve ulusal başvuruların rüçhanını taşıyan üç PCT başvurusu…". 08:115 tek cümle. Kaynak bilgisi tablo altyazısında ("kaynak: EK B ve EK C") duruyor. |
| B8-S04 | uygulandı | 08:90 başlık "Fikrî Mülkiyet Çıktıları". |
| B8-S03 | uygulandı | Tablo 8.1 dört hücre "yanıtlanmıştır.", AS2 ikinci cümle "gösterilmiştir." |
| B8-T05 | uygulandı | 08:126 sonundaki $L_2$/$L_1$ cümlesi çıktı. 08:128 sonunda iki cümle: "Benzetim tarafında $L_2$ şebeke ve varyak eşdeğeri doğrudan empedans ölçümüyle, $L_1$ ise doyum eğrisiyle modellenmelidir. S1 faz akımı dalga biçimi, ölçülen şebeke gerilimi harmonikleriyle birlikte yeniden değerlendirilmelidir." |
| B8-J06 | uygulandı | 08:39 "Ortalama modelde $L$, $S$ ve $T$ fonksiyonları…", "Analog eşdeğer çevrim, anma akımındaki kritik geçişte…". |
| B8-N04 | uygulandı | Özet: "eksi yüzde 2,1 genlik hatasıyla". Summary: "0.17 %", "0.43 ms". |

### Uygulanmayan rapor 31 maddeleri

| Madde | Neden |
|---|---|
| Bütün B ve [HESAP] seçenekleri (B8-H02 B, B8-J02 B) | Yeni sayı gerektiriyor, görev dışı. |
| §6.2 Yer 3 | Görev gereği. Yer 1 uygulandığı için bilgi üçüncü kez yazılmış olurdu. |
| B8-T04 | Ayrı işlem gerekmedi: Genel Sonuç'taki S4 cümlesi B8-T01 ile çıktı. |
| B8-T06 | Ayrı işlem gerekmedi: 08:142 cümle 3 B8-H04 ile çıktı. Cümle 1–2 rapor gereği kaldı. |
| B8-N01 | Ayrı işlem gerekmedi: "20–25 kW" Yer 1 ile kalktı. |
| B8-A04, B8-N02, B8-N03, B8-J07, B8-J08, B8-G04 | Görevde uygulanmaması istendi. |
| §9 adım 6 (karar defterine yazma) | Görevde yok. `01_KARAR_DEFTERI.md` değişmedi. |

## Rapor 32

| Madde | Durum | Yer ve not |
|---|---|---|
| Y-1 | uygulandı (şablona en yakın seçenek) | Tablo 8.2 `table[H]` olarak kaldı. Altyazı kısaldı. Sütunlar `p{0.17}`, `p{0.20}`, `X`, `p{0.18}` (08:53–56). B8-T01 ile üçüncü sütun da kısaldı. `longtable` dönüşümü yapılmadı. Sayfa 144 boşluğu derleme sonrası ölçülmeli. |
| Y-2 | uygulandı | B8-S02 ile. İsteğe bağlı "250–280 W"ı 8.3'e de ekleme yapılmadı (08:45'te var). |
| Y-3 | uygulandı | Patent tablosu raporun kodu: `@{}`, `p{0.15}`, `p{0.21}`, `X` iki yana yaslı değil, numaralarda ve "Bülten~2025/x"te `~`, satır aralarında `\addlinespace` (08:99–110). Sayı ve tarihler aynı. |
| O-1 | uygulandı | Tablo 8.1 (08:10–33) `\begingroup\setlength{\tabcolsep}{3pt}`, sütun başına `\footnotesize`, satır aralarında `\addlinespace`. "Kanıt türü" sütunu çıktığı için genişlikler üç sütuna yeniden dağıtıldı: `p{0.06}`, `p{0.40}`, `p{0.51}` (toplam 0,97\textwidth + 4 × 3 pt ≈ 410,8 pt, metin genişliği 411,1 pt). |
| O-2 | uygulandı | 08:21 "(devamı)". |
| O-3 | uygulandı | 08:28 "chap:sistem}'teki", "chap:anahtarlama}'teki". 08:35'teki aynı ekler cümleyle birlikte kalktı. Tablo 8.2 göndermesi ('te → 'de) cümleyle birlikte kalktı (B8-T03). |
| O-4 | uygulandı | 08:31 "çalışma kipi ve doğrulama tabloları". "(çalışma modları, güvenli kip geçişi)" sütunla birlikte kalktı. Bölüm 8'de "mod" kalmadı. |
| O-5 | uygulandı | 08:70 `\mbox{T-tipi}`. Dördüncü sütunda yer listesinden sonra `\newline`, tür bölümü noktayla bitiyor (08:63, 08:68, 08:73). İsteğe bağlı kararlılık cümlesi birleştirmesi B8-T01 ile yapıldı ("…kaldığı için analog eşdeğer çevrimin kararlılık marjlarını korumaktadır (faz marjı \SI{54}{\degree}, kazanç marjı \SI{35}{\decibel})"). "senkron-/buck" `\mbox` önerisi uygulanmadı (rapor kabul edilebilir diyor). |
| D-1 | yalnız Bölüm 8 | 08:39 ve 08:67 `$54^{\circ}$` → `\SI{54}{\degree}`. Bölüm 8'de `^{\circ}` kalmadı. Öteki bölümler değişmedi. |
| D-2 | uygulandı | Tablo 8.1 AS3: "Şekil fig:sin3-yeniden-tarama, Tablo s4-tarama, kararlilik-marjlar, kararlilik-olcum ve kalibrasyon-karsilastirma" (5.2, 5.2, 5.4, 5.6, 6.12). AS2: "Tablo deney-dusuk-guc-ozeti ve kalibrasyon-karsilastirma, orta akım için Tablo s4-tarama". Tablo 8.2 satır 1: "Alt Bölüm s1-s2-kalibre, Bölüm deney, Tablo s4-tarama ve kalibrasyon-karsilastirma" ("ve" sona alındı). Satır 2: "Alt Bölüm sin3-yeniden-tarama, s4-kapali-cevrim, kararlilik-bode, kalibrasyon" (5.3, 5.6, 5.7, 6.10), "Tablo kararlilik-marjlar, kalibrasyon-karsilastirma". Tek biçim olarak "Tablo~X, Y" kısaltması seçildi. Numaralar etiketlerin kaynaktaki sırasından çıkarıldı (derleme yapılmadı). |
| D-8 | uygulandı | `02-literatur.tex:377`, `04-dusuk-guc-anahtarlama.tex:167` "senkron-buck benzeri". Tezde tiresiz "senkron buck" kalmadı. |
| D-3 | uygulandı | Y-3 kodunda. |
| D-4, D-5, D-6, D-7, D-9 | uygulanmadı | Görevde yok. Altyazı "(kaynak: EK B ve EK C)" ve "soru--kanıt--sonuç" sırası değişmedi. |

## Doğrulanan sayılar ve kaynak satırları

| Büyüklük | Bölüm 8'deki yeri | Kaynak |
|---|---|---|
| Sınır akımı en çok yaklaşık 4,5 A, dalgalanmanın yarısı | 08:37 | 04:11 ("sınır akımı … en çok yaklaşık 4,5 A", "ortalama endüktör akımı dalgalanmanın yarısından küçük kaldığında"), 05:333 ("anlık akımın mutlak değeri yaklaşık 4,5 A'in altına indiği") |
| S2→S3 verim: \%94,5 düzeyinde korunur, DA belirsizliği ±0,5 puan | 08:39, 08:140, 01:44, Özet | 06:407 ("verimi \%94,5 düzeyinde korurken"), 06:276 |
| Anma akımında üçüncü harmoniğin kaynağı Sin³ terimi, $K_{34}$ 2,3 A'e kalibre | 08:39 | 05:552 |
| L, S, T ortalama modelde aynı | 08:39 | 05:590 |
| 54° faz marjı, +35 dB kazanç marjı (anma akımı, analog eşdeğer) | 08:39, 08:67 | 05:446 (Tablo kararlilik-marjlar, A/PI), 05:590 |
| 44 µs gecikme marjı | 08:126 | 05:590 ("44 µs"), 05:446 (44,4), 05:479 |
| PWM periyodu 100 µs (44 µs < 1 periyot), (B) bir periyot hesaplama gecikmesi | 08:126 | 04:11 ($T_s$ = 100 µs), 05:479 ("(B2)'de 100 µs"), 05:484 altyazısı ("Bir periyot hesaplama gecikmeli durumda (B)") |
| LCL rezonansında faz payı gecikmeyle belirlenir | 08:126 | 05:479 ("Toplam çevrim gecikmesi, LCL rezonansındaki faz payını belirleyen tasarım büyüklüğüdür") |
| 10 A'de THD \%20 düzeyi (S4) | 08:80 | 05:588 |
| PI 25 A genlik hatası $-$\%2,1 | 08:39, 08:67, Özet | 05:552, 05:588 |
| Basamak aşımı \%0,17, yerleşme 0,43 ms | Summary | 05:350, 05:352 (Tablo s4-basamak), 05:588 |
| S1–S3 deneyleri açık çevrim | 08:120 | 03:345 ("Laboratuvar deneyleri (S1--S3) açık çevrim modülasyon referansıyla yürütülmüştür"), 05:220 |
| 2,3 A, 250–280 W, 120 V, tek faz kolu | 08:45 | eski 08:44 altyazısı, 06:489–491 (249,6 W ve 281,2 W), 01:55 |
| Ölü zamanın akıma bağlı gerilim hatası (S1, akım her periyotta sıfırı kesiyor) | 08:35 | 06:552 (`sec:kalibrasyon` altında) |
| Faz hücresi başına iki röle | 08:88 | 07:60 |
| Faz başına iki PFC yükseltici diyot (üç fazda altı) | 08:88 | 07:42 |
| $D_1$--$D_2$ hızlı toparlanmalı ($t_{rr}$ = 190 ns) | 08:88 | 03:510 |
| Şarjda $Q_1$--$Q_2$ iki seviyeli yarım köprü, $Q_3$--$Q_4$ Vienna PFC | 08:88, 08:122 | 07:22, 07:33–35 (`tab:gt-eleman-gorevleri`) |

## Kuşkulu kalan cümleler

- **08:35** "Klasik anahtarlamada akımın her anahtarlama periyodunda sıfırı kesmesi, ölü zamanın akıma bağlı bir gerilim hatası üretmesine yol açmaktadır." AS1'in harmonik sorusuna dolaylı yanıt veriyor. Kaynak cümle (06:552) iç empedansı açıklıyor, harmonikten söz etmiyor.
- **08:80** "Orta akım için tamamlayıcı anahtarlamaya akım düzeyine bağlı geçiş öngörülmüştür." Bölüm 5 (05:333) iki seçenek veriyor: tamamlayıcı anahtarlamaya dönüş ya da akıma göre ayarlanan ileri besleme. Cümle birini öne çıkarıyor. 08:126 ikisini de tasarlatıyor.
- **08:88** "…patentlerin de odak noktası olan yeniden görevlendirme ilkesidir." ve "iki hızlı PFC yükseltici diyot". Kaynakları Ümit'in açıklaması. Patent metinleriyle tezde ayrıca bağ kurulmuyor.
- **08:88 / 08:122** "iki seviyeli yarım köprü": Ümit "iki seviyeli evirici" diyor. Bölüm 7'nin tablosuna uyuldu. Tez sahibi Ümit'in sözcüğünü isterse iki yerde "iki seviyeli evirici" yazılabilir (07:263 altyazısı da öyle diyor).
- **08:122** "Şarj zincirinin deneysel doğrulaması, kendi başına proje ölçeğinde bir iş olarak gelecek çalışmalara alınmıştır." Ümit'in "çok uzun bir proje" gerekçesinin olumlu kurgusu. "iş" sözcüğü akademik metinde biraz gündelik kalabilir ("çalışma" bir sonraki "çalışmalara" ile yinelendiği için seçilmedi).
- **08:126** "Bir periyot hesaplama gecikmeli sayısal gerçeklemede LCL rezonansındaki faz payı yeniden kurulmalıdır." Raporun önerdiği "aktif sönümleme gerektirmektedir" yerine yazıldı. Yeni teknik iddia olmasın diye.
- **08:39 / 08:41 / 08:88 / 08:122 / 08:140** Şarj yönünün benzetimle gösterildiği bilgisi dört yerde geçiyor (AS4, Yer 1, Genel Sonuç; Yer 2 yalnız deney yönünü veriyor). Her biri farklı işlev görüyor (soru yanıtı, katkı, genel sonuç). İstenirse Yer 1'in "Şarj zincirinin birlikte çalışması benzetimle gösterilmiştir." cümlesi çıkarılabilir.
- **01:44** "mevcut akım çevriminin modülasyon girişine": B8-J01 ile aynı sorun ("mevcut"). Görevde yalnız 01:33 sayıldığı için dokunulmadı.
- **Tablo 8.2 satır 2 (08:67)** \%14,8 ve $-$\%2,1 benzetim sayıları rapor 31'in hücre önerisi gereği kaldı. "Katkı tablosu yalnız deney sayılarını versin" ilkesine sıkı uyulacaksa iki cümle de çıkarılabilir.

## Derleme sonrası denetlenecekler

- Tablo 8.1 küçük yazıyla kaç sayfa tutuyor, nerede bölünüyor. "Soru" sütunu (0,06\textwidth) "AS1" ve kalın "Soru" için yeterli mi.
- Tablo 8.2 basılı s. 144'e sığıyor mu (Y-1). Sığmazsa rapor 32'deki `longtable` biçimi.
- Patent tablosunda "Bülten~2025/x" ve numaraların satır sonunda bölünmemesi.
- `\SI{54}{\degree}` Times yazı tipinde basılıyor mu.
- Tanımsız gönderme olmamalı (`sec:sonuc-kosullar` yeni).
