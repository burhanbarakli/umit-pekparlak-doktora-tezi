# 2026-10-27 · Diyot eşlemesinin düzeltilmesi (D-08) ve etkisi

## Amaç

Harici D1–D2 diyotlarıyla nötr IGBT ters paralel diyotlarının (DS3–DS4) parametre kümeleri
modellerde yer değiştirmişti. Klasörde takas betikle giderildi; S3 ve onarılmış S1+S2 modeli
0,1 s koşturuldu, S3 için blok bazında kayıp ayrıştırması yapıldı. D-01'in (S2 kapı onarımı)
sayısal doğrulaması da klasördeki D-01 + D-08 koşusuna dayanır.

- İş paketi: İP-2b (İP-1 doğrulaması dahil)
- İlgili kayıtlar: D-08 (düzeltme), D-01, D-03, D-04, D-10; K-18
- Review notu: [2026-10-27_D08_DIYOT_ESLEME.md](../../review/2026-10-27_D08_DIYOT_ESLEME.md)
- Kayıt defterleri: [01_KARAR_DEFTERI.md](../../../tez-tamamlama/01_KARAR_DEFTERI.md),
  [02_MODEL_DUZELTME_KAYDI.md](../../../tez-tamamlama/02_MODEL_DUZELTME_KAYDI.md)

## Senaryolar ve modeller

`model/`:

| Model dosyası | Senaryo | Pakete göre değişiklik |
|---|---|---|
| `inverter_senaryo3.slx` | S3 | Yok (paketle bayt bayt aynı; takasın kaynağı) |
| `inverter_senaryo3_d08.slx` | S3 | D-08: `Diode3`/`Diode5` `DS34_` → `D12_`, `Diode6`/`Diode7` `D12_` → `DS34_`; PreLoadFcn (D-03) |
| `inverter_s1s2_s2onarim.slx` | S1 + S2 | D-01 (`2026-10-27_s2_kapi_onarimi/model/` ile bayt bayt aynı kopya) |
| `inverter_s1s2_s2onarim_d08.slx` | S1 + S2 | D-01 + D-08: iki devrede 8 diyot (A devresi `Diode3/5/6/7`, B devresi `Diode4/8/10/11`); PreLoadFcn (D-03) |
| `inverter_common_parameters.m` | Ortak parametre dosyası | Yok (paketle aynı) |

`kayip/model/`: kayıp ayrıştırma koşuları için `inverter_senaryo3.slx` ve
`inverter_senaryo3_d08.slx` kopyaları (ana koşunun Accelerator derlemesiyle çakışmasın diye ayrı klasör).

Bağlantıya dokunulmadı, blok eklenmedi ya da silinmedi. Takasta önekle başlayan 18 diyalog
parametresi yeniden yazıldı; sayı olarak yazılmış `CJ0`, `Tdevice` ve `thermal_mass` değişmedi (D-10).
`_d08` modelleri sonraki bütün koşuların (kalibrasyon, S4) tabanıdır.

## Parametreler

Devre ve modülasyon parametreleri paketle aynıdır (kalibrasyon yok, D-09 uygulanmamış).

| Büyüklük | S1 (A devresi) | S2 (B devresi) | S3 |
|---|---|---|---|
| Vdc [V] | 431,5 | 395,0 | 427,5 |
| Şebeke Vac RMS [V] | 119,8 | 121,0 | 124,3 |
| K1x | `K11` = 0,7865 | `K12` = 0,794 | `K13` = 0,45 |
| K3x | — | 0 (`S2 K3`) | `K33` = 0,39 |
| Referans fazı [°] | −0,44 | 0 | 0 |
| L1 / L2 / Cf / L1 çekirdek Rp | 600 µH / 1000 µH / 8 µF / 600 Ω | aynı | aynı |
| EMC X kapasitörü | 1 µF / 0,01 Ω (D-09 öncesi) | aynı | aynı |
| fsw / ölü zaman / DC bara | 10 kHz / 1 µs / 2 × 470 µF | aynı | aynı |

Takas edilen diyot değerleri (m-dosyasından):

| Rol | Önek (düzeltme sonrası) | Vf [V] | Ron [mΩ] | Qrr [µC] | trr [ns] | iRM [A] |
|---|---|---|---|---|---|---|
| D1–D2 harici (DSEI2x61-12B) | `D12_` | 1,58 | 8,5 | 3,0 | 190 | −13 |
| DS3–DS4 nötr ters paralel (IXYN iç FRD) | `DS34_` | 1,70 | 6 | 9,5 | 100 | −95 |

## Nasıl çalıştırılır

Komutlar proje kökünden (`tez-matlab-simulink/`) verilir. `model/` klasöründe
`inverter_senaryo3.slx`, `inverter_s1s2_s2onarim.slx` ve `inverter_common_parameters.m`
bulunmalıdır (paketten ve `2026-10-27_s2_kapi_onarimi/model/` klasöründen kopya).

