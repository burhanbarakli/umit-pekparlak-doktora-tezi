# 2026-10-28 · Tek parametre tablosu için parametre envanteri

## Amaç

Bölüm 3'teki `tab:sistem-parametreleri` tablosu 12.10 paketinin parametre dosyasından yeniden
üretildi. Her değişkenin yalnız m-dosyasında tanımlı olmasıyla yetinilmedi; sonuçların dayandığı
taban modellerde hangi blokta gerçekten kullanıldığı MATLAB ile tarandı. Benzetim koşturulmadı,
model kaydedilmedi; klasörde benzetim sonucu yoktur.

- İş paketi: İP-7 (jüri maddesi 9)
- İlgili kayıtlar: D-03, D-07, D-08, D-09, D-10, D-11, D-13, D-14 (sabit yazılmış ölçüm ve
  çözücü ayarları); K-09, K-14, K-17, K-18, K-19, K-20, K-22 (tablo tür sınıfları)
- Review notu: [2026-10-28_PARAMETRE_TABLOSU.md](../../review/2026-10-28_PARAMETRE_TABLOSU.md)
- Kayıt defterleri: [01_KARAR_DEFTERI.md](../../../tez-tamamlama/01_KARAR_DEFTERI.md),
  [02_MODEL_DUZELTME_KAYDI.md](../../../tez-tamamlama/02_MODEL_DUZELTME_KAYDI.md)

## Senaryolar ve modeller

Bütün dosyalar kaynaklarının bayt bayt kopyasıdır (`envanter_gunlugu.txt`, `ayni=1`).

`model/ham/` (12.10 paketi, değiştirilmemiş):

| Etiket | Model | Senaryo |
|---|---|---|
| ham_S1S2 | `inverter_scenario1_parametric5_etiquetli.slx` | S1 + S2 devresi (S2 kapısız, D-01) |
| ham_S3 | `inverter_senaryo3.slx` | S3 |
| ham_S4 | `inverter_senaryo4.slx` | S3 kopyası (D-02) |

`model/tez/` (tez sonuçlarının dayandığı taban modeller):

| Etiket | Model | Ek dosya | Kaynak klasör | Uygulanan düzeltmeler |
|---|---|---|---|---|
| tez_S1 | `inverter_s1_kal.slx` | `inverter_s1_kal_kalibrasyon.m` | `2026-10-28_kalibrasyon/model_s1` | D-01, D-03, D-08, D-09, D-12; K-20 |
| tez_S2 | `inverter_s2_kal.slx` | `inverter_s2_kal_kalibrasyon.m` | `2026-10-28_kalibrasyon/model_s2` | D-01, D-03, D-08, D-09, D-12; K-20 |
| tez_S3 | `inverter_senaryo3_kal.slx` | `inverter_senaryo3_kal_kalibrasyon.m` | `2026-10-28_kalibrasyon/model_s3` | D-03, D-08, D-09; K-20 |
| tez_S4 | `inverter_senaryo4_kc.slx` | `s4_denetleyici_parametreleri.m` (+ `KC_PI_25A/kosu_bilgisi.txt` InitFcn eki) | `2026-10-28_s4_kapali_cevrim/model` | D-02, D-03, D-08, D-09, D-11; K-14, K-19, K-20 |

Her iki alt klasörde `inverter_common_parameters.m` paketle aynıdır. Yorum satırına alınmış bloklar
(D-12 ayrık kopyalarında `Commented = on`) taramaya katılmadı.

## Parametreler

Tez modellerinde senaryoya özgü etkin değerler (`etkin_degerler.csv`):

