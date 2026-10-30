# 2026-10-28 · S4 kapalı çevrim modeli ve 2,3 / 10 / 25 A taraması

## Amaç

Teslim edilen `inverter_senaryo4.slx` S3'ün kopyasıydı (D-02). S4 (S3 + L1 akım geri beslemesi)
S3 tabanından betikle kuruldu; P, PI ve PIR denetleyicileriyle 2,3 / 10 / 25 A RMS akım
referanslarında ve 10 → 25 A basamağında koşturuldu. Kesin tarama (`KC_*`) kalibre S3 ileri
beslemesini ve büyütülmüş DC barayı kullanır.

- İş paketi: İP-5 (jüri maddesi 8)
- İlgili kayıtlar: D-02 (S4 kuruldu), D-11 (DC bara 2 × 5,6 mF), D-03, D-05, D-09, D-13;
  K-05, K-07, K-14, K-19 (denetimin analog eşdeğeri), K-20, K-21
- Review notu: [2026-10-28_S4_KAPALI_CEVRIM.md](../../review/2026-10-28_S4_KAPALI_CEVRIM.md)
- Kayıt defterleri: [01_KARAR_DEFTERI.md](../../../tez-tamamlama/01_KARAR_DEFTERI.md),
  [02_MODEL_DUZELTME_KAYDI.md](../../../tez-tamamlama/02_MODEL_DUZELTME_KAYDI.md)

## Senaryolar ve modeller

| Klasör / model | Senaryo | Değişiklik |
|---|---|---|
| `model/inverter_senaryo3_d08.slx` | S3 tabanı | `2026-10-27_diyot_esleme/model/` kopyası (D-03 + D-08) |
| `model/inverter_senaryo4_kc.slx` | S4 = S3 + L1 akım denetimi | D-02: S3 değişkenleri S4 karşılıklarıyla değiştirildi (`Vdc4`, `Vac4_peak`, `K14`, `K34`, `phase_deg4`, `L1_core_Rp4`); D-09; 27 üst düzey blok eklendi (L1 akım ölçümü, 5 kHz süzgeç, `i_ref`, `S4 Akim Denetleyicisi`, doyum, anti-windup, kayıt); PreLoadFcn iki parametre dosyasını yükler (D-03) |
| `model_a/`, `model_b/`, `model_c/` | S4 | `model/` ile bayt bayt aynı kopyalar; paralel koşular için ayrı derleme klasörleri |
| `*/inverter_common_parameters.m` | Ortak parametre dosyası | Yok (paketle aynı) |
| `*/s4_denetleyici_parametreleri.m` | S4 denetim ve ölçüm değişkenleri | `scripts/s4_denetleyici_parametreleri_20261028.m` kopyası |

Sin³ terimi (K34·sin³θ) modülasyon toplamına geri besleme yolunun dışından eklenir; denetleyici
çıkışı u_fb ayrı bir toplama bloğunda eklenir (K-07).

## Parametreler

| Büyüklük | Özgün tarama (`P_*`, `PI_*`) | Kesin tarama (`KC_*`) | Kaynak |
|---|---|---|---|
| Vdc [V] | 427,5 (`Vdc4`) | aynı | m-dosyası |
| Şebeke Vac RMS [V] | 120,0 (`Vac4_rms`) | aynı | m-dosyası |
| K14 (temel genlik) | 0,45 | 0,44343 | m-dosyası / K-20 |
| K34 (Sin³ genliği) | 0,39 | 0,384306 | m-dosyası / K-20 |
| `phase_deg4` [°] | 0 | 0,6575 | m-dosyası / K-20 |
| DC bara (`Cdc_pos` = `Cdc_neg`) | 470 µF | 5,6 mF | m-dosyası / D-11 |
| L1 çekirdek Rp | 1500 Ω (`L1_core_Rp4`) | aynı | K-14 |
| L1 / L1r | 600 µH / 0,03 Ω | aynı | m-dosyası |
| Cf / Cr | 8 µF / 0,01 Ω | aynı | m-dosyası |
| L2 / L2r | 1000 µH / 0,01 Ω | aynı | m-dosyası |
| EMC X kapasitörü | 0,5 µF / 0,2 Ω | aynı | D-09 |
| fsw / ölü zaman | 10 kHz / 1 µs | aynı | m-dosyası |

