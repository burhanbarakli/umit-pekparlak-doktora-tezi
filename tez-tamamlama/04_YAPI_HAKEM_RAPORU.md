# Yapı hakem raporu — akış, sıra ve hacim (29.10.2026)

Durum: **Bekliyor — tez sahibi daha sonra bakacak.** Uygulanmadı; tez metninde
hiçbir değişiklik yapılmadı. Uygulama kararı İP-14 olarak plan tablosunda.

- İnceleyen: `tez-hakem` alt ajanı (`.claude/agents/tez-hakem.md`) — doktora tezi
  yazımında deneyimli, güç elektroniğine hâkim, jüri gözüyle okuyan bağımsız hakem.
  Önceki tekrar ayıklamasının sonucu ona verilmedi; kendi okumasını yaptı.
- İncelenen sürüm: `tez-latex-v2/tez_guncel_2026-10-29.pdf` (notsuz, 226 sayfa),
  commit `e2fd45e`.
- Soru: "Tezin akış başlıkları ve sıralaması uygun mu; bölüm bakımından fazla mı?"

## 1. Genel hüküm (hakem)

Sekiz bölüm bir SAÜ FBE doktora tezi için fazla sayılmaz. Giriş → literatür →
model → iki katkı → deney → üçüncü katkı → sonuç dizisi gelenekle uyumludur;
bölüm birleştirmeye gerek yoktur. Sorun bölümlerin içindedir:

- Bölüm 3 aşırı yüklüdür (32 s., %19).
- Bölüm 4 ve 5, Bölüm 6'daki kalibrasyona ileriye doğru dayanır.
- Benzetim ekranları, güç tanımları ve kapı mantığı iki üç yerde yinelenir.
- Kanıtı en zayıf katkı olan GT-tipi bölüm (24 s.), hacimce faz kolu katkılarına yakındır.

Yaklaşık 15–20 sayfa eke taşınabilir veya kısaltılabilir. Hedef ana metin
~145–150 s. (şimdi ~166 s.).

## 2. Sayfa payı (ana metin s. 1–168)

| Bölüm | Sayfa | Pay | Kesim | Kelime |
|---|---|---|---|---|
| B1 Giriş | 1–8 (8 s.) | %5 | 5 | 2 666 |
| B2 Literatür | 9–28 (20 s.) | %12 | 6 | 5 799 |
| B3 Sistem, Model, Metodoloji | 29–60 (32 s.) | %19 | 10 | 9 172 |
| B4 Düşük Güç Anahtarlama | 61–80 (20 s.) | %12 | 5 | 4 939 |
| B5 Sin³ ve Kapalı Çevrim | 81–106 (26 s.) | %16 | 9 | 6 499 |
| B6 Deneysel Doğrulama | 107–134 (28 s.) | %17 | 11 | 5 047 |
| B7 GT-Tipi Mimari | 135–158 (24 s.) | %15 | 8 | 4 584 |
| B8 Sonuç | 159–168 (10 s.) | %6 | 5 | 2 430 |

Bölüm 6'da donanım tanımı (6.1–6.5) 14 s., üç kipin deney kayıtları (6.6–6.8)
yalnız ~5 s.

## 3. Öneriler (hakem, öncelik sırasıyla)

Satır numaraları 29.10.2026 (`e2fd45e`) sürümüne göredir.

