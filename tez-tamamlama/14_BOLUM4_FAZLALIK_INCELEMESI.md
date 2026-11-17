# Bölüm 4 fazlalık, gereksiz ayrıntı ve tekrar incelemesi

- **Kapsam:** `yeni_tez/bolumler/04-dusuk-guc-anahtarlama.tex` (210 satır). Tekrar karşılaştırması için 01, 02, 03, 05, 06 ve 08 okundu. `onkisim/simgeler.tex` ve `tezpaketleri.sty` (`\umitnot` tanımı) denetlendi.
- **Bakış açısı:** jüri üyesi ve tez danışmanı. Yalnız içerik ve yapı incelendi. Bölüm 4 dil açısından az önce sadeleştirildiği için dil önerisi yok.
- **Görev kipi:** incele (yalnız rapor). Hiçbir `.tex` dosyası değişmedi. Derleme ve commit yapılmadı.
- **Tarih:** 17.11.2026
- **Satır numaraları** dosyaların bugünkü hâline aittir. Alıntılar en çok 20 kelimedir.
- **Kelime sayımı:** `wc -w` ile, kaçışsız `%` yorumları dışarıda, LaTeX komutları dahil. Sayfa kestirimi: düz metin için ~300 kelime/sayfa.

---

## 1. Özet

### 1.1 Kelime sayısı

| Kesim | Satır | Kelime | Pay |
|---|---|---:|---:|
| Bölüm girişi | 1–8 | 253 | %7 |
| Ters akım dolaşım mekanizması | 10–33 | 591 | %17 |
| Klasik anahtarlama yöntemi (tablo dahil) | 35–59 | 316 | %9 |
| Önerilen anahtarlama yöntemi (kural) | 61–80 | 202 | %6 |
| Modelden okunan kapı mantığı ve senaryo eşlemesi (3 şekil, 1 tablo) | 82–157 | **1 035** | **%30** |
| Verim ve harmonik ödünleşimi (giriş) | 159–161 | 79 | %2 |
| Kalibre benzetimde S1–S2 karşılaştırması (2 şekil, `\umitnot` dahil) | 163–197 | 648 | %19 |
| Güç tanımları, işaret kuralı ve anma ifadeleri | 199–204 | 199 | %6 |
| Bölüm sonucu | 206–210 | 151 | %4 |
| **Toplam** | | **3 474** | |
| `\umitnot` hariç (PDF'te görünen) | | 3 357 | |

### 1.2 Bulgu sayısı

| Tür | Yüksek | Orta | Düşük | Toplam |
|---|---:|---:|---:|---:|
| Tekrar | 3 | 4 | 4 | 11 |
| Gereksiz ayrıntı | 1 | 3 | 3 | 7 |
| Yanlış yer | 2 | 2 | 0 | 4 |
| Oran | 0 | 1 | 0 | 1 |
| Şekil/tablo | 0 | 1 | 2 | 3 |
| Jüri riski | 4 | 3 | 4 | 11 |
| **Toplam** | **10** | **14** | **13** | **37** |

### 1.3 Önerilerin hepsi uygulanırsa tahmini kazanç

- **Bölüm 4 içinde ~1 500–1 600 kelime (~%45).** Bulgulardaki tek tek kazançların toplamı ~1 890 kelimedir; örtüşmeler (özellikle G-15 ile G-04, G-14, G-19) düşülünce ~1 550 kalır. Bunun 117 kelimesi PDF'te görünmeyen `\umitnot`, 88 kelimesi Bölüm 3'e taşınan şekil başlığıdır.
- **PDF'te görünen net kazanç:** Bölüm 4'te ~1 350 kelime, yani ~4,5 sayfa. Yatay sayfadaki S3 model şekli Bölüm 4'ten çıkar (–1 sayfa, Bölüm 3'e +1 sayfa, tez geneli için net sıfır). S1/S2 kapı işareti şekillerinin birleştirilmesi ~0,5 sayfa kazandırır.
- **Diğer bölümler:** Bölüm 4'le çakışan tekrarlar (Bölüm 3'te ~130, Bölüm 2'de ~45, Bölüm 6'da ~35 kelime) da kaldırılırsa ek ~0,7 sayfa kazanılır.
- **Tez geneli:** ~5–5,5 sayfa.
- Jüri riski düzeltmelerinden üçü (G-30, G-32, G-33) birer kısa cümle ekler. Bu ekler yukarıdaki kazanca dahil değildir; toplam ~40 kelime tutar.
- Önerilerden sonra Bölüm 4 ~1 900 kelime, 5 şekil ve 2 tablo olur. Kural, mekanizma ve bedelin payı %24'ten ~%45'e çıkar (G-23).
- **Başlık:** Yalnız "Güç tanımları, işaret kuralı ve anma ifadeleri" alt başlığının tamamen kalkması öneriliyor (G-20). Gerekçe güçlü: içerik Bölüm 3'ün tanımıdır ve bir sonuç kesiminin içinde durmaktadır. Tek gönderme 06:10'dan gelir ve o da bir tekrardır.

### 1.4 En önemli 5 öneri

1. **"Modelden okunan kapı mantığı" alt bölümünü başlığının işine indir (G-19, G-22, G-24, G-14, G-23).** Alt bölüm 1 035 kelimeyle bölümün %30'unu tutuyor. Susturma kuralını veren ana metin (61–80) ise 202 kelime. Alt bölümün içinde başlıkla ilgisi olmayan üç öğe var: yatay sayfada S3 benzetim modeli şekli (S3 Bölüm 5'in konusudur; şekil Bölüm 5'ten iki gönderme alıyor), "güvenli uygulamada dört koşul" paragrafı ve harmonik ceza paragrafı. S1 ve S2 kapı işareti şekilleri de kapı tablosuyla aynı bilgiyi veriyor. Kazanç ~400 kelime ve Bölüm 4'te ~1,5 sayfa.
2. **Güç tanımları alt bölümünü kaldır (G-20, G-08, G-09; F-05 ve F-19 hâlâ geçerli).** 04:202, Bölüm 3'teki `eq:guc-ortalama-tanimlari` paragrafını (03:570–583) ve 06:524'ü tekrarlıyor. 04:204'teki anma güç ifadeleri parametre tablosunda ve 06:10'da da var. "Yaklaşık 30 değeri tezde yalnız faz akımı tasarım değeri olarak … geçmektedir" cümlesi okura görmediği bir tutarsızlığın düzeltme notunu okutuyor. Kazanç ~190 kelime.
3. **S1–S2 sonuçlarını Bölüm 4'te bir kez ver, kalibrasyon kalitesini Bölüm 6'ya bırak (G-07, G-21).** Verim ve THD sayıları bölüm içinde üç kez geçiyor (168, 170, 210). Bölüm 6'da da üç tabloda ve iki paragrafta var. Bölüm 4'te modelin DA gücü hatası (%0,004), verim hatası (–0,27 puan), S1 kaybı (24,0/19,7 W), benzetim belirsizliği (0,1 puan), THD'nin analizör ve osiloskop kaynakları ve %3,3 genlik azalması Bölüm 6'nın kalibrasyon içeriğidir. Kazanç ~160 kelime.
4. **Fiziksel olarak savunulması güç iki önermeyi düzelt (G-27, G-28).** (a) 04:6, 04:31, 04:37 ve 03:215 düşük güçte "modülasyon indeksinin küçüldüğünü" ve sıfır durumunun payının arttığını söylüyor. Şebekeye bağlı eviricide görev oranını şebeke gerilimi belirler (d ≈ v_g/V_h). Akım küçülünce görev oranı değişmez. Düşük güçteki asıl neden 04:13'te doğru verilmiş: dalgalanma sabit kalır, ortalama akım küçülür. (b) 04:41 senkron anahtarlamanın üstünlüğünü "diyot iletimini … anahtar kanalıyla değiştirmesi" diye veriyor. Nötr kol IGBT'dir ve IGBT ters yönde kanaldan iletmez. 04:17 de bu kazancın IGBT'de sınırlı olduğunu söylüyor, yani iki cümle çelişiyor. Kazanç ~70 kelime; asıl yarar jüri savunması.
5. **Susturma kuralını uygulanan biçimiyle tanımla, uyarlanabilir kısmı gelecek çalışmaya bırak (G-29, G-14, G-12).** Eşitlik 4.x'teki σ(t) kuralı |i*|, I_th, H ve χ_rev büyüklüklerine dayanıyor. S1–S3 ise açık çevrimdir, yani i* yoktur. I_th ve H için hiçbir değer verilmiyor. Benzetimde ve deneyde σ=1 sabit. "Devreye girmektedir" ve "sürekli kip değiştirme önlenmektedir" önermeleri sınanmamış davranışı anlatıyor. 08:115 eşiği, histerezisi ve kip geçişini zaten gelecek çalışma olarak sayıyor. Aynı durum Q_rev için de geçerli: tanımlanıyor ama hiç hesaplanmıyor, 08:117 de onu gelecek ölçüt olarak sayıyor. Kazanç ~310 kelime.

