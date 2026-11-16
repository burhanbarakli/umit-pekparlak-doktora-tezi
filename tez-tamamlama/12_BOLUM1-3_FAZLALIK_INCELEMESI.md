# Bölüm 1–3 fazlalık, gereksiz ayrıntı ve tekrar incelemesi

- **Kapsam:** `yeni_tez/bolumler/01-giris.tex`, `02-literatur.tex`, `03-sistem-model-metodoloji.tex`. Bağlam için 04–08, `onkisim/ozet.tex` ve `ekler.tex` okundu.
- **Bakış açısı:** jüri üyesi ve tez danışmanı. Yalnız içerik ve yapı incelendi, dil önerisi yok.
- **Görev kipi:** incele (yalnız rapor). Hiçbir `.tex` dosyası değişmedi. Derleme ve commit yapılmadı.
- **Tarih:** 16.11.2026
- **Satır numaraları** dosyaların bugünkü hâline aittir. Alıntılar en çok 20 kelimedir.
- **Kelime sayımı:** `%` yorumları ve TikZ blokları dışarıda, LaTeX komutları dahil. Sayfa kestirimi: düz metin için ~300, `\footnotesize` uzun tablolar için ~600 kelime/sayfa.

---

## 1. Özet

### 1.1 Bölüm başına kelime sayısı

| Bölüm | Ham (wc) | TikZ hariç | Başlıca alt bölümler (TikZ hariç) |
|---|---:|---:|---|
| 1 Giriş | 2 720 | 2 466 | Problem 947 · Sav/amaç/AS 332 · Özgün katkılar 734 (liste 247, başlık eşlemesi 89, tablo 354) · Kapsam 179 · Düzen 256 |
| 2 Literatür | 5 710 | 5 204 | EDS mimarileri 1 356 · T-tipi kuramsal temel 462 · FV profili/kısmi yük/THD 1 341 · Akım kontrolü/ileri besleme 715 · Karşılaştırmalı değerlendirme 945 (tablo 792) · Boşluk 284 |
| 3 Sistem, model, metodoloji | 9 053 | 8 519 | Genel mimari 370 · Faz kolu ve durumlar 1 217 · Düşük güç eşdeğeri 413 · LCL 328 · Denetim/Sin³ 465 + 174 · **Parametre tablosu 1 730** · L₂ 179 · **Yarı iletken eşlemesi 405** · Doğrulama metodolojisi 733 · **Model doğrulaması 922** · **Düşük akım modelleme 972** · Sonuç 183 |
| **Toplam** | **17 483** | **16 189** | |

### 1.2 Bulgu sayısı

| Tür | Yüksek | Orta | Düşük | Toplam |
|---|---:|---:|---:|---:|
| Tekrar | 3 | 6 | 10 | 19 |
| Gereksiz ayrıntı | 4 | 3 | 5 | 12 |
| Yanlış yer | 1 | 2 | 2 | 5 |
| Oran | 1 | 1 | 0 | 2 |
| Şekil/tablo | 1 | 4 | 2 | 7 |
| **Toplam** | **10** | **16** | **19** | **45** |

### 1.3 Önerilerin hepsi uygulanırsa tahmini kazanç