| # | Öncelik | Yer | Sorun | Öneri |
|---|---|---|---|---|
| 1 | Yüksek | Kesim 6.10 `06-deneysel-dogrulama.tex:487` | Kalibrasyon ileride kalıyor: 3.9 (`03:682`), 4.4.1 (`04:143`) ve 5.6 kalibre modele (`sec:kalibrasyon`) dayanıyor, okuyucu yöntemi iki bölüm sonra görüyor | 6.10'u deney özet tablosuyla birlikte Bölüm 3'e, 3.8'in ardına "Benzetim Modelinin Deney Özetine Kalibrasyonu" adıyla taşı |
| 2a | Yüksek | Kesim 3.6 `03:427–538` | Parametre uzun tablosu ~10 s. | Ek-D'ye taşı; metinde 12–15 satırlık özet tablo kalsın |
| 2b | Yüksek | Kesim 3.8 `03:651–680` | D-01…D-11 model düzeltme tablosu metni şişiriyor | Ek-E'ye taşı; metinde bir paragraf kalsın |
| 2c | Yüksek | Kesim 3.9 `03:682` | "Düşük Akımda Benzetim Modelleme" kalibrasyon koşularının sonucu; başlık dil bakımından kusurlu | Taşınan kalibrasyon kesimiyle birleştir; başlık "Modelin Düşük Akım Davranışı" |
| 3a | Orta | 4.4.3 `04:274` ↔ 3.7 `03:602–615` | Güç tanımları iki yerde | 4.4.3, 3.7'ye katılsın |
| 3b | Orta | `03:362` (`eq:sin3-ozdeslik`) ↔ `05:9` (`eq:sin3-acilimi`) | Sin³ özdeşliği iki kez kurulmuş | Bir yerde kur, öbüründe atıf ver (hakem: 3.5'te atıf) |
| 3c | Orta | 3.5.1 `03:420` ↔ 4.3.1 `04:82` | Kapı mantığı iki yerde | 4.3'te birleştir |
| 3d | Orta | 2.3 `02:325–371`, 3.3, 4.1 | Senkron-buck ters akımı üç yerde; `02:371` paragrafı tezin kendi model çıktısına dayanıyor | `02:371` paragrafını literatürden 4.1'e al |
| 4 | Orta | 4.4.2 `04:179–272` (~5 s.), 5.6 ikinci yarı `05:222–247` | Kalibre edilmemiş ekran kayıtları, kalibre karşılaştırmanın yanında ikinci ve çelişebilen sayı kümesi sunuyor (S1 THD %8,3 / %39,5 / %15) | Ekranları tek ek kesimde topla; metinde bir cümlelik atıf |
| 5a | Orta | 6.2–6.5 `06:114–234` | Bölüm 6 oranı ters (donanım 14 s., sonuç ~5 s.) | Kart fotoğrafları, pencere karşılaştırıcı, PC yazılımı, bileşen tabloları eke; metinde 4–5 s. düzenek ve ölçüm zinciri özeti |
| 5b | Orta | 6.6–6.8 | Üç kip ayrı kesimlerde | "Üç Anahtarlama Kipinin Deney Kayıtları" altında üç alt kesim |
| 6a | Orta | 7.3 `07:184` | "Şarj Yönündeki Benzetim Kayıtları", modları tanımlayan 7.4'ten önce | 7.4 ve 7.5 öne alınsın |
| 6b | Orta | 7.6, 7.7 | Ayrı kesimler | "Karşılaştırma ve Kanıt Düzeyi" adıyla birleştir |
| 6c | Orta | 7.2.2 `07:106–182`, IEC tablosu `07:395` | Proje başvuru şekilleri ve koruma-doğrulama tablosu hacim | Eke al; Bölüm 7 hedefi ~15 s. |
| 6d | Orta (jüri riski) | `01-giris.tex:25` ↔ `07:469` | Ana sav GT'yi ilk sırada anıyor, kanıt düzeyi "mimari tanım" | Sav cümlesinde sıra kanıt gücüne göre (bkz. §4) |
| 7a | Düşük | 3.5, 4.3, 6.9 | Tek alt kesimli kesimler (3.5.1, 4.3.1, 6.9.1) | Alt kesim kaldırılsın ya da kardeş eklensin |
| 7b | Düşük | 3.5.1, 3.6.x, 4.x, 5.7.x, 5.8.x, 6.10.x ↔ 7.2.x, 6.9.1, 8.2.x | Büyük harf düzeni karışık (cümle düzeni ↔ her sözcük büyük) | Tek düzene çek |
| 7c | Düşük | 6.10.1 | "Yöntem" çok genel başlık | Özgül başlık |
| 8 | Düşük | Bölüm 4, Kesim 4.3 | "Yeni Anahtarlama Yöntemi" belirsiz | Bölüm: "DÜŞÜK GÜÇTE TERS AKIM VE NÖTR ANAHTAR SUSTURMA YÖNTEMİ"; 4.3: "Nötr Anahtar Susturma Yöntemi" |
| 9 | Düşük | Bölüm 5 iç sırası | 5.2 "Geçerlilik Sınırı" türetmeden (5.3–5.4) önce; 5.5 "Önerilen Yapı" katsayılardan sonra | Tanım → yapı → mekanizma → katsayılar → geçerlilik sınırı → S3 → S4 → kararlılık |

## 4. Hakemin önerdiği yeni sıra

1. **Giriş** — değişmez.
2. **Literatür** — 2.1 kısalır; 2.3'ün son paragrafı 4.1'e.
3. **Sistem ve Model** — 3.1–3.4; 3.5 (atıf); 3.6 özet tablo; 3.7 (+ güç tanımları);
   3.8 model doğrulama (özet); 3.9 kalibrasyon ve düşük akım davranışı.
4. **Düşük Güçte Ters Akım ve Nötr Anahtar Susturma** — 4.1 mekanizma; 4.2 klasik;
   4.3 susturma ve kapı mantığı; 4.4 kalibre karşılaştırma.
5. **Sin³** — 5.1 tanım; 5.2 yapı; 5.3 mekanizma; 5.4 katsayılar ve geçerlilik;
   5.5 S3; 5.6 S4; 5.7 kararlılık.
6. **Deneysel Doğrulama** — 6.1 düzenek ve ölçüm zinciri (özet); 6.2 üç kipin
   kayıtları; 6.3 değerlendirme ve belirsizlik.
7. **GT-Tipi** — 7.1 gereksinimler; 7.2 yapı; 7.3 modlar; 7.4 geçişler; 7.5 şarj
   benzetimi; 7.6 karşılaştırma ve kanıt düzeyi.
8. **Sonuç.**

Ekler: EK-A–C değişmez; yeni EK-D (parametre tablosu ve donanım ayrıntıları),
EK-E (model düzeltme kaydı ve kalibre edilmemiş ekranlar).

Tahmini sonuç: ana metin ~145–150 s.; Bölüm 3 ~22 s., Bölüm 6 ~14 s., Bölüm 7 ~15 s.

## 5. Doğrulama ve Claude'un görüşü

Başlık ağacı `grep` ile kaynaktan çıkarıldı ve hakem bulguları denetlendi.

**Doğrulanan bulgular**

- Kalibrasyon (Kesim 6.10, `06:487`) Bölüm 3, 4 ve 5'ten sonra geliyor.
- Tek alt kesimli kesimler: 3.5 → 3.5.1, 4.3 → 4.3.1, 6.9 → 6.9.1.
- Kesim 7.3 şarj benzetimi, Kesim 7.4 modlardan önce geliyor.
- Büyük harf düzeni karışık.
- Sin³ özdeşliği hem `03:363` hem `05:11` içinde ayrı etiketle kurulmuş. İkisi de
  doğru özdeşliği kullanıyor.

**Görüşler**

1. **Kalibrasyonun Bölüm 3'e taşınması (#1).** Taşıma, deney özet tablosunu deney
   bölümünden önce vermek demektir. Uygulanabilir çözüm: tablo Bölüm 3'te
   "raporlanmış deney özeti" olarak yer alır. Bölüm 6 ekran kayıtlarını, ölçüm
   zincirini ve sayısal denetimi (6.9.1) gösterir ve Bölüm 3'teki tabloya atıf verir.
   - Alternatif: Bölüm 6'yı Bölüm 4'ün önüne almak. Önerilmez; katkılar tanıtılmadan
     deney kipleri anlamsız kalır.
2. **Uygulama sırası (önerilen).** Önce yüksek, sonra eke taşıma gerektirmeyenler,
   en sonda eke taşımalar.
   1. Eke taşıma gerektirmeyenler:
      - 6a, 6b, 7a, 7b, 7c, 8 ve 9 (sıra ve başlık düzeltmeleri);
      - 3a–3d (yinelenen tanımlar);
      - 5b (6.6–6.8'in birleşmesi).

      Bu grup sayfa sayısını az değiştirir; risk düşüktür.
   2. #1 ve 2c (kalibrasyonun taşınması): bütün `sec:kalibrasyon` atıfları denetlenir.
   3. Eke taşımalar: 2a, 2b, 4, 5a, 6c.
      - Ekler EK-A–C'nin `\ekbasligi` / `\ekbelge` düzenine uyar.
      - Ek numaraları `\ref` ile verilir.
3. **Jüri riski 6d.** Sav cümlesinde sıra şöyle değişebilir: önce nötr anahtar
   susturma ve Sin³ (deney ve kalibre benzetim kanıtlı), sonra GT-tipi mimari
   (tanım ve şarj benzetimi düzeyinde). Tablo 1.1'deki katkı sırası aynı kalır
   ya da aynı düzene çekilir.
4. **#4 kalibre edilmemiş ekranlar.** Ekranların eke alınması, Ümit Abi notundaki
   S1 karışıklığını (%8,3 / %39,5 / %15) metinden kaldırır. "%15'ten %47'ye"
   cümleleri için A/B kararı (K-28 notu) hâlâ Ümit Abi'dedir; eke taşıma o kararı
   değiştirmez.
5. **Biçim.** Önerilerin hiçbiri sayfa geometrisini, başlık stilini ya da İçindekiler
   ayarını değiştirmez. Bölüm başlığının büyük harfle yazımı mevcut stilin işidir.

## 6. Uygulanırsa denetim listesi

- [ ] `grep "Undefined" build/main.log` boş; Overfull yok.
- [ ] Bütün `\ref{sec:kalibrasyon}`, `tab:kalibrasyon-karsilastirma`,
      `tab:sistem-parametreleri`, `sec:model-dogrulama-duzeltme` atıfları doğru yeri gösteriyor.
- [ ] Bölüm 1 "Tezin Düzeni" (`sec:giris-duzen`) ve Şekil 1.1 akışı yeni sıraya göre güncel.
- [ ] Özet/Summary bölüm sırası anlatımı güncel.
- [ ] "bu" ailesi taraması 0.
- [ ] Notlu ve notsuz derleme; sayfa sayıları kayda.