### 1.5 Jüri riski taşıyan noktalar

| Kimlik | Konu | Yer |
|---|---|---|
| G-30 | "Senaryolar arasında yalnızca nötr kapı mantığı, modülasyon genliği ve referans fazı değişmiştir" önermesi 05:231, 06:234 ve `tab:gelen-excel-senaryolar` ile çelişiyor: DA bara 431,5/395,0/427,5 V, şebeke 119,8/121,0/124,3 V. S1→S2 verim farkı 36 V'luk DA bara farkıyla da karışıyor. | 04:161, 04:168 |
| G-27 | Düşük güçte modülasyon indeksinin küçüldüğü önermesi | 04:6, 04:31, 04:33, 04:37; 03:215 |
| G-28 | IGBT'li nötr kolda "senkron üstünlük" önermesi; 04:17 ile çelişki | 04:41; 03:257 |
| G-29 | σ kuralı uygulamayla örtüşmüyor; I_th, H tanımlanıp kullanılmıyor; eşitlikte anahtar indeksi yok | 04:63–80; `simgeler.tex`:21, 71 |
| G-12 | Q_rev ve P_cond tanımlanıyor ama sayısal sonuç yok | 04:19–29 |
| G-31 | Ara seviye oranı (%0,5, %12,4) kalibre sonuç gibi sunuluyor; Bölüm 3 ve 6 "kalibrasyon öncesi" diyor | 04:181 ↔ 03:637, 06 `tab:kopru-ic-empedansi` |
| G-32 | "Ters yönde akım yolu yoktur" ile "ters akım yönünde D₁–D₂ yol sağlamaktadır" çelişiyor | 04:106 ↔ 04:155 |
| G-33 | "Temel periyodun büyük bölümünde ters akım" ile ölçülen %25,2 farklı ölçüler | 04:13, 04:208 ↔ 04:183 |
| G-34 | Δi_L simgesi Bölüm 6'da 2,6 A için kullanılıyor; tanımı tepe–tepe ≈9 A | 06:545 ↔ 03:241–245, 04:13 |
| G-18 | `\umitnot` içinde kural 10 ihlalleri (ilk tez, Şekil 5.18, Tablo 5.4, Temmuz benzetimi, mail) | 04:172–179 |

---

## 2. Önceki rapordan (12) Bölüm 4'e değen bulguların durumu

| Bulgu | Konu | Bugünkü durum | Bu rapordaki karşılığı |
|---|---|---|---|
| F-05 | Güç tanımları ve işaret kuralı | **Geçerli.** 04:202 aynen duruyor, 06:10 hâlâ `sec:guc-tanimlari`'ya gönderiyor. Bölüm 3 tarafı (03:570–583) tek birincil yer olarak kalmış. | G-08, G-20 |
| F-12 | Ters akım sayısal eşiği ve diyot benzetimi | **Kısmen geçerli.** 04:13 sayıları ve Bölüm 3 göndermesini birlikte veriyor. 03:635 de aynı hesabı veriyor. 03:252'deki diyot benzetimi cümlesi 02:259'u hâlâ tekrarlıyor. | G-02 |
| F-19 | Anma güç ifadeleri | **Geçerli.** 04:204 ve 06:10 aynen duruyor. | G-09 |
| F-25 | A_rev/N_sw ve Q_rev | **Kısmen uygulandı.** A_rev, N_sw ve RMSE Bölüm 3'ten çıkmış. Q_rev Bölüm 4'te tek tanım olarak kalmış ama hiç kullanılmıyor. | G-12 |
| F-33 | Bölüm 2'de tezin kendi bulgusu (kutup geriliminin ara değeri) | **Geçerli.** 02:305 duruyor. | G-03 |
| F-34 | Bölüm 3'teki S3 kayıp ayrışımı (kalabilir denmişti) | Bölüm 3'te kalmış, ama 04:31 aynı sayıları tekrarlıyor. | G-10 |
| F-07 | Kapı mantığı | **Kısmen geçerli.** 03:427'nin son iki cümlesi ve 03:157 hâlâ 04:85 ve 04:106 ile çakışıyor. | G-04 |
| F-09, F-17 | Kalibrasyon özeti ve "ayrı raporlanmıştır" | 04:4 ve 04:166'da sürüyor. | G-06 |

---

## 3. `\label`–`\ref` taraması

**Yöntem:** Betik (`refs.py`, oturum geçici dizininde) `yeni_tez/bolumler/`, `onkisim/` ve `sekiller/` altındaki bütün `.tex` dosyalarında `\ref`, `\eqref`, `\autoref`, `\pageref` ve `\cite*` komutlarını saydı. Kaçışsız `%` ile başlayan yorumlar sayılmadı.

**Bölüm 4'te hiç `\ref` almayan şekil ya da tablo yok.** Tezin bütününde gönderme almayan iki şekil var, ikisi de Bölüm 6'da: `fig:deney-susturma-pc` (06:275) ve `fig:deney-sin3-pc` (06:304). Bu rapor kapsamında değil, bilgi olarak not edildi.

**Bölüm 4 etiketleri:**

| Etiket | Yer | Gönderme | Not |
|---|---|---|---|
| `chap:anahtarlama` | 04:2 | 13 (12 dış) | |
| `sec:ters-akim-mekanizmasi` | 04:11 | 0 | Kesim etiketi, zararsız |
| `eq:ters-akim-yuku` | 04:22 | 1 (04:24) | G-12 ile çıkarılabilir |
| `eq:iletim-kaybi-yaklasik` | 04:27 | 2 (04:29, 04:31) | |
| `tab:klasik-onerilen-islevsel` | 04:46 | 1 (04:41) | |
| `eq:susturma-etkinlestirme` | 04:73 | 1 (04:75) | G-29 |
| `eq:notr-susturma-kurali` | 04:78 | 1 (04:80) | G-29 |
| `sec:model-kapi-mantigi` | 04:83 | 4 (03:157, 03:427, 04:161, 08:72) | **Korunmalı** |
| `tab:model-kapi-mantigi` | 04:90 | 3 (04:85, 04:106, 04:135) | |
| `fig:susturma-esdeger` | 04:123 | 2 (04:108, **05:50**) | **Korunmalı** |
| `fig:s2-kapi-isaretleri` | 04:132 | 1 (04:126) | G-24 |
| `fig:s1-kapi-isaretleri` | 04:141 | 1 (04:135) | G-24 |
| `fig:s3-simulink-modeli` | 04:151 | 3 (04:144, **05:236, 05:241**) | Taşınırsa etiket aynı kalmalı (G-19) |
| `sec:s1-s2-kalibre` | 04:164 | 2 (04:33, **08:55**) | **Korunmalı** |
| `fig:s1-s2-kalibre-l1` | 04:189 | 1 (04:183) | |
| `fig:s1-s2-kalibre-dalga` | 04:196 | 4 (03:637, 04:183, **06:582, 06:584**) | **Korunmalı** |
| `sec:guc-tanimlari` | 04:200 | 1 (**06:10**) | G-20 ile kalkarsa 06:10 `eq:guc-ortalama-tanimlari`'ya ya da `tab:sistem-parametreleri`'ye yönlendirilmeli |

**Atıflar:** Bölüm 4'teki sekiz atıf anahtarının hiçbiri yalnız Bölüm 4'te geçmiyor. Bölüm 4'te bir cümle çıkarılınca tezden düşen atıf yok.

| Atıf | Bölüm 4 dışındaki yerler |
|---|---|
| `Mondol2007`, `AbRahman2020` | yalnız 02:175 (04:8 çıkarılırsa orada kalır) |
| `Aneke2016` | 01:7, 02:8 |
| `Chicco2009` | 01:11, 02:220, 02:257, 05:72 |
| `Chen2010` | 10 yer |
| `Schweizer2013` | 5 yer |
| `Zhang2014Deadtime` | 01:17, 02:313, 02:356 |
| `Teodorescu2006PR` | 02:309, 03:359 |

