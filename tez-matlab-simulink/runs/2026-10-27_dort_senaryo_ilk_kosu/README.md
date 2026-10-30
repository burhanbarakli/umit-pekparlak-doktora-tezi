# 2026-10-27 · Dört senaryo paketinin değiştirilmemiş ilk koşusu

## Amaç

12.10.2026 dört senaryo paketindeki modeller devreye, parametreye ve çözücüye dokunulmadan
koşturuldu; Display değerleri deney özet tablosuyla karşılaştırıldı. Kalibrasyon yoktur.
Koşu, sonraki bütün düzeltmelerin (D-01, D-02, D-08, D-09) baz çizgisidir.

- İş paketi: İP-0
- İlgili kayıtlar: D-01 (S2 kapı sinyali yok), D-02 (S4 teslim edilmemiş), D-03 (parametre
  yükleme sırası), D-04 (çakışan kayıt adları), D-05 (kullanılmayan parametreler); K-01, K-02,
  K-04, K-05, K-15
- Review notu: [2026-10-27_DORT_SENARYO_ILK_KOSU.md](../../review/2026-10-27_DORT_SENARYO_ILK_KOSU.md)
- Kayıt defterleri: [01_KARAR_DEFTERI.md](../../../tez-tamamlama/01_KARAR_DEFTERI.md),
  [02_MODEL_DUZELTME_KAYDI.md](../../../tez-tamamlama/02_MODEL_DUZELTME_KAYDI.md)

## Senaryolar ve modeller (`model/`)

| Model dosyası | Senaryo | Pakete göre değişiklik |
|---|---|---|
| `inverter_scenario1_parametric5_etiquetli.slx` | S1 (tamamlayıcı anahtarlama) + S2 devresi | Yok (bayt bayt aynı). S2 devresinin kapı sürücüleri `g12…g42` etiketlerini okur, etiketleri üreten Goto bloğu yoktur; S2 IGBT'leri anahtarlanmaz (D-01) |
| `inverter_senaryo3.slx` | S3 (nötr susturma + Sin³ ileri besleme) | Yok (bayt bayt aynı) |
| `inverter_senaryo4.slx` | Paket adıyla S4; içerik S3'ün kopyası | Yok (bayt bayt aynı). Akım denetleyicisi yoktur (D-02) |
| `inverter_common_parameters.m` | Ortak parametre dosyası | Yok (SHA-256 `f066abfe…`, paketle aynı) |

Kaynak paket: `incoming_real_data/models/2026-10-12_dort_senaryo_paketi/`.

## Parametreler

Bütün değerler `model/inverter_common_parameters.m` dosyasından okunmuştur (12.10 paketi).

| Büyüklük | S1 | S2 | S3 | S4 (S3 kopyası) |
|---|---|---|---|---|
| Vdc [V] | 431,5 (`Vdc1`) | 395,0 (`Vdc2`) | 427,5 (`Vdc3`) | modelde `Vdc3` okunur |
| Şebeke Vac RMS [V] | 119,8 | 121,0 | 124,3 | modelde `Vac3_peak` okunur |
| K1x (temel genlik) | `K11` = 0,7865 | `K12` = 0,794 (modelde kullanılmıyor) | `K13` = 0,45 | `K13` okunur |
| K3x (Sin³ genliği) | — | — | `K33` = 0,39 | `K33` okunur |
| Referans fazı [°] | `phase_deg1` = −0,44 | `phase_deg2` = 0 (kullanılmıyor) | `phase_deg3` = 0 | `phase_deg3` okunur |

| Ortak büyüklük | Değer | Değişken |
|---|---|---|
| L1 / L1 seri direnci | 600 µH / 0,03 Ω | `L1`, `L1r` |
| L1 çekirdek kaybı (paralel) | 600 Ω | `L1_core_Rp` (`L1_core_Rp4` = 1500 Ω tanımlı, kullanılmıyor) |
| Cf / ESR | 8 µF / 0,01 Ω | `C`, `Cr` |
| L2 (şebeke + varyak) / direnç | 1000 µH / 0,01 Ω | `L2`, `L2r` |
| EMC X kapasitörü (modeldeki) | 1 µF / 0,01 Ω | `C_emc_aux`, `R_emc_aux` |
| Ortak kip bobini | 400 µH, k = 0,995 | `EMC_Lw`, `EMC_k` |
| DC bara | 2 × 470 µF, ESR 0,1 Ω | `Cdc_pos`, `Cdc_neg`, `Cdc_esr` |
| fsw / ölü zaman | 10 kHz / 1 µs | `fsw`, `deadtime` |
| Kp | 0,03 (tanımlı, hiçbir blokta kullanılmıyor) | `Kp` |
| Çözücü | ode15s, MaxStep 1 µs, StopTime 0,1 s | `sim_max_step` |

