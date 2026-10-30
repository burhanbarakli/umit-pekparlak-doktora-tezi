# 2026-10-27 · Reaktif güç ve cosφ işaretinin dalga biçiminden belirlenmesi

## Amaç

Benzetimde Q her senaryoda pozitif, deney tablosunda sıfır ya da negatif görünüyordu (D-06).
Klasörde S3 modelinin ham dalga biçimleri (v_ac, i_ac, v_inv, i_L1) kaydedildi; fazör ve
LCL + EMC ağ hesabıyla modelin Power bloğunun işaret kuralı (C noktası, üretici kuralı)
belirlendi ve EMC X kapasitörü düzeltmesinin (D-09) Q'ya etkisi hesaplandı.

- İş paketi: İP-3
- İlgili kayıtlar: D-06 (Q işareti), D-09; K-02, K-02a, K-17
- Review notu: [2026-10-27_Q_ISARET_ANALIZI.md](../../review/2026-10-27_Q_ISARET_ANALIZI.md)
- Kayıt defterleri: [01_KARAR_DEFTERI.md](../../../tez-tamamlama/01_KARAR_DEFTERI.md),
  [02_MODEL_DUZELTME_KAYDI.md](../../../tez-tamamlama/02_MODEL_DUZELTME_KAYDI.md)

## Senaryolar ve modeller

| Klasör / model | Senaryo | Pakete göre değişiklik |
|---|---|---|
| `model_inverter_senaryo3/inverter_senaryo3.slx` | S3 | Yok (bayt bayt aynı). Kayıt yalnız bellekte açıldı, model kaydedilmedi |
| `model_inverter_scenario1_parametric5_etiquetli/inverter_scenario1_parametric5_etiquetli.slx` | S1 + S2 devresi | Yok (bayt bayt aynı). Accelerator derlemesi LCC bağlama hatası verdi; S1 dalga koşusu yapılmadı |
| `model_*/inverter_common_parameters.m` | Ortak parametre dosyası | Yok (paketle aynı) |

Her model ayrı alt klasörde derlenir; Accelerator derlemeleri çakışmaz. S1 için analiz, ilk koşunun
Display kayıtları ve ağ hesabıyla yapıldı (`2026-10-27_dort_senaryo_ilk_kosu`).

## Parametreler

Devre, modülasyon ve çözücü parametreleri paketle aynıdır (D-08 ve D-09 uygulanmamış, kalibrasyon yok).

| Büyüklük | S1 (ağ hesabı) | S3 (dalga koşusu) |
|---|---|---|
| Vdc [V] | 431,5 | 427,5 |
| Şebeke Vac RMS [V] | 119,8 | 124,3 |
| K1x / K3x | 0,7865 / — | 0,45 / 0,39 |
| Referans fazı [°] | −0,44 | 0 |
| L1 / L1r | 600 µH / 0,03 Ω | aynı |
| L1 çekirdek Rp | 600 Ω | aynı |
| Cf / Cr | 8 µF / 0,01 Ω | aynı |
| L2 / L2r | 1000 µH / 0,01 Ω | aynı |
| EMC X kapasitörü | 1 µF / 0,01 Ω (D-09 karşılaştırmasında 0,5 µF / 0,2 Ω) | aynı |
| Ortak kip bobini (diferansiyel) | 2 × (400 − 398) µH = 4 µH kademe başına | aynı |
| fsw / ölü zaman | 10 kHz / 1 µs | aynı |
| Çözücü | ode15s, MaxStep 1 µs, StopTime 0,1 s | aynı |
| Analiz penceresi | 0,06–0,10 s (iki şebeke periyodu) | aynı |

## Nasıl çalıştırılır

Komutlar proje kökünden (`tez-matlab-simulink/`) verilir. Kayıt betiği paket modelini ve
parametre dosyasını kendi alt klasörüne kopyalar, parametre dosyasını `load_system`'dan önce
çalıştırır (D-03).

```powershell
# 1) S3 ham dalga kaydı (results/inverter_senaryo3/dalga_0p05_0p1.mat; 0,05–0,1 s)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_q_isaret_dalga_20261027('inverter_senaryo3')"

# 2) Fazör, ağ hesabı, duyarlılık ve D-09 analizi (q_isaret_*.csv, q_isaret_S3.png)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "run('scripts/analyze_q_sign_20261027.m')"
```

Ön koşullar ve süreler:

- Analiz betiği ayrıca `2026-10-27_dort_senaryo_ilk_kosu/results/<model>/logsout.mat`
  dosyalarını okur; önce ilk koşu yeniden üretilmiş olmalıdır.
- S3 dalga koşusu Accelerator modunda 9415 s (~2,6 saat) sürdü; dört ham sinyalin her çözücü
  adımında kaydı ve aynı anda koşan diğer süreçler süreyi uzattı.
- S1+S2 modeli için `run_q_isaret_dalga_20261027('inverter_scenario1_parametric5_etiquetli', 'normal')`
  çağrısı gerekir (Accelerator LCC ile bağlanamaz); koşu yapılmadı.

## Çıktılar

| Dosya | İçerik |
|---|---|
| `q_isaret_ozet.csv` | Display tabanlı P₁, Q₁, cosφ₁, PF, THD ve deney değerleri (S1, S3) |
| `q_isaret_noktalar.csv` | Ölçüm noktalarına (A evirici çıkışı, B, B+, C, G şebeke) göre fazör ve güç |
| `q_isaret_dogrulama.csv` | Dalga fazörü ↔ ağ hesabı ↔ Power3 bloğu karşılaştırması (S3) |
| `q_isaret_duyarlilik.csv` | Evirici geriliminin genlik/faz ve şebeke gerilimi duyarlılığı |
| `q_isaret_d09.csv` | X kapasitörü 1 µF → 0,5 µF değişiminin P ve Q'ya etkisi (hesap) |
| `q_isaret_S3.png` | v_ac, i_ac, i_L1 dalga biçimleri (0,06–0,10 s) |
| `analiz_log.txt` | Analiz betiğinin konsol çıktısı |
| `results/<model>/kosu_bilgisi.txt`, `matlab_log.txt` | Koşu bilgisi (S1 klasöründe Accelerator hata kaydı) |

`.gitignore` gereği `results/inverter_senaryo3/dalga_0p05_0p1.mat` (257 MB), `slprj/`, `*.slxc`,
`*_acc.*` artıkları ve `*.autosave` depoya girmez; kayıt betiği yeniden koşturularak üretilir.
`model_*/` altındaki `.slx` ve `.m` dosyaları depoda tutulur.

## Uyarı

- Model kalibre edilmemiş 12.10 paketidir (DENEME parametreleri); klasör yalnız ölçüm zincirini
  ve işaret kuralını belgeler, sayılar tez bulgusu değildir.
- Kayıt sonucu değiştirmedi: Power3 P₁/Q₁ değerleri ilk koşuyla aynıdır.