| Büyüklük | tez_S1 | tez_S2 | tez_S3 | tez_S4 |
|---|---|---|---|---|
| Vdc [V] | 431,5 | 395,0 | 427,5 | 427,5 |
| Şebeke Vac RMS [V] | 119,8 | 121,0 | 124,3 | 120,0 |
| K1x (kalibre; m-dosyası) | 0,7865024 (0,7865) | 0,7679568 (0,794) | 0,44343 (0,45) | 0,44343 (0,45) |
| K3x (kalibre; m-dosyası) | — | — (K3 = 0) | 0,384306 (0,39) | 0,384306 (0,39) |
| Referans fazı [°] (kalibre; m-dosyası) | −0,36607 (−0,44) | +0,1121 (0) | +0,6575 (0) | +0,6575 (0) |
| DC bara | 2 × 470 µF | 2 × 470 µF | 2 × 470 µF | 2 × 5,6 mF (D-11) |
| L1 çekirdek Rp | 600 Ω | 600 Ω | 600 Ω | 1500 Ω (K-14) |
| EMC X kapasitörü | 0,5 µF / 0,2 Ω (D-09; m-dosyası 1 µF / 0,01 Ω) | aynı | aynı | aynı |
| Kp / Ki / Kaw / Kr / ω_b | — | — | — | 0,03 / 11,31 / 377 / 0,3 / 12,57 rad/s |
| Ölçüm süzgeci / denetim adımı / \|u\| sınırı | — | — | — | 5 kHz / 1 µs / 1 |

Bütün modellerde ortak: L1 = 600 µH (L1r = 0,03 Ω), Cf = 8 µF (Cr = 0,01 Ω), L2 = 1000 µH
(L2r = 0,01 Ω), ortak kip bobini 400 µH (k = 0,995), fsw = 10 kHz, ölü zaman = 1 µs, ode15s,
MaxStep 1 µs, RelTol/AbsTol 1e-6. Diyot önekleri tez modellerinde D-08'e göredir (D1–D2 `D12_*`,
DS3–DS4 `DS34_*`), ham modellerde takaslıdır.

## Nasıl çalıştırılır

Komut proje kökünden (`tez-matlab-simulink/`) verilir; süre ~4 dk.

```powershell
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "run('scripts/envanter_parametre_20261028.m')"
```

Ön koşullar:

- Betik modelleri `incoming_real_data/models/2026-10-12_dort_senaryo_paketi/`,
  `2026-10-28_kalibrasyon/model_s*/` ve `2026-10-28_s4_kapali_cevrim/model/` klasörlerinden
  kopyalar; S4 InitFcn eki `2026-10-28_s4_kapali_cevrim/results/KC_PI_25A/kosu_bilgisi.txt`
  dosyasından okunur. Önceki iş paketlerinin klasörleri hazır olmalıdır.
- Parametre dosyası her yüklemeden önce taban çalışma alanında yeniden çalıştırılır
  (D-03; model kapanınca `C` ve `L` silindiği için D-13).

## Çıktılar

| Dosya | İçerik |
|---|---|
| `parametre_envanteri.csv` | 228 değişken (m-dosyası 206 + S4 dosyası 22) ve 7 kalibrasyon ataması: kaynak dosya, satır, ifade, değer, birim, yorum; model başına kullanım sayısı ve örnek blok yolu |
| `parametre_kullanim_uzun.csv` | Model, değişken, blok, parametre, ifade (uzun biçim) |
| `model_yapilandirma.csv` | Çözücü, adım, toleranslar, geri çağrılar, powergui ve Solver Configuration ayarları |
| `etkin_degerler.csv` | Tez modellerinde senaryoya özgü etkin değerler ve S4 kip kazançları |
| `blok_parametreleri_tez.csv` | Tez modellerinde denetim, ölçüm ve PWM blok parametreleri |
| `sabit_sayi_parametreleri.csv` | Fiziksel bloklarda değişken yerine sayı yazılmış etkin alanlar (D-10, D-14) |
| `envanter_gunlugu.txt` | Kopya denetimi, yükleme ve kullanım özeti |

`.gitignore` gereği `slprj/`, `*.slxc` ve `*_acc.*` artıkları depoya girmez. `model/ham/` ve
`model/tez/` altındaki `.slx` ve `.m` dosyaları depoda tutulur.

## Uyarı

- Klasör yalnız yapı ve parametre bağlarını belgeler; benzetim sayısı içermez.
- Kalibre değerler (K1x, K3x, faz) deney özet tablosuna ayarlanmış benzetim değerleridir; tabloda
  "kalibre" türüyle, m-dosyası değeri ilk değer olarak verilir (K-22).