Denetleyici (`s4_denetleyici_parametreleri.m` + koşu betiği; K-19):

| Büyüklük | P | PI | PIR |
|---|---|---|---|
| Kp [1/A] | 0,03 | 0,03 | 0,03 |
| Ki [1/(A·s)] | 0 | 11,31 (= Kp·2π·60) | 11,31 |
| Anti-windup Kaw [1/s] | 0 | 377 | 377 |
| Rezonans Kr [1/A] / ω_b [rad/s] | 0 / — | 0 / — | 0,3 / 12,57 (2π·2) |
| Denetim adımı / ölçüm süzgeci | 1 µs / 5 kHz tek kutup | aynı | aynı |
| Doyum / integratör sınırı | \|u\| ≤ 1 / ±1 | aynı | aynı |

| Koşu ayarı | Değer |
|---|---|
| Akım referansı (RMS) | 2,3 / 10 / 25 A; basamak 10 → 25 A, t = 55 ms |
| StopTime | 0,06 s (PIR kesin değerleri 0,2 s; basamak 0,09 s) |
| Çözücü | ode15s, MaxStep 1 µs, Accelerator |

`KC_*` değerleri bellekteki modelin InitFcn'inin sonuna eklenir (model kaydedilmez); etkin
değerler her `results/KC_*/kosu_bilgisi.txt` dosyasının "etkin" satırlarındadır.

## Nasıl çalıştırılır

Komutlar proje kökünden (`tez-matlab-simulink/`) verilir.

```powershell
# 1) Ortalama model üzerinde denetleyici ön tasarımı (tasarim/; Simulink koşturmaz, ~10 s)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "run('scripts/design_s4_controller_20261028.m')"

# 2) S4 modelinin kurulması (model/inverter_senaryo4_kc.slx, inspection/build_s4_denetim.txt)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); build_s4_closed_loop_20261028"

# 3) Tek koşu örnekleri: özgün tarama ve kesin tarama (KC_)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_s4_closed_loop_20261028('PI_25A', 'PI', 25, 0.06)"
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_s4_closed_loop_20261028('KC_PI_25A', 'PI', 25, 0.06, struct('Cdc', 5.6e-3, 'ust', struct('K14', 0.44343, 'K34', 0.384306, 'phase_deg4', 0.6575), 'model_kopya', 'model_a'))"
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_s4_closed_loop_20261028('KC_PI_basamak_10_25A', 'PI', [10 25], 0.09, struct('t_step', 0.055, 'simscape', false, 'Cdc', 5.6e-3, 'ust', struct('K14', 0.44343, 'K34', 0.384306, 'phase_deg4', 0.6575), 'model_kopya', 'model_b'))"

# 4) Özet tablo ve şekiller ('' = özgün tarama, 'KC_' = kesin tarama)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "s4_onek = 'KC_'; run('scripts/summarize_s4_20261028.m')"
```

Bütün tarama Git Bash kuyruğuyla da koşturulur (süre sınırı saniye cinsinden; paralel kuyruklar
`MK` ile ayrı model klasörü kullanır). Koşuların kuyruklara dağılımı serbesttir; aşağıdaki bölüşüm örnektir:

```bash
MK=model_a bash scripts/queue_s4_20261028.sh 3600 KC_P_2p3A KC_PI_2p3A KC_P_10A KC_PI_10A
MK=model_b bash scripts/queue_s4_20261028.sh 3600 KC_P_25A KC_PI_25A KC_PI_basamak_10_25A KC_PIR_10A_02s KC_PIR_25A_02s
```

Kuyruktaki koşu adları ve tam argümanları `scripts/queue_s4_20261028.sh` içindedir.

Ön koşullar ve süreler:

- `build_s4_closed_loop_20261028` tabanı `2026-10-27_diyot_esleme/model/inverter_senaryo3_d08.slx`
  dosyasından okur.
