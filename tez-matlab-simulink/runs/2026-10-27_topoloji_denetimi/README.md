# 2026-10-27 · Topoloji, cihaz eşlemesi ve modülasyon denetimi

## Amaç

12.10 paketindeki üç modelin güç devresi bağlantısı, yarı iletken parametre eşlemesi ve PWM
yapısı tez tanımına göre salt okumayla denetlendi. Benzetim koşturulmadı, model kaydedilmedi;
klasörde sayısal benzetim sonucu yoktur.

- İş paketi: İP-2
- İlgili kayıtlar: D-07 (IGBT eşlemesi uygun), D-08 (diyot takası), D-09 (EMC X kapasitörü),
  D-10 (sabit yazılmış değerler); K-06a (Sin³ biçimi: K33·sin³θ), K-17, K-18
- Review notu: [2026-10-27_TOPOLOJI_DENETIMI.md](../../review/2026-10-27_TOPOLOJI_DENETIMI.md)
- Kayıt defterleri: [01_KARAR_DEFTERI.md](../../../tez-tamamlama/01_KARAR_DEFTERI.md),
  [02_MODEL_DUZELTME_KAYDI.md](../../../tez-tamamlama/02_MODEL_DUZELTME_KAYDI.md)

## Senaryolar ve modeller (`model/`)

| Model dosyası | Senaryo | Pakete göre değişiklik |
|---|---|---|
| `inverter_scenario1_parametric5_etiquetli.slx` | S1 + S2 devresi (S2 kapısız, D-01) | Yok (bayt bayt aynı) |
| `inverter_senaryo3.slx` | S3 (susturma + Sin³ ileri besleme) | Yok (bayt bayt aynı) |
| `inverter_senaryo4.slx` | S3 kopyası (D-02) | Yok (bayt bayt aynı) |
| `inverter_common_parameters.m` | Ortak parametre dosyası | Yok (paketle aynı) |

Denetim sonrası kopyaların SHA-256 özetleri değişmemiştir.

## Parametreler

Değerler paketin parametre dosyasıyla aynıdır; ayrıntılı tablo
`2026-10-27_dort_senaryo_ilk_kosu/README.md` içindedir. Denetimin doğruladığı ya da sorun
bulduğu başlıca parametre bağları:

| Konu | Modeldeki durum | Tez kapsamındaki doğru durum |
|---|---|---|
| Dış IGBT S1–S2 | `S12_*` (SKM100GB12T4) | aynı (D-07, uygun) |
| Nötr IGBT S3–S4 | `S34_*` (IXYN100N65C3H1) | aynı (D-07, uygun) |
| Harici diyot D1–D2 (`Diode5`/`Diode3`) | `DS34_*` (IXYN iç FRD) | `D12_*` (DSEI2x61-12B) — D-08 |
| Nötr ters paralel DS3–DS4 (`Diode6`/`Diode7`) | `D12_*` (DSEI) | `DS34_*` (IXYN iç FRD) — D-08 |
| EMC X kapasitörü (`Capacitor6`/`Capacitor7`) | `C_emc_aux` = 1 µF / 0,01 Ω | `EMC_Cx_eq` = 0,5 µF / `EMC_Rx_eq` = 0,2 Ω — D-09 |
| Sin³ terimi (S3) | `Sine Wave3` → `Product15` → `Product1` → `K3` (= `K33`) | K33·sin³θ, pozitif, normalizasyonsuz (K-06a) |
| IGBT `Vth`, ısıl ağ, diyot `Tdevice` | Sayı olarak yazılmış (6; [0, 10]; 25) | Değerler m-dosyasıyla aynı, sayısal etkisiz (D-10) |
| DC bara | 2 × 470 µF (`Cdc_pos/neg`) | aynı |
| L1 / Cf / L2 | 600 µH / 8 µF / 1000 µH | aynı |
| fsw / ölü zaman | 10 kHz / 1 µs | aynı |

## Nasıl çalıştırılır

Komut proje kökünden (`tez-matlab-simulink/`) verilir; süre ~1 dk.

```powershell
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "run('scripts/audit_topology_20261027.m')"
```

Ön koşullar:

- `model/` klasöründe ham paketin bayt bayt kopyası bulunmalıdır (betik kopyalamaz).
- Betik parametre dosyasını `load_system`'dan önce taban çalışma alanında çalıştırır (D-03).
- Modeller yalnız yüklenir; derleme ya da benzetim yapılmaz.

## Çıktılar

Her model için (`<model>` = üç model adı):

| Dosya | İçerik |
|---|---|
| `<model>_netlist.txt` | Fiziksel düğüm listesi ve blok → düğüm tablosu (union-find ile kurulmuş) |
| `<model>_bacak_eslemesi.txt` | T-tipi bacak rollerinin otomatik çıkarımı (dış/nötr IGBT, D1–D2, DS1–DS4, DA bara) |
| `<model>_cihaz_eslemesi.csv` | IGBT/diyot → parametre tablosu öneki, sayı olarak yazılmış alanlar |
| `<model>_simscape_params.csv` | Bütün Simscape bloklarının diyalog parametreleri |
| `<model>_signal_graph.txt` | PWM, kapı ve ölçüm sinyal grafiği; Goto/From tablosu |
| `<model>_mdosyasi_kullanim.txt` | m-dosyası değişkenlerinin bloklarda doğrudan kullanımı |

`.gitignore` gereği `slprj/`, `*.slxc` ve `*_acc.*` artıkları depoya girmez. `model/` altındaki
`.slx` ve `.m` dosyaları depoda tutulur.

## Uyarı

- Denetim yapı ve parametre bağı düzeyindedir; D-08 ve D-09'un sayısal etkisi
  `2026-10-27_diyot_esleme` ve `2026-10-28_kalibrasyon` klasörlerinde ölçülmüştür.
- Ortak kip bobini nokta yönü ve diyot A/K sırası korumalı Simscape bileşenlerinden okunamadı;
  bağlantı tutarlılığından çıkarıldı (review notu, "Doğrulanamayan" kesimi).