```powershell
# 1) D-08 düzeltmesi (yeni model + inspection/<model>_diyot_esleme.{txt,csv})
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); fix_diode_mapping_20261027('runs/2026-10-27_diyot_esleme/model/inverter_senaryo3.slx', 'inverter_senaryo3_d08')"
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); fix_diode_mapping_20261027('runs/2026-10-27_diyot_esleme/model/inverter_s1s2_s2onarim.slx', 'inverter_s1s2_s2onarim_d08')"

# 2) 0,1 s koşular (results/<model>/)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_umit_dort_senaryo_20261027('inverter_senaryo3_d08', '2026-10-27_diyot_esleme', 'accelerator')"
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_umit_dort_senaryo_20261027('inverter_s1s2_s2onarim_d08', '2026-10-27_diyot_esleme', 'accelerator')"

# 3) Display eşlemesi ve karşılaştırma (ilk koşuya göre regresyon)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); extract_umit_display_values_20261027('2026-10-27_diyot_esleme')"
python -I scripts/compare_umit_dort_senaryo_20261027.py --run 2026-10-27_diyot_esleme --baseline 2026-10-27_dort_senaryo_ilk_kosu

# 4) S3 kayıp ayrıştırması, D-08 öncesi ve sonrası (kayip/results/<model>/)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_diode_losses_20261027('inverter_senaryo3', '2026-10-27_diyot_esleme', 'accelerator')"
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_diode_losses_20261027('inverter_senaryo3_d08', '2026-10-27_diyot_esleme', 'accelerator')"
```

Ön koşullar ve süreler:

- Parametre dosyası `load_system`'dan önce taban çalışma alanında çalıştırılır (betikler yapar;
  `_d08` modellerinde PreLoadFcn de vardır).
- Duvar süreleri (makinede 4–6 MATLAB süreci aynı anda koşarken): `inverter_senaryo3_d08`
  10 455 s, `inverter_s1s2_s2onarim_d08` 14 579 s (~4 saat; iki devre aynı çözücüyü paylaşır),
  kayıp ayrıştırma 10 263 s ve 1884 s. Yük azken S3 koşusu ~30 dk sürer.
- Kayıp ayrıştırma `kayip/model/` klasöründe derlenir; aynı klasörde eşzamanlı Accelerator
  derlemesi yapma.
- `compare_umit_dort_senaryo_20261027.py` baz koşunun `display_degerleri_eslesik.csv`
  dosyalarını okur; önce `2026-10-27_dort_senaryo_ilk_kosu` adımları tamamlanmış olmalıdır.

## Çıktılar

| Dosya | İçerik |
|---|---|
| `inspection/<model>_d08_diyot_esleme.txt`, `.csv` | Takas öncesi/sonrası her diyotun rolü, A/K düğümleri, öneki ve temel değerleri; temiz yeniden yükleme ve derleme denetimi |
| `results/<model>/display_degerleri*.csv`, `display_eslemesi.csv` | Display değerleri (ad ve blok yolu + port eşlemeli) |
| `results/<model>/kosu_bilgisi.txt`, `matlab_log.txt` | Koşu bilgisi ve konsol çıktısı |
| `karsilastirma.csv` | `_d08` modellerinin deney hedefleriyle karşılaştırması |
| `regresyon_2026-10-27_dort_senaryo_ilk_kosu.csv` | İlk koşuya göre fark (D-08 ve D-01 etkisi) |
| `kayip/results/<model>/kayip_ozeti.csv` | Son 20 ms blok bazında kayıp (`ee_getPowerLossSummary`) |
| `kayip/results/<model>/diyot_akimlari.csv` | Her diyotun ortalama, RMS ve en küçük akımı (0,08–0,10 s) |
| `kayip/results/<model>/kosu_bilgisi.txt`, `kayip/matlab_log_*.txt` | Kayıp koşusu bilgisi ve konsol çıktısı |

`.gitignore` gereği `results/<model>/logsout.mat`, `slprj/`, `*.slxc`, `*_acc.*` artıkları ve
`*.autosave` depoya girmez; ilgili betik yeniden koşturularak üretilir. `model/` ve
`kayip/model/` altındaki `.slx` ve `.m` dosyaları depoda tutulur.

## Uyarı

- Sayılar kalibrasyon öncesi model durumunu belgeler; tez bulgusu değildir.
- S1+S2 D-08 koşusunda çözücü ilk 51 ms'deki geçici rejimde altı kez en küçük adım sınırına
  takıldığını bildirdi; Display değerlerinin alındığı 0,08–0,10 s penceresinde uyarı yoktur.
- S1+S2 için kayıp ayrıştırması yapılmadı (yalnız S3).