- Koşu betiği iki parametre dosyasını `load_system`'dan önce taban çalışma alanında çalıştırır (D-03).
  Cdc ve K-20 değerleri yalnız taban çalışma alanına yazılırsa InitFcn bunları ezer; betik
  değerleri InitFcn'e ekler.
- Duvar süreleri (`kosu_bilgisi.txt`, Accelerator): 0,06 s'lik koşular 12–30 dk
  (ör. `KC_PI_25A` 1103 s), basamak koşuları 23–49 dk, 0,2 s'lik PIR koşuları 51–65 dk.
- Aynı model klasöründe eşzamanlı Accelerator derlemesi yapma; paralel koşularda
  `model_kopya` ile `model_a|b|c` kullan.

## Çıktılar

| Dosya | İçerik |
|---|---|
| `s4_tarama_KC.csv` | Kesin tarama özeti (D-11 + K-20): izleme genlik/faz hatası, THD, P_ac, η, cosφ₁, doyum, kayıplar, basamak ölçütleri |
| `s4_tarama.csv` | Özgün DC bara ve m-dosyası ileri beslemesiyle tarama (D-11 sınırlılık kanıtı) |
| `results/<koşu>/metrik.csv` | Koşu metrikleri (son tam şebeke periyodu) |
| `results/<koşu>/cihaz_akimlari.csv`, `kayip_ozeti.csv` | IGBT/diyot akım tepeleri ve Simscape kayıp ayrıştırması |
| `results/<koşu>/kosu_bilgisi.txt` | Kip, kazançlar, I_ref, StopTime, model klasörü, InitFcn eki, etkin değerler, süre |
| `results/_gecersiz_Cb_InitFcn_ezdi/` | Geçersiz `Cb_*` koşuları (Cdc InitFcn tarafından 470 µF'a geri yazıldı); açıklama `OKU.txt` |
| `results/duman_P_25A_20ms/` | 20 ms'lik duman testi; sonuç olarak kullanılmaz |
| `sekiller/s4_*_KC.png`, `.fig` | Kesin tarama şekilleri: 25 A akım izleme, 10 → 25 A basamak, tarama özeti (300 dpi); `_KC` eksizleri özgün tarama |
| `tasarim/` | Ortalama model tasarım marjları (`s4_tasarim_marjlari.csv`, `s4_tasarim_allmargin.csv`), Bode (`.png`, `.fig`), `s4_tasarim_ozet.txt` |
| `inspection/build_s4_denetim.txt` | Değişken eşlemesi, D-09, eklenen bloklar, temiz oturumda derleme denetimi |
| `loglar/` | Koşu konsol çıktıları ve `kuyruk.txt` |

`.gitignore` gereği `results/<koşu>/dalga.mat`, `slprj/`, `*.slxc`, `*_acc.*` artıkları ve
`*.autosave` depoya girmez; koşu betiği yeniden çalıştırılarak üretilir. Model klasörlerindeki
`.slx` ve `.m` dosyaları depoda tutulur.

## Uyarı

- S4 için deney yoktur; sayılar kalibre S3 modelinin kapalı çevrimle anma akımına taşınmasını
  gösteren model içi karşılaştırmadır.
- S4 L1 çekirdek kaybı için 1500 Ω kullanır, S1–S3 600 Ω kullanır (K-14); S4 verimi yalnız S4
  koşuları arasında karşılaştırılır.
- `tasarim/s4_tasarim_marjlari.csv` içindeki "GM −30,7 dB @ 2808 Hz" değeri 0° sarma hatasından
  gelir ve geçersizdir (K-21); geçerli marjlar `2026-10-28_kararlilik/frekans/kararlilik_marjlar.csv` dosyasındadır.
- 0,06 s'lik `KC_PIR_10A` ve `KC_PIR_25A` koşuları oturmamıştır; PIR değerleri `_02s` koşularından alınır.
- DC bara 5,6 mF bir boyutlandırma varsayımıdır; denetim analog eşdeğeridir (K-19).