**Bölümler arası gönderme (kural 11):** `\umitnot` dışında 24 gönderme var. `sec:kalibrasyon` 4 kez (41, 155, 166, 202), `sec:dusuk-akim-modelleme` 4 kez (13, 17, 31, 183) anılıyor. 04:13 tek paragrafta üç bölümler arası gönderme kuruyor. Öneriler uygulanırsa sayı ~12'ye iner (G-37).

---

## 4. Bulgu listesi

Biçim: **Kimlik — tür — öncelik — tahmini kazanç**, ardından yer, alıntı ve öneri.

### 4.1 Tekrarlar

**G-01 — tekrar — orta — ~170 kelime**
- **Yer:** 04:4 (cümle 1 ve son cümle), **04:6**, **04:8** ↔ 01:15 ve 01:17 (problem, ters akım, ödünleşim) ↔ 01:11 ve 02:175 (FV kısmi yük süresi, `Mondol2007`, `AbRahman2020`).
- **Alıntı:** 04:6 "Düşük güçteki temel tasarım problemi, verim kazancı ile harmonik bozulma arasındaki ödünleşimin yönetilmesidir." 01:17 aynı ödünleşimi kuruyor.
- **Öneri:**
  - 04:8'i çıkar. Düşük gücün işletme gerekçesi Giriş ve Literatür'ün işidir. İki atıf 02:175'te kalır.
  - 04:6'yı iki cümleye indir: ters akımın RMS kaybı ve kesilmesinin harmonik bedeli. İlk iki cümle G-27'nin konusudur.
  - 04:4'ün ilk cümlesi Bölüm 3'ün içindekiler listesini sayıyor; "Bölüm 3'teki ortak taban üzerinde" demek yeterli. Son cümle ("İki kanıt türü ayrı raporlanmıştır") F-17'nin tekrarıdır ve savunmacı okunur (kural 8). Çıkar.

**G-02 — tekrar — orta — Bölüm 4'te ~30, Bölüm 3'te ~90 kelime**
- **Konu:** Ters akım sayısal eşiği (~9 A tepe–tepe, ~4,5 A sınır akımı, ~3,3 A tepe akım).
- **Yer:** **04:13** (cümle 5–6), 04:183 (cümle 9: "S1'de yaklaşık 9 A tepe–tepe…"), 04:208 (cümle 2) ↔ **03:635** (hesabın tamamı).
- **Alıntı:** 04:13 "akım dalgalanması en çok yaklaşık 9 A tepe–tepe, sınır akımı … en çok yaklaşık 4,5 A'dir".
- **Öneri:** Hesap tek yerde dursun.
  - Tercih: **Bölüm 4:13.** Hesap düşük güç mekanizmasının argümanıdır, "susturma neden gerekli" sorusunu yanıtlıyor. 03:635 ise "Düşük akımda benzetim modelleme" başlığı altında, yani model doğruluğu bağlamında duruyor.
  - 03:635'te genel eşitlikler (`eq:buck-akim-dalgalanmasi`, `eq:ters-akim-esigi`, `eq:sinir-akimi`) kalsın, sayısal hesap bir cümleye insin. 10 A / 25 A S4 uzantısı Bölüm 5'e aittir.
  - Not: Rapor 12'deki F-12 ters yönü (Bölüm 3 birincil) önermişti. Önemli olan tek yerde kalmasıdır; F-12 uygulanacaksa 04:13'te yalnız sonuç cümlesi kalır.
  - 04:183'teki "9 A" cümlesini çıkar; şekil zaten gösteriyor.
  - 03:252'deki diyot benzetimi cümlesi 02:259'u tekrarlıyor (F-12'nin ikinci yarısı). Çıkar.

**G-03 — tekrar (ve yanlış yer) — yüksek — Bölüm 3'te ~110, Bölüm 2'de ~45 kelime**
- **Konu:** Susturmalı çalışmanın devre davranışı: senkron olmayan diyotlu alçaltıcı, akımın sıfırda kalması, kutup geriliminin filtre tarafını izlemesi, ara seviye, yumuşak kaynak.
- **Yer:** **04:106 (cümle 3–6), 04:108, `fig:susturma-esdeger` (birincil)**, 04:183 (cümle 3–4) ↔ 03:637 (paragrafın tamamı, ara seviye oranları ve Bölüm 4 şekline ileri gönderme) ↔ 02:305 (F-33) ↔ 06:526 (yumuşak kaynak).
- **Alıntı:** 03:637 "faz kolu, senkron alçaltıcı dönüştürücüden senkron olmayan, diyotlu alçaltıcı dönüştürücüye geçmektedir" ↔ 04:108 "senkron olmayan alçaltıcıdır".
- **Öneri:** Birincil yer Bölüm 4, çünkü tezin ilk katkısının devre açıklamasıdır ve şekil buradadır.
  - 03:637'yi tek cümleye indir: "Susturmalı çalışmada süreksiz iletim köprüyü yumuşak bir kaynak gibi davrandırmaktadır." Ara seviye oranları ve `fig:s1-s2-kalibre-dalga` göndermesi Bölüm 3'ten çıksın. 11 dış gönderme alan `sec:dusuk-akim-modelleme` etiketi yerinde kalır.
  - 02:305'i çıkar (F-33). Literatür bölümü tezin kendi bulgusunu vermemeli.

**G-04 — tekrar — orta — Bölüm 4'te ~70, Bölüm 3'te ~40 kelime**
- **Konu:** Kapı mantığı, susturulan anahtar ve ölü zaman.
- **Yer:**
  - Hangi anahtarın susturulduğu bölüm içinde altı kez anlatılıyor: 04:80 (cümle 5–6), `tab:model-kapi-mantigi`, 04:106 (cümle 1–3), alt şekil başlıkları 04:115 ve 04:120, 04:126 (cümle 3–4), 04:135 (cümle 2–4).
  - "Klasikte tümleyen, susturmada sabit 1/0": 04:85 (cümle 2–4) ↔ 03:427 (son iki cümle) ↔ 03:157 (cümle 5–6).
  - "S1 kapı mantığı Tablo t-tipi-durumlar ile birebir aynıdır": 04:106 son cümle ↔ 03:157 cümle 7.
  - 1 µs ölü zaman ve kaynağı: 04:85 (cümle 6), 04:155 (cümle 7–8) ↔ 03:427, 03:429, parametre tablosu.
- **Alıntı:** 04:85 "Nötr anahtar komutları ise PWM çıkışlarının mantıksal tümleyenidir." ↔ 03:427 "nötr anahtar komutları, dış anahtar PWM çıkışlarının mantıksal tümleyenidir".
- **Öneri:**
  - S1–S2/S3 kapı karşılaştırması Bölüm 4'te, tabloyla birlikte kalsın (F-07 ile uyumlu).
  - 03:427'nin son iki cümlesini ve 03:157'nin 5–7. cümlelerini çıkar. Bölüm 3'te bir cümle kalsın: "Susturmalı kapı mantığı Alt Bölüm 4.x'te verilmiştir."
  - 04:80'in son üç cümlesini tek cümleye indir; tablo hemen ardından geliyor.
  - 04:85'teki ölü zaman cümlesini ve 04:155'teki "ölü zaman yazmacından gelen tasarım değeri" cümlesini çıkar. Değer ve kaynağı tabloda var.
  - 04:106'nın son cümlesini çıkar.
  - Kapı işareti şekilleri için G-24'e bak.

**G-05 — tekrar — düşük — ~95 kelime**
- **Konu:** Tek faz kolu, SPWM, açık çevrim ve senaryo tanımları.
- **Yer:** 04:39 (paragrafın tamamı), 04:161 (cümle 1–3 ve 5) ↔ 03:5, 03:359, 03:427, 03:547, 01:54, 05:236, 06:234.
- **Alıntı:** 04:39 "Benzetim ve deney, prototipin tek faz kolunu kapsamaktadır."
- **Öneri:**
  - 04:39'u çıkar. Tek faz kolu kapsamı 01:52 ile 03:5'te, modülasyon 03:427'de var. "Faz başına inceleme … açıkça göstermektedir" cümlesi bilgi taşımıyor.
  - 04:161'i iki cümleye indir: senaryolar arasındaki fark (G-30'daki düzeltmeyle birlikte) ve açık çevrimin mekanizmayı ayırma işlevi. "Senaryo eşlemesi … doğrulanmıştır" cümlesi G-04'teki tekrarın bir halkasıdır.