- **Bölüm 1–3 içinde yaklaşık 6 100 kelime** (TikZ hariç metnin ~%37'si). Dağılım: Bölüm 1 ~980 (≈%40), Bölüm 2 ~1 250 (≈%24), Bölüm 3 ~3 850 (≈%45).
- **Sayfa:** metin ~15–16 sayfa, kaldırılan ya da birleştirilen şekil/tablo ~3,5 sayfa, toplam **~18–19 sayfa**.
- **Taşınanlar:** katkı tablosu Bölüm 8'e (F-32), köprü iç empedansı tablosu Bölüm 6'ya (F-01) taşınır. İkisi düşülünce tez genelindeki net kazanç **~16–17 sayfadır**.
- **Diğer bölümler:** Bölüm 4 ve 6'daki eş tekrarlar (F-05, F-12, F-19) da kaldırılırsa ek ~300 kelime, yaklaşık 1 sayfa kazanılır.
- Bölüm 1–3'te başlık silmek gerekmez. Yalnız bir alt başlık (`sec:yariiletken-esleme`, gönderme almıyor) üst kesime katılabilir.

### 1.4 En önemli 5 öneri

1. **Bölüm 3'teki model kalite güvence günlüğünü kısalt (F-20, F-21, F-22, F-24).** "Benzetim Modelinin Doğrulanması", "Yarı iletken eşlemesi" ve parametre tablosu birlikte ~3 000 kelime tutuyor. Simulink blok adları, parametre dosyası değişken adları, çözücü toleransları ve "erken tarihli parametre notları" türü süreç notları jüriye çalışma sürecini anlatıyor, tezin argümanına katkı vermiyor. Kazanç ~1 200 kelime, ~4 sayfa.
2. **Köprü iç empedansı ve kalibrasyon duyarlılıklarını tek yerde (Bölüm 6) bırak (F-01).** Bölüm 3:703–724 ile Bölüm 6:526–530 aynı sayıları neredeyse aynı cümlelerle veriyor: 1,67/28,7/13,7 Ω, 1,7 Ω ölü zaman kestirimi, ampirik Jacobian, genlik belirsizlikleri ve 0,7–1,6 µs. İçerik bir kalibrasyon sonucudur. Kazanç ~410 kelime, ~1,5 sayfa.
3. **Giriş'teki katkı anlatımını teke indir ve sayısal sonuç tablosunu Bölüm 8'e taşı (F-04, F-32).** Giriş aynı üç katkıyı altı kez sayıyor: amaç listesi, AS, katkı listesi, başlık eşlemesi, tablo, akış şekli ve düzen. `tab:katki-yontem-kanit` okurun henüz tanımadığı S1–S4, PI, kalibre ve faz marjı terimleriyle dolu bir sonuç tablosudur. Bölüm 8 bu tabloya zaten gönderme yapıyor. Kazanç ~720 kelime, ~2,5 sayfa.
4. **Bölüm 2'deki batarya, BYS ve dengeleme anlatımını tezin odağına göre kısalt (F-37).** Bu kesim ~790 kelime ve 5 şekil/tablo tutuyor. Tezin ana topolojisi olan T-tipi kuramsal temel ise 462 kelime ve 1 şekil. Deşarj derinliği–çevrim ömrü eğrisi tezde başka hiçbir yerde kullanılmıyor. Kazanç ~450 kelime ve ~2 sayfa şekil/tablo.
5. **"Sin³ denetleyici değil ileri beslemedir / çevrimin dışındadır" konumlandırmasını üç yerde bırak (F-02).** Bölüm 1–3'te 16 kez tekrarlanıyor. Kanıtın yeri Bölüm 5'tir. Kazanç ~300 kelime.

**Jüri riski taşıyan iki ek nokta:**
- **F-25:** Bölüm 3, hiçbir sonuç bölümünde raporlanmayan üç ölçüt tanımlıyor (A_rev, N_sw, RMSE). A_rev, Bölüm 4'te Q_rev adıyla ikinci kez tanımlanıyor.
- **F-26:** Bölüm 3'teki şebeke gerilimi ileri beslemesi yolu (U_ff, v_ff) ve genel PR denetleyicisi modellerde yer almıyor. Gösterim de tutarsız: Bölüm 3'te ω_c, Bölüm 5'te ω_b.

---

## 2. `\label`–`\ref` taraması

**Yöntem:** Betik (`refs.py`) `bolumler/`, `onkisim/` ve `sekiller/` altındaki bütün `.tex` dosyalarında `\ref`, `\eqref`, `\autoref` ve `\pageref` komutlarını saydı. `%` yorum satırları sayılmadı.

**Bir kez bile anılmayan şekil/tablo:**

| Etiket | Yer | Gönderme | Not |
|---|---|---:|---|
| `tab:agirlikli-verim-katsayilari` | 02:264 | 0 | Eşitlik 2.2–2.3 ile aynı katsayılar (F-39) |

**Yalnız kendi paragrafında anılan, çıkarılması kolay öğeler:**

| Etiket | Yer | Gönderme |
|---|---|---|
| `tab:yariiletken-esleme` | 03:564 | 03:559 |
| `tab:bys-islev-karsilastirma` | 02:134 | 02:148 |
| `fig:batarya-omur-guvenlik` | 02:91 | 02:76 |
| `tab:eds-maliyet-dagilimi` | 02:57 | 02:74 |
| `fig:gelen-faz1-hucresi` | 03:91 | 03:75 |
| `fig:genel-sistem-mimarisi` | 03:47 | 03:11 |

**Taşıma ya da çıkarmada korunması gereken etiketler (başka bölümlerden gönderme alıyor):**

| Etiket | Gönderme sayısı ve yeri |
|---|---|
| `tab:sistem-parametreleri` | 22 dış (01, 04, 05, 06, 07, ekler) + 15 iç |
| `sec:dusuk-akim-modelleme` | 11 dış |
| `sec:model-dogrulama-duzeltme` | 8 dış |
| `fig:t-tipi-akim-yollari` | 04, 07 |
| `fig:t-tipi-uc-seviye` | 07 |
| `fig:gelen-tam-topoloji` | 07 |
| `tab:model-katmanlari` | 05 |
| `tab:kopru-ic-empedansi` | 04 |
| `eq:ters-akim-anahtarlama-olcutleri` | 04:33, 06:234 |
| `eq:thd-rmse-tanimlari` | 06:234 |
| `sec:denetim-modelden` | 04:39 |
| `tab:katki-yontem-kanit`, `sec:giris-katkilar` | 08:40 |
| `sec:guc-tanimlari` (Bölüm 4) | 06:10 |

**Tek kalan atıflar** (bulunduğu cümle çıkarılırsa atıf tezden düşer):

| Atıf | Yer |
|---|---|
| `Vetter2005` | 02:76 |
| `Taylor2025PVGIS` | 02:211 |
| `Zhou2018` | 02:375 |
| `IEAPVPS2024` | 01:7 |
| `Meinhardt2000` | 01:11 |
| `Smith2017`, `Chen2021`, `Feng2018` | yalnız 02:76 ve 02:90 (batarya ömrü şekli) |

---

## 3. Bulgu listesi

Biçim: **Kimlik — tür — öncelik — tahmini kazanç**, ardından yer, alıntı ve öneri.

### 3.1 Tekrarlar

**F-01 — tekrar (ve yanlış yer) — yüksek — ~410 kelime, ~1,5 sayfa (Bölüm 3)**
- **Yer:** 03:703–724 (Köprünün iç empedansı paragrafı, `tab:kopru-ic-empedansi`, duyarlılıkların üç sonucu) ↔ 06:526 (Köprünün yumuşak kaynak davranışı) ↔ 06:530 (genlik/faz belirsizliği). Ayrıca 03:701 ↔ 06:526 (ara seviye oranları %12,4 ve %22,6).
- **Alıntı:** 03:724 "kalibre genliğin belirsizliği S1'de \%0,025, S2'de \%0,4, S3'te \%0,2 olmaktadır" ↔ 06:530 "Genlik belirsizliği … S1'de $\pm$\%0,025, S2'de $\pm$\%0,4, S3'te $\pm$\%0,2".
- **Öneri:** Tek yerde, **Bölüm 6 §Kalibrasyon** altında bırak. İçerik kalibrasyon benzetimlerinden elde edilmiş bir sonuçtur.
  - Tabloyu Bölüm 6'ya taşı. `tab:kopru-ic-empedansi` etiketi taşınır, 04'teki gönderme bozulmaz.
  - Bölüm 3'te düşük akım modelleme kesimine bir cümle kalsın: "Süreksiz iletim köprüyü yumuşak bir kaynak gibi davrandırmaktadır." 11 dış gönderme alan `sec:dusuk-akim-modelleme` etiketi yerinde kalır.
  - 03:722'deki "Pasif ağ hesabı … 0,2 mV ve 0,0001° içinde örtüşmektedir" cümlesi doğrulama ayrıntısıdır, çıkar.

**F-02 — tekrar — yüksek — ~300 kelime**
- **Konu:** "Sin³ terimi denetleyici değil, ileri besleme bileşenidir; çevrim dışındadır; karakteristik denklemi değiştirmez." Bölüm 1–3'te 16 yerde geçiyor.

  | Bölüm | Satırlar |
  |---|---|
  | 1 | 19 (son 5 cümle: terminolojik ayrım, gecikme/LCL, karakteristik payda, inceleme kapsamı), 26 (savın ikinci önermesi), 55 (son iki cümle), 94 (cümle 5) |
  | 2 | 383 (son iki cümle), 385 (son cümle), 387 (son cümle) |
  | 3 | 11 (cümle 5–6), 46 (caption), 371, 378 (cümle 2), 429, 524 (tablo hücresi, ikinci cümle), 674 (tablo satırı), 684 (cümle 3–4), 730 (son cümle) |

- **Alıntı:** 01:19 "Üretilen terim, akım hatasından türetilen bağımsız bir geri besleme denetleyicisi değil, mevcut akım çevriminin…". Aynı fikir 02:385 ve 03:11'de de geçiyor.
- **Öneri:** Birincil yer Bölüm 5 "Analitik katman" alt bölümüdür (kanıt orada).
  - Bölüm 1'de katkı 2 maddesinde bir cümle kalsın.
  - Bölüm 2'de 02:385'te literatürle ayrım için bir cümle kalsın.
  - Bölüm 3'te 03:429'da blok şemasıyla birlikte iki cümle kalsın.
  - Diğer yerlerden çıkar.
  - 01:19'un kararlılık tartışması (son 4 cümle) 02:387 ile örtüşüyor. Giriş'te tek cümleye indir.
  - Ek yarar: kural 8. Sürekli "denetleyici değil" demek savunmacı bir ton taşıyor.

**F-03 — tekrar — orta — ~100 kelime**
- **Konu:** Deney koşulu (~2,3 A, ~120 V, varyak, güvenli laboratuvar).
- **Yer:** 01:54, 01:63 (caption), **01:96**, 03:5 (son cümle), **03:466/471 (tablo)**, 03:552 (cümle 2), 03:601 (tablo hücresi), 03:693. Bölüm 1–3 dışında: 04:203, 06:4, 06:10, 08:83, `ozet`.
- **Alıntı:** 03:5 "Deneyler güvenli laboratuvar koşulunda, varyak üzerinden yaklaşık \SI{120}{\volt} şebeke geriliminde…" ile 01:96 aynı cümle.
- **Öneri:** Cümle olarak 01:96'da (Kapsam), değer olarak `tab:sistem-parametreleri`'de bırak.
  - 03:5'teki cümleyi çıkar.
  - 03:552'de varyak yalnız L₂'nin fiziksel anlamı için anılsın.
  - 01:63 caption'daki koşul notu, tablo Bölüm 8'e taşınınca (F-32) orada kalabilir.
  - 03:601 ve 03:693 tablo hücresi ya da hesap girdisi olduğu için kalabilir.

**F-04 — tekrar — yüksek — ~300 kelime (+ F-32)**
- **Konu:** Katkılar Giriş'te altı biçimde anlatılıyor:
  1. amaç listesi (01:30–37, 5 madde),
  2. araştırma soruları (01:41–46),
  3. katkı listesi (01:53–57),
  4. başlık eşlemesi paragrafı (01:59),
  5. katkı tablosu (01:61–87),
  6. akış şekli `fig:tez-akisi` ile Tezin Düzeni metni (01:154–158).

  Bölüm 2:445 sav'ı üç bileşenle bir kez daha anlatıyor.
- **Alıntı:** 01:59 "Tez başlığının üç bileşeninin her biri bir katkının karşılığıdır." Tablonun ilk sütunu da "Katkı ve başlıktaki karşılığı".
- **Öneri:**
  - Amaç listesini 1–2 cümlelik genel amaca indir. Maddeleri AS1–AS4 ile bire bir örtüşüyor (amaç 3–4 → AS3).
  - Başlık eşlemesini ya 01:59'da ya tabloda tut, ikisinde değil. Tablo taşınırsa (F-32) 01:59 kalır.
  - Tezin Düzeni'nde bölüm özetlerini kısalt. Şekil zaten "her katkının bölümünü ve kanıtını tek bakışta" gösteriyor (01:101). 01:158'deki "Deney düzeneği GT-tipi olarak kurulmuştur…" cümleleri 01:56'yı tekrarlıyor.

**F-05 — tekrar — orta — ~150 kelime (Bölüm 3) + ~170 kelime (Bölüm 4)**
- **Konu:** Güç/verim tanımları, C ölçüm noktası, üretici işaret kuralı, reaktif gücün karşılaştırma kuralı.
- **Yer:** 03:273 (cümle 4–5), 03:544 (tablo), **03:611–624 (birincil, eşitlikler)**, 03:675 (tablo satırı), 03:686 (son 5 cümle) ↔ 04:199–202 (`sec:guc-tanimlari`) ↔ 06:524.
- **Alıntı:** 04:202 "İşaret kuralı üreticidir: evirici fazından şebekeye akan akım pozitiftir, $P_{\mathrm{ac}}>0$ …" ↔ 03:619 "$i_g$ ise üretici kuralıyla, evirici fazından şebekeye doğru pozitif alınmaktadır."
- **Öneri:** Birincil yer 03:611–624.
  - 03:675 satırını ve 03:686'nın reaktif güç kısmını çıkar.
  - Bölüm 4'teki `sec:guc-tanimlari`'nin ilk paragrafını çıkar. 06:10'daki gönderme `eq:guc-ortalama-tanimlari`'ya ya da `tab:sistem-parametreleri`'ye yönlendirilmeli.
  - Bölüm 6:524'te yalnız deneye özgü kısım (Q_o hesabı, okuma bandı) kalsın.

**F-06 — tekrar — orta — ~180 kelime**
- **Konu:** S4 için büyütülmüş DA bara kapasitansı.
- **Yer:** 03:493 (tablo satırı), 03:678 (doğrulama tablosu satırı), 03:684 (cümle 5–10) ↔ 05:266 ("DA bara önkoşulu", aynı sayılar).
- **Alıntı:** 03:678 "PI \SI{25}{\ampere}: genlik hatası $-\%31{,}9\to-\%2{,}1$; doyum $\%20{,}6\to\%0$; THD $\%57{,}4\to\%9{,}2$" ↔ 05:266 aynı üç sayı.
- **Öneri:** Birincil yer Bölüm 5:266 (S4 orada). Bölüm 3'te yalnız 03:493 tablo satırı kalsın. 03:678 satırını ve 03:684'ün DA bara kısmını çıkar.

**F-07 — tekrar — orta — ~250 kelime**
- **Konu:** Kapı mantığı (klasikte tümleyen, susturmada sabit 1/0, 1 µs ölü zaman yükselen kenarda, testere dişi 0–1, V_dc normalizasyonu yok, 1 µs örnekleme).
- **Yer:** 03:107 (son 3 cümle), 03:139 (son cümle), 03:157 (cümle 4–8), **03:434**, 03:436, 03:517–519 ve 525 (tablo) ↔ 04:85 ve `tab:model-kapi-mantigi`.
- **Alıntı:** 03:434 "Klasik anahtarlamada nötr anahtar komutları, dış anahtar PWM çıkışlarının mantıksal tümleyenidir." ↔ 04:85 "nötr anahtar komutları PWM çıkışlarının mantıksal tümleyenidir".
- **Öneri:**
  - Sayısal değerler tabloda, S1–S2/S3 kapı mantığı karşılaştırması Bölüm 4'te kalsın.
  - 03:157'yi iki cümleye indir (yarım periyot etkinleştirme kuralı).
  - 03:434'ü ~60 kelimeye indir (zincirin sırası).
  - 03:436'yı tamamen çıkar: 1 µs örnekleme 434'te ve tabloda var, "sürekli etkin" bilgisi 525'te var, analog S4 bilgisi 535'te ve Bölüm 5'te var.
  - `sec:denetim-modelden` etiketi kısaltılmış alt bölümde kalır (04:39 gönderiyor).

**F-08 — tekrar — orta — ~90 kelime**
- **Konu:** Sin³ özdeşliği ve harmonik eşdeğer açılımı.
- **Yer:** 01:19 (satır içi), 02:385 (satır içi), 03:373–376 (`eq:sin3-ozdeslik` ile 376'nın son 5 cümlesi) ↔ 05:9–28 (`eq:sin3-acilimi`, `eq:sin3-esdeger-katsayilar`, K₁ₓ/K₃ₓ eşlemesi 05:28).
- **Alıntı:** 03:376 "modülasyon referansı $(K_1+3K_3/4)\sin\theta-(K_3/4)\sin3\theta$ olmaktadır" ↔ 05:12 eşdeğer ifade.
- **Öneri:** Birincil yer Bölüm 5. 03:376'daki K eşlemesi, açılım ve tepe değer cümlelerini çıkar. Bölüm 3'te `eq:modulasyon-toplami` kalsın, U_sin³ tanımı yeterli. `eq:sin3-ozdeslik` yalnız Bölüm 3 içinden iki gönderme alıyor, birlikte çıkarılabilir. 01:19 ve 02:385'teki satır içi özdeşlikten biri yeterli, Giriş'teki tercih edilebilir.

**F-09 — tekrar — düşük — ~80 kelime**
- **Konu:** Kalibrasyon özeti ("aktif ve reaktif güce kalibre, öteki büyüklükler bağımsız"; "iki serbest değişken").
- **Yer:** 01:72, 01:89, 03:440 ("Kalibre" tür tanımı), 03:590 (son cümle), 03:656 (cümle 4), 03:703–724 (F-01). Dışarıda: 04:4, 06:6, 06:517–522, `ozet`.
- **Öneri:** Birincil yer Bölüm 6 §Kalibrasyon. Bölüm 3'te 03:590'da bir cümle yeterli. 01:89 ve 03:656'daki tekrarları çıkar.

**F-10 — tekrar — düşük — ~60 kelime**
- **Konu:** "Deney düzeneği GT-tipi olarak kurulmuştur."
- **Yer:** 01:21, 01:56, 01:84 (tablo), 01:158, 03:75, 03:81 (caption).
- **Öneri:** 01:56 (katkı 3) ile 03:81 caption'ında bırak. 01:21, 01:158 ve 03:75'teki cümleleri çıkar.

**F-11 — tekrar — düşük — ~70 kelime**
- **Konu:** Prototip üç faz dört telli, benzetim/deney tek faz kolu, değerler faz başına.
- **Yer:** **01:94**, 01:63 (caption), 03:5 (cümle 4–7), 03:459–460 (tablo), 03:75 (son iki cümle), 03:730 (cümle 2).
- **Öneri:** 01:94 ile tabloda bırak. 03:5'i tek yan cümleye, 03:75'in son iki cümlesini bir cümleye indir. 03:730'daki tekrarı çıkar.

**F-12 — tekrar — düşük — ~80 kelime (Bölüm 3) + ~50 kelime (Bölüm 4)**
- **Konu:** Senkron buck'ta ters akım ve diyot benzetimi anlatımı. Sayısal ters akım eşiği (9 A tepe–tepe, 4,5 A, 3,3 A).
- **Yer:** 01:15, **02:325–327 (literatür, birincil)**, 02:369, 03:252 (cümle 2–4) ↔ 04:13–17. Sayılar: **03:699 (birincil)** ↔ 04:13 (cümle 3–5) ↔ 04:208.
- **Alıntı:** 03:252 "Diyot benzetimi, akım sıfıra yaklaştığında senkron yolu keserek negatif akımı engellemektedir." ↔ 02:325 "senkron anahtar akım sıfıra yaklaşırken kapatılarak negatif akım engellenmektedir".
- **Öneri:** 03:252'yi tek cümleye ve şekil göndermesine indir. Bölüm 4:13'te sayıları vermek yerine 03:699'a gönderme yeterli.

**F-13 — tekrar — düşük — ~40 kelime**
- **Konu:** PI sıfırının 60 Hz'e, geçiş frekansının (~586 Hz) onda birine yerleştirilmesi.
- **Yer:** 03:364 (son 2 cümle), 03:531 (tablo) ↔ 05:264 (gerekçe ile faz kaybı hesabı).
- **Öneri:** Gerekçe 05:264'te, değer tabloda kalsın. 03:364'ten çıkar.

**F-14 — tekrar — düşük — ~60 kelime**
- **Konu:** S1–S4 senaryo tanımları.
- **Yer:** **03:588 (birincil)**, 03:674 (tablo satırı: "S4 = S3 + L₁ akım geri beslemesi"), 03:684 (cümle 1–2). Bölüm 1'deki tablo kodları tanımlanmadan kullanıyor (01:73, 01:77–78). Dışarıda: 04:4, 05:235.
- **Öneri:** Tanım 03:588'de kalsın. 03:674 satırı ile 03:684'ün ilk iki cümlesini çıkar (F-20 ile birlikte). Bölüm 1'de kodlar yerine adlar kullanılsın; tablo taşınırsa (F-32) sorun kalmaz.

**F-15 — tekrar — düşük — ~25 kelime**
- **Konu:** Tam topoloji şemasındaki L1/L2/L3 = 600 µH etiketlerinin A/B/C faz bobinleri olması.
- **Yer:** 03:75 (cümle 9–10) ↔ 03:552 (cümle 6) ↔ 03:483 (tablo "tam topoloji şeması").
- **Alıntı:** 03:552 "Tam topoloji şemasındaki \SI{600}{\micro\henry} etiketleri ise üç fazın $L_1$ bobinleridir."
- **Öneri:** 03:75'te bırak, 03:552'den çıkar.

**F-16 — tekrar — orta — ~70 kelime**
- **Konu:** Bölüm 2'nin son paragrafı sav'ı üç bileşenle yeniden anlatıyor ve ileriye duyuru yapıyor.
- **Yer:** 02:445 ↔ 01:26 ve 01:51 (sav, katkılar), 02:4.
- **Alıntı:** 02:445 "Sonraki bölümlerde tezin savı, ortak sistem modeli, çalışma kipleri … üzerinden sınanacaktır."
- **Öneri:** Tek cümleye indir: "Belirlenen boşluk tezin üç katkısını tek sav altında birleştirmektedir." Son cümleyi çıkar (kural 11).

**F-17 — tekrar — düşük — ~20 kelime**
- **Konu:** "Benzetim ve deney sonuçları ayrı raporlanmaktadır."
- **Yer:** 01:96, 03:590 (cümle 4). Dışarıda: 04:4, `ozet`.
- **Öneri:** 01:96'da bir kez kalsın, 03:590'dan çıkar. Tekrarlandıkça savunmacı okunuyor (kural 8).

**F-18 — tekrar — düşük — ~40 kelime**
- **Konu:** EDS maliyetinde batarya baskın, güç elektroniği önemli (`Ramasamy2023`, `Lazard2024`).
- **Yer:** 01:9 (cümle 5–7) ↔ 02:50 (cümle 4) ↔ `tab:eds-maliyet-dagilimi` (02:54–74).
- **Öneri:** Literatür bölümünde tabloyla birlikte kalsın. 01:9'u bir cümleye indir; iki atıf 01:9'da da kalsın.

**F-19 — tekrar — düşük — Bölüm 1–3'te kazanç yok, Bölüm 4/6'da ~80 kelime**
- **Konu:** Anma güç ifadeleri (20 kVA, 20–25 kW, ~30 A).
- **Yer:** **03:461–463 (tablo, birincil)** ↔ 04:203 ↔ 06:10 ↔ 01:96 (cümle 4).
- **Öneri:** Tabloda kalsın. 04:203'ün ilk cümlelerini ve 06:10'daki tekrarı tablo göndermesine indir.

### 3.2 Gereksiz ayrıntı

**F-20 — gereksiz ayrıntı — yüksek — ~350 kelime (F-05, F-06, F-14 satırları dışında), ~1,2 sayfa**
- **Yer:** 03:651–688, "Benzetim Modelinin Doğrulanması". 922 kelime; `tab:model-duzeltme-ozeti` tablosu tek başına 365 kelime.
- **Alıntı:** 03:656 "Model adımları programatik ve yeniden üretilebilir betiklerle uygulanmış, her adımın etkisi aynı çalışma noktasında benzetimlerle ölçülmüştür."
- **Gerekçe:** Kesim, model düzeltme kaydının (D-xx) tez içi özeti gibi okunuyor. Kapı girişlerinin bağlanması, blok parametre kümelerinin atanması ve X kapasitörü bloğuna değer atanması süreç bilgisidir. 03:682, 684 ve 686 tablo satırlarını düzyazıyla tekrarlıyor. 03:688 "hangi taban model hangi adımı içeriyor" bilgisini veriyor.
- **Öneri:** ~250 kelimeye indir.
  - İlk paragraf (üç denetim) kalsın.
  - Tabloda üç satır kalsın: S2 kapı yolu, diyot eşlemesi, X kapasitörü eşdeğeri. Sonuç sütununda yalnız verim/kayıp uyumu yer alsın.
  - "S4 kapalı çevrim" (F-14), "reaktif güç işaret kuralı" (F-05) ve "S4 DA bara" (F-06) satırlarını çıkar.
  - 03:682–688'i iki cümleye indir. Diyot eşlemesinin S1'de on kat etkisinin fiziksel nedeni (03:686, cümle 3–5) korunmaya değer.
  - `sec:model-dogrulama-duzeltme` etiketi kalır (8 dış gönderme).

**F-21 — gereksiz ayrıntı — yüksek — ~300 kelime + ~0,5 sayfa tablo**
- **Yer:** 03:556–583, "Yarı iletken eşlemesi". 405 kelime, `tab:yariiletken-esleme` ve Simulink blok adları.
- **Alıntı:** 03:581 "aynı roller \texttt{N-Channel IGBT4}--\texttt{IGBT7} ile \texttt{Diode12}, \texttt{Diode1}, \texttt{Diode11} … bloklarına karşılık gelmektedir."
- **Gerekçe:** Blok adları ve "bağlantı grafiğinden otomatik olarak çıkarılmış" bilgisi (03:559) model yazılımının iç işleyişidir. Jüri için anlamı yok. `sec:yariiletken-esleme` hiç gönderme almıyor. Tablo yalnız 03:559'dan anılıyor.
- **Öneri:** Tabloyu ve blok adlarını çıkar. Fiziksel içerik taşıyan 4 cümle kalsın, faz kolu kesimine ya da parametre tablosunun altına katılsın:
  - D₁–D₂ toplam V_dc'yi kestiği için 1200 V sınıfındadır.
  - Nötr kol diyotları V_dc/2'yi kestiği için 650 V iç diyot yeterlidir.
  - D₁–D₂ kararlı çalışmada iletime girmez.
  - Serbest dolaşım yolu DS₃–DS₄'tür.

  03:583 (veri sayfası tabanlı modeller, 25 °C) tek cümle olarak kalabilir. 54 `\texttt{}` kullanımının 15'i bu kesimdedir.

**F-22 — gereksiz ayrıntı — yüksek — ~500 kelime, ~1–1,5 sayfa**
- **Yer:** 03:442–547, `tab:sistem-parametreleri`. 1 730 kelime, Bölüm 3'ün %20'si.
- **Alıntı:** 03:545 "Osiloskop akım ölçekleme kazancı & \num{20} & -- & Parametre dosyası (\texttt{measurement\_gain}). Yalnız görüntülemede kullanılmaktadır".
- **Gerekçe:**
  - "Kaynak" sütununda "Parametre dosyası" 33 kez geçiyor. Yanında 38 `\texttt{}` değişken adı var (`f_grid`, `L1r`, `EMC_Cx_eq`, `sim_rel_tol` …).
  - "Sayısal çözüm ve değerlendirme" grubu (03:536–545) çözücü adını, üç toleransı, Simscape yerel çözücü/powergui ayarını, benzetim sürelerini ve osiloskop görüntü kazancını veriyor.
  - Modele ait yapay öğeler de var: 03:497 (DA kaynağı ters akım diyotu), 03:498 (modele katılmayan donanım öğeleri), 03:480 (PTPER/DTR yazmaç sayımları).
  - Kalibre satırlarındaki "(parametre dosyasındaki ilk değer)" parantezleri (03:520–522) süreç izidir.
- **Öneri:**
  - Kaynak sütununu kısa kodlara indir ve tablo notunda açıkla: PD parametre dosyası, VS veri sayfası, ŞM şema, DÖ deney özeti. `\texttt` adlarını kaldır.
  - "Sayısal çözüm" grubunu EK'e taşı. Ek, tabloya zaten gönderme yapıyor. Değerlendirme penceresi ve THD tanımı satırları (03:543–544) ana metinde kalabilir.
  - Osiloskop satırını tamamen çıkar.
  - 03:480 yerine f_s ve t_d satırları yeterli. 03:497–498'i tablo notunda tek cümleye indir.
  - İlk değer parantezlerini çıkar. Kalibrasyonun ne kadar değiştirdiği zaten 06:530'da veriliyor.
  - Etiket 37 gönderme aldığından kalır. Satır silerken başka bölümün bir satıra dayanıp dayanmadığına bak: 06:139 ve 06:145 ölçüm donanımı satırlarına gönderiyor, o satırlar kalmalı.

**F-23 — gereksiz ayrıntı — orta — ~100 kelime**
- **Yer:** 03:440, tablo öncesi paragraf (168 kelime). Altı tür sınıfı ve süreç cümleleri var.
- **Alıntı:** "Her değerin hangi model bloğunda kullanıldığı, sonuçların dayandığı dört taban modelin blok parametreleri ve model yapılandırması taranarak ayrıca denetlenmiştir."
- **Öneri:** ~60 kelimeye indir. Tablonun amacı ve altı türün tek satırlık tanımı kalsın. "taranarak denetlenmiştir", "taban modellerde kullanılan değerler alınmıştır" ve "ilk değer parantez içinde" cümlelerini çıkar.

**F-24 — gereksiz ayrıntı (süreç notu) — yüksek — ~35 kelime**
- **Yer:** 03:552, cümle 4–5.
- **Alıntı:** "Kaynak belgelerde görülen \SI{200}{\micro\henry} ve \SI{400}{\micro\henry} değerleri daha erken tarihli parametre notlarına ve model yapılandırmalarına aittir."
- **Öneri:** Bu cümleyi ve "Tezde en yeni makine okunur parametre dosyasındaki değer esas alınmıştır" cümlesini çıkar. Okura, tezde bilmediği belgelerdeki başka değerleri duyurmuş oluyor; kural 10'un ruhuna da aykırı. 03:554 kalsın (L₂'nin iki fiziksel etkisi). Oradaki "rezonans 2,8 kHz", "0–5 mH taraması" sonuçlarını F-34'e bak.

**F-25 — gereksiz ayrıntı (kullanılmayan tanım) — orta — ~150 kelime**
- **Yer:**
  - 03:626–634: RMSE_i, `eq:thd-rmse-tanimlari`'nin ikinci satırı.
  - 03:636–645: A_rev ve N_sw, `eq:ters-akim-anahtarlama-olcutleri`.
  - 04:19–22: Q_rev, `eq:ters-akim-yuku`, A_rev ile aynı integral.
- **Alıntı:** 03:645 "Anahtarlama çevrimi sayısı istenirse değer, uygun kenar eşleştirmesiyle ayrıca hesaplanmalıdır."
- **Gerekçe:**
  - Üç ölçüt Bölüm 4–7'de hiçbir sayısal sonuçla raporlanmıyor. Bölüm 5 genlik hatası kullanıyor, Bölüm 4 ara seviye zaman oranını kullanıyor.
  - 08:89 "ters akım alanı, anahtarlama geçiş sayısı" ölçütlerini Gelecek Çalışmalar altında sayıyor.
  - Aynı integral iki bölümde iki ayrı simgeyle tanımlanmış.
  - Jüri "tanımladığınız ölçütün sonucu nerede?" diye sorabilir.
- **Öneri:** A_rev/N_sw eşitliğini ve RMSE satırını çıkar, THD kalsın. Ters akım ölçütü gerekiyorsa tek tanım olarak Bölüm 4'teki Q_rev kalsın. Gönderme düzeltilecek yerler: `eq:ters-akim-anahtarlama-olcutleri` (04:33, 06:234) ve `eq:thd-rmse-tanimlari` (06:234).

**F-26 — gereksiz ayrıntı (modelde olmayan yapı) — orta — ~120 kelime**
- **Yer:**
  - 03:359–364: genel PR denetleyicisi `eq:pr-denetleyici`, ω_c.
  - 03:366–371: `eq:modulasyon-toplami` içindeki U_ff.
  - 03:405 ve 412: blok şemasındaki "Şebeke gerilimi ileri besleme v_ff".
  - 03:429, cümle 6–7.
  - 03:343–349: `eq:lcl-aktarim`, G_vi = I₂/V_inv.
- **Alıntı:** 03:429 "iki ileri besleme yolu kapalı çevrim analizinde ayrı girişler olarak tutulmuştur."
- **Gerekçe:**
  - Bölüm 4–8'de v_ff ya da U_ff hiç geçmiyor. S4'ün u_ff'si yalnız K₁₄ sin + K₃₄ sin³'tür (05:249).
  - S1–S3 açık çevrimdir (03:364). S4 P/PI/PIR kullanıyor ve PIR Bölüm 5'te ω_b ile ayrıca tanımlanıyor (05:257). Parametre tablosu da ω_b diyor (03:533).
  - Bölüm 5'teki denetlenen sistem G = i_L1/v_inv'dir (05:360). Bölüm 3'ün I₂/V_inv aktarımı kullanılmıyor.
- **Öneri:**
  - PR eşitliği yerine "C_i(s), S4'te P, PI ya da PIR'dir" cümlesini koy, ya da Bölüm 5'teki `eq:s4-denetleyiciler`'i Bölüm 3'e al ve Bölüm 5'ten gönder.
  - U_ff/v_ff yolunu eşitlikten ve şekilden çıkar ya da "genel yapı, tezde kullanılmayan" diye işaretle; olumlu yazım için çıkarmak daha iyi.
  - G_vi'yi i₁'e göre yaz ya da kısa tut.
  - Eşitlik etiketleri yalnız Bölüm 3'ten gönderme alıyor.

**F-27 — gereksiz ayrıntı (yanlış yer) — düşük — ~80 kelime**
- **Yer:** 03:647 (DA–AA analizör kayıt gecikmesi ~50 ms, çevrim 1 s) ↔ 06:223 (aynı bilgi). 03:649 (kanıt zinciri izlenebilirliği, betikler).
- **Alıntı:** 03:649 "Her sonuç, kendisini üreten betiğe ve benzetim çıktılarına bağlıdır. Aynı betik aynı sonuçları yeniden üretmektedir."
- **Öneri:** 03:647'yi çıkar, deney altyapısı Bölüm 6'da. 03:649'u çıkar; süreç bilgisidir, tez metninde karşılığı yok.

**F-28 — gereksiz ayrıntı (küçük süreç/doğrulama notları) — düşük — ~100 kelime**
- **Yer ve alıntılar:**
  - 03:7, cümle 2: "Topolojiye ilişkin iddialar çok seviyeli dönüştürücü ve hafif yük literatürüyle sınanmıştır".
  - 03:139, son cümle: ölü zamanda diyot iletiminin "kendiliğinden oluşması".
  - 03:157, cümle 8: "Modelden okunan kapı mantığı Tablo … ile birebir örtüşmektedir".
  - 03:697, son 2 cümle: "Simscape diyot modelinin anahtarlama kenarlarında ürettiği ani akım tepeleri…".
  - 03:645, son 2 cümle.
  - 03:209: `samepage` paragrafı, 03:75'i tekrarlıyor.
- **Öneri:** Çıkar. Hiçbiri tezin argümanına bilgi eklemiyor.

**F-29 — gereksiz ayrıntı — düşük — ~150 kelime**
- **Yer:** 02:391, doktora tezlerinin "tezin yapısı için örnek" olarak anlatılması.
- **Alıntı:** "Literatürdeki doktora tezleri, tezin yapısı için de örnek oluşturmaktadır. … Sunulan tezde de aynı akış izlenmiştir."
- **Gerekçe:** Bir tezin yapısını başka tezlerle gerekçelendirmesi jüriye yabancı gelir. Kerekes, Hartmann ve Dong'un tez açısından içeriği karşılaştırma tablosunda zaten var (02:414, 427, 432).
- **Öneri:** Paragrafı çıkar. Kerekes2009, Hartmann2011 ve Dong2012 tabloda atıflı kalır. Wereley1991, 02:387'de ve Bölüm 5'te kalır.

**F-30 — gereksiz ayrıntı — düşük — ~80 kelime**
- **Yer:** 02:211 (PVGIS'in ne yaptığı), 02:220–225 (`eq:temsili-yil-saat-yuzeyi`, 4–200 W/m², 50 kat, %2).
- **Alıntı:** "PVGIS, konum, yönelim, eğim, sistem kaybı ve meteorolojik veri kümesi belirtilerek saatlik veya aylık üretim hesabı…"
- **Öneri:** Motivasyon amaçlı temsilî bir profil için çarpım yüzeyinin türetimi fazla. Bir cümleye indir: "Yıl–saat yüzeyi aylık ışınım ile gün içi normalize profilin çarpımıdır." Eşitlik etiketi yalnız kendi paragrafından anılıyor. PVGIS gerçekten veri kaynağıysa cümle kısaltılarak kalsın, `Taylor2025PVGIS` tek atıftır.

**F-31 — gereksiz ayrıntı — düşük — ~100 kelime**
- **Yer:** 02:284 (tipik eğrilerden okunan sayılar), 02:321 (motivasyon niteliğinin yeniden açıklanması), 02:227 (son cümle).
- **Alıntı:** 02:321 "Tezin verim ve THD bulguları ise deney kayıtlarına ve kalibre benzetimlere dayalıdır."
- **Öneri:**
  - 02:321'i çıkar. Motivasyon niteliği 02:292 ve 02:315 caption'larında, ayrıca 02:227'de zaten söylenmiş. Bulgularla ayrım cümlesi savunmacı (kural 8).
  - 02:284'ü tek cümleye indir.
  - "%23,6" 02:227'de üç kez geçiyor, bire indir.

### 3.3 Yanlış yere konmuş içerik

**F-32 — yanlış yer — yüksek — ~420 kelime, ~1,3 sayfa (Bölüm 1; tablo Bölüm 8'e taşınır)**
- **Yer:** 01:61–87 (`tab:katki-yontem-kanit`) ve katkı listesindeki sonuç sayıları (01:54 son cümle, 01:55 cümle 3–5, 01:56 cümle 4–5).
- **Alıntı:** 01:78 "S4'te PI denetimi \SI{25}{\ampere}'i $-$\%2,1 genlik hatasıyla, doyumsuz izlemektedir. … (faz marjı $54^{\circ}$, kazanç marjı \SI{35}{\decibel})".
- **Gerekçe:**
  - Giriş'te okur S1–S4'ü, kalibre benzetimi, PI/PIR'i ve analog eşdeğer çevrimi henüz tanımıyor.
  - Tablo yedi alt bölüm ve tablo göndermesi taşıyor; kural 11 ile çelişiyor.
  - 08:40 tabloyu zaten Bölüm 8'in "Özgün Katkıların Değerlendirilmesi" girişinde kullanıyor.
- **Öneri:**
  - Tabloyu Bölüm 8 §8.2'nin başına taşı; etiket aynı kalır.
  - Giriş'te katkı başına en çok bir başlık sonucu bırak, ya da hiç sayı verme. Örnek: "susturma deneyde verimi yaklaşık 1,7 puan artırmış, THD bedelini Sin³ terimi klasik düzeye indirmiştir."
  - Taşınan tablo Bölüm 8'deki §8.2.1–8.2.3 düzyazısıyla örtüşüyorsa orada da kısaltma fırsatı doğar.

**F-33 — yanlış yer — orta — ~45 kelime**
- **Yer:** 02:371 (Bölüm 2 son paragrafı, ileri besleme kesiminden önce).
- **Alıntı:** "Senkron alçaltıcıdaki CCM/DCM ayrımının T-tipi nötr koldaki karşılığı tezin benzetim modelinde incelenmiştir."
- **Gerekçe:** Literatür bölümünde tezin kendi bulgusu: susturmalı çalışmada kutup geriliminin ara değer alması. Aynı bulgu 03:701'de ve Bölüm 4'te (`fig:s1-s2-kalibre-dalga`) sayılarıyla var. 02:369'un ilk iki cümlesi de yöntemi önceden anlatıyor.
- **Öneri:** 02:371'i çıkar. 02:369'da yalnız literatürün açıklamadığı kısım (son cümle) kalsın.

**F-34 — yanlış yer — orta — ~40 kelime (diğerleri F-01, F-06, F-20 içinde sayıldı)**
- **Yer:** Bölüm 3'te Bölüm 4–6'nın sonuçları:
  - 03:554: fiziksel modelde rezonans 2,8 kHz; 0–5 mH şebeke endüktansı taraması (Bölüm 5).
  - 03:673–678: tablo sonuç sütunu (P_ac 269,6 W, η %94,07; PI −%2,1, PIR −%1,0; THD %57,4→%9,2).
  - 03:682: S2 kalibrasyon öncesi verim farkı.
  - 03:701: ara seviye zaman oranları.
  - 03:703–724: köprü empedansı ve duyarlılıklar (F-01).
- **Öneri:**
  - Bölüm 3'te yalnız modelin geçerliliğini tanımlayan ifadeler kalsın; sonuç sayıları sonuç bölümlerine gitsin.
  - 03:554'teki iki sonuç cümlesini "kararlılık analizinde incelenmiştir" düzeyine indir.
  - 03:695'teki S3 kayıp ayrışımı (L₁ çekirdek kaybı baskın, anahtarlama kaybı ~%7) modelin düşük akım geçerliliğini gerekçelendiriyor ve 04:30'dan gönderme alıyor. Kalabilir.

**F-35 — yanlış yer — düşük — ~43 kelime**
- **Yer:** 01:89, doğrulama altyapısı paragrafı (üç Bölüm 3 göndermesi).
- **Alıntı:** "Benzetim modelleri tez tanımına göre doğrulanmıştır … Bütün parametreler kaynak ve tür bilgisiyle tek tabloda toplanmıştır".
- **Öneri:** Çıkar. Bilgi, Tezin Düzeni'nin Bölüm 3 özetinde (01:154) ve `fig:tez-akisi` "Ortak taban" kutusunda zaten var. Kural 11 de bunu gerektiriyor.

**F-36 — yanlış yer (ileriye dönük duyuru) — düşük — ~60 kelime**
- **Yer:** 02:186 (son cümle: "ilerleyen bölümlerde sunulan işlev paylaşımının…"), 02:445 (son cümle; F-16), 03:50 (cümle 6), 03:355 (son cümle), 03:364 (cümle 5), 03:732 (son cümle).
- **Öneri:** Kural 11'e göre çıkar ya da gönderme olmadan kısa bir bağla. Bölüm 2'nin sonraki bölümlere gönderme yapmaması gerekiyor. 02:186 bölüm numarası vermiyor, ama "ilerleyen bölümlerde" duyurusu da gereksiz.

### 3.4 Oran sorunları

**F-37 — oran — yüksek — ~450 kelime + ~2 sayfa şekil/tablo**
- **Yer:** 02:76–186, batarya ömrü, BYS ve hücre dengeleme. ~790 kelime; `fig:batarya-omur-guvenlik`, `fig:bys-mimarisi`, `tab:bys-islev-karsilastirma`, `fig:dengeleme-yontemleri` ve `tab:dengeleme-karsilastirma`.
- **Karşılaştırma:** Tezin merkezindeki "Üç Seviyeli T-Tipi Dönüştürücünün Kuramsal Temeli" 462 kelime ve 1 şekil. Bölüm 2.1'in tamamı 1 356 kelime ve 7 şekil/tablo. Deşarj derinliği ve çevrim ömrü Bölüm 4–8'de hiç geçmiyor.
- **Alıntı:** 02:148 "Sayısal ömür artışı ise hücre kimyası, görev profili, sıcaklık ve yaşlanma testi birlikte verildiğinde ileri sürülebilir."
- **Öneri:**

  | Öğe | Öneri | Atıf ya da gerekçe |
  |---|---|---|
  | (a) `fig:batarya-omur-guvenlik` | Çıkar. 02:76'yı tek cümleye indir. | Vetter2005 tek atıftır; Smith2017, Chen2021 ve Feng2018 yalnız burada geçiyor. Cümle atıflarıyla kalsın. |
  | (b) `tab:bys-islev-karsilastirma` (4 satır Var/Sınırlı) ve 02:148 | Çıkar. | 02:148 savunmacı (kural 8). |
  | (c) Dört dengeleme paragrafı (02:161–167, 221 kelime) | Tek paragrafa indir (~80 kelime). Transformatörlü yapının paragrafı korunsun. | Bölüm 7 çok sekonderli BYS transformatörleri kullanıyor; geri kalan bilgi şekil ve tabloda var. |
  | (d) `fig:dengeleme-yontemleri` ile `tab:dengeleme-karsilastirma` | Biri yeterli. Tablo daha az yer tutar. | Şekil iki göndermeli (02:152, 02:186). |
  | (e) `fig:bys-mimarisi` | Kalabilir. | 02:94 onu GT-tipi yapının hedef işlevlerinin başvuru noktası olarak bağlıyor. |

  Daowd2011 ve Khan2024 başka satırlarda atıflı kalır.

**F-38 — oran — orta — kazanç tek tek bulgularda sayıldı**
- **Yer:** Bölüm 3'ün bütünü.
- **Karşılaştırma:**
  - Parametre tablosu 1 730, yarı iletken eşlemesi 405, model doğrulaması 922, düşük akım modelleme 972 ve L₂ 179 kelime. Toplam ~4 200 kelime, bölümün **~%49'u**.
  - Çekirdek model (faz kolu, durumlar, düşük güç eşdeğeri, LCL, denetim) ~2 400 kelime.
  - Bölüm 3 tezin en uzun bölümü. Bölüm 5 7 045, Bölüm 4 3 505 kelime.
- **Öneri:** F-01, F-07, F-20–F-28 uygulanırsa Bölüm 3 ~5 000–5 500 kelimeye iner. Çekirdek model ile kalite güvence oranı ~60/40'a gelir. Başlık yapısı korunabilir.

### 3.5 Şekil ve tablo fazlalığı

**F-39 — şekil/tablo — yüksek — ~50 kelime, ~0,25 sayfa**
- **Yer:** 02:261–273, `tab:agirlikli-verim-katsayilari`. Hiç `\ref` almıyor. Katsayılar 02:251 ve 02:256'daki Eşitlik `eq:eta-eu` ve `eq:eta-cec` ile aynı.
- **Öneri:** Tabloyu çıkar. Sera2008 ve Sandia2015 başka yerlerde atıflı.

**F-40 — şekil/tablo — orta — ~120 kelime, ~0,5 sayfa**
- **Yer:** 02:288–319, `tab:ticari-evirici-thd` ile `fig:ticari-evirici-thd`. Şekil tablonun grafiği; caption bunu söylüyor: "Tablo~\ref{tab:ticari-evirici-thd}'deki kaydın grafiği."
- **Öneri:**
  - Birini bırak. Logaritmik eksenli şekil, devreye girişteki %400 değerini daha iyi gösterir. Tablo istenirse EK'e gidebilir.
  - "Motivasyon amaçlı gözlem kaydı" ifadesi üç kez geçiyor (02:292, 02:315, 02:321), bire indir.
  - **Ek not:** Kaydın kaynağı (hangi evirici, kim, nerede ölçtü) metinde ve caption'da yok. Jüri sorabilir; tek bir kaynak cümlesi eklenmeli.

**F-41 — şekil/tablo — orta — ~70 kelime, ~0,3 sayfa**
- **Yer:** 02:229–247 `tab:fv-guc-dagilimi` ↔ 02:216 `fig:fv-calisma-profilleri`, panel (d). Caption'a göre (d) paneli aynı sayımların güç sınıflarına gruplanmış hâli.
- **Öneri:** Tabloyu çıkar ya da (d) panelini kaldır. Tablo yalnız 02:321'den, yani F-31'de çıkarılan paragraftan anılıyor.

**F-42 — şekil/tablo — orta — ~100 kelime, ~0,4 sayfa**
- **Yer:**
  - 03:109–137 `fig:t-tipi-uc-seviye` (P, O, N durumları) ↔ 03:163–205 `fig:t-tipi-akim-yollari` (b)–(e) (aynı devre çizimleriyle P, O, N ve iki O yolu) ↔ 03:141–155 `tab:t-tipi-durumlar`.
  - 02:198–203 `fig:t-tipi-faz-kolu` ↔ `fig:t-tipi-akim-yollari`(a) (faz başına tam topoloji ve LCL).
- **Öneri:**
  - `fig:t-tipi-uc-seviye`'yi çıkar. Akım yolları şekli aynı bilgiyi akım yönüyle birlikte veriyor. Ölçü: bir kez 03:109'dan, bir kez Bölüm 7'den gönderme alıyor; Bölüm 7'deki gönderme `fig:t-tipi-akim-yollari`'ya yönlendirilmeli.
  - Bölüm 2'deki faz kolu fotoğraf/çizimi Q₁–Q₄ adlandırması için Bölüm 3'ten gönderme alıyor (03:73). Adlandırma Bölüm 3'te (a) panelinde de verilebilir, ama iki şekli korumak da kabul edilebilir. Düşük öncelikli alt öneri.

**F-43 — şekil/tablo — orta — ~250 kelime, ~0,5 sayfa**
- **Yer:** Kanıt eşleme işlevli dört öğe:
  - 03:54–69 `tab:model-katmanlari` (katman → sınanan konu → tamamlayıcı katman),
  - 03:592–609 `tab:dogrulama-matrisi` (bölge → yöntem → kanıt → bölüm),
  - 01:61–87 `tab:katki-yontem-kanit` (katkı → yöntem → kanıt),
  - 01:103–153 `fig:tez-akisi` (yeşil "kanıt katmanları" kutuları).
- **Alıntı:** 03:52 "Katman ayrımı, ortalama değerli denetim modelinden elde edilen kararlılık sonucunu anahtarlama kaybı ve deneysel verim kanıtından ayrı tutmaktadır."
- **Öneri:** Bölüm 3'te iki tabloyu birleştir. Doğrulama matrisine bir "model katmanı" sütunu eklemek yeterli. `tab:model-katmanlari` etiketi Bölüm 5'ten bir gönderme alıyor; birleşik tabloya yönlendirilmeli. 03:52 paragrafı birleşik tablonun girişine katılsın. Bölüm 1'deki tablo F-32 ile taşınıyor.

**F-44 — şekil/tablo — düşük — ~50 kelime, ~0,4 sayfa (isteğe bağlı)**
- **Yer:** 03:13–48 `fig:genel-sistem-mimarisi` ↔ 02:12–48 `fig:eds-mimarisi` (aynı güç zinciri: batarya → DA bara → dönüştürücü → LCL → şebeke) ↔ 03:380–427 `fig:denetim-modulasyon-blok` (denetim zinciri daha ayrıntılı, Sin³ yolu dahil).
- **Öneri:** Bölüm 3'teki genel mimari şekli, iki komşu şeklin birleşimi niteliğinde. Tek gönderme alıyor (03:11). Çıkarılabilir; 03:11 paragrafı güç yolunu Bölüm 2 şekli olmadan bir cümleyle anlatır. İsteğe bağlı: sistem bölümünün bir genel şekille açılması da yaygın bir tercih.

**F-45 — şekil/tablo — düşük — 0 ile ~1 sayfa (isteğe bağlı)**
- **Yer:** 03:77–93, iki yatay sayfa: `fig:gelen-tam-topoloji` ve `fig:gelen-faz1-hucresi` (birincinin büyütülmüş ayrıntısı, tek gönderme).
- **Öneri:** Tam topoloji okunabiliyorsa büyütülmüş hücre çıkarılabilir. Okunamıyorsa ikisi kalsın. Basılı PDF'te okunabilirlik denetlenmeli.

---

## 4. Uygulama sırası önerisi

Uygulama yapılırsa en az risk ve en çok kazanç için önerilen sıra:

1. Tek başına güvenli çıkarmalar: F-24, F-39, F-27, F-28, F-29, F-35, F-36.
2. Bölüm 3 kalite güvence kısaltması: F-20, F-21, F-22, F-23. Dış göndermeler (`sec:model-dogrulama-duzeltme`, `tab:sistem-parametreleri`) korunmalı.
3. Taşımalar: F-01 (Bölüm 3 → 6), F-32 (Bölüm 1 → 8). Taşıma sonrasında `\label` sayısı aynı kalmalı. `grep -c '\\label'` ile önce ve sonra karşılaştırılmalı.
4. Tekrarların tek yere indirilmesi: F-02, F-05–F-08, F-13. Bölüm 4 ve 5'teki eşleri de birlikte düzenlenmeli.
5. Bölüm 2 oran düzenlemesi: F-37, F-40, F-41. Tek kalan atıflar (Vetter2005, Smith2017, Chen2021, Feng2018) korunmalı.
6. Tanım temizliği: F-25, F-26. 04:33 ve 06:234'teki eşitlik göndermeleri düzeltilmeli.
7. Her adımdan sonra Ayakaleaf'te derlenmeli ve tanımsız gönderme kalmadığı denetlenmeli. Derlemeyi ana oturum yapar.
