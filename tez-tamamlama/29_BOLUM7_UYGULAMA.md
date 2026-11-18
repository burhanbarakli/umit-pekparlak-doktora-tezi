# Bölüm 7 düzeltmelerinin uygulanması (rapor 27 ve 28)

- **Tarih:** 18.11.2026
- **Onay:** tez sahibi. Gerçek hatalar, çelişkiler, aşırı iddialar, şekil/tablo, altyazı, boşluk ve tekrar düzeltilir. Küçük sayı farkları bırakılır. `\kirmizinot` eklenmez. [HESAP]/[YENİ SAYI] maddelerinde yalnız yeni sayı gerektirmeyen A seçeneği.
- **Değişen dosyalar:** `yeni_tez/bolumler/07-gt-tipi-mimari.tex` (419 → 394 satır). `yeni_tez/bolumler/08-sonuc.tex` 08:119 sonuna bir gelecek çalışma cümlesi (B7-A03).
- **Değişmeyenler:** deney ve benzetim sayıları, tablo sayı hücreleri, şekil dosyaları. Derleme (tez bütünü) ve commit yapılmadı.
- **Sayımlar (07):** `\label` 35 → 33 (yalnız rapor 27 §4'ün çıkarılabilir dediği `eq:gt-soc-guncelleme` ve `eq:gt-roundtrip-verim`, denklemleriyle birlikte, dış gönderme yok), `\ref` 55 → 43, `\eqref` 4 → 2, `\cite` 7 → 4, `\includegraphics` 14 → 14, `\kirmizinot` 1 → 0. Bütün `\ref` hedefleri `yeni_tez` altında tek tanımlı. Ayraç ve ortam dengesi tutuyor. Düz metinde ve tablo hücrelerinde noktalı virgül kalmadı. Yasak gösterme sözcüğü yok.
- **TikZ denetimi:** Şekil 7.7 ve 7.8 tek başına `lualatex` ile (article + geometry 145 mm metin alanı + TeX Gyre Termes + tikz, `\small` = 10/11,5 bp) derlendi, PyMuPDF ile PNG'ye işlenip gözle denetlendi. Kesişme ve binme yok, ikisi de metin alanına sığıyor. Kırpılan sekiz ekran görüntüsünün kırpma değerleri de aynı yolla (graphicx `trim/clip`) denetlendi. Dosyalar: `/private/tmp/claude-501/-Users-bob-CALISMALAR--mit-abi-tez-yazimi-manuel-kontrol-ayakaleaf/1fc9a723-a9bc-4d46-bec5-6e3d30f64760/scratchpad/b7tikz/`.

## Rapor 27

| Madde | Durum | Not |
|---|---|---|
| B7-T01 | uygulandı (Bölüm 7) | 07:8 kaldı. 07:348 paragrafı, 07:383 ilk dört cümle ve 07:415 cümle 4–5 çıktı. 07:383 tablo duyurusuna indi. 07:371 hücresi kaldı. 08:80 uygulanmadı (Bölüm 7 dışı, gelecek çalışma değil). |
| B7-T02 | uygulandı | 07:13 cümle 4–5 çıktı, atıflar son cümleye taşındı. 07:354 tek cümle oldu (Bölüm 2'nin ilgili kesiminde etiket yok, `chap:literatur` göndermesi kullanıldı). |
| B7-T03 | uygulandı | 07:15 cümle 2 ve 07:376 cümle 2 çıktı. 07:415/419 T05 ile kısaldı. |
| B7-T04 | uygulandı | 07:186 cümle 3 denklem giriş cümlesiyle birleşti. 07:417 son cümle çıktı. |
| B7-T05 | uygulandı | Değerlendirme iki kısa paragrafa indi: tanım ve devre düzeyi, denklemler ve kanıt (J01 biçimi). Kip listesi ve üst-anlatı cümleleri çıktı. |
| B7-T06 | uygulandı | Güç tabanı yalnız 07:15'te kaldı. 07:4 "Deney düzeneği GT-tipi olarak kurulmuştur." 07:378 ve 07:415 parantezleri çıktı. |
| B7-T07 | uygulandı | 07:4 son iki cümle tek cümle oldu ("faz hücresi röleleri, PFC yükseltici diyotları ve BYS transformatörleri"). BYS açılımı çıktı. |
| B7-T08 | uygulandı | 07:8 son cümle, 07:140 son cümle (kısa tablo duyurusu), 07:266 cümle 3, 07:348 cümle 2, 07:383 "İki kanıt grubu…" cümlesi çıktı. |
| B7-T09 | uygulandı | 07:51 ve 07:97 son cümleleri çıktı. |
| B7-T10 | uygulanmadı | Rapor isteğe bağlı bırakıyor. Sütun kaldı. |
| B7-A01 | uygulandı | 07:17 IEC cümleleri tek cümle oldu. 07:261 paragrafı çıktı, tablo duyurusu 07:238 sonuna (tablodan önce) alındı. |
| B7-A02 | uygulandı (A) | SoC paragrafı ve denklemi çıktı. Doğrulama matrisinde "CC--CV algoritması, sıcaklık sınırları". |
| B7-A03 | uygulandı | 07:378 ve gidiş–dönüş verimi denklemi çıktı. 08:119'a tek gelecek çalışma cümlesi eklendi. 07:419 yöntemsel temel cümlesi çıktı. |
| B7-A04 | kısmen | Sütun başlığı "Kabul ölçütü" (J13 ile). Tablo kısaltılmadı (isteğe bağlı). |
| B7-S01 | uygulandı | Şekil 7.6 altyazısı tek cümle. Q3/Q4 bilgisi 07:88 sonuna metin cümlesi olarak girdi ("şekilde NOTR"). |
| B7-S02 | kısmen | Bölüm 7'de tek ad: "PFC yükseltici diyotları ($D_1$--$D_2$)" (07:4, 07:22, 07:42, 07:376, Değerlendirme). 03:24 ve 08:119 dokunulmadı (bölüm dışı). |
| B7-S03 | kısmen | kip/mod: iki kesim başlığı, tablo sütunu, iki altyazı, matris hücresi "kip". trafo → transformatör (TikZ, tablo). Röle adı Bölüm 3 ile aynı "kip değişim rölesi" (07:6, 07:22, Şekil 7.3 altyazısı, 07:376). buck/alçaltıcı tez geneli kararı olduğu için uygulanmadı. 08:27 bölüm dışı. |
| B7-S04 | kısmen | Pencere çerçeveleri `trim/clip` ile kırpıldı (Şekil 7.9–7.14). 07:339'a "buck çıkışındaki" eklendi. Altyazı değişmedi. |
| B7-S05 | uygulandı | "temel bileşen güç faktörü". |
| B7-N01 | uygulanmadı | Küçük sayı tutarlılığı (tez sahibi görüşü). 07:15'teki "20 kVA (20–25 kW)" kaldı, öteki tekrarları T06 ile çıktı. |
| B7-N02 | uygulandı (A) | 07:15 "Gerilim ve akım sınırları Tablo … içinde verilmiştir." (frekans ve "evirici kipiyle ortak" ifadesi çıktı). |
| B7-N03 | uygulandı | A02 ile kalktı. |
| B7-J01 | uygulandı | Son paragraf: "Evirici kipindeki deneyler deşarj yönünü, şarj kipi benzetim kayıtları ise şarj zincirinin işleyişini göstermiştir." |
| B7-J02 | uygulandı (A) | 07:266 "şarj kipindeki eşdeğer devresi Simulink'te benzetilmiştir…". 07:383 cümlesi T01 ile kalktı. 07:397 hücresi "Benzetim kaydı, şarj kipi eşdeğer devresi". |
| B7-J03 | uygulandı (A) | CC–CV denklemi tek doyum satırı + koruma satırı. 07:173'e CC/CV açıklama cümlesi. Yeni sayı yok. |
| B7-J04 | uygulandı (A) | 07:339'a iki cümle (şarj akımı negatif işaretli, sabit akım düzeyinde). 07:181'deki çelişen işaret cümlesi A02 ile kalktı. |
| B7-J05 | uygulandı | Proteus şeması (`guc_yapi_10.pdf`, L3 hücresi) açılıp okundu: RL2 orta noktayı $D_1$–$D_2$–$Q_3$ düğümüne, RL1 transformatör hattına bağlıyor. Bölüm 3 altyazısıyla ("kip değişim röleleri $RL1$--$RL2$") tutarlı. 07:60'a iki cümle, 07:69 "röleler evirici konumundayken", 07:79 "(şekilde röleler faz sırasıyla numaralandırılmıştır)". `\kirmizinot` silindi. |
| B7-J06 | uygulandı (A) | Şekil 7.7'ye batarya → DA bara "deşarj" oku. 07:97 "Deşarjda batarya grupları ortak DA barayı beslemekte…". B seçeneği (ayırma kontaktörü) tez sahibi bilgisi ister, uygulanmadı. |
| B7-J07 | kısmen (A) | 07:35 hücresi "Görevi şarj kipindedir". 03:544 bölüm dışı. |
| B7-J08 | uygulanmadı | 01, 08, Özet, Summary (bölüm dışı). |
| B7-J09 | uygulanmadı | 01:34 / 08:36 (bölüm dışı). |
| B7-J10 | uygulandı (A) | N02 ile. Metne sayı eklenmedi. |
| B7-J11 | uygulandı | 07:79 "faz arası (üçgen) bağlı". 07:295 cümle 2 sıfır aralığı biçimiyle yeniden kuruldu. |
| B7-J12 | uygulandı | "PWM'ler durdurulmuş, ana kontaktörler açık (enerji yolu kesik)". |
| B7-J13 | uygulandı | Altyazı "… asgari koruma işlevleri ve kabul ölçütleri.", sütun "Kabul ölçütü". |
| B7-J14 | uygulandı | $h_{\mathrm{RL1}}$ tanımı "$k$ kipine ait konum", yeni konum doğrulamasının ayrı geçiş olduğu cümlesi. |
| B7-J15 | kısmen | Şekil 7.8'e "Hazır → Güvenli kapalı" "durdur" oku. İsteğe bağlı "şarj/deşarj → hazır" okları eklenmedi. |
| B7-J16 | uygulandı | "Akım, primer anahtarlamasının enerji aktarım aralıklarında akmaktadır." |
| B7-J17 | uygulanmadı | Rapor metin değişikliği istemiyor (savunma yanıtı). |
| B7-J18 | kısmen | 07:395 S05 ile. 01:45 bölüm dışı. |
| B7-J19 | uygulandı | Başlık "Doğrulama Matrisi". |
| B7-J20 | uygulandı | "geliştirilmiş T-tipi". |
| B7-J21 | uygulandı | "Enerji iki yönde aktarılabilmeli". |

## Rapor 28

| Madde | Durum | Not |
|---|---|---|
| Y-1 | uygulandı | Şekil 7.8 raporun yerleşimiyle yeniden kuruldu: `scale` kalktı, etiketler beyaz zeminli ve kısa ("uygun", $i\approx 0$), Ön şarj → hata yolu sütun boşluğundan, hata → güvenli kapalı ayrı alt yoldan, etiket alt yolun altında. İki satırlı düğümlerde `\\[0.8mm]`. Derlenip görsel denetlendi. |
| Y-2 | uygulandı | Kesikli denetim çizgisi batarya kutusunun solundan dolaşıyor. Batarya → DA bara deşarj oku eklendi. İkinci sıra düğümler sütunlara `below=of` ile hizalandı. İki satırlı düğümlerde `\\[0.8mm]`. Derlenip görsel denetlendi. |
| Y-3 | kısmen | Altyazı açıklama cümlesi çıktı, bilgi metne taşındı. Görüntü üstü etiket (b) yapılmadı (görevde istenmedi). |
| Y-4 | uygulandı | B7-J05 ile. Şekil 7.4'teki "L1" ad çakışması bırakıldı (düşük). |
| Y-5 | kısmen | Adım 1 uygulandı: Şekil 7.9–7.14 başlık çubuğu, menü, araç çubuğu ve durum çubuğu `trim/clip` ile atıldı, 7.11'in sağ boş şeridi kırpıldı. Adım 2–5 (eksen yeniden çizimi, Simulink etiket katmanı, yeni kaynak) uygulanmadı. |
| Y-6 | kısmen | B7-J04 cümleleri eklendi. "yaklaşık −10 A" ve "3,46 V" sayıları yeni sayı olduğu için eklenmedi. Menüler Y-5 adım 1 ile kırpıldı. |
| O-1 | uygulandı | Tablo 7.2–7.5 `L{}` ve `>{\teksatir\raggedright\arraybackslash}X` sütunlarına geçti (raporun genişlikleri). Tablo 7.2 ve 7.5 üçüncü sütun sonu noktaları kaldırıldı. Tablo 7.2 hücrelerindeki noktalı virgül ve geniş zaman giderildi. `\footnotesize` → `\small` denemesi yapılmadı. |
| O-2 | kısmen | Şekil 7.2 genişliği 0.67 → 0.60, Şekil 7.5 0.88 → 0.82. Kırpma 7.10–7.14'ü kısaltıyor. Boşluklar tez derlenince yeniden ölçülmeli. |
| O-3 | kısmen | Boş şerit kırpıldı. "yaklaşık 225 V" yeni sayı olduğu için eklenmedi. |
| O-4 | uygulanmadı | Scope başlığındaki yazım hatası görüntünün içinde (yeni kaynak). Kırpma başlığı korur. |
| D-1 | uygulanmadı | Görüntü üstü etiket istenmedi. |
| D-2 | kısmen | Kırpmayla pencere çerçevesi ve gölge kalktı. `height=` eşitlemesi yapılmadı. |
| D-3 | uygulanmadı | "doğrultma öncesi" doğru, rapor 27 B7-S04 değişiklik istemiyor. |
| D-4 | uygulanmadı | Yalnız savunma notu. Metin B7-J02 ile "eşdeğer devre" diyor. |
| D-5 | uygulanmadı | Proteus çıktısındaki İngilizce etiketler bırakıldı (§4). |
| D-6 | kısmen | Şekil 7.7 gönderme cümlesi şekilden önceki paragrafa alındı. Tablo 7.3 duyurusu tablodan önceye alındı. Şekil 7.8 ve Tablo 7.4 aynı sayfada kaldı. |
| D-7 | uygulandı | "bekçi zamanlayıcı (watchdog)", "devre dışı bırakma (bypass) olanağı". |
| D-8 | uygulandı | Tablo 7.4 altyazısından "literatürdeki" çıktı. |
| D-9 | uygulanmadı | Bölüm 6 (bölüm dışı). |
| §3-1 (20 kV A) | uygulanmadı | Tez geneli `siunitx` ayarı. Bölüm 7'de yalnız 07:15'te kaldı. |
| §3-2 (satır yüksekliği) | uygulanmadı | Tez geneli karar. `L{}` sütunları `\teksatir` getiriyor. |
| §3-3 (p → L taraması) | kısmen | Bölüm 7 tabloları yapıldı. Öteki bölümler kapsam dışı. |
| §3-4 (`\kirmizinot`) | uygulandı | Bölüm 7'deki tek kutu çözüldü ve silindi. |

## Açık kalanlar

- RL1 adı metinde (tablo, durum makinesi, Eşitlik 7.2) kip geçişini gösteriyor, donanımda geçiş iki röleyle yapılıyor. Rapor 27 bunu "RL1 röle çiftinin kısaltması" okumasıyla kabul ediyor. İstenirse 07:60'a tek cümle eklenebilir. Karar defterinde K-41 RL2 kutusu kapatılmalı.
- `eq:gt-soc-guncelleme` ve `eq:gt-roundtrip-verim` denklemleriyle birlikte silindi (dış gönderme yok). Denklem numaraları değişti (7.1 CC–CV, 7.2 geçiş izni).
- Tez Ayakaleaf'te derlenip Bölüm 7 sayfa boşlukları ve tablo satır aralıkları yeniden ölçülmeli.