**G-06 — tekrar — düşük — ~55 kelime**
- **Konu:** Kalibrasyon özeti ("aktif ve reaktif güce kalibre, diğerleri bağımsız") ve "ayrı raporlanmıştır".
- **Yer:** 04:4 (cümle 4–5), 04:166 (cümle 2–4) ↔ 06:6, 06:522, `tab:kalibrasyon-karsilastirma` başlığı, 03:549.
- **Alıntı:** 04:166 "Aktif güç ve reaktif güç kalibrasyon hedefidir. Şebeke akımı, verim, DA güç ve THD ise bağımsız doğrulama büyüklükleridir."
- **Öneri:** 04:166'da bir cümle yeterli: "S1 ile S2, deneyin aktif ve reaktif gücüne kalibre edilmiş benzetim modeliyle karşılaştırılmaktadır." Kalan kısım ve 04:4'teki tekrar çıkarılabilir.

**G-07 — tekrar — yüksek — ~50 kelime (bölüm sonucunda; Bölüm 6'ya ait ayrıntılar G-21'de)**
- **Konu:** S1/S2 verim ve THD sayıları.
- **Yer:** Bölüm 4 içinde üç kez: 04:168, 04:170 ve **04:210**. Dışarıda: 06 `tab:deney-dusuk-guc-ozeti`, `tab:kalibrasyon-karsilastirma`, `tab:thd-kaynaklar`, 06:347, 06:595 (2,78 ve 1,7 puan), 08:32, 08:54 (`tab:katki-yontem-kanit`), 01:43, 05:231, `ozet`.
- **Alıntı:** 04:210 "Model S2'nin DA gücünü \%0,004, verimini 0,27 puan hatayla yeniden üretmekte".
- **Öneri:**
  - Argüman Bölüm 4 §`sec:s1-s2-kalibre`'de kalsın (08:55 bu alt bölüme gönderiyor). Sayılar orada bir kez geçsin, tablolar Bölüm 6'da kalsın.
  - 04:210'u iki cümleye indir: verim artışı ve THD bedeli birer sayı çiftiyle, ardından Sin³ gerekçesi. Model hatası cümlesi ve "Mutlak değerler arasındaki farklar Tablo … içinde ayrıntılı" cümlesi çıksın.
  - Bölüm 8 ve Bölüm 1'deki tekrarlar Rapor 12'nin konusudur (F-32), burada dokunulmaz.

**G-08 — tekrar — yüksek — ~110 kelime (F-05)**
- **Konu:** $P_{\mathrm{dc}}$, $P_{\mathrm{ac}}$, C noktası, üretici işaret kuralı, $Q_{g,1}$ işareti, değerlendirme penceresi.
- **Yer:** **04:202** ↔ **03:570–583 (birincil, eşitliklerle)** ↔ 06:524.
- **Alıntı:** 04:202 "İşaret kuralı üreticidir. Evirici fazından şebekeye akan akım pozitiftir" ↔ 03:578 "$i_g$ ise üretici kuralıyla, evirici fazından şebekeye doğru pozitif alınmaktadır."
- **Öneri:** 04:202'yi tamamen çıkar (G-20). 04:202'de Bölüm 3'te olmayan iki bilgi var:
  - "$L_2$ verim hesabının dışındadır." Gerekiyorsa 03:578'e bir yan cümle olarak eklenebilir.
  - "Güç, kaynağın ters akım diyotu ile bağlantı direncinden sonra ölçülmektedir." Bu bir model ayrıntısıdır, tablo notunda (03:531) diyot zaten anılıyor. Çıkarılabilir.

**G-09 — tekrar — orta — Bölüm 4'te ~80, Bölüm 6'da ~35 kelime (F-19)**
- **Konu:** 20 kVA, 20–25 kW, ~30 A, 120 V, 250–280 W, S4 anma noktası ~3 kW.
- **Yer:** **04:204** ↔ 03 `tab:sistem-parametreleri` (birincil) ↔ 06:10 ↔ 01:54.
- **Alıntı:** 04:204 "Yaklaşık 30 değeri tezde yalnız faz akımı tasarım değeri olarak, amper biriminde geçmektedir".
- **Öneri:**
  - 04:204'ü çıkar (G-20). Okura görmediği bir tutarsızlığın düzeltme notunu okutan "Yaklaşık 30 değeri…" cümlesi bu çıkarmayla birlikte gider (kural 10'un ruhu).
  - "S4'ün anma noktası ~3 kW" bilgisi Bölüm 5'te yok. Gerekiyorsa Bölüm 5'in S4 tarama kesimine (05:268 civarı) bir cümle olarak taşınsın.
  - 06:10'un ikinci cümlesini ve `sec:guc-tanimlari` göndermesini çıkar ya da `tab:sistem-parametreleri`'ye yönlendir.

**G-10 — tekrar (ve yanlış yer) — düşük — ~35 kelime**
- **Yer:** 04:31 (cümle 4) ↔ 03:631 (S3 kayıp ayrışımı, F-34'e göre Bölüm 3'te kalıyor).
- **Alıntı:** 04:31 "$L_1$ çekirdek kaybının baskın olduğunu ve anahtarlama kaybının toplam kaybın yaklaşık \%7'sinde kaldığını göstermiştir".
- **Öneri:** Bölüm 4'ten çıkar. Bölüm 4 S1–S2 karşılaştırmasıdır. S3'ün kayıp ayrışımı burada "kayıp nötr kola kayıyor" önermesini desteklemiyor (G-13).

**G-11 — tekrar — düşük — ~40 kelime**
- **Konu:** Harmonik cezanın mekanizması: süreksiz iletim, alternans ortasındaki çökme, sıfır geçiş çevresindeki eğim farkı.
- **Yer:** 04:6 (cümle 5), **04:157**, `tab:klasik-onerilen-islevsel` 4. satır, 04:183 (cümle 3) ↔ **05:47–126 (`sec:harmonik-mekanizma`, birincil)**, 05:221.
- **Alıntı:** 04:157 "Alternans ortasında … akım zarfındaki çökmenin nedeni, DA bara ile şebeke gerilimi arasındaki akım yükseltme payının azalmasıdır."
- **Öneri:** 04:157 Bölüm 4'ün bedel anlatımıdır, kalsın, ama üç cümleye insin: susturma süreksiz iletime zorlar, akım zarfı alternans ortasında çöker, sonuç üçüncü harmoniktir. Mekanizmanın nicel açıklaması Bölüm 5'te. Paragrafın yeri için G-22'ye bak.

### 4.2 Gereksiz ayrıntı

**G-12 — gereksiz ayrıntı (kullanılmayan tanım) ve jüri riski — orta — ~90 kelime**
- **Yer:** 04:19–24 (`eq:ters-akim-yuku`, Q_rev), 04:24–29 (`eq:iletim-kaybi-yaklasik`, P_cond, V_on, R_on, I_avg,abs, I_rms).
- **Alıntı:** 04:24 "Ters akım yükü, kayıp enerjisi ya da güç yerine farklı anahtarlama yöntemlerindeki dolaşımı karşılaştırmak için kullanılmaktadır."
- **Gerekçe:**
  - Q_rev bölümde ve tezde hiçbir sayısal sonuçla verilmiyor. 04:183 ters akımı zaman oranıyla (%25,2) ölçüyor. 08:117 "ters akım yükü"nü gelecek çalışmalar arasında sayıyor. Jüri sorusu: "Tanımladığınız ölçütün değeri nerede?"
  - P_cond yalnız nitel yorum için kullanılıyor (04:29 son iki cümle, 04:31). RMS akımın kaybı büyüttüğü bilgisi tek cümleyle de verilebilir.
