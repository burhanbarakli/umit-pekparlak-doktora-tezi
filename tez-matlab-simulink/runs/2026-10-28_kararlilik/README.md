# 2026-10-28 · S4 akım denetiminin kararlılık analizi ve Sin³ ileri beslemesi

## Amaç

Jüri maddesi 7'nin istediği kapalı çevrim ve Bode analizi K-07'nin üç katmanıyla yapıldı:
(1) analitik olarak Sin³ teriminin 1 + L(s) = 0 denkleminin dışında kaldığı; (2) ortalama
modelde P / PI / PIR için L, S, T Bode eğrileri, marjlar ve kutuplar, K34 = 0,384306 ve K34 = 0
için ayrı ayrı; Simulink Control Design doğrusallaştırmasıyla bağımsız denetim; (3) anahtarlamalı
S4 modelinde çok tonlu enjeksiyonla L(jω) ölçümü ve 10 → 25 A basamağı.

- İş paketi: İP-6 (jüri maddesi 7)
- İlgili kayıtlar: D-02, D-11, D-13 (CloseFcn `C`/`L` siliyor); K-07, K-14, K-19, K-20, K-21
- Review notu: [2026-10-28_KARARLILIK_BODE.md](../../review/2026-10-28_KARARLILIK_BODE.md)
- Kayıt defterleri: [01_KARAR_DEFTERI.md](../../../tez-tamamlama/01_KARAR_DEFTERI.md),
  [02_MODEL_DUZELTME_KAYDI.md](../../../tez-tamamlama/02_MODEL_DUZELTME_KAYDI.md)

## Senaryolar ve modeller

| Klasör / model | Senaryo | Değişiklik |
|---|---|---|
| `model_a/`, `model_b/`, `model_c/` · `inverter_senaryo4_enj.slx` | S4 (S3 + L1 akım denetimi), ölçüm kopyası | `2026-10-28_s4_kapali_cevrim/model/inverter_senaryo4_kc.slx` + üç blok: `S6 Enjeksiyon Tonlari`, `S6 Ton Toplami`, `S6 Enjeksiyon Toplami` (u_x = u_fb + d). d = 0 iken S4 modeliyle matematiksel olarak aynıdır; model düzeltmesi değildir (D-xx yok). Üç kopya bayt bayt aynıdır |
| `model_*/inverter_common_parameters.m`, `s4_denetleyici_parametreleri.m` | Parametre dosyaları | S4 klasöründeki dosyalarla aynı |
| `model_ort/s4_ortalama_kararlilik.slx` | S4 ortalama (anahtarlamasız) eşdeğeri | Betikle kurulur: `S4 Akim Denetleyicisi` S4 modelinden kopya; köprü K_pwm = Vdc4/2 kazançlı denetimli gerilim kaynağı; güç ağı Simscape Foundation elemanlarıyla aynı sırada |

Anahtarlamalı koşularda `model_a` ve `model_b` kullanıldı; `model_c` kurulmuş ancak koşuda kullanılmamıştır.

## Parametreler

Bütün anahtarlamalı koşular `KC_*` ayarlarıyladır (K-20 + D-11); değerler bellekteki modelin
InitFcn'ine eklenir, etkin değerler `results/<koşu>/kosu_bilgisi.txt` dosyasındadır.

