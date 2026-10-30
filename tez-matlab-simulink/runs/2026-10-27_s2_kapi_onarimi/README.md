# 2026-10-27 · S2 kapı yolunun onarımı (D-01)

## Amaç

Ham S1+S2 modelinde S2 devresinin kapı sürücüleri `g12…g42` etiketlerini okur, etiketleri
üreten Goto bloğu yoktur ve S2 IGBT'leri hiç anahtarlanmaz. Klasörde S2 devresine S3 modelinin
susturmalı PWM yolu (Sin³ dalı kazancı 0) betikle eklenmiş, kapı mantığı denetlenmiştir.

- İş paketi: İP-1
- İlgili kayıtlar: D-01 (düzeltme), D-03 (PreLoadFcn), D-05; K-03, K-04
- Ayrı review notu yoktur. Düzeltmenin ayrıntısı ve S2'nin ilk sayısal sonucu:
  [02_MODEL_DUZELTME_KAYDI.md, D-01](../../../tez-tamamlama/02_MODEL_DUZELTME_KAYDI.md) ve
  [2026-10-27_D08_DIYOT_ESLEME.md](../../review/2026-10-27_D08_DIYOT_ESLEME.md) (Tablo 5, D-01 + D-08 koşusu)

## Senaryolar ve modeller (`model/`)

| Model dosyası | Senaryo | Pakete göre değişiklik |
|---|---|---|
| `inverter_s1s2_s2onarim.slx` | S1 devresi (tamamlayıcı) + S2 devresi (nötr susturma) | D-01: 11 üst düzey blok eklendi (`S2 Sine Wave`, `S2 K1` = `K12`, `S2 K3` = 0, `S2 sin2`, `S2 sin3`, `S2 Sum`, `S2 PWM susturma`, `S2 Goto g12/g22/g32/g42`); PreLoadFcn eklendi (D-03). Mevcut blok silinmedi, S1 devresine dokunulmadı |
| `inverter_scenario1_parametric5_etiquetli.slx` | Onarımın kaynağı | Yok (paketle bayt bayt aynı) |
| `inverter_senaryo3.slx` | Susturmalı PWM alt sisteminin kopyalandığı model | Yok (bayt bayt aynı) |
| `inverter_senaryo4.slx` | Paket kopyası | Yok (bayt bayt aynı) |
| `inverter_common_parameters.m` | Ortak parametre dosyası | Yok (paketle aynı) |

Diyot parametreleri onarılmış modelde hâlâ takaslıdır (D-08 uygulanmamış). D-08'li sürüm
`2026-10-27_diyot_esleme/model/inverter_s1s2_s2onarim_d08.slx` dosyasıdır.

## Parametreler

Ortak parametre dosyası paketle aynıdır; S2 devresi senaryoya özgü değişkenleri ilk kez okur.

| Büyüklük | S1 devresi | S2 devresi |
|---|---|---|
| Vdc [V] | 431,5 (`Vdc1`) | 395,0 (`Vdc2`) |
| Şebeke Vac RMS [V] | 119,8 | 121,0 |
| K1x | `K11` = 0,7865 | `K12` = 0,794 |
| K3 (Sin³) | — | 0 (yalnız `S2 K3` bloğunda; `K33` değişmez) |
| Referans fazı [°] | −0,44 | `phase_deg2` = 0 |
| L1 / L2 / Cf | 600 µH / 1000 µH / 8 µF | aynı |
| L1 çekirdek Rp | 600 Ω | 600 Ω |
| EMC X kapasitörü | 1 µF / 0,01 Ω | aynı |
| fsw / ölü zaman | 10 kHz / 1 µs | aynı |
| DC bara | 2 × 470 µF | aynı |

## Nasıl çalıştırılır

Komutlar proje kökünden (`tez-matlab-simulink/`) verilir. Onarım betiği her seferinde paketin
değişmemiş kopyasından başlar; ham pakete yazmaz.

```powershell
# 1) PWM yolunun incelenmesi (inspection/pwm_yolu_*.txt)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "run('scripts/inspect_pwm_paths_20261027.m')"

# 2) D-01 onarımı + derleme + kapı mantığı testi (+ isteğe bağlı 5 ms duman koşusu)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); fix_s2_gate_path_20261027('smoke')"

# 3) Tam koşu (0,1 s) — aşağıdaki uyarıya bakın
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_umit_dort_senaryo_20261027('inverter_s1s2_s2onarim', '2026-10-27_s2_kapi_onarimi', 'accelerator')"
```

Ön koşullar:

- Parametre dosyası `load_system`'dan önce taban çalışma alanında çalıştırılır (betikler yapar;
  onarılmış modelde PreLoadFcn de vardır).
- Duman koşusu Normal modda ~10 dk (603 s) sürdü.
- Aynı `model/` klasöründe eşzamanlı Accelerator derlemesi yapma.

## Çıktılar

| Dosya | İçerik |
|---|---|
| `inspection/pwm_yolu_<model>.txt` | S3 ve ham S1+S2 modelinde modülasyon/PWM yolu, Goto/From tablosu, kapı sürücüsü → IGBT eşlemesi |
| `inspection/fix_s2_denetim.txt` | Eklenen bloklar, etiket eşleşmesi, PreLoadFcn ve derleme denetimi, kapı mantığı özeti, duman koşusu özeti |
| `inspection/s2_kapi_mantik_testi.csv`, `.png` | 0–40 ms yalnız denetim yolu testi: alternans başına geçiş sayısı ve ortalama |
| `inspection/fix_smoke_konsol.log` | Onarım + duman koşusunun konsol çıktısı |
| `tam_kosu_konsol.log` | Tam koşu denemesinin konsol çıktısı |
| `results/inverter_s1s2_s2onarim/` | Boş (tam koşu tamamlanmadı) |

`.gitignore` gereği `*.mat`, `slprj/`, `*.slxc`, `*_acc.*` derleme artıkları ve `*.autosave`
depoya girmez; betik yeniden koşturularak üretilir. `model/` altındaki `.slx` ve `.m` dosyaları
depoda tutulur.

## Uyarı

- D-08'siz onarılmış modelin 0,1 s'lik tam koşusu 15 saatte bitmedi ve 28.10.2026'da durduruldu;
  `results/` boştur. D-01'in sayısal doğrulaması D-01 + D-08 modeliyle
  `2026-10-27_diyot_esleme` klasöründe yapılmıştır.
- Parametreler kalibre edilmemiş 12.10 değerleridir (DENEME). Kalibre S2 değerleri
  `2026-10-28_kalibrasyon` klasöründedir.
