# S4: denetleyici düzeltmesinin yarım periyot göstergesini çevirmesi (17.11.2026)

Karar: K-37. Amaç: ilk tezin 3.7.2 "akım kontrolörünün düzeltme davranışı" savını
(düşük akımda denetleyici düzeltmesi karşı anahtar grubunu devreye sokar) S4 kapalı çevrim
kayıtlarıyla sınamak. Yeni benzetim yapılmadı; mevcut kayıtlar salt okunur sayıldı.

- Betik: `scripts/analyze_s4_sign_flips_20261117.m`
- Kaynak: `runs/2026-10-28_s4_kapali_cevrim/results/KC_*/dalga.mat` (tezdeki S4 kesin
  tarama ayarları, K-20 + D-11; P: Kp = 0,03, PI: Ki = Kp·2π·60)
- Çıktı: `results/s4_isaret_degisimi_20261117/isaret_degisimi.csv`
- Pencere: son temel periyot (20 ms), örnekleme 1 µs.
- Tanımlar: κ = (u_top ≥ 0) (Bölüm 4, `eq:susturma-etkinlestirme`); "ters κ"
  sgn(u_top) ≠ sgn(i_ref); ters yük Q_rev = ∫max(−i_L1·sgn(i_ref), 0) dt
  (Bölüm 4 `sec:ters-akim-mekanizmasi` tanımı, i_L1 anlık akım).

## Sonuç

| Koşu | u_top işaret değişimi | u_ff işaret değişimi | Ters κ aralığı (>100 µs) | Ters κ süresi | Q_rev (A·µs) | Q_rev, ters κ içinde |
|---|---|---|---|---|---|---|
| P, 2,3 A | 2 | 2 | 3 (0) | %0,72 | 12,6 | 0,07 |
| PI, 2,3 A | 2 | 2 | 3 (0) | %0,56 | 12,6 | 0,00 |
| P, 10 A | 4 | 2 | 4 (0) | %0,53 | 2,1 | 0,01 |
| PI, 10 A | 24 | 2 | 13 (0) | %1,80 | 391,7 | 345,6 (%88) |
| P, 25 A | 14 | 2 | 9 (0) | %0,66 | 0,3 | 0,07 |
| PI, 25 A | 24 | 2 | 13 (0) | %0,91 | 119,9 | 105,5 (%88) |

## Yorum

1. İleri besleme komutu periyotta iki kez işaret değiştirir. PI denetleyiciyle 10 A ve 25 A'de
   toplam komut 24 kez işaret değiştirir. Ek değişimler sıfır geçişler çevresinde toplanır ve
   her ters κ aralığı bir anahtarlama periyodundan (100 µs) kısadır.
2. PI koşularında ters akım yükünün yaklaşık %88'i ters κ aralıklarında oluşur. Susturulan nötr
   anahtar κ ile seçildiğinden, ters κ aralığında susturulması gereken anahtar iletime alınır ve
   ters akım yolu yeniden açılır. İlk tezdeki savın susturmalı yapıdaki karşılığı budur.
3. 2,3 A deney noktasında ve oransal denetleyiciyle ters κ yükü ihmal edilebilir düzeydedir.
   2,3 A'deki 12,6 A·µs ters yük ters κ aralıklarında değil, κ'nın referansla aynı olduğu
   aralıklarda oluşur.
4. Laboratuvar deneyleri (S1–S3) açık çevrimdir ve u = u_ff olduğundan mekanizma
   deney sonuçlarına uygulanmaz.

## Sınırlar

- Sayım tek bir periyot penceresidir. Ölçüm dalgalanmasından doğan titreşim payı ayrıştırılmadı,
  ama ters κ yükünün büyük bölümü yalnız PI koşularında görüldüğünden kayıt gürültüsü sonucu
  belirlemez.
- Kapı kayıtları doğrudan okunmadı; κ, u_top işaretinden ve `tab:model-kapi-mantigi` kuralından
  türetildi.
- Kayıp payı nicelenmedi; tezde ek anahtarlama kaybı için sayı verilmez.
