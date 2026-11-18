# Bölüm 8 fazlalık, gereksiz ayrıntı, tekrar ve jüri riski incelemesi

- **Kapsam:** `yeni_tez/bolumler/08-sonuc.tex` (129 satır, rapor 30 sonrası; düzenleme HEAD = d92396f'de, çalışma ağacı HEAD ile aynı). Sayı ve iddia karşılaştırması için 01, 04, 05, 06, 07, `onkisim/ozet.tex`, `onkisim/summary.tex` okundu. Rapor 23, 25, 27, 29, 30 ve `01_KARAR_DEFTERI.md` (K-08, K-12, K-36, K-41) denetlendi.
- **Bakış açısı:** jüri üyesi, tez danışmanı, güç elektroniği uzmanı. Bölüm 8 bugün dil açısından düzenlendiği için (rapor 30) dil önerisi yalnız anlamı etkileyen yerlerde var.
- **Görev kipi:** incele (yalnız rapor). Hiçbir `.tex` dosyası değişmedi. Derleme ve commit yapılmadı.
- **Tarih:** 18.11.2026. Satır numaraları dosyaların bugünkü hâline aittir. Alıntılar en çok 20 kelimedir.
- **Kelime sayımı:** `wc -w`, LaTeX komutları dahil (rapor 23 ve 27 ile aynı yöntem). Sayfa kestirimi ~300 kelime/sayfa.
- **İşaretler (rapor 23 ve 27 ile aynı):** **[HESAP]** yeni benzetim gerektirmeyen elle hesap ya da şekilden okuma (tezde yeni sayı olur, tez sahibi onayı gerekir). **[YENİ SAYI]** yeni benzetim, model ya da tez sahibi bilgisi gerektirir. Her [HESAP] ve [YENİ SAYI] önerisinin yanında yeni sayı gerektirmeyen bir seçenek (**A**) verilmiştir.
- **Kısıtlar:** sayı uydurulmadı. Uyuşmazlıklar iki tarafın satırıyla verildi. Önerilen metinler olumlu kurguyla yazıldı (kural 8), gösterme sözcüğü, noktalı virgül ve geniş zamanla biten cümle içermez. Altyazıya cümle eklenmesi önerilmez. `\kirmizinot` önerilmez. Tez sahibinin 18.11.2026 görüşü gereği küçük sayı farkları **Düşük** önceliktedir. Gerçek çelişkiler (yanlış yön, yanlış senaryo, yanlış koşul) **Yüksek** önceliktedir.

---

## 1. Özet

### 1.1 Kelime sayısı

| Kesim | Satır | Kelime | Pay | Tablo |
|---|---|---:|---:|---|
| Bölüm girişi | 1–5 | 101 | %4 | – |
| 8.1 Araştırma Sorularının Yanıtları: duyuru | 6–9 | 38 | %2 | – |
| Tablo `tab:arastirma-sorusu-kanit` | 10–28 | 216 | %9 | 1 |
| AS1–AS4 paragrafları | 30–36 | 402 | %17 | – |
| 8.2 Özgün Katkılar: duyuru ve Tablo `tab:katki-yontem-kanit` | 38–68 | 385 | %16 | 1 |
| 8.2.1–8.2.3 katkı alt kesimleri | 70–80 | 275 | %12 | – |
| 8.2.4 Fikrî mülkiyet (tablo dahil) | 82–105 | 265 | %11 | 1 |
| 8.3 Sonuçların Elde Edildiği Koşullar | 107–109 | 62 | %3 | – |
| 8.4 Gelecek Çalışmalar | 111–123 | 406 | %17 | – |
| 8.5 Genel Sonuç | 125–129 | 237 | %10 | – |
| **Toplam** | | **2 387** | | **3** |

**Oran sorunu:** Aynı deney ve benzetim sayıları dört katmanda veriliyor: AS paragrafları (402), katkı tablosu (~200 kelimelik bulgu sütunu), katkı alt kesimleri (275) ve Genel Sonuç (237). Sonuç bölümünde tekrar doğaldır, ama dört katman fazla. Öneri: sayılar AS paragraflarında kalsın, katkı tablosu yalnız deney sayılarını versin, Genel Sonuç ana sayılarla sınırlı kalsın (B8-T01).

### 1.2 Bulgu sayısı

| Tür | Yüksek | Orta | Düşük | Toplam |
|---|---:|---:|---:|---:|
| Tekrar (B8-T) | 0 | 3 | 3 | 6 |
| Gereksiz ayrıntı (B8-A) | 0 | 2 | 2 | 4 |
| Tablo, altyazı, terim (B8-S) | 0 | 1 | 3 | 4 |
| Sayı tutarlılığı (B8-N) | 0 | 0 | 4 | 4 |
| AS ve katkı eşleşmesi (B8-Q) | 1 | 3 | 0 | 4 |
| Jüri riski ve aşırı iddia (B8-J) | 6 | 5 | 3 | 14 |
| Gelecek Çalışmalar (B8-G) | 0 | 2 | 2 | 4 |
| **Toplam** | **7** | **16** | **17** | **40** |

### 1.3 Önerilerin hepsi uygulanırsa tahmini kazanç

- **Çıkan metin:** ~470 kelime (B8-T01 ~105, B8-T02 ~110, B8-T03 ~75, B8-A01 ~20, B8-A02 ~35, B8-A03 ~45, B8-T05 ~15, B8-T06 ~20, B8-S02 ~20, B8-T04 ~25).
- **Eklenen metin:** ~190 kelime (Ümit'in açıklaması ~75, B8-J01 açık çevrim ~12, B8-Q02 sınır akımı ~20, B8-J04 ~25, B8-J05 ~25, B8-G01 ~15, B8-Q01 ~20).
- **Net kazanç:** ~280 kelime (**~%12**), PDF'te yaklaşık **1 sayfa**. Tablo sayısı değişmiyor. Tablo `tab:arastirma-sorusu-kanit` dört sütundan üçe iniyor.
- **Diğer bölümler:** 01:33, 01:34, 01:44, Özet'te birer sözcük ya da cümle değişikliği (B8-H01, B8-J01, B8-Q04).

### 1.4 En önemli 7 öneri

1. **"%94,5'e taşımıştır" → "%94,5 düzeyinde korumuştur" (B8-H01).** S2→S3 farkı 0,3 puan, Bölüm 6'nın verdiği DA belirsizliği ±0,5 puan. Bölüm 6 "korurken" diyor (06:407), Bölüm 8 iki yerde, Bölüm 1 ve Özet artış diyor.
2. **AS2 satırındaki "orta ve anma akımında S4 benzetimiyle yanıtlandı" iddiasını düzelt (B8-H02).** S4, S3'ün (susturma + Sin³) kapalı çevrim modelidir. S4'te klasik anahtarlama yok, dolayısıyla orta ve anma akımında verim–harmonik ödünleşimi karşılaştırılmadı.
3. **08:72'deki "orta akımda tamamlayıcı anahtarlama tercih edilmektedir" yapılmış iş gibi okunuyor (B8-H03).** Aynı öneri 08:113'te gelecek çalışma. Bölüm 5 iki seçenek sunuyor (05:333).
4. **Sin³ kazanımını koşuluna bağla (B8-H04).** 08:129 harmonik iyileşme ile kararlılığı tek iddiada birleştiriyor. Harmonik iyileşme 2,3 A deneyinde, kararlılık 25 A ortalama modelde gösterildi. Anma akımında üçüncü harmoniğin kaynağı Sin³ teriminin kendisidir (05:552).
5. **44 µs gecikme marjını güç diye sunma (B8-H05).** Marj bir PWM periyodundan (100 µs) kısa. Bir periyot hesaplama gecikmeli gerçekleme (B) ve (B2) satırlarında Nyquist sayısı 1 (05:449–452). Cümle 08:76'dan çıksın, gerekçe olarak Gelecek Çalışmalar'a (08:113) girsin.
6. **Ümit'in açıklamasını 08:80 ve 08:109'a yerleştir (B8-H07, §6).** Tezde şarj kipinin neden deneyle sınanmadığına dair hiçbir cümle yok. GT-tipi katkının özgünlüğü (iki röle + iki hızlı diyot, aynı elemanlarla PFC + iki seviyeli evirici) Bölüm 7'de dağınık, Bölüm 8'de hiç yok.
7. **Dört katmanlı sayı tekrarını üçe indir (B8-T01, T02, T03).** Katkı tablosundaki benzetim sayıları, AS tablosunun "Kanıt türü" sütunu ve Genel Sonuç'taki S4/kalibrasyon cümleleri çıksın.

### 1.5 Jüri riski taşıyan noktalar

| Kimlik | Konu | Yer |
|---|---|---|
| B8-H01 | S2→S3 verim artışı belirsizlik içinde, "taşımıştır" artış iddiası | 08:34, 08:127 ↔ 06:276, 06:407 |
| B8-H02 | AS2 orta/anma akımı yanıtı yanlış senaryoya dayanıyor | 08:25 ↔ 05:220, 05:283 |
| B8-H03 | Önerilen kip geçişi uygulanmış gibi | 08:72 ↔ 08:113, 05:314, 05:333 |
| B8-H04 | Harmonik iyileşme ve kararlılık farklı koşullarda gösterilmiş, tek iddiada | 08:129, 08:127 ↔ 05:552, 05:313 |
| B8-H05 | 44 µs marj < PWM periyodu, sayısal gerçeklemeler Nyquist = 1 | 08:76 ↔ 05:446–452, 05:479 |
| B8-H06 | "tutarlı bir enerji depolama mimarisi sunmuştur" (şarj yönü eşdeğer devre benzetimi) | 08:127 ↔ 07:256, 07:393 |
| B8-H07 | Şarj kipi neden deneyle sınanmadı: tezde yanıt yok | 08:36, 08:80, 08:109 ↔ 07 (tamamı) |
| B8-J01 | S1–S3 deneyleri açık çevrim, metin "mevcut akım denetleyicisi" diyor | 08:76, 01:33 ↔ 05:220 |
| B8-J02 | "maliyet ile hacmin azaltılmasına olanak" (nicel karşılaştırma yok, eklenen elemanlar var) | 08:80 ↔ 07:357, 07:363 |
| B8-J03 | Tek "RL1" ↔ faz başına iki röle | 08:36, 08:80, 08:119 ↔ 07:6, 07:60 |
| B8-J04 | Sin³'ün anma akımındaki üçüncü harmonik bulgusu Bölüm 8'de yok | 08:34, 08:113 ↔ 05:552 |
| B8-J05 | Şebeke standardı harmonik sınırıyla karşılaştırma yok, 25 A THD %8,5–9,2 | 08:115 ↔ 05:303–304, 05:588 |

---

## 2. Önceki raporlardan Bölüm 8'e değen maddelerin durumu

### 2.1 Rapor 30 (Bölüm 8 yazım düzenlemesi) açık maddeleri

| Rapor 30 | Konu | Durum | Bu rapordaki karşılığı |
|---|---|---|---|
| §5 tablo hücreleri | "yanıtlandı." görülen geçmiş zaman (24–27) | **Açık** | B8-S03 |
| §5 altyazı | 08:44 ikinci cümle (koşul açıklaması) | **Açık** (proje kuralı) | B8-S02 |
| §5 kanıt düzeyi dili | 08:4 son cümle, 08:40, 08:82 başlığı | **Açık** | B8-A01, B8-S04 |
| §5 fazlalık | 32/34 ↔ 54/59 ↔ 127; 109 ↔ 127 | **Açık** | B8-T01, B8-T04 |
| §5 terim | kip/mod (27 "çalışma modu"), senkron-buck, "doğrultucu/boost", "izolasyon" | **Açık** | B8-S01 |
| §6.1 | 08:84 "aynı buluşlara dayanan" | Tez sahibi seçimi. Öneri: "ulusal başvuruların rüçhanını taşıyan" hukuken daha kesin. B8-A03 ile birlikte | B8-A03 |
| §6.4 | 08:127 "korumuş ve %94,5'e taşımıştır" | **Açık** | B8-H01 |
| §6.5 | 08:72 "tercih edilmektedir" | **Açık** | B8-H03 |
| §6.6 | 08:30 "iletim kaybı potansiyeli" | **Açık** | B8-Q01 |
| §6.8 | 08:129 "ortaya koymuştur" | Ek iş gerekmez | – |

### 2.2 Rapor 27 ve 29'un Bölüm 8 maddeleri

| Bulgu | Konu | Bugünkü durum |
|---|---|---|
| B7-T01 | 08:80 cümle 3 (evirici deneyle, şarj benzetimle) AS4'te de var | **Açık** (rapor 29: "Bölüm 7 dışı"). B8-T03 |
| B7-A03 | 08:119'a karşılaştırma ölçütleri cümlesi | **Uygulandı** (08:119 son cümle) |
| B7-S02 | 08:119 "doğrultucu/boost diyotları" ↔ K-36 "PFC yükseltici diyotları" | **Açık**. B8-S01 |
| B7-S03 | 08:27 "çalışma modu" ↔ "kip" | **Açık**. B8-S01 |
| B7-J05 | Faz başına iki röle (Bölüm 7'de uygulandı: 07:60) | Bölüm 8 hâlâ tek "RL1" diyor. B8-J03 |
| B7-J08 | 01:45, 08:64, 08:80, Özet "eleman sayısı", "maliyet ile hacim" | **Açık**. B8-J02 |
| B7-J09 | 01:34 AS4 "hücre dengeleme" ↔ 08:36 | **Açık**. B8-Q04 |
| B7-N01 | 08:80 "20–25 kW" ↔ 20 kVA | **Açık**, Düşük. B8-N01 |

### 2.3 Rapor 23 ve 25'in Bölüm 8 maddeleri

| Bulgu | Konu | Bugünkü durum |
|---|---|---|
| B6-J07 | S2→S3 farkı belirsizlik içinde; 01:44, 08:34, 08:127, Özet "artış" diyor | Rapor 25 kırmızı not koymuştu; notlar artık metinde yok (`grep kirmizinot` 01, 06, 08: 0). İfade **açık**. B8-H01 |
| B6-J08 | S2 farklı DA bara geriliminde (395 V) | 08:34 S1 ve S3 gerilimini veriyor; S2 için ek iş gerekmez. 08:32'deki S1→S2 karşılaştırmasında bara farkı söylenmiyor, Düşük (B8-N03) |
| B6-J09 | Tek çalışma noktası, tek kayıt | 08:115 "en az üç tekrar" gelecek çalışmayla karşılanıyor. Ek iş gerekmez |
| B6-J13 | 20 kVA ↔ 20–25 kW | **Açık**, B8-N01 |
| H-57 | 08:34 DA bara koşulu | Kapalı |

---

## 3. Sayı tutarlılığı (bölümler arası)

| Büyüklük | Bölüm 8 | Kaynak | Durum |
|---|---|---|---|
| Deney verimi %92,5 / %94,2 / %94,5 | 08:32, 34, 54, 59, 127 | 06:294, 06:325, 06:356, 06:400–402; 04:141; 01:43; Özet | Tutarlı |
| S1→S2 deney artışı 1,7 puan | 08:32, 08:127 | 06:407, 04:141, 01:43 | Tutarlı |
| S3–S1 deney farkı 2,0 puan | 08:34 | 06:407 | Tutarlı |
| S2→S3 deney farkı (0,3 puan) | 08:34 "taşımıştır", 08:127 "korumuş ve taşımıştır" | 06:407 "korurken"; 06:276 DA belirsizliği ±0,5 puan | **Yön iddiası uyuşmuyor** (B8-H01) |
| Benzetim verimi %91,15 / %93,93, 2,78 puan | 08:32, 08:54 | 04:141, 06:400–401, 06:574 | Tutarlı |
| S1 benzetim sapması −1,35 puan | 08:32 | 06:574, 06:592 | Tutarlı. Fazla artış 2,78 − 1,7 = 1,08 puan = 1,35 − 0,27 [HESAP denetimi]; cümle doğru, ifade sadeleşebilir (B8-N02) |
| Deney THD %15 / %47 / %14 | 08:32, 34, 54, 59, 127 | 06:400–402, 06:579; 04:143; Özet | Tutarlı |
| Benzetim THD %39,5 / %56,7 / %14,8 | 08:32, 34, 54, 59 | 06:400–402, 06:579, 05:215 | Tutarlı |
| S3 modeli verim 0,25 puan, AA akımı %1,4 | 08:34, 08:59 | 06:573–574, 06:588 | Tutarlı |
| DA bara S1 / S3: 431,5 V / 427,5 V | 08:34 | 06:290, 06:575, 03:470 ↔ 06:428 (430 / 427 V, deney özeti) | Tutarlı (ölçülen değerler). İki adlı kaynak sorunu Bölüm 6'da (B6-J02), Düşük |
| Osiloskop $I_3/I_1$ ~%47 → ~%9 | 08:34 | 06:519 | Tutarlı |
| Analitik $I_3/I_1$ %39,96 → %0,15, $(0{,}34,\ 0{,}40)$ | 08:34, 08:59 | 05:115, 05:586; Özet; Summary | Tutarlı |
| S4 PI / PIR genlik hatası −%2,1 / −%1,0 (25 A) | 08:34, 08:59 | 05:303–304, 05:588 | Tutarlı. Özet "yüzde 2,1" işaretsiz (B8-N04) |
| S4 doyumsuz izleme | 08:34, 59, 127 | 05:303–304 (doyum %0) | Tutarlı |
| 10 A THD %19,6–22,6 | 08:32 | 05:298–300 (P %22,6, PI %20,8, PIR %19,6) | Tutarlı |
| 10 A THD "%20 düzeyi" | 08:72 | 05:588, 05:312 | Tutarlı |
| Faz marjı 54°, kazanç marjı +35 dB | 08:34, 08:59 | 05:446, 05:459, 05:590; Özet; Summary | Tutarlı. Koşul (25 A, ortalama model) Bölüm 8'de yok (B8-J06) |
| Gecikme marjı 44 µs | 08:76 | 05:446 (44,4), 05:590 (44), Summary (44) | Sayı tutarlı. Yorum sorunlu (B8-H05) |
| Deney koşulu 2,3 A, 250–280 W, 120 V | 08:44, 08:109 | 06:489–491 (249,6–281,2 W), 01:57 | Tutarlı |
| Anma akımı 25 A | 08:25, 34, 59, 109, 127 | 05:220, 01:57 | Tutarlı |
| Tasarım güç aralığı 20–25 kW | 08:80 | 07:15 (20 kVA + 20–25 kW), 03 tablo, K-08 | $P\le S$ ile çelişiyor, Düşük (B8-N01) |
| Basamak aşımı ve yerleşme | Bölüm 8'de yok | 05:588 ve Tablo `tab:s4-basamak`: %0,17, 0,43 ms ↔ Summary: 0.2 %, 0.44 ms | Bölüm 8 dışı, Düşük (B8-N04) |
| L, S, T eşitliği | 08:34 "K34 açıkken de kapalıyken de aynıdır" | 05:590: ortalama model ve doğrusallaştırmada aynı, anahtarlamalı modelde fark belirsizlik içinde | Genelleme, Düşük (B8-J06) |

**Gerçek çelişki sayısı (yanlış yön, senaryo ya da koşul):** dört (B8-H01 yön, B8-H02 senaryo, B8-H03 ve B8-H04 koşul). Öteki sayılar kaynakla birebir tutarlı.

---

## 4. Araştırma soruları ve katkı listesiyle örtüşme

| Giriş | Soru ya da katkı | Bölüm 8 yanıtı | Örtüşme |
|---|---|---|---|
| 01:31 AS1 | (a) hangi anahtarlama durumları ve akım yolları, (b) kayıplara ve **akım harmoniklerine** etkisi | 08:30: (a) tam; (b) kayıp "potansiyeli artmaktadır", harmonik etkisi yok | **Kısmi** (B8-Q01) |
| 01:32 AS2 | verimi **hangi çalışma aralığında** ve hangi harmonik maliyetle değiştiriyor | 08:32: 2,3 A deney ve benzetim; 10 A'de S4 THD. Aralık sözcükle verilmiyor. Tablo 08:25 orta/anma akımını "yanıtlandı" sayıyor | **Kısmi, tablo aşırı** (B8-H02, B8-Q02) |
| 01:33 AS3 | (a) üçüncü harmoniği ne ölçüde azaltıyor, (b) **mevcut** kapalı çevrim akım kontrolünün marjlarıyla etkileşim | 08:34: (a) tam (deney, model, analitik); (b) tam (analog eşdeğer S4) | **Tam**; "mevcut" sözcüğü sorunlu (B8-J01). Anma akımındaki ters etki eksik (B8-J04) |
| 01:34 AS4 | şarj–deşarj ve **hücre dengeleme** kiplerinde güvenli yeniden görevlendirme | 08:36: işlev paylaşım yolları, evirici deneyi, şarj benzetimi, güvenli geçiş koşulları. Dengeleme yok | **Kısmi** (B8-Q04, B7-J09) |
| 01:43 Katkı 1 | kip/akım yolu analizi, benzetim, deney; verim +1,7 puan, THD artışı | 08:52–55, 08:72 | Tam |
| 01:44 Katkı 2 | karakteristik denklemi değiştirmiyor; THD klasik düzeye, "verimi bir miktar daha arttırmıştır" | 08:57–60, 08:76 | Tam; "arttırmıştır" iki tarafta da aşırı (B8-H01) |
| 01:45 Katkı 3 | klasik ayrık mimariyle "çalışma kipleri, anahtarlama durumları, enerji akış yolları ve güvenlik kısıtları" üzerinden karşılaştırma; eleman sayısı | 08:62–65 "klasik ayrık mimariyle nitel karşılaştırma"; 08:80 maliyet ve hacim | Kısmi: 08:80 Giriş'te olmayan "maliyet ile hacim" ekliyor (B8-J02). 01:45 karşılaştırma ölçütleri Bölüm 7 tablosuyla uyuşmuyor (B7-J18, açık) |
| 01:48 Başlık–katkı eşlemesi | üç bileşen | 08:52, 57, 62 | Tam |

---

## 5. `\label`–`\ref` taraması

- Bölüm 8'in dört etiketi: `chap:sonuc` (01:107), `tab:arastirma-sorusu-kanit` (08:8), `tab:katki-yontem-kanit` (08:40, 08:76), `tab:fikri-mulkiyet` (08:84, ekler:19). Hepsi gönderme alıyor.
- Öneriler uygulanırsa: B8-T03 08:76'daki `tab:katki-yontem-kanit` göndermesini kaldırır; 08:40 kaldığı için etiket gönderme almaya devam eder.
- Bölüm 8'de tek kalan gönderme yeri olan dış etiket yok. `tab:deney-dusuk-guc-ozeti` (06:387), `sec:thd-kaynaklar` (06:6, 06:314), `tab:kararlilik-olcum` (05:541), `fig:sin3-yeniden-tarama` (05:150), `sec:s1-s2-kalibre` (04:73) başka yerlerden de gönderme alıyor. Tablo hücreleri kısaltılırken silinmeleri etiketi yetim bırakmaz.
- B8-Q02 önerisi `eq:sinir-akimi` (03:232) ya da `sec:ters-akim-mekanizmasi` (04:9) göndermesini kullanabilir; AS2 paragrafındaki öteki göndermelerle birlikte kural 11 sınırını aşmamak için tablo göndermesi yerine geçmeli.

---

## 6. Ümit'in açıklaması: tezde var mı, nereye yerleşir

### 6.1 Açıklamanın üç öğesi ve tezdeki karşılığı

Grep: `röle`, `boost diyot`, `yükseltici diyot`, `yenilik`, `uzun`, `deneysel çalışma`, `iki seviyeli evirici`, `patent` (01, 02, 03, 07, 08).

| Öğe | Ümit'in metni (özet) | Tezde var mı | Yer |
|---|---|---|---|
| (a) Özgünlük | T-tipi eviriciye 2 röle + 2 hızlı boost diyodu; şarjda aynı elemanlarla 1 PFC + 1 iki seviyeli evirici; patentlerin odağı | **Dağınık, kısmen.** Röle ve diyotla yeniden görevlendirme 07:4, 07:22, 07:391; faz başına iki röle 07:60; altı yükseltici diyot 07:42; diyotların hızlı olduğu yalnız parametre tablosunda ($t_{rr}$, 03:510). 07:22 "iki seviyeli yarım köprü **ya da** … Vienna PFC" diyerek iki işlevi seçenek gibi sunuyor; Ümit'in metni şarjda ikisinin birlikte çalıştığını söylüyor. Patentlerle özgünlük bağı hiçbir yerde yok. Bölüm 8'de (a) yok | 07:4, 07:22, 07:42, 07:60, 07:391 |
| (b) Kullanım alanı | transformatör tipi BYS ile PFC–evirici–BYS mekanizması, benzetim | **Var.** 07:256 (şarj kipi eşdeğer devresi, PFC → DA bara → primer → sekonder → buck/batarya zinciri), 08:36, 08:80 | 07:256 |
| (c) Deneysel çalışmanın gerekçesi | çok uzun proje; PFC ve iki seviyeli evirici özelinde yenilik vaat edilmiyor | **Yok.** Tezin hiçbir yerinde şarj kipinin neden deneyle sınanmadığı söylenmiyor | – |

### 6.2 Nereye ve hangi cümleyle

**Yer 1 (önerilen ana yer): 08:80, Alt Bölüm "GT-Tipi Mimari Katkısı".** Paragraf bugün katkının ne olduğunu değil, kanıtını tekrar ediyor (B8-T03, B8-J02, B8-J03). Ümit'in (a) ve (b) öğeleri paragrafın yerine geçer. Hemen ardından gelen patent alt kesimiyle (08:84) doğal bağ kurar.

Bugünkü 08:80 (beş cümle) yerine:

> GT-tipi yaklaşımın özgünlüğü, patentlerin de odaklandığı yeniden görevlendirme ilkesidir. T-tipi eviricinin her faz hücresine iki kip değişim rölesi ve iki hızlı PFC yükseltici diyot ($D_1$--$D_2$) eklenmiştir. Şarj kipinde aynı yarı iletkenler bir Vienna PFC ve bir iki seviyeli evirici olarak çalışmaktadır. Yaklaşımın kullanım alanı, transformatör tabanlı BYS ile kurulan PFC--evirici--BYS zinciri üzerinden örneklenmiştir. Zincirin birlikte çalışması benzetimle gösterilmiştir. Yeniden görevlendirilen IGBT'ler sürücü, koruma ve soğutma altyapısının ortak kullanılmasına olanak sağlamaktadır.

- Çıkanlar: "mimari çerçeve sunmaktadır" cümlesi (08:64 ve 08:127 ile aynı), "20–25 kW" (B8-N01), "Evirici kipi deneylerle, şarj yönü …" (08:36 ile aynı, B7-T01), "RL1 ile" (B8-J03), "maliyet ile hacmin azaltılmasına" (B8-J02).
- Cümle uzunlukları 10–17 kelime. Yeni sayı yok. Terimler Bölüm 7 ile aynı ("kip değişim rölesi", "PFC yükseltici diyot", K-36).
- **Tez sahibinin onaylaması gereken tek nokta:** Ümit'in "2 röle, 2 adet de hızlı boost diyodu" ifadesi faz başına okunmuştur (07:60 "her faz hücresinde iki röle", 07:42 üç fazda "altı yükseltici diyot"). Toplam sayı kastediliyorsa ikinci cümle "T-tipi eviriciye kip değişim röleleri ve hızlı PFC yükseltici diyotlar ($D_1$--$D_2$) eklenmiştir." olur.

**Yer 2: 08:109, "Sonuçların Elde Edildiği Koşullar".** Ümit'in (c) öğesi burada koşul olarak durur. Kesim zaten deney koşullarını sayıyor. Son cümleden sonra:

> GT-tipi donanımın deneyleri evirici kipinde yürütülmüştür. Tezin yeniliği, literatürde yerleşik PFC ve iki seviyeli evirici yapılarının aynı yarı iletkenlerle elde edilmesindedir. PFC--evirici--BYS zincirinin deneysel doğrulaması ise ayrı bir proje büyüklüğünde bir çalışmadır. Zincirin birlikte çalışması tezde benzetimle gösterilmiş, deneysel doğrulama adımları gelecek çalışmalara alınmıştır.

- Ümit'in "gerek duyulmamıştır" ifadesi kullanılmadı. Gerekçe: (1) kural 8 kendini zayıflatan ya da savunmacı kurguyu yasaklıyor; (2) jüri "yenilik yeniden görevlendirmenin kendisiyse, kip geçişini sınamak gerekmez mi?" diye karşı soru sorabilir. Önerilen metin aynı mantığı olumlu kurar: yenilik bilinen kiplerin aynı elemanlarla elde edilmesidir, zincirin deneyi proje büyüklüğündedir, adımlar 08:119'da tanımlıdır.
- Son cümle 08:119'daki donanım-içinde-döngü ve düşük gerilim doğrulama planına bağlanır.

**Yer 3 (isteğe bağlı, kısa): 08:36, AS4 paragrafı.** Üçüncü cümle şöyle değişebilir:

> Düşük güç deneyleri donanımın evirici kipinde yapılmış, PFC--evirici--BYS zincirinin birlikte çalışması benzetimle gösterilmiştir.

Yer 1 uygulanırsa Yer 3 gerekmez; aynı bilgi üçüncü kez yazılmış olur.

**Bölüm 8 dışı (bilgi için):** Yer 1'in ilk üç cümlesi 07:391'e (Bölüm 7 Değerlendirme) de uyar; 07:22'deki "ya da" bağlacı "ve" ile değiştirilirse Bölüm 7 Ümit'in "şarjda 1 PFC ve 1 iki seviyeli evirici" okumasıyla uyumlu olur. Kapsam dışında bırakıldı.

---

## 7. Bulgu listesi

Biçim: **Kimlik — tür — öncelik — tahmini kazanç**, ardından yer, alıntı ve öneri.

### 7.1 Yüksek öncelikli çelişki ve aşırı iddialar

**B8-H01 — jüri riski (verim yönü) — yüksek — 0**
- **Yer:** 08:34 (cümle 1), 08:127 (cümle 4), 01:44 (son cümle), Özet ↔ 06:407, 06:276.
- **Alıntı:** 08:127 "THD'yi %14'e, yani klasik anahtarlama düzeyine indirirken verimi korumuş ve %94,5'e taşımıştır."
- **Sorun:** S2→S3 farkı 0,3 puan. Bölüm 6 DA tarafı belirsizliğini ±0,5 puan veriyor ve "verimi %94,5 düzeyinde korurken" diyor. S2 ve S3 deneyleri farklı DA bara geriliminde (395 V, 427,5 V). "Taşımıştır" belirsizlik içindeki bir farkı artış diye sunuyor. 08:127'de "korumuş ve taşımıştır" yan yana çelişkili okunuyor (rapor 30 §6.4).
- **Öneri A:** 08:34 "verimi %94,5'e taşımıştır" → "verimi %94,5 düzeyinde korumuştur". 08:127 → "Sin\textsuperscript{3} ileri beslemesi THD'yi \%14'e, yani klasik anahtarlama düzeyine indirmiş, verimi \%94,5 düzeyinde korumuştur." 01:44 "verimi bir miktar daha arttırmıştır" → "verimi korumuştur" (ayrıca "arttırmak" TDK'de "artırmak"). Özet aynı biçimde.

**B8-H02 — AS eşleşmesi (yanlış senaryo) — yüksek — ~0**
- **Yer:** 08:25 (AS2 satırı, "Sonuç düzeyi" ve "Kanıt türü" hücreleri) ↔ 05:220, 05:283, 03:345.
- **Alıntı:** 08:25 "Düşük güçte (yaklaşık 2,3 A) deney ve benzetimle, orta ve anma akımında S4 benzetimiyle yanıtlandı."
- **Sorun:** AS2 susturmanın klasik anahtarlamaya göre verim–harmonik ödünleşimini soruyor. S4, kalibre edilmiş S3'e (susturma + Sin³) akım geri beslemesi eklenerek kurulmuştur (05:220). S4'te klasik anahtarlama kolu yok. Dolayısıyla 10 A ve 25 A'de susturmanın klasik anahtarlamaya göre verim farkı bilinmiyor; S4 yalnız susturmalı köprünün süreksiz iletim bölgesini ve THD düzeyini veriyor. Jüri sorusu: "10 A'de klasik anahtarlamaya göre verim farkı nedir?"
- **Öneri A:** Hücre → "Düşük güçte (yaklaşık \SI{2.3}{\ampere}) deney ve benzetimle yanıtlandı. Orta akımda susturmalı köprünün süreksiz iletim bölgesi S4 benzetimiyle gösterildi." "Kanıt türü" hücresi B8-T02 ile kalkar. B8-Q02 ile birlikte AS2 paragrafı çalışma aralığını sınır akımıyla verir.
- **Öneri B [YENİ SAYI]:** S4'ün klasik tamamlayıcı kapı mantığıyla 10 A ve 25 A koşusu (S4-S1). Gelecek Çalışmalar 08:115 ortak karşılaştırmayı zaten öneriyor.

**B8-H03 — jüri riski (önerilen iş uygulanmış gibi) — yüksek — ~10 kelime**
- **Yer:** 08:72 (son iki cümle) ↔ 08:113 (cümle 4), 05:314, 05:333, 05:588.
- **Alıntı:** 08:72 "Yöntemin çalışma bölgesi de aynı kanıtla belirlenmiştir … orta akımda tamamlayıcı anahtarlama tercih edilmektedir."
- **Sorun:** İki koşul hatası. (1) "Aynı kanıt" 2,3 A deneyi ve kalibre edilmiş benzetimdir; 10 A bulgusu S4 benzetiminden geliyor. (2) Kip geçişi tezde uygulanmadı; 08:113 aynı geçişi gelecek çalışma olarak tasarlatıyor. Bölüm 5 iki seçenek sunuyor: tamamlayıcı anahtarlamaya dönüş ya da akıma göre ayarlanan ileri besleme (05:333).
- **Öneri A:** Son iki cümle → "Susturma düşük güç bölgesi için tasarlanmış bir yöntemdir. S4 benzetiminde \SI{10}{\ampere}'de süreksiz iletim THD'yi \%20 düzeyine taşımaktadır. Orta akım için tamamlayıcı anahtarlamaya akım düzeyine bağlı geçiş öngörülmüştür." (Son cümle 08:113'e bağlanır, Bölüm 5'in iki seçeneğinden birini dışlamaz.)

**B8-H04 — jüri riski (farklı koşulda gösterilmiş iki bulgu tek iddiada) — yüksek — ~−10 kelime**
- **Yer:** 08:129 (cümle 3 ve son cümle), 08:127 (cümle 2) ↔ 05:552, 05:313, 05:446.
- **Alıntı:** 08:129 "Sin³ terimi, faz kolu değişikliğinin harmonik bedelini akım çevriminin kararlılığını bozmadan klasik anahtarlama düzeyine indirmekte…"
- **Sorun:** Harmonik iyileşme 2,3 A açık çevrim deneyinde gösterildi. Kararlılık 25 A analog eşdeğer ortalama modelde gösterildi. Kararlılığın gösterildiği anma akımında üçüncü harmoniğin kaynağı Sin³ teriminin kendisidir: $K_{34}$ açıkken $L_1$ THD %9,4, kapalıyken %5,6 (05:552). Cümle iki bulguyu aynı koşulda geçerli gibi birleştiriyor. 08:129 son cümle ("harmonik kalitesini korumakta") ve 08:127 cümle 2 ("dengelenmektedir") koşulsuz.
- **Öneri A:** 08:129 cümle 3 çıksın (08:127 aynı bilgiyi veriyor, B8-T06). Son cümle → "Yaklaşım, deney noktasında düşük güç verimini artırırken şebeke akımının harmonik kalitesini korumakta ve aynı donanımı enerji depolama sisteminin şarj--deşarj işlevlerinde birleştirmektedir." 08:127 cümle 2 → "Susturmanın getirdiği verim--harmonik ödünleşimi, deney noktasında Sin\textsuperscript{3} ileri beslemesiyle dengelenmektedir."

**B8-H05 — jüri riski (zayıflığı güç diye sunma) — yüksek — ~−20 kelime (08:76) + ~25 kelime (08:113)**
- **Yer:** 08:76 (cümle 5) ↔ 05:446–452 (Tablo `tab:kararlilik-marjlar`), 05:479, 05:484 (altyazı), 03:515 ($f_s$ = 10 kHz).
- **Alıntı:** 08:76 "Kararlılık ayağında analog eşdeğer çevrim ayrıca 44 µs gecikme marjına sahiptir."
- **Sorun:** 44 µs bir PWM periyodundan (100 µs) kısa. Bölüm 5'in kendi tablosunda bir periyot hesaplama gecikmeli gerçekleme (B, 200 µs) ve periyotta iki güncellemeli (B2, 100 µs) satırları Nyquist sayısı 1 ve negatif kazanç marjı veriyor. Güç elektroniği jürisi 44 µs'yi "olağan bir DSP gerçeklemesi bu marjı aşar" diye okur. Bölüm 8 sayısal gerçeklemenin neden "öncelikli gelecek çalışma" olduğunu da söylemiyor.
- **Öneri A:** 08:76 cümle 5 çıksın. 08:113 cümle 1'den sonra olumlu kurulu gerekçe: "Analog eşdeğer çevrimin \SI{44}{\micro\second} gecikme marjı bir PWM periyodundan kısadır. Hesaplama gecikmeli sayısal gerçekleme, LCL rezonansında aktif sönümleme gerektirmektedir (Tablo~\ref{tab:kararlilik-marjlar})." Ardından mevcut "Kapasitör akımı geri beslemesiyle aktif sönümleme…" cümlesi gelir. Yeni sayı yok (100 µs = $1/f_s$).

**B8-H06 — jüri riski (iddia ↔ kanıt) — yüksek — ~0**
- **Yer:** 08:127 (son cümle) ↔ 07:256, 07:393, 08:36.
- **Alıntı:** "GT-tipi yaklaşım, aynı T-tipi donanımı … işlevlerinde kullanan tutarlı bir enerji depolama mimarisi sunmuştur."
- **Sorun:** Genel Sonuç jürinin en dikkatli okuduğu paragraf. Şarj yönü, GT-tipi yapının şarj kipindeki eşdeğer devresinin benzetimiyle gösterildi (07:256). Kip geçişi tasarım tanımı. "Tutarlı … sunmuştur" ölçütü belirsiz ve kanıt türünü gizliyor. Bölüm 7 aynı yeri artık kanıt türüyle kapatıyor (07:393). B7-J01 ile aynı sınıf.
- **Öneri A:** "GT-tipi yaklaşım, aynı T-tipi donanımı evirici (şebekeye deşarj), Vienna PFC (şebekeden şarj) ve aktif batarya yönetimi (batarya bazlı şarj denetimi) işlevlerinde yeniden görevlendiren bir enerji depolama mimarisi olarak tanımlanmıştır. Deşarj yönü deneyle, şarj zinciri benzetimle gösterilmiştir."

**B8-H07 — jüri riski (şarj kipi deneyinin gerekçesi yok) — yüksek — +~75 kelime**
- **Yer:** 08:36, 08:80, 08:109 ↔ Bölüm 7 tamamı, 01:45.
- **Sorun:** GT-tipi katkının deney kanıtı evirici kipindeki düşük güç deneyleridir. Bu deneyler T-tipi eviricinin S1–S3 deneyleridir; GT-tipi yapının ayırt edici elemanlarını (röle, $D_1$–$D_2$, BYS) sınamıyor. Jürinin ilk sorusu "şarj kipini neden deneyle sınamadınız?" olur. Tezde yanıt cümlesi yok.
- **Öneri:** §6.2 Yer 1 ve Yer 2.

### 7.2 Araştırma sorusu ve katkı eşleşmesi

**B8-Q01 — AS eşleşmesi (AS1 harmonik ayağı) — orta — +~20 kelime**
- **Yer:** 08:30 ↔ 01:31 (soru b), 06:552.
- **Sorun:** AS1 dolaşım akımının kayıplara **ve akım harmoniklerine** etkisini soruyor. 08:30 kayıp için "iletim kaybı potansiyeli artmaktadır" diyor (belirsiz, rapor 30 §6.6), harmonik için bir şey söylemiyor.
- **Öneri A:** "potansiyeli artmaktadır" → "iletim kaybı artmaktadır". Sona Bölüm 6 bulgusuna dayanan bir cümle: "Klasik anahtarlamada akım her anahtarlama periyodunda sıfırı kestiği için ölü zaman akıma bağlı bir gerilim hatası üretmektedir (Alt Bölüm~\ref{sec:kalibrasyon})." Kural 11 gereği paragraftaki iki bölüm göndermesinden biri çıkmalı (Tablo 08:24 aynı iki bölümü veriyor, rapor 30 §3).

**B8-Q02 — AS eşleşmesi (AS2 "hangi çalışma aralığında") — orta — +~20 kelime**
- **Yer:** 08:32 ↔ 01:32, 04:11, 05:333, eş. `eq:sinir-akimi` (03:232).
- **Sorun:** Soru çalışma aralığını soruyor. Tezde aralığın analitik sınırı var: ters akım, ortalama akım dalgalanmanın yarısından küçükken oluşur; sınır akımı en çok yaklaşık 4,5 A (04:11, 05:333). Bölüm 8 bu sayıyı kullanmıyor; aralık yalnız "düşük güç" sözcüğüyle veriliyor.
- **Öneri A (yeni sayı yok):** 08:32 ilk cümleden önce: "Ters akım, anlık akımın yaklaşık \SI{4.5}{\ampere} sınır akımının altında kaldığı bölgede oluşmaktadır. Susturmanın etkili olduğu çalışma aralığı da sınır akımıyla belirlenmektedir." Ardından 2,3 A sayıları gelir.

**B8-Q03 — AS eşleşmesi (AS3 anma akımında ters etki) — orta — bkz. B8-J04**

**B8-Q04 — AS eşleşmesi (AS4 "hücre dengeleme") — orta — 0**
- **Yer:** 01:34 ↔ 08:36, 07:354 ("Şarjda batarya başına bağımsız akım/gerilim düzenleme"). B7-J09 açık.
- **Öneri A:** 01:34 "şarj--deşarj ve hücre dengeleme kiplerinde" → "şarj--deşarj ve batarya bazlı şarj denetimi kiplerinde" (08:127'deki üçlüyle aynı). Bölüm 8'e dokunmak gerekmez.

### 7.3 Orta ve düşük öncelikli jüri riskleri

**B8-J01 — jüri riski (açık çevrim deney, "mevcut" denetleyici) — orta — +~12 kelime**
- **Yer:** 08:76 (son cümle), 01:33 ↔ 05:220, 05:278.
- **Alıntı:** 08:76 "…mevcut akım denetleyicisi değiştirilmeden uygulanabilmektedir."
- **Sorun:** S1–S3 deneyleri açık çevrim modülasyonla yürütüldü (05:220). Kapalı çevrim akım denetimi tezde S4 benzetimi için kuruldu. "Mevcut" sözcüğü prototipte çalışan bir akım denetleyicisi olduğunu ima ediyor. Bölüm 8'in koşullar kesimi (08:109) deneylerin açık çevrim olduğunu söylemiyor.
- **Öneri A:** 08:76 "mevcut akım denetleyicisi" → "akım denetleyicisi". 01:33 "mevcut kapalı çevrim akım kontrolünün" → "kapalı çevrim akım denetiminin". 08:109 ilk cümleden sonra: "S1--S3 deneyleri açık çevrim modülasyonla yürütülmüştür."

**B8-J02 — jüri riski (maliyet ve hacim iddiası) — orta — −~6 kelime**
- **Yer:** 08:80 (son cümle), 08:64 (hücre son cümle) ↔ 07:357 ("röle, diyot ve buck kolları ise eklenmektedir"), 07:363 (bedeller), 01:45. B7-J08 açık.
- **Sorun:** Bölüm 7 nitel karşılaştırma yapıyor ve eklenen elemanları sayıyor. "Maliyet ile hacim" Bölüm 7'de hiç geçmiyor; sayım yok.
- **Öneri A:** 08:80 son cümleden "maliyet ile hacmin azaltılmasına" çıksın (§6.2 Yer 1 bunu içeriyor). 08:64 hücresi 01:45 ile aynı kalabilir (kural 8 örneği "eleman sayısını azaltma olanağı" ifadesini onaylıyor).
- **Öneri B [HESAP]:** aktif anahtar ve sürücü sayımı (ayrı Vienna + ayrı yarım köprü ↔ GT-tipi), topoloji şemalarından (B7-J08 B).

**B8-J03 — jüri riski ve terim (röle adı) — orta — 0**
- **Yer:** 08:36 "Kip seçen RL1 fonksiyon anahtarıyla", 08:80 "RL1 ile", 08:119 "RL1 kip geçişi" ↔ 07:6, 07:22 ("kip değişim röleleri"), 07:60 (her faz hücresinde iki röle, RL1 ve RL2), 03:24.
- **Öneri A:** 08:36 → "Kip değişim röleleriyle yapılan geçişin güvenliği…". 08:80 için §6.2 Yer 1. 08:119 "RL1 kip geçişi" → "röleli kip geçişi". Ümit'in "2 röle" ifadesiyle de uyumlu olur.

**B8-J04 — jüri riski (Sin³ anma akımında üçüncü harmoniği artırıyor) — orta — +~25 kelime**
- **Yer:** 08:34, 08:113 ↔ 05:552, 05:313, 05:333.
- **Sorun:** AS3 "ne ölçüde azaltmakta" sorusunun dürüst yanıtı çalışma noktasına bağlılığı içeriyor; 08:34 "Uygun katsayılar çalışma noktasıyla değişmektedir" diyor ama anma akımındaki ters etkiyi söylemiyor. Jüri Tablo `tab:s4-tarama`'dan 25 A THD'sinin %8,5–9,2 olduğunu görür ve sorar. 08:113'teki "Sin³ ileri besleme genliğinin akımla ayarlanması" gerekçesiz kalıyor.
- **Öneri A:** 08:34 "Uygun katsayılar çalışma noktasıyla değişmektedir" cümlesinin yerine: "Anma akımında üçüncü harmoniğin kaynağı, \SI{2.3}{\ampere} noktasına göre kalibre edilmiş Sin\textsuperscript{3} teriminin kendisidir (Alt Bölüm~\ref{sec:s4-kapali-cevrim}). Uygun ileri besleme genliği akım düzeyine bağlıdır." Paragraftaki göndermelerden biri çıkarsa kural 11 sınırı korunur.

**B8-J05 — jüri riski (şebeke standardı) — orta — +~15 kelime**
- **Yer:** 08:115 ↔ 05:303–304, 05:588; `\umitnot` 05:309 (iç not).
- **Sorun:** Tezde THD şebeke bağlantı standartlarıyla karşılaştırılmıyor. 25 A'de THD %8,5–9,2, 10 A'de ~%20. Güç elektroniği jürisi standart sorusunu sorar. Gelecek Çalışmalar standarttan söz etmiyor.
- **Öneri A:** 08:115 ikinci cümleden sonra: "Akım harmonikleri IEEE~1547 ve IEC~61727 sınırlarına göre değerlendirilmelidir." (Standart adları tezde kaynakçada varsa `\citep` eklenir; yoksa ad yeterli.)

**B8-J06 — jüri riski (genelleme) — düşük — +~4 kelime**
- **Yer:** 08:34 ("Analize göre L, S ve T fonksiyonları K34 açıkken de kapalıyken de aynıdır"; "Analog eşdeğer çevrim, kritik geçişte 54° … kararlıdır") ↔ 05:590, Tablo `tab:kararlilik-marjlar` altyazısı (25 A, ortalama model).
- **Öneri A:** "Analize göre" → "Ortalama modelde". "Analog eşdeğer çevrim" → "Analog eşdeğer çevrim anma akımında". Rapor 30 bu cümleleri yeni kurdu; anlam değişikliği yok.

**B8-J07 — jüri riski (evirici deneyinin GT-tipi için kanıt değeri) — düşük — 0**
- **Yer:** 08:4 (cümle 4), 08:65 (hücre).
- **Sorun:** "GT-tipi inceleme … evirici kipindeki deneylerini … temel almaktadır" ifadesine jüri "bu deney GT-tipi'nin hangi özelliğini sınıyor?" diye sorabilir.
- **Öneri:** §6.2 Yer 2'deki "Tezin yeniliği, literatürde yerleşik PFC ve iki seviyeli evirici yapılarının aynı yarı iletkenlerle elde edilmesindedir." cümlesi yanıtı veriyor. Ek değişiklik gerekmez.

**B8-J08 — jüri riski (S1→S2 bara farkı) — düşük — 0**
- **Yer:** 08:32 ↔ 06:290 (S2 395 V), 08:34 (S1 ve S3 gerilimi veriliyor).
- **Öneri:** Değişiklik isteğe bağlı. Savunma yanıtı: "S1→S2 farkı 1,7 puan, DA belirsizliğinin (±0,5 puan) üzerindedir (06:407)."

### 7.4 Tekrarlar

**B8-T01 — tekrar (deney ve benzetim sayıları dört katmanda) — orta — ~105 kelime**
- **Yer:** 08:32, 08:34 (AS paragrafları, **birincil**) ↔ 08:54, 08:59 (katkı tablosu) ↔ 08:127 (Genel Sonuç) ↔ 01:43–44, Özet.
- **Sayım:** %92,5→%94,2: 32, 54, 127. %91,15→%93,93: 32, 54. THD %15→%47: 32, 54, 127. %39,5→%56,7: 32, 54. %14 ve %94,5: 34, 59, 127. %14,8 ve 0,25 puan: 34, 59 (127'de sözle). %39,96→%0,15: 34, 59. −%2,1: 34, 59. 54° ve 35 dB: 34, 59. S4 koşulları: 109, 127.
- **Öneri:**
  - 08:54 hücresi: benzetim sayıları çıksın → "Klasik anahtarlamaya (S1) göre susturma (S2) verimi deneyde \%92,5'ten \%94,2'ye yükseltmektedir. Bedeli süreksiz iletim ve üçüncü harmoniktir: akım THD'si deneyde \%15'ten \%47'ye çıkmaktadır. Susturma, düşük güç bölgesi için tasarlanmış bir yöntemdir." (~15 kelime kazanç)
  - 08:59 hücresi: "Analitik modelde …" cümlesi ve iki kararlılık cümlesinden biri çıksın → "Susturma ile birlikte (S3) deneyde THD \%14, verim \%94,5'tir. Kalibre edilmiş model, kalibrasyon hedefi olmayan THD'yi \%14,8 olarak vermektedir. S4'te PI denetimi \SI{25}{\ampere}'i $-$\%2,1 genlik hatasıyla, doyumsuz izlemektedir. Sin\textsuperscript{3} terimi akım çevriminin dışında kaldığı için kararlılık marjlarını korumaktadır (faz marjı $54^{\circ}$, kazanç marjı \SI{35}{\decibel})." (~30 kelime)
  - 08:127: "Uygun ileri besleme katsayıları çalışma noktasına bağlıdır." (34'te ve B8-J04'te), "Deney özetine kalibre edilen benzetim modeli S3'te …" (34, 59) ve "S4 benzetiminde ileri besleme ile PI ve PIR …" (34, 59, 109) cümleleri çıksın. Genel Sonuç'ta susturma (1,7 puan, THD %15→%47), Sin³ (THD %14, verim korunur), kararlılık ve GT-tipi cümleleri kalır. (~60 kelime)

**B8-T02 — tekrar (AS tablosunun "Kanıt türü" sütunu) — orta — ~110 kelime**
- **Yer:** 08:10–28 ("Kanıt türü" sütunu), 08:8 (cümle 2, sütun açıklaması).
- **Sorun:** "Kanıt türü" sütunu "Sonuç düzeyi" ve "Başlıca dayanak" sütunlarını yineliyor. AS1 satırı "Devre analizi (anahtarlama durumları, akım yolları, senkron-buck eşdeğeri)" dayanak sütunundaki listenin aynısı. AS2 satırında üç sütun aynı akım düzeylerini sayıyor.
- **Öneri:** "Kanıt türü" sütunu çıksın; sütun genişlikleri 0,07 / 0,40 / 0,49'a dağıtılsın. 08:8 cümle 2 çıksın; cümle 1 "Tablo~\ref{tab:arastirma-sorusu-kanit}, dört araştırma sorusunu yanıtlarıyla ve dayanaklarıyla eşleştirmektedir." olsun. Kanıt türü bilgisi "Sonuç düzeyi" hücrelerinde zaten var ("deney ve benzetimle", "analitik model ve benzetimle", "mimari … düzeyinde").

**B8-T03 — tekrar (katkı alt kesimleri AS paragraflarını ve tabloyu yineliyor) — orta — ~75 kelime**
- **Yer ve öneri:**
  - 08:72 cümle 2 ("Ters akım, sıfır gerilim durumu, nötr kol ve akım yönü üzerinden açıklanmıştır.") = 08:30. Çıksın. Cümle 4 "verim kazancı … aynı yönde bulunmuştur (AS2)" = 08:32, 08:55. Çıksın. Son iki cümle için B8-H03.
  - 08:76 cümle 4 ("Harmonik etkinin … Tablo~\ref{tab:katki-yontem-kanit}'te verilmiştir.") üst-anlatı. Çıksın. Cümle 5 B8-H05 ile Gelecek Çalışmalar'a taşınsın.
  - 08:80 cümle 3 ("Evirici kipi deneylerle, şarj yönü benzetim kayıtlarıyla gösterilmiştir.") = 08:36 (B7-T01). §6.2 Yer 1 ile kalkar.
- **Gerekçe:** Alt kesimlerin işi katkının literatürdeki konumunu vermektir (08:72 cümle 1, 08:76 cümle 1–3 ve 7 bunu iyi yapıyor). Kanıt AS paragraflarında ve tabloda.

**B8-T04 — tekrar (S4 koşulları) — düşük — ~25 kelime**
- **Yer:** 08:109 (birincil) ↔ 08:127 (S4 cümlesi), 08:25 hücresi.
- **Öneri:** B8-T01 ile 08:127'deki S4 cümlesi çıkar. Koşul 08:109'da kalır.

**B8-T05 — tekrar (şebeke eşdeğeri) — düşük — ~15 kelime**
- **Yer:** 08:113 son cümle ("$L_2$ şebeke ve varyak eşdeğeri doğrudan empedans ölçümüyle…") ↔ 08:115 son cümle ("şebeke eşdeğerinin $L$ ve $R$ değerleri modele eklenerek…").
- **Öneri:** İki cümle 08:115 sonunda birleşsin: "$L_2$ şebeke ve varyak eşdeğeri doğrudan empedans ölçümüyle, $L_1$ ise doyum eğrisiyle modellenmelidir. Ölçülen şebeke gerilimi harmonikleriyle birlikte S1 faz akımı dalga biçimi yeniden değerlendirilmelidir." 08:113'teki cümle çıkar.

**B8-T06 — tekrar (iki ölçek ekseni) — düşük — ~20 kelime**
- **Yer:** 08:129 (cümle 1–3) ↔ 01:21 (son iki cümle, neredeyse aynı söz dizimi), 08:127.
- **Öneri:** 08:129 cümle 3 çıksın (B8-H04). Cümle 1–2 Giriş'le bilinçli bir çerçeve kapanışı olarak kalabilir.

### 7.5 Gereksiz ayrıntı

**B8-A01 — gereksiz ayrıntı (kullanılmayan sınıflama) — orta — ~20 kelime**
- **Yer:** 08:4 (son cümle).
- **Alıntı:** "Sonuçlar, dayandıkları kanıt türüne göre doğrulanmış mekanizma, raporlanmış sayısal bulgu, yeniden üretim/uyumluluk sonucu…"
- **Sorun:** Beş sınıf bölümün hiçbir yerinde kullanılmıyor (tablolar "Sonuç düzeyi", "Kanıt türü" diye başka sözcükler kullanıyor). Kural 8 kanıt düzeyi tartışmasının çıkarılmasını istiyor.
- **Öneri:** Cümle çıksın.

**B8-A02 — gereksiz ayrıntı (genel gelecek çalışma) — orta — ~35 kelime**
- **Yer:** 08:123.
- **Alıntı:** "Yapay zekâ veya adaptif optimizasyon gibi ilave yöntemler, tezde kurulan fiziksel model ve deney zinciriyle birlikte kullanıldığında…"
- **Sorun:** Tezde açık kalan bir sınırla eşleşmiyor. Mikro şebeke, elektrikli araç ve hibrit yenilenebilir listesi her güç elektroniği tezine yazılabilecek genellikte. Jüri bu paragrafı dolgu diye okur.
- **Öneri:** Üçüncü cümle (yapay zekâ) çıksın. İlk iki cümle tek cümleye insin: "Yöntemlerin elektrikli araç şarj altyapısı gibi çift yönlü uygulamalara aktarılabilirliği, T-tipi sistemde kurulan mekanizma ve ölçütler üzerine araştırılabilir." Ya da paragraf tümüyle çıksın.

**B8-A03 — gereksiz ayrıntı (patent kesiminde üst bilgi) — düşük — ~45 kelime**
- **Yer:** 08:84 (cümle 3 ve 6), 08:105 (cümle 1).
- **Sorun:** 08:84 cümle 3 ("Numara, tarih, hak sahibi ve buluş sahipleri … okunmuştur (EK B ve EK C).") altyazıdaki "(kaynak: EK B ve EK C)" ile aynı. Cümle 6 ("Her PCT başvurusu bir ulusal başvurunun rüçhanını taşımaktadır.") tablonun rüçhan sütunu ile aynı. 08:105 cümle 1 (PCT yayını ve arama raporu) tablonun aynısı.
- **Öneri:** Üç cümle çıksın. 08:84 cümle 2'de rapor 30 §6.1 seçimi: "Ulusal patentler ve ulusal başvuruların rüçhanını taşıyan üç PCT başvurusu…" (cümle 6 çıkınca bilgi buraya geçer). 08:105 tek cümle kalır: "Fikrî mülkiyet çıktıları, tezin teknolojik yenilik katkısını tamamlamaktadır."

**B8-A04 — gereksiz ayrıntı (ölçüm listesi) — düşük — ~0**
- **Yer:** 08:115 (cümle 2, dokuz büyüklük), 08:119 (cümle 3, yedi arıza türü).
- **Öneri:** Gelecek Çalışmalar için ayrıntı düzeyi kabul edilebilir. İsteğe bağlı: 08:115 listesi "verim, güç faktörü, THD, $I_3/I_1$, ters akım yükü ve yarı iletken sıcaklığı" olarak altıya insin.

### 7.6 Tablo, altyazı ve terim

**B8-S01 — terim — orta — 0**
- **Yer ve öneri:**
  - 08:119 "doğrultucu/boost diyotları" → "PFC yükseltici diyotları" (K-36, 07:22).
  - 08:119 "izolasyon" → "yalıtım" (Bölüm 2, 7, ekler).
  - 08:27 "çalışma modu" → "çalışma kipi" (07 başlıkları "kip"e çekildi, rapor 29).
  - 08:24, 08:30, 08:53 "senkron-buck": tez geneli kararı bekliyor (Bölüm 4–6 "senkron alçaltıcı"). Karar verilince tek geçişte.
  - 08:115 "en yüksek/nominal güç" → "en yüksek güç".

**B8-S02 — altyazı (proje kuralı) — düşük — ~20 kelime**
- **Yer:** 08:44 (ikinci cümle).
- **Alıntı:** "Deney değerleri yaklaşık 2,3 A faz akımı, 250–280 W AA güç ve yaklaşık 120 V şebeke gerilimindeki tek faz kolu içindir."
- **Öneri:** Altyazıdan çıksın. Koşul 08:109'da var; 250–280 W gerekiyorsa 08:109 ilk cümlesine "(\num{250}--\SI{280}{\watt})" olarak girer.

**B8-S03 — tablo hücresi (kip) — düşük — 0**
- **Yer:** 08:24–27 "yanıtlandı."
- **Öneri:** "yanıtlanmıştır." (rapor 30 §5). B8-H02'deki yeni hücre de "gösterilmiştir" ile biter.

**B8-S04 — başlık — düşük — 0**
- **Yer:** 08:82 "Fikrî Mülkiyet Çıktılarının Kanıt Konumu".
- **Öneri:** "Fikrî Mülkiyet Çıktıları". "Kanıt konumu" belirsiz ve kural 8'in kanıt düzeyi diline yakın.

### 7.7 Sayı tutarlılığı (küçük farklar)

**B8-N01 — sayı (kVA ↔ kW) — düşük — ~5 kelime**
- **Yer:** 08:80 ↔ 07:15, K-08. §6.2 Yer 1 ile kalkar.

**B8-N02 — sayı ifadesi — düşük — 0**
- **Yer:** 08:32 "Benzetimdeki fazla artış S1 verimindeki $-1{,}35$ puanlık sapmadan gelmektedir."
- **Not [HESAP]:** Fazla artış 1,08 puan = S1 sapması 1,35 − S2 sapması 0,27. Cümle doğru. İstenirse "büyük kısmı … gelmektedir".

**B8-N03 — sayı (DA bara adları) — düşük — 0**
- **Yer:** 08:34 (431,5 / 427,5 V) ↔ 06:428 (430 / 427 V). Bölüm 6 kaynaklı (B6-J02). Bölüm 8 ölçülen değeri kullanıyor; değişiklik gerekmez.

**B8-N04 — sayı (ön kısım) — düşük — 0**
- **Yer:** Özet "PI denetimi 25 A anma akımını yüzde 2,1 genlik hatasıyla" (işaret yok) ↔ 05:303 (−%2,1). Summary "overshoot … 0.2 %, settling time 0.44 ms" ↔ Tablo `tab:s4-basamak` ve 05:588 (%0,17, 0,43 ms).
- **Öneri:** Özet "eksi yüzde 2,1" ya da "yüzde 2,1 eksik genlikle". Summary "0.17 %", "0.43 ms".

### 7.8 Gelecek Çalışmalar: tezde açık kalan sınırlarla eşleşme

| Açık sınır (tezdeki yeri) | Gelecek Çalışmalar karşılığı | Durum |
|---|---|---|
| S4 analog eşdeğer, hesaplama gecikmesi yok (05:238); (B) ve (B2) Nyquist = 1 (05:449–452) | 08:113 sayısal gerçekleme, aktif sönümleme | Var, **gerekçesiz** (B8-H05) |
| Orta akımda susturma THD'si ~%20 (05:333) | 08:113 kip geçişi | Var |
| Sin³ genliği 2,3 A'e kalibre, anma akımında üçüncü harmonik kaynağı (05:552) | 08:113 genliğin akımla ayarlanması | Var, **gerekçesiz** (B8-J04) |
| $L_1$ doğrusal (05:238), $L_2$ ölçülmedi (06:597) | 08:113 son cümle | Var (B8-T05 tekrar) |
| Tek çalışma noktası, yöntem başına tek kayıt (06:6) | 08:115 üç nokta, üç tekrar | Var |
| S1 modeli THD %39,5 ↔ deney %15 (06:592) | 08:115 son cümle | Var |
| S4'te klasik anahtarlama kolu yok (B8-H02) | 08:115 ortak karşılaştırma (dolaylı) | Kısmi; "S1 ve S2 kapı mantığıyla" denirse tam (B8-G02) |
| Şebeke standardı karşılaştırması yok | – | **Yok** (B8-J05) |
| Deneyler tek faz kolunda (01:55) | – | **Yok** (B8-G01) |
| L, S, T anahtarlamalı modelde belirsizlik sınırında (05:590) | 08:117 | Var |
| GT-tipi şarj kipi, kip geçişi, koruma tasarım tanımı (07) | 08:119 | Var |
| Batarya modeli Simulink bloğu, SoC kestirimi yok (B7-A02) | 08:121 | Var |
| AI, mikro şebeke | 08:123 | Tezde karşılığı yok (B8-A02) |

**B8-G01 — gelecek çalışma (üç fazlı çalışma) — orta — ~5 kelime**
- **Yer:** 08:115 cümle 1 ↔ 01:55 (prototip üç fazlı dört telli, deney tek faz kolunda).
- **Öneri:** "İkinci aşamada üç fazlı çalışmada düşük, orta ve güvenli biçimde erişilebilen en yüksek güç noktalarında ortak karşılaştırma yapılmalıdır."

**B8-G02 — gelecek çalışma (S4'te klasik kol) — orta — ~10 kelime**
- **Yer:** 08:115 ↔ B8-H02.
- **Öneri:** 08:115 cümle 1 sonuna "Karşılaştırma, S1, S2 ve S3 kapı mantıklarını aynı kapalı çevrim denetimiyle kapsamalıdır." Bu, AS2'nin orta ve anma akımı ayağını açıkça gelecek çalışmaya bağlar.

**B8-G03 — gelecek çalışma (uzunluk) — düşük — bkz. B8-A02, B8-A04**

**B8-G04 — gelecek çalışma (belirsizlik) — düşük — ~6 kelime**
- **Yer:** 08:115 cümle 2 ↔ 06:276 (birleşik belirsizlikte yalnız DA terimi verilmiş, B6-J07 B).
- **Öneri:** "…en az üç tekrarla ve AA ile DA güç belirsizliğiyle birlikte raporlanmalıdır."

---

## 8. Yeni sayı ya da tez sahibi bilgisi gerektiren öneriler

| Kimlik | Ne gerekir | Gerekmezse yapılacak (A) |
|---|---|---|
| B8-H02 (B) | [YENİ SAYI] S4'ün S1 kapı mantığıyla 10 A ve 25 A koşusu | Hücre düzeltmesi; B8-G02 |
| B8-J02 (B) | [HESAP] aktif anahtar ve sürücü sayımı | "maliyet ile hacim" çıkar |
| §6.2 Yer 1 | Tez sahibi onayı: "2 röle, 2 diyot" faz başına mı toplam mı | Toplam okuması için verilen ikinci cümle |
| B8-J05 | Standart adlarının kaynakçada olup olmadığı | Ad, atıfsız |
| B8-A03 | Tez sahibi seçimi: "aynı buluşlara dayanan" ↔ "ulusal başvuruların rüçhanını taşıyan" (rapor 30 §6.1) | Bugünkü ifade kalır |

---

## 9. Önerilen uygulama sırası

1. **Yüksek öncelikli düzeltmeler (önce, kısaltılacak paragraflara dokunuyor):** B8-H01 (08:34, 08:127, 01:44, Özet), B8-H02 (08:25), B8-H03 (08:72), B8-H04 (08:127, 08:129), B8-H05 (08:76 → 08:113), B8-H06 (08:127), B8-H07 (§6.2 Yer 1 08:80, Yer 2 08:109).
2. **AS eşleşmesi ve orta jüri riskleri:** B8-Q01 (08:30), B8-Q02 (08:32), B8-J04 (08:34), B8-J01 (08:76, 08:109, 01:33), B8-J02 ve B8-J03 (Yer 1 ile birlikte; 08:36, 08:119), B8-Q04 (01:34), B8-J05, B8-G01, B8-G02 (08:115).
3. **Tekrar ve gereksiz ayrıntı:** B8-T02 (AS tablosu sütunu, 08:8), B8-T01 (08:54, 08:59, 08:127), B8-T03 (08:72, 08:76), B8-A01 (08:4), B8-A02 (08:123), B8-T05 (08:113/115), B8-T06 (08:129), B8-A03 (08:84, 08:105).
4. **Terim, tablo, altyazı:** B8-S01, B8-S02 (08:44), B8-S03, B8-S04.
5. **Düşük öncelikli:** B8-N01–N04, B8-J06–J08, B8-A04, B8-G04.
6. **Kararlar** `01_KARAR_DEFTERI.md`'ye yazılır: Ümit'in açıklamasının tezdeki yeri ve "gerek duyulmamıştır" yerine olumlu kurgu (B8-H07), S2→S3 verim ifadesi "korumuştur" (B8-H01, B6-J07'nin kapanışı), K-36'nın 08:119'a uygulanması.
7. **Her adımdan sonra** Ayakaleaf'te derlenmeli ve tanımsız gönderme kalmadığı denetlenmeli. Derlemeyi ana oturum yapar.

**Korunması gereken etiketler:** `chap:sonuc` (01:107), `tab:katki-yontem-kanit` (08:40 göndermesi kalmalı), `tab:fikri-mulkiyet` (ekler:19). Bölüm 8 göndermeleri silinse de yetim kalan dış etiket yok (§5).