Diyot parametre eşlemesi pakette takaslıdır (D-08); düzeltme `2026-10-27_diyot_esleme` klasöründedir.

## Nasıl çalıştırılır

Komutlar proje kökünden (`tez-matlab-simulink/`) PowerShell ile verilir. Koşu betiği
parametre dosyasını `load_system`'dan önce taban çalışma alanında çalıştırır (D-03).

```powershell
# 1) Model yapısının incelenmesi (inspection/*.txt)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "run('scripts/inspect_umit_dort_senaryo_20261027.m')"

# 2) Koşular (results/<model>/)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_umit_dort_senaryo_20261027('inverter_senaryo3', '2026-10-27_dort_senaryo_ilk_kosu', 'accelerator')"
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_umit_dort_senaryo_20261027('inverter_senaryo4', '2026-10-27_dort_senaryo_ilk_kosu', 'accelerator')"
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_umit_dort_senaryo_20261027('inverter_scenario1_parametric5_etiquetli', '2026-10-27_dort_senaryo_ilk_kosu', 'normal')"

# 3) Display değerlerinin blok yolu + port ile eşlenmesi (D-04)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); extract_umit_display_values_20261027('2026-10-27_dort_senaryo_ilk_kosu')"

# 4) Deney hedefleriyle karşılaştırma (karsilastirma.csv)
python -I scripts/compare_umit_dort_senaryo_20261027.py --run 2026-10-27_dort_senaryo_ilk_kosu
```

Ön koşullar ve süreler:

- Ham S1+S2 modeli çalışma makinesindeki LCC derleyicisiyle Accelerator modunda bağlanamaz
  (`rt_InitInfAndNaN` tanımsız); Normal modda koşar, ~1,9 saat (6906 s).
- S3 ve S4 Accelerator modunda ~27 dk (1624 s / 1615 s).
- Aynı `model/` klasöründe iki Accelerator derlemesini eşzamanlı başlatma; MEX oluşturma hatası verir.

## Çıktılar

| Dosya | İçerik |
|---|---|
| `inspection/<model>.txt` | Üst düzey bloklar, ölçüm/kayıt blokları, senaryo değişkenlerinin kullanıldığı bloklar |
| `results/<model>/display_degerleri.csv` | Kayıtlı sinyallerin son değeri ve son 20 ms ortalaması (ada göre) |
| `results/<model>/display_eslemesi.csv` | Display bloğu → kayıt adı eşlemesi |
| `results/<model>/display_degerleri_eslesik.csv` | Display değerleri, kaynak blok yolu + port ile eşlenmiş (karşılaştırmanın girdisi) |
| `results/<model>/kosu_bilgisi.txt` | MATLAB sürümü, başlangıç, mod, duvar süresi, durum |
| `karsilastirma.csv` | Senaryo başına hedef / benzetim / fark (Vdc, Idc, P_dc, I_ac, P_ac, Q, cosφ, THD, verim) |

`.gitignore` gereği `results/<model>/logsout.mat`, `slprj/`, `*.slxc`, `*_acc.*` derleme
artıkları ve `*.autosave` depoya girmez; koşu betiği yeniden çalıştırılarak üretilir.
`model/` altındaki `.slx` ve `.m` kopyaları depoda tutulur.

## Uyarı

- Modeller ham paketle bayt bayt aynıdır; parametreler kalibre edilmemiş 12.10 değerleridir.
  Sayılar tez bulgusu değildir, yalnız modelin düzeltme öncesi durumunu belgeler.
- S2 sütunu anahtarlanmayan devreye aittir (D-01); S4 sonuçları S3 ile bayt bayt aynıdır (D-02).
