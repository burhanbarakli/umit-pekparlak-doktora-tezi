# İP-11: tez şekillerinin yenilenmesi (29.10.2026)

Karar: K-25. Amaç, 300 dpi altındaki benzetim şekillerinin kalibre modellerden vektör olarak
yeniden üretilmesi ve yeniden çizilebilen kavram şekillerinin vektöre çevrilmesidir.

## Koşu

- Betik: `scripts/run_tez_sekilleri_20261029.m` (`s1`, `s2`, `s3`; üç süreç paralel, ayrı klasörler).
- Model kaynağı: `runs/2026-10-28_parametre_tablosu/model/tez/` (kalibre S1/S2/S3, K-20 değerleri
  `*_kalibrasyon.m` içinde). Model ve parametre değişmedi.
- Ek kayıt: bütün PS-Simulink dönüştürücü çıkışları (L1 akımı, kapı sürücüsü 0/15 V) ve modelin
  kendi kayıtlı işaretleri; t ≥ 0,075 s saklandı (`results/<s>/sekil_kayit.mat`, git dışı).
- Accelerator, 0,1 s: S1 2342 s, S2 1954 s, S3 2039 s.

## Yeniden üretim denetimi

Son değerler kalibrasyon koşularıyla (s1_k4, s2_k4, s3_k6) aynıdır:

| Senaryo | η (bu koşu) | η (kalibrasyon) | THD (bu koşu) | THD (kalibrasyon) |
|---|---|---|---|---|
| S1 | 0,911510 | 0,911510 | 0,395093 | 0,395093 |
| S2 | 0,939322 | 0,939322 | 0,567219 | 0,567219 |
| S3 | 0,942544 | 0,942544 | 0,147768 | 0,147768 |

## İşaret eşlemesi

- L1 akımı: S1 ve S3'te `PS-Simulink Converter3`, S2'de `PS-Simulink Converter5`. Doğrulama:
  son periyotta L1 temel bileşeni şebeke akımı temel bileşeniyle %1 içinde (S1 2,085/2,063 A,
  S2 2,095/2,101 A, S3 2,253/2,254 A RMS); fark Cf akımıdır.
- Kapılar: S2'de mantık işaretleri g12, g22, g42, g32 → Q1, Q2, Q3, Q4. S1 modelinde mantık
  kaydı yoktur; kapı sürücüsü çıkışları S2'deki eşleşmeyle (sürücü 3, 2, 4, 1 → Q1–Q4; uyum
  0,969–0,9997, fark ölü zaman kenarları) aynı sırayla alındı.
- S1 kapı mantığı (son periyot, yarım periyot başına geçiş): pozitif yarıda Q1 ve Q4 198 geçiş,
  Q2 sürekli 0, Q3 sürekli 1; negatif yarıda Q2 ve Q3 198 geçiş, Q1 0, Q4 1. S2'de Q4 pozitif,
  Q3 negatif yarıda bastırılmıştır. Tablo 4.2 (`tab:model-kapi-mantigi`) ile örtüşür.

## L1 akımı metrikleri (pozitif yarım periyot, 0,1 µs eşit ızgara)

| Senaryo | i_L1 < −0,05 A süre oranı | \|i_L1\| ≤ 0,05 A süre oranı | i_L1 tepe |
|---|---|---|---|
| S1 | %25,2 | %1,5 | ±8,5 A |
| S2 | %0 | %17,0 | 8,2 A |
| S3 | %0 | %27,6 | 7,7 A |

Değişken adımlı örneklerin doğrudan ortalaması sıfır geçişlerinde sıklaşan örnekler nedeniyle
sapmalıdır (S1 sıfır oranı %15,9 çıkıyordu); oranlar eşit ızgarada hesaplanmıştır. Sıfır oranı,
kutup geriliminin ara seviyede kaldığı süre oranından (`sureksiz_iletim.csv`, S2 %12,4, S3 %22,6,
20 ms pencere) farklı bir tanımdır; ikisi aynı sıralamayı verir.

## Üretilen şekiller (`tez-latex-v2/figures/`)

| Dosya | Üreten | Tezdeki yer |
|---|---|---|
| `model_dogrulama/s1_kapi_isaretleri.pdf` | `uret_l1_kapi_sekilleri.m` | Şekil 4.2 (eski 4 kapı ekranı yerine) |
| `model_dogrulama/s1_s2_kalibre_l1.pdf` | aynı | Kesim 4.5.1 (eski 4 L1 ekranı yerine) |
| `model_dogrulama/s3_kalibre_l1.pdf` | aynı | Kesim 5.6 (eski Sin³ L1 ekranı yerine) |
| `model_dogrulama/s3_model_ust_duzey.pdf` | `uret_model_cizimi.m` + `kirp_model_cizimi.py` | Şekil 4.3 (eski model ekranı yerine) |
| `literatur/batarya_*.pdf` | `literatur/uret_batarya_egrileri.m` | Şekil 2.2 (aynı veri noktaları) |
| TikZ | bölüm dosyalarında | Şekil 1.1 akış, 2.1 EDS, 2.3 BYS, 2.10 DE/CCM, 5.2 eşpotansiyel |

Çıkarılanlar: eski faz modeli görseli (Şekil 3.4 aynı yapıyı vektör olarak verir; eski görselde
C1 = 1 nF etiketi tasarım değeri 8 µF ile çelişiyordu), Chicco2009 veri grafiği (108 dpi; değerler
metinde atıfla), eşpotansiyel dalga ekranı (Şekil 5.2'ye birleşti).

Sayılar tez bulgusu değildir (İ5): kalibre benzetim, deney özetini belirtilen hatayla yeniden üretir.