| Büyüklük | Değer | Kaynak |
|---|---|---|
| Vdc4 / K_pwm | 427,5 V / 213,75 V (Vdc4/2) | m-dosyası |
| Şebeke Vac RMS | 120,0 V | m-dosyası (`Vac4_rms`) |
| K14 / φ4 | 0,44343 / 0,6575° | K-20 |
| K34 | 0,384306 (`*_K34_*`) ya da 0 (`*_K340_*`) | K-20 / karşılaştırma |
| DC bara (`Cdc_pos` = `Cdc_neg`) | 5,6 mF (ortalama modelde sabit Vdc4/2) | D-11 |
| L1 / L1r | 600 µH / 0,03 Ω | m-dosyası |
| L1 çekirdek Rp | 1500 Ω (`L1_core_Rp4`) | K-14 |
| Cf / Cr | 8 µF / 0,01 Ω | m-dosyası |
| EMC X kapasitörü | 0,5 µF / 0,2 Ω | D-09 |
| CMC diferansiyel endüktansı | 4 µH kademe başına | m-dosyası (`EMC_Ldm_stage`) |
| L2 / L2r | 1000 µH / 0,01 Ω | m-dosyası |
| fsw / ölü zaman | 10 kHz / 1 µs | m-dosyası |
| Kp / Ki / Kaw | 0,03 1/A / 11,31 1/(A·s) / 377 1/s | K-19 |
| PIR Kr / ω_b | 0,3 1/A / 12,57 rad/s | K-19 |
| Ölçüm süzgeci / denetim adımı / Td (A) | 5 kHz / 1 µs / 2 µs | K-19 |
| Sayısal gerçekleme (B) / (B2) | Ts = 100 µs / 50 µs, 1 Ts hesaplama gecikmesi | karşılaştırma |
| Enjeksiyon tonları | küme A 212,5 / 525 / 1037,5 Hz; küme B 587,5 / 2025 / 3362,5 Hz; genlik 0,015 | koşu ayarı |
| Koşu süresi / analiz penceresi | 0,11 s / 0,03–0,11 s (basamak 0,09 s, t = 55 ms) | koşu ayarı |

## Nasıl çalıştırılır

Komutlar proje kökünden (`tez-matlab-simulink/`) verilir. Ön koşul: `2026-10-28_s4_kapali_cevrim/model/`
altında S4 modeli ve iki parametre dosyası bulunmalıdır.

```powershell
# 1) Katman 1–2: analitik ve frekans alanı (frekans/; Simulink koşturmaz, ~1 dk)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); analiz_kararlilik_20261028"

# 2) Ortalama Simulink/Simscape modeli: kur + SCD doğrusallaştırma + zaman alanı (model_ort/, ortalama/)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); ortalama_model_kararlilik_20261028('hepsi')"

# 3) Anahtarlamalı ölçüm kopyaları (model_a|b|c/, inspection/build_enjeksiyon_denetim.txt)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); build_enjeksiyon_kararlilik_20261028({'model_a','model_b','model_c'})"

# 4) Tek enjeksiyon koşusu örneği (results/PI25_K34_A/)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); run_enjeksiyon_kararlilik_20261028('PI25_K34_A', 'PI', 25, 0.11, struct('model_kopya', 'model_a', 'pencere', [0.03 0.11], 'tonlar', [212.5 525 1037.5]))"

# 5) Ortalama ↔ anahtarlamalı karşılaştırma (karsilastirma/)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); karsilastir_kararlilik_20261028"

# 6) Anahtarlamalı modelin doğrudan linearize denemesi (gerekçe kaydı)
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "addpath('scripts'); linearize_anahtarlamali_kararlilik_20261028"
```

Sekiz anahtarlamalı koşu Git Bash kuyruğuyla iki paralel kuyrukta koşturuldu (`loglar/kuyruk.txt`):

```bash
MK=model_a bash scripts/queue_kararlilik_20261028.sh 3600 PI25_K34_A PI25_K340_A PI10_K34_A PI_basamak_10_25A_K340
MK=model_b bash scripts/queue_kararlilik_20261028.sh 3600 PI25_K34_B PI25_K340_B PI2p3_K34_A PI10_K34_B
```

Ön koşullar ve süreler:

- Betikler parametre dosyalarını `load_system`'dan önce taban çalışma alanında çalıştırır (D-03)
  ve model kapandıktan sonra yeniden yükler (D-13).
- Anahtarlamalı koşu Accelerator modunda 25–31 dk; iki kuyrukla toplam ~2 saat. Ortalama model
  koşuları 1–6 s.
