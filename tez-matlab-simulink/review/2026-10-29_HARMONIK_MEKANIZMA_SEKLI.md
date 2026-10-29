# Harmonik oluşum mekanizması şekli ve susturma eşdeğer devresi (29.10.2026)

**Amaç.** İlk tezde bulunup yeni tezde karşılığı olmayan iki açıklayıcı şekli yeniden
üretmek (`tez-tamamlama/05_SEKIL_TABLO_ESLEME.md`, A.1):

- İlk tez Şekil 3.13: üçüncü harmonik oluşum mekanizması. Yeni tezde Şekil 5.1
  (`fig:harmonik-mekanizma`), Kesim 5.3 (`sec:harmonik-mekanizma`).
- İlk tez Şekil 4.24: susturma sonrası iki buck eşdeğeri. Yeni tezde Şekil 4.1
  (`fig:susturma-esdeger`), Kesim 4.3.

Yeni benzetim koşulmadı. Şekil 5.1, 29.10 kalibre S2 kaydını okur
(`runs/2026-10-29_tez_sekilleri/results/s2/sekil_kayit.mat`).

## Yöntem

- **Betik:** `tez-latex-v2/figures/sin3/uret_harmonik_mekanizma.m`.
  - Çıktılar: `harmonik_olusum_mekanizmasi.pdf` (vektör) ve `harmonik_mekanizma_metrikleri.csv`.
- **Analitik model:** Kesim 5.4 taramasıyla (`rescan_sin3_coefficients_20260901.m`) aynı
  parçalı doğrusal anahtarlama periyodu çözümü. Akım sıfırda kesilir, DCM/CCM geçişi
  kendiliğinden oluşur.
- **Parametreler** (kalibre S2 noktası, Tablo 3.3):

  | Parametre | Değer |
  |---|---|
  | V_dc | 395,0 V |
  | V_m | 121,00·√2 = 171,1 V |
  | L = L1 | 600 µH |
  | f_s | 10 kHz |

- **d_m:** Serbest bırakılan tek değişkendir. Analitik L1 temel bileşeni, kalibre S2
  L1 temel bileşenine (2,0953 A RMS, `l1_metrikleri.csv`) `fzero` ile eşitlendi.
- **Hizalama:** Benzetim kaydı, şebeke geriliminin 80 ms'deki yükselen sıfır geçişine
  göre hizalandı (t0 = 0,079999 s). Ortalama zarf, 0,1 µs eşit ızgarada her T_s
  penceresinin ortalamasıdır.

## Sonuç

| Büyüklük | Parçalı analitik model | Kalibre S2 benzetimi |
|---|---|---|
| d_m | 0,7679 | K12 = 0,76796 (kalibrasyon kaydı) |
| L1 temel bileşen tepe | 2,9632 A | 2,9632 A (eşitlendi) |
| I3/I1 (L1) | %55,60 | %55,92 |
| Ortalama zarf tepesi | ≈ 3,2 A (iki tepe simetrik) | 3,64 A (ilk tepe), ≈ 2,9 A (ikinci tepe) |

**Gözlemler**

1. **d_m ile K12 aynı çıktı.** Bulunan d_m, kalibre S2 modelinin modülasyon genlik
   ölçeğiyle (K12) dört basamakta aynıdır. Yalnız temel bileşen eşitlenmesine rağmen
   üçüncü harmonik oranı 0,3 puan içinde tutar. Saf sinüs görev oranında tek endüktanslı
   DCM modeli, susturmalı S2 akımının harmonik içeriğini doğru öngörür.
2. **Oran %39,96'dan büyüktür (Tablo 5.1).** Zarf biçimi d_m'den bağımsızdır, ancak
   V_m/V_h oranına bağlıdır: S1 noktasında 0,785, S2 noktasında 0,866.
3. **Benzetim zarfı asimetriktir.** İlk tepe 3,6 A, ikinci tepe 2,9 A'dır. Analitik
   modelde C_f–L2 dinamiği ve akımın şebekeye göre fazı yoktur. Tezde fark
   "ilişkilendirilebilir" diliyle verildi; nedeni ayrıca ölçülmedi.

## Tez metni

- **Kesim 4.3:** Yeni paragraf ve Şekil 4.1 (TikZ `\susturmabuckvector`,
  `figures/sistem/t_tipi_vektor_cizimler.tex`). Pozitif yarım periyot: Q1 + (Q3 iletimde
  + DS4). Negatif yarım periyot: Q2 + (Q4 iletimde + DS3). Gösterim Tablo 4.2 kapı
  mantığıyla aynıdır.
- **Kesim 5.3:** Etiket `sec:harmonik-mekanizma` eklendi. Giriş cümlesi Şekil 4.1'e
  bağlandı. Yukarıdaki sayılarla yeni paragraf ve Şekil 5.1 eklendi.
- **Derleme 29.10.2026:** Notlu 230 sayfa, notsuz 226 sayfa; Undefined ve Overfull yok.