- **Öneri:** İki seçenek var.
  - (a) Q_rev'i S1 için mevcut $L_1$ kayıtlarından hesapla ve 04:183'te zaman oranının yanında ver (S2'de tanım gereği sıfır). Ek benzetim gerektirmez; kayıtlar 04:183'te anılan yinelenmiş benzetimlerde var. Bu, ölçütü işe yarar kılar.
  - (b) Q_rev eşitliğini çıkar ve 08:117'de tanımsız kalmaması için orada kısa bir tanım ver.
  - P_cond eşitliği iletim kaybının RMS bağımlılığını göstermek için kalabilir. 04:29'un "anahtarlama enerjisini … içermeyen ilk mertebe" ve "bağlantı iletkenleri" cümleleri çıkarılabilir.
  - Etiketler yalnız Bölüm 4 içinden gönderme alıyor, dışarıda bozulan bir şey olmaz.

**G-13 — gereksiz ayrıntı (desteksiz önerme) — orta — ~45 kelime (G-10'un 35 kelimesi hariç)**
- **Yer:** 04:31 (cümle 1–3 ve 5).
- **Alıntı:** "toplam kayıp, ana anahtarlardan nötr kol elemanlarına ve serbest dolaşım yollarına doğru yeniden dağılmaktadır."
- **Gerekçe:** Önerme S1 ile S2 arasında bir kayıp ayrışımı gerektiriyor. Bölümde böyle bir ayrışım yok. Verilen tek ayrışım S3'e ait ve baskın kaybın $L_1$ çekirdek kaybı olduğunu söylüyor. "Modülasyon indeksi küçüldükçe" gerekçesi G-27'deki fiziksel sorunu taşıyor.
- **Öneri:** Paragrafı tek cümleye indir: "Düşük akımda $V_{\mathrm{on}}I_{\mathrm{avg,abs}}$ teriminin çıkış gücüne oranı büyür. S1 ile S2 arasındaki kayıp farkı DA ve AA güçlerinin farkından değerlendirilmiştir."

**G-14 — gereksiz ayrıntı — orta — ~160 kelime**
- **Yer:** 04:33 (cümle 1–5) ve **04:155** (paragrafın tamamı, "Güvenli uygulamada dört koşul…").
- **Alıntı:** 04:33 "Güvenilir uygulama akım eşiği, histerezis, minimum bekleme süresi ve güvenli komütasyon koşullarını birlikte kullanmalıdır."
- **Gerekçe:**
  - İki paragraf aynı konuyu (uygulamada güvenilir karar ve güvenli komütasyon) iki yerde, "-meli/-malı" kipinde anlatıyor. Biri mekanizma kesiminin sonunda, öteki alt bölümün ortasında, S3 şeklinin ardında duruyor.
  - Anlatılan koşulların çoğu (eşik, histerezis, bekleme süresi, ölçüm geçersizliğinde güvenli kipe dönüş) bu tezde uygulanmamış ve sınanmamıştır. 08:115 bunları gelecek çalışma olarak sayıyor. Jüri sorusu: "Bu dört koşulu prototipte nasıl sağladınız?"
- **Öneri:** İki paragrafı ~60 kelimelik tek paragrafta birleştir ve önerilen yöntem kesiminin sonuna, kuralın ardına koy. Kalsın:
  - Tezde uygulanan biçim: yarım periyot işaretine bağlı sabit susturma.
  - Ölü zamanın korunması.
  - Nötr yol kesildiğinde akımın sıfırda kendiliğinden söndüğü ve aşırı gerilim yolunun D₁–D₂ olduğu (G-32 ile birlikte düzeltilmiş hâliyle).
  - 04:33'ün son cümlesi (ölçüm büyüklükleri) ve `sec:s1-s2-kalibre` göndermesi kalabilir.
  - Eşik ve histerezis Bölüm 8'e bırakılsın.

**G-15 — gereksiz ayrıntı (süreç notu) — düşük — ~110 kelime**
- **Yer ve alıntılar:**
  - 04:17, son cümle: "Kayıp karşılaştırması, gerçek parça kodlarının veri sayfası karakteristikleriyle kurulan anahtarlamalı benzetim modelinde yapılmıştır".
  - 04:85, cümle 1: "Senaryo tanımları ile benzetim modellerinin kapı üretim yapısı blok blok karşılaştırılmıştır."
  - 04:126, cümle 1: "S2 kapı yolu, tezdeki nötr anahtar susturma tanımına göre kurulmuştur". Okura modelin sonradan düzeltildiğini sezdiriyor.
  - 04:135, son cümle: "Ölü zaman ve kapı polaritesi model bloklarından okunmuştur."
  - 04:144, son cümle: "Bölümdeki sayısal sonuçlar doğrulanan ve kalibre edilen modellerden alınmıştır."
  - 04:183, cümle 8: "Kayıt, kalibrasyon değerleri değiştirilmeden … yinelenen benzetimlerden alınmıştır."
- **Öneri:** Çıkar. Model kalite güvencesi Bölüm 3 §`sec:model-dogrulama-duzeltme`'de bir kez anlatılıyor. Bölüm 4'te tekrarlanınca çalışma sürecini anlatıyor ve argümana bilgi eklemiyor.
- **Not:** 04:126'daki `sec:model-dogrulama-duzeltme` göndermesi düşer. Etiket 8 dış gönderme alıyor, etkilenmez.

**G-16 — gereksiz ayrıntı — düşük — ~55 kelime**
- **Yer:** 04:183. 168 kelimelik paragraf iki şeklin başlıklarını düzyazıyla yeniden anlatıyor.
- **Alıntı:** "Alt panel aynı zaman aralığında iki senaryonun kutup gerilimini göstermektedir."
- **Öneri:** Panel betimlemesini başlıklara bırak. Paragrafta yalnız nicel bulgular kalsın: S1'de %25,2 ters akım ve –2,6 A, S2'de ters akım yok ve %17 sıfır akım. Ayrıca G-02 ve G-15'teki cümleler çıkar. Şekillerin yerleşimi için G-26'ya bak.

**G-17 — gereksiz ayrıntı — düşük — ~45 kelime**
- **Yer:** 04:37 (paragrafın tamamı).
- **Alıntı:** "Pozitif alternansta aktif enerji aktarımının yolu $P$ durumu, serbest dolaşımın yolu $O$ durumudur."
- **Gerekçe:** Paragraf 03:159 ("Modülasyon, pozitif yarım periyotta $P$ ile $O$…"), `tab:t-tipi-durumlar` ve 04:13 (cümle 3) ile aynı bilgiyi veriyor. Son cümle G-27'nin sorununu taşıyor.
- **Öneri:** Çıkar ya da tek cümleye indir. "Klasik Anahtarlama Yöntemi" başlığı 04:41 (G-28'e göre düzeltilmiş) ve tabloyla dolu kalır; başlık silmek gerekmez.

**G-18 — gereksiz ayrıntı (iç not, kural 10) — yüksek (temizlik) — 117 kelime (PDF'te görünmez)**
- **Yer:** 04:172–179, `\umitnot{S1 THD: mailinizdeki değerlendirme işlendi}`.
- **Kural 10'a aykırı ifadeler:**
  - 04:172 başlık: "mailinizdeki değerlendirme işlendi".
  - 04:174: "Metindeki ``tutarsızlık'' ve ``\%42'' ifadeleri kaldırıldı. Önceki A/B kararı da kapandı".
  - 04:175: "İlk tezin Şekil~5.18'indeki faz akımı izi sayısallaştırıldı".
  - 04:176: "Tablo~5.4. Yeni tezdeki karşılığı Tablo~\ref{tab:deney-dusuk-guc-ozeti}".
  - 04:177: "Temmuz benzetimi. … Bölüm~\ref{chap:anahtarlama} ve Bölüm~\ref{chap:sin3}'ten çıkarıldı."
- **Durum:** `tezpaketleri.sty`:54–67'ye göre not yalnız `\UMITNOTLARI` tanımlıysa (`tez_notlu.pdf`) basılıyor. Nihai PDF'te görünmez.
- **Öneri:** Notun bütün maddeleri "kapandı/işlendi" diyor. Bloğu sil. İçindeki göndermeler (`tab:thd-kaynaklar`, `tab:deney-dusuk-guc-ozeti`, `sec:kalibrasyon`, `chap:*`) başka yerlerden de gönderme aldığı için etiket sayımı bozulmaz.
- **Bölüm 4 dışı, bilgi için:** 06:588 `\umitnot` "Mailinizin 4. maddesi" ve "Temmuz benzetimine aittir" ifadelerini içeriyor (kural 10). 05:296'daki not kural 10 açısından temiz görünüyor.

### 4.3 Yanlış yere konmuş içerik

**G-19 — yanlış yer — yüksek — Bölüm 4'te ~150 kelime ve 1 yatay sayfa (tez geneli için net ~50 kelime)**
- **Yer:** 04:144 (paragraf) ve 04:146–153 (`fig:s3-simulink-modeli`, `landscape` sayfa).
- **Alıntı:** 04:150 "S3 benzetim modelinin üst düzey çizimi. … Güç katı ve ölçüm blokları Senaryo~1--4 modellerinde aynıdır."
- **Gerekçe:**
  - Şekil S3 modelini ve Sin³ modülasyonunu gösteriyor. Konusu Bölüm 3'ün ortak model tabanı ya da Bölüm 5'tir. "Modelden okunan kapı mantığı" alt başlığıyla ilgisi yok.
  - Şekil Bölüm 5'ten iki gönderme alıyor (05:236, 05:241). Bölüm 4'te kapı tablosu ile susturma eşdeğeri arasında okumayı tam sayfa kesiyor.
  - 04:144'ün içeriği Bölüm 3'te var: 03:599 (S1–S2 ortak dosya, ortak parametre dosyası) ve `tab:sistem-parametreleri`.
- **Öneri:** Şekli Bölüm 3 §`sec:model-dogrulama-duzeltme`'nin ilk paragrafının (03:599) ardına taşı. Etiket aynı kalsın, 05:236 ve 05:241 bozulmaz. Bölüm 5'e taşımak da kabul edilebilir, ama başlık güç katının S1–S4'te ortak olduğunu söylüyor, bu da Bölüm 3'ü uygun kılıyor. 04:144'ü çıkar; "S4 … akım geri beslemesiyle ayrılmaktadır" bilgisi 05:236'da var.

**G-20 — yanlış yer (başlık silme) — yüksek — kazanç G-08 ve G-09'da sayıldı (~190 kelime)**
- **Yer:** 04:199–204, `\subsection{Güç tanımları, işaret kuralı ve anma ifadeleri}` (`sec:guc-tanimlari`).
- **Gerekçe:**
  - "Tezde raporlanan bütün benzetim verimleri aynı tanıma dayanmaktadır" (04:202) tez geneline ait bir tanımdır. Bölüm 4'ün sonuç kesiminin içinde, sonuçlar verildikten sonra duruyor.
  - İçeriğin tamamı Bölüm 3'te (03:570–583) ve parametre tablosunda var.
  - Tek gönderme 06:10'dan geliyor, o da F-19'daki tekrarın parçası.
- **Öneri:** Alt bölümü başlığıyla birlikte kaldır. 06:10'daki göndermeyi `eq:guc-ortalama-tanimlari`'ya ya da `tab:sistem-parametreleri`'ye yönlendir. Başlık silmenin güçlü gerekçesi şudur: kalan hiçbir içerik Bölüm 4'e özgü değil.

**G-21 — yanlış yer — orta — ~110 kelime**
- **Konu:** Kalibrasyon kalitesi Bölüm 6'nın içeriğidir.
- **Yer:**
  - 04:168, cümle 6–8: S2 DA güç hatası %0,004 ve –0,27 puan, S1 kaybı 24,0/19,7 W ve diyot toparlanmasına duyarlılık, "0,1 saniyedeki oturma farkı" ile 0,1 puan belirsizlik. Karşılıkları 06:582, 06:584, 06:597 ve tablo.
  - 04:170, cümle 4–6: THD'nin analizör/osiloskop kaynakları, S3 THD'si, "kalibrasyon incelemesinde ele alınmıştır". Karşılıkları 06:495–513 ve 06:578.
  - 04:181, son cümle: "Kalibre S2 genliğinin … ilk değerden \%3,3 düşük olması". Karşılığı 06:549.
- **Alıntı:** 04:168 "Verim farkının belirsizliği, 0,1 saniyedeki oturma farkı nedeniyle S2 için yaklaşık 0,1 puandır."
- **Öneri:** Çıkar. Bölüm 4'te üç bulgu kalsın (verim, harmonik ceza, köprü davranışı), her biri bir iki sayıyla.
- **Jüri notu:** 04:168 yalnız benzetim tarafı belirsizliğini (0,1 puan) veriyor. Deney tarafı (06:389, DA analizöründen ±0,5 puan) Bölüm 4'te yok. Belirsizlik Bölüm 4'te anılacaksa deney belirsizliği de anılmalı. Yoksa ikisi birlikte Bölüm 6'da kalsın.

**G-22 — yanlış yer (paragraf yerleşimi) — orta — 0 kelime**
- **Yer:** 04:155 (güvenli uygulama) ve 04:157 (harmonik ceza), "Modelden okunan kapı mantığı ve senaryo eşlemesi" alt bölümünün sonunda, S3 model şeklinin ardında.
- **Gerekçe:** İki paragraf da kapı mantığının modelden okunmasıyla ilgili değil. 04:157 yöntemin bedelini anlatıyor ve "Verim ve Harmonik Performans Ödünleşimi" kesimine en yakın içerik.
- **Öneri:** 04:157'yi (G-11'e göre kısaltılmış) "Önerilen Anahtarlama Yöntemi" ana metninin sonuna, alt bölümden önceye al. 04:155 G-14 ile 04:33 ile birleşip aynı yere gitsin. `sec:model-kapi-mantigi` alt başlığı dört dış gönderme aldığı için kalsın; içeriği tablo, 04:106, şekil 4.x ve birleştirilmiş kapı işareti şekli (G-24) olsun.

### 4.4 Oran

**G-23 — oran — orta — kazanç tek tek bulgularda sayıldı**
- **Ölçüm (bugünkü hâl):**

  | İçerik | Kelime | Pay |
  |---|---:|---:|
  | Yöntemin özü: mekanizma (04:13, 04:15), kural (04:63–80), kapı farkı (tablo, 04:106), susturma eşdeğeri (04:108 ve şekil), bedel (04:157) | ~840 | %24 |
  | Kanıt: S1–S2 kalibre karşılaştırması (04:168, 170, 181, 183 ve iki şekil) | ~480 | %14 |
  | Çevre anlatım: giriş, kayıp modeli, uygulama koşulları, klasik yöntem genel anlatımı, model ve kapı işareti şekilleri, S3 şekli, güç tanımları, bölüm sonucu, `\umitnot` | ~2 150 | %62 |

- **Gözlem:**
  - En uzun alt bölüm ("Modelden okunan kapı mantığı", 1 035 kelime) kuralın kendisinden (202 kelime) beş kat uzun.
  - Bedel tek paragrafta, alt bölümün sonunda kalıyor.
  - Bölüm 3'ün en ağır kısmı da model kalite güvencesiydi (F-38). Bölüm 4'te aynı eğilim kapı işareti şekilleri ve süreç cümleleriyle sürüyor.
- **Öneri:** G-01, G-12–G-17, G-19–G-22 ve G-24 uygulanırsa Bölüm 4 ~1 900 kelimeye iner. Öz ~%45, kanıt ~%25, çevre ~%30 olur. Önerilen sıra:
  1. Mekanizma
  2. Klasik yöntem
  3. Önerilen kural, kapı farkı, eşdeğer devre, bedel, uygulama koşulu
  4. S1–S2 kanıtı
  5. Sonuç

  Başlık yapısı G-20 dışında korunabilir.

### 4.5 Şekil ve tablo fazlalığı

**G-24 — şekil/tablo — orta — ~0,5 sayfa ve ~90 kelime**
- **Yer:** `fig:s2-kapi-isaretleri` (04:128–133) ve `fig:s1-kapi-isaretleri` (04:137–142) ↔ `tab:model-kapi-mantigi` (04:87–104). Metin 04:126 ve 04:135.
- **Alıntı:** 04:135 "Kapı dizileri Tablo~\ref{tab:model-kapi-mantigi} ile örtüşmektedir."
- **Gerekçe:** İki tam genişlikli şekil, tablonun ideal durumlarla verdiği bilgiyi dalga biçimi olarak tekrarlıyor. Tek ek bilgi, nötr anahtarların S2'de yarım periyot boyunca sabit kalmasıdır; o da tabloda ve 04:85'te var. İki şekil de yalnız kendi paragrafından gönderme alıyor.
- **Öneri:** Tek şekilde birleştir: yalnız 400 µs kesitte S1 ve S2 yan yana, ya da üst üste dört satır. Bir şebeke periyodu panelleri bilgi taşımıyor. Ya da S1 şeklini çıkar: klasik tamamlayıcı sürme okurun bildiği yapıdır, fark tabloda kalın hücrelerle gösteriliyor. 04:126 ve 04:135'i tek kısa paragrafa indir.

**G-25 — şekil/tablo — düşük — ~50 kelime**
- **Yer:** `tab:klasik-onerilen-islevsel` (04:43–59) ↔ 04:41 (cümle 4–6), 04:63 (cümle 1–2), 04:157.
- **Gerekçe:** Tablo satırları "beklenen kayıp etkisi" ve "beklenen harmonik etkisi" gibi önceden kestirim diliyle yazılmış. Aynı bilgiler metinde ve bölüm sonunda ölçülmüş olarak var. "Gerekli tamamlayıcı önlem: güvenli kip geçişi" satırı tezde uygulanmayan bir önlemi gerekli sayıyor (G-29).
- **Öneri:** Tablo işlevsel özet olarak kalsın. 04:41'in tabloyu düzyazıyla anlatan son üç cümlesini çıkar. Son satırdaki "güvenli kip geçişi"ni G-29 kararına göre ya çıkar ya da "(gelecek çalışma)" diye işaretle. İstenirse "beklenen" satırlarına ölçülen yön eklenebilir; bu bir içerik kararıdır.

**G-26 — şekil/tablo — düşük — 0**
- **Yer:** 04:183 önce `fig:s1-s2-kalibre-dalga`'ya, sonra `fig:s1-s2-kalibre-l1`'e gönderiyor. Kayan nesneler ters sırada yerleştirilmiş (l1 04:185'te, dalga 04:192'de).
- **Öneri:** İki şeklin sırasını ya da metindeki gönderme sırasını değiştir. İki şekil farklı bilgi veriyor (kutup gerilimi ve şebeke akımı ile $L_1$ akımı), ikisi de kalmalı. `fig:s1-s2-kalibre-dalga` dört gönderme alıyor (03:637, 06:582, 06:584).

### 4.6 Jüri riski

**G-27 — jüri riski (fiziksel önerme) — yüksek — ~30 kelime (G-01, G-13, G-17 ile örtüşen kısım hariç)**
- **Yer:** 04:6 (cümle 2), 04:31 (cümle 3), 04:33 (cümle 1, "küçük modülasyon bölgesinde"), 04:37 (son cümle) ↔ 03:215 (cümle 1).
- **Alıntı:** 04:6 "Modülasyon indeksinin küçülmesi aktif gerilim durumlarının süresini azaltırken sıfır durumunun … payını artırmaktadır."
- **Gerekçe:**
  - Şebekeye bağlı eviricide sürekli iletimde yerel görev oranı şebeke gerilimiyle belirlenir (d ≈ v_g/V_h, Eşitlik `eq:buck-akim-dalgalanmasi`). Aktarılan akım küçülünce modülasyon indeksi ancak filtre üzerindeki küçük gerilim düşümü kadar değişir.
  - S1–S3'te $V_{\mathrm{dc}}$ ve şebeke gerilimi sabit, akım ~2,3 A. Modülasyon genliği anma akımındakinden belirgin biçimde küçük değildir.
  - Düşük güçteki asıl neden 04:13'te doğru verilmiş: dalgalanma genliği akımla küçülmez, ortalama akım küçülür. Jüri bu çelişkiyi sorabilir.
- **Öneri:** Bu cümleleri çıkar. Düşük güç mekanizmasını yalnız dalgalanma/ortalama akım oranıyla (04:13) anlat. Böylece G-01 ve G-17'deki tekrarlar da kendiliğinden azalır. 04:33'teki "veya küçük modülasyon" ibaresini çıkar. Bölüm 3:215'in ilk cümlesi de aynı biçimde düzeltilmeli.

**G-28 — jüri riski (iç çelişki) — yüksek — ~40 kelime**
- **Yer:** 04:41 (cümle 1–2) ↔ 04:17 (cümle 1–3) ↔ 03:257 (bölge listesi, madde 1).
- **Alıntı:** 04:41 "Senkron anahtarlamanın temel üstünlüğü, normal ve yüksek akım bölgesinde diyot iletimini düşük gerilim düşümlü anahtar kanalıyla değiştirebilmesidir."
- **Gerekçe:**
  - Nötr kol sırt sırta iki IGBT ve iç diyotlarından oluşuyor. IGBT ters yönde kanaldan iletmez, nötr yolda akım her zaman bir IGBT ile bir diyottan geçer.
  - Pozitif akımda serbest dolaşım yolu $Q_4$ ile $DS_3$'tür. $Q_3$'ün kapı komutu ancak akım ters döndüğünde etkili olur (04:106 bunu doğru söylüyor).
  - Bu topolojide tamamlayıcı sürmenin işlevi diyot kaybını azaltmak değildir. Akımın iki yönlü sürekliliğini, yani sürekli iletimi ve doğrusal gerilim–görev oranı ilişkisini korumaktır. S1'in daha düşük THD vermesi de bununla tutarlıdır.
  - 04:17 kazancın "IGBT'de daha sınırlı kalabilir" olduğunu söylüyor. 04:41 ise onu "temel üstünlük" sayıyor.
- **Öneri:** 04:41'in ilk iki cümlesini şöyle değiştir: "Klasik yöntemde tamamlayıcı sürme, nötr kolu iki yönlü iletken yaparak akımın sürekliliğini korumaktadır." 04:17'yi iki cümleye indir; MOSFET karşılaştırması kalabilir, kesin dille. 03:257'deki madde 1 aynı biçimde düzeltilmeli.

**G-29 — jüri riski (tanım ile uygulama farkı) — yüksek — ~60 kelime**
- **Yer:** 04:63 (cümle 2–3), 04:65–75 (`eq:susturma-etkinlestirme`), 04:77–80 (`eq:notr-susturma-kurali`); `onkisim/simgeler.tex`:21 ($I_{\mathrm{th}}$) ve :71 ($\chi_{\mathrm{rev}}$).
- **Alıntı:** 04:63 "yalnız akımın sınır iletim bölgesine yaklaştığı koşullarda devreye girmektedir" ↔ 04:80 "$\sigma=1$'dir, yani susturma senaryo boyunca sürekli etkindir".
- **Gerekçe:**
  - Kural $|i^{\ast}(t)|$ ile tanımlanıyor. S1–S3 açık çevrimdir, akım referansı yoktur.
  - $I_{\mathrm{th}}$ ve $H$ için değer verilmiyor. Histerezisin "sürekli kip değiştirmeyi önlediği" sınanmamış (04:75).
  - $\chi_{\mathrm{rev}}$ 04:80'e göre yalnız yarım periyot işaretine bağlı. Uygulanan kural sabit, işaret tabanlı bir maskedir.
  - Eşitlik `eq:notr-susturma-kurali`'de $g_n$ anahtar indeksi taşımıyor. Kural $Q_3$ için pozitif, $Q_4$ için negatif yarım periyotta etkili olmalı. Tek bir $g_n$ ile yazılınca iki anahtarın da susturulduğu okunabilir.
  - $\chi_{\mathrm{rev}}$ hem $\sigma$'nın tanımında hem çarpımda yer alıyor, yani fazlalık var.
  - 08:115 eşiği, histerezisi ve kip geçişini gelecek çalışma sayıyor.
- **Öneri:** Uygulanan kuralı ana tanım yap. Örnek: $g_{Q3,\mathrm{yeni}}=g_{Q3,\mathrm{kl}}\,[1-s(t)]$ ve $g_{Q4,\mathrm{yeni}}=g_{Q4,\mathrm{kl}}\,s(t)$; burada $u\geq0$ için $s=1$, $u<0$ için $s=0$. Bu, Tablo `tab:model-kapi-mantigi` ile birebir örtüşür. $\sigma$, $I_{\mathrm{th}}$ ve $H$ ile verilen akıma bağlı etkinleştirmeyi tek cümleyle "yöntemin akım düzeyine bağlı genişletmesi" olarak an ve ayrıntıyı 08:115'e bırak. `simgeler.tex` buna göre güncellenmeli. İki eşitlik etiketi yalnız Bölüm 4 içinden gönderme alıyor.

**G-30 — jüri riski (Bölüm 5–6 ile çelişki) — yüksek — 0 (bir cümle düzeltmesi ve bir cümle ek)**
- **Yer:** 04:161 (cümle 4) ↔ 05:231, 06:234, `tab:gelen-excel-senaryolar` (06:477), `tab:kalibrasyon-karsilastirma`.
- **Alıntı:** 04:161 "Senaryolar arasında yalnızca nötr kapı mantığı, modülasyon genliği ve referans fazı değişmiştir."
- **Gerekçe:**
  - Deneylerde DA bara 431,5 / 395,0 / 427,5 V, şebeke gerilimi 119,8 / 121,0 / 124,3 V'tur. Bölüm 5 ve 6 bunu açıkça yazıyor.
  - S1→S2 verim karşılaştırmasında (04:168) DA bara S2'de 36 V düşük. Düşük bara gerilimi dalgalanmayı ve anahtarlama kaybını azaltır. Jüri sorusu: "1,7 puanın ne kadarı DA bara farkından?"
- **Öneri:**
  - Cümleyi düzelt: "Her senaryo kendi deneyinin DA bara ve şebeke gerilimiyle benzetilmiştir; modelde kapı mantığı, modülasyon genliği ve referans fazı değişmiştir."
  - Olanak varsa farkı ayıran tek bir benzetim (S1 modeli 395 V'ta ya da S2 modeli 431,5 V'ta) 04:168'e bir cümleyle eklensin. Bu ekleme fazlalık incelemesinin dışındadır ama jüri riskini doğrudan kapatır.

**G-31 — jüri riski (tutarsız etiket) — orta — 0**
- **Yer:** 04:181 (cümle 2), "Kalibre benzetimde…" alt bölümünde ↔ 03:637 ("kalibrasyon öncesi benzetimlerde") ↔ 06 `tab:kopru-ic-empedansi` başlığı ("kalibrasyon öncesi benzetimler").
- **Alıntı:** 04:181 "Kutup geriliminin ara seviyede kaldığı zaman oranı S1'de \%0,5, S2'de \%12,4'tür."
- **Öneri:** Sayılar kalibrasyon öncesine aitse 04:181'de bunu belirt. Ya da kalibre modellerden yeniden ölç ve üç yerde aynı sayıyı kullan. G-03 uygulanırsa sayı Bölüm 3'ten çıkar ve Bölüm 4 ile Bölüm 6 tablosunda kalır.

**G-32 — jüri riski (iç çelişki) — orta — 0**
- **Yer:** 04:106 (cümle 5) ↔ 04:155 (cümle 4–5) ↔ 04:122 (şekil başlığı).
- **Alıntı:** 04:106 "Ters yönde ise akım yolu yoktur." ↔ 04:155 "Ters akım yönünde ise $D_1$--$D_2$ ve dış anahtar diyotları yol sağlamaktadır."
- **Öneri:** Şekil başlığındaki kesin ifadeyi iki yerde de kullan: "nötr koldan ters yönde yol yoktur; kutup gerilimi DA rayını aşarsa $D_1$--$D_2$ iletime girer." G-14 birleştirmesinde tek cümle olarak kalsın.

**G-33 — jüri riski (ölçü karışıklığı) — orta — 0 (bir yan cümle)**
- **Yer:** 04:13 (son cümle) ve 04:208 (cümle 2) ↔ 04:183 (cümle 10).
- **Alıntı:** 04:208 "klasik anahtarlama temel periyodun büyük bölümünde ters akıma izin vermektedir" ↔ 04:183 "Pozitif yarım periyodun \%25,2'sinde akım … ters yöndedir."
- **Gerekçe:** Birinci önerme anahtarlama periyodunda sıfırı kesen periyotların payını, ikincisi ters akımın zaman payını anlatıyor. Okur "büyük bölüm" ile %25'i çelişkili okuyabilir.
- **Öneri:** 04:183'te iki ölçüyü ayır: "Pozitif yarım periyottaki anahtarlama periyotlarının %x'inde akım sıfırı kesmekte, toplam sürenin %25,2'sinde akım ters yöndedir." x, mevcut $L_1$ kaydından okunabilir. 04:208'i buna göre yaz.

**G-34 — jüri riski (simge tutarsızlığı) — düşük — 0 (Bölüm 6'da düzeltme)**
- **Yer:** 06:545 ↔ 03:241–245 (Δi_L tanımı, tepe–tepe) ↔ 04:13 ve 04:183 (~9 A tepe–tepe, –2,6 A negatif tepe).
- **Alıntı:** 06:545 "$V_{\mathrm{dc}}t_df_s/\Delta i_L\approx\SI{431}{\volt}\cdot\SI{1}{\micro\second}\cdot\SI{10}{\kilo\hertz}/\SI{2.6}{\ampere}$".
- **Öneri:** Bölüm 6'daki kestirimde Δi_L yerine ayrı bir simge kullan ya da 2,6 A'in ne olduğunu belirt (04:183'teki negatif tepe). Bölüm 4'te değişiklik gerekmez.

**G-35 — jüri riski (simge çakışması) — düşük — 0**
- **Yer:** 04:150 (başlık: "Şekildeki S1--S4 etiketli anahtarlar sırasıyla $Q_1$--$Q_4$'tür") ↔ 03:73 ↔ 03:491–494 (tabloda $S_1$--$S_2$ anahtar adı) ↔ tez genelinde S1–S4 senaryo adı.
- **Öneri:** Tabloda anahtar adlarını $Q_1$–$Q_4$ yap. S1–S4 yalnız senaryo adı olarak kalsın. Model çizimindeki etiketler değiştirilemiyorsa başlıktaki eşleme cümlesi yeterli. G-19 ile şekil taşınınca bu cümle Bölüm 3'e gider.

**G-36 — jüri riski (atıf yeri) — düşük — 0**
- **Yer:** 04:33, paragraf sonu `\citep{Teodorescu2006PR,Zhang2014Deadtime}`.
- **Gerekçe:** Atıflar "susturmanın etkisi … ölçülmüştür" cümlesinin ardında duruyor. `Teodorescu2006PR` bir PR denetleyici çalışmasıdır, ölçüm ölçütlerini desteklemez. `Zhang2014Deadtime` 04:155'te de kullanılıyor.
- **Öneri:** G-14 birleştirmesinde atıfları ilgili önermenin yanına koy: ölü zaman için `Zhang2014Deadtime`. `Teodorescu2006PR` gerekmiyorsa çıkar; 02:309 ve 03:359'da kalır.

**G-37 — jüri riski (kural 11) — düşük — 0**
- **Yer:** 04:13 (üç bölümler arası gönderme tek paragrafta), 04:41, 04:155, 04:166, 04:202 (`sec:kalibrasyon` dört kez), 04:13, 04:17, 04:31, 04:183 (`sec:dusuk-akim-modelleme` dört kez).
- **Öneri:** G-02, G-13, G-14, G-15, G-20 ve G-21 uygulanınca bölümler arası gönderme 24'ten ~12'ye iner. 04:13'te tek gönderme (ya Bölüm 3 eşitliği ya da hiçbiri) kalsın.

---

## 5. Önerilen uygulama sırası

1. **Jüri riski düzeltmeleri (içerik değiştirir, önce yapılmalı):** G-27, G-28, G-29, G-30. Bunlar G-01, G-13, G-14 ve G-17'nin kısaltacağı paragraflara dokunuyor. Önce önermeler düzeltilmeli, sonra kısaltılmalı. Bölüm 3:215 ve 3:257'deki eşleri de birlikte düzeltilmeli. G-29 sonrasında `simgeler.tex` güncellenmeli.
2. **Tek başına güvenli çıkarmalar:** G-18 (`\umitnot`), G-15, G-16, G-05, G-06, G-01 (04:8), G-10, G-21.
3. **Yapısal taşımalar:**
   - G-20: `sec:guc-tanimlari` kaldırılır, 06:10 göndermesi yönlendirilir.
   - G-19: `fig:s3-simulink-modeli` Bölüm 3'e taşınır, etiket aynı kalır.
   - G-22: paragraf yerleşimi düzeltilir.
   - Sonrasında `grep -c '\\label'` ile etiket sayısı karşılaştırılmalı: Bölüm 4 –1 (`sec:guc-tanimlari`), Bölüm 3 +1 (taşınan şekil).
4. **Birleştirmeler:** G-14 (04:33 ve 04:155), G-12 ve G-13 (kayıp modeli), G-24 (kapı işareti şekilleri), G-04, G-25, G-11, G-17.
5. **Bölümler arası tekrarların tek yere indirilmesi:** G-03 (03:637, 02:305), G-02 (03:635, 03:252), G-08, G-09 (06:10), G-07 (04:210).
6. **Küçük tutarlılık düzeltmeleri:** G-31, G-32, G-33, G-34 (Bölüm 6), G-35, G-36, G-26, G-37.
7. **Her adımdan sonra** Ayakaleaf'te derlenmeli ve tanımsız gönderme kalmadığı denetlenmeli. Derlemeyi ana oturum yapar.

**Korunması gereken etiketler** (başka bölümlerden gönderme alıyor): `chap:anahtarlama`, `sec:model-kapi-mantigi` (03:157, 03:427, 08:72), `fig:susturma-esdeger` (05:50), `fig:s3-simulink-modeli` (05:236, 05:241; taşınırsa adı aynı kalmalı), `sec:s1-s2-kalibre` (08:55), `fig:s1-s2-kalibre-dalga` (03:637, 06:582, 06:584). Kaldırılırsa yönlendirme gereken tek etiket `sec:guc-tanimlari`dır (06:10).