- 10 → 25 A basamağının K34 = 0,384306 karşılığı S4 klasöründeki `KC_PI_basamak_10_25A`
  koşusudur; karşılaştırma betiği o klasörü de okur.
- Aynı model klasöründe eşzamanlı Accelerator derlemesi yapma.

## Çıktılar

| Dosya | İçerik |
|---|---|
| `frekans/kararlilik_marjlar.csv`, `kararlilik_gecisler.csv` | Gerçekleme (A, Ad, B, B2) × denetleyici başına kazanç geçişleri, PM, GM, gecikme marjı, ‖S‖∞, Nyquist ve kutup ölçütü |
| `frekans/kararlilik_kutuplar.csv` | Kapalı çevrim kutupları |
| `frekans/k34_degismezlik.csv` | K34 = 0,384306 ve K34 = 0 için L, S, T farkı |
| `frekans/bode_L_S_T_A.csv` | (A) gerçeklemesinin L, S, T frekans yanıtı |
| `frekans/sin3_bozucu_etkisi.csv` | Sin³ ileri beslemesinin temel ve 150 Hz akım bileşenine etkisi (S(jω) ile) |
| `frekans/lg_taramasi.csv`, `kazanc_taramasi.csv`, `gecikme_taramasi.csv` | L_g, etkin köprü kazancı ve gecikme taramaları |
| `frekans/kararlilik_*.pdf`, `.png` | L Bode (K34 açık/sıfır), \|S\| ve \|T\|, Nyquist (A/B), kutup haritası, L_g taraması (vektör PDF + 300 dpi PNG) |
| `frekans/analiz_gunlugu.txt` | Analiz betiğinin günlüğü |
| `ortalama/scd_dogrusallastirma.csv` | Simulink Control Design doğrusallaştırması ile analitik (Ad) karşılaştırması |
| `ortalama/anahtarlamali_linearize.txt` | Anahtarlamalı modelin doğrudan `linearize` denemesinin çıktısı |
| `results/<koşu>/tonlar.csv`, `arka_plan.csv`, `metrik.csv`, `kosu_bilgisi.txt` | Ton frekanslarında L, S, T, P, C tahmini; arka plan düzeyi; koşu metrikleri ve etkin değerler |
| `results/duman_PI25/` | 4 ms'lik duman testi; sonuç olarak kullanılmaz |
| `karsilastirma/ton_karsilastirma.csv` | Analitik ↔ ortalama ↔ anahtarlamalı L(jω) |
| `karsilastirma/harmonik_80ms.csv`, `k34_harmonik_farki.csv` | Temel ve 3. harmonik, K34 farkı |
| `karsilastirma/basamak_*.csv`, `kararlilik_basamak_K34.*`, `kararlilik_L_olcum_karsilastirma.*` | Basamak karşılaştırması ve ölçüm noktalı L şekli |
| `inspection/build_enjeksiyon_denetim.txt` | Ölçüm kopyasının kurulum denetimi |
| `loglar/` | Koşu konsol çıktıları ve `kuyruk.txt` |

`.gitignore` gereği `results/<koşu>/olcum.mat`, `ortalama/*.mat`, `frekans/frekans_verisi.mat`,
`slprj/`, `*.slxc` ve `*_acc.*` artıkları depoya girmez; ilgili betik yeniden koşturularak
üretilir. Model klasörlerindeki `.slx` ve `.m` dosyaları depoda tutulur.

## Uyarı

- S4 için donanım deneyi yoktur; sonuçlar benzetim modelinin kendi içindeki kararlılık kanıtıdır.
- Sayısal gerçekleme (B, Ts = 100 µs) ve çift güncelleme (B2, Ts = 50 µs) kararsız çıkar; tezde
  S4 analog eşdeğeri olarak sunulur (K-19, K-21).
- 2,3 A'da küme B (2–3,4 kHz) ölçülmedi; P ve PIR anahtarlamalı modelde ayrıca ölçülmedi.
