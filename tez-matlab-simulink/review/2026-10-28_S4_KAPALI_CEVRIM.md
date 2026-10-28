# S4 kapalı çevrim taraması: 2,3 / 10 / 25 A (İP-5)

Tarih: 28.10.2026 · MATLAB R2023b Update 7 · bu makine · İP-5 · D-02, D-11, K-05, K-19, K-20

## Amaç ve kapsam

Jüri maddesi 8 nominal güçte kapalı çevrim istiyor. S4 = S3 + L1 akım geri beslemesi
(K-03). Teslim edilen `inverter_senaryo4.slx` S3'ün kopyasıydı (D-02); S4 bu yüzden S3
tabanından betikle kuruldu. Bu not taramanın sonucunu belgeler.

Sayılar **tez bulgusu değildir**. İ5 diliyle: S4 için deney yok. Bu tablo, kalibre S3
modelinin (İP-4) kapalı çevrimle anma akımına nasıl taşındığını gösterir.

- Betikler:
  - `scripts/s4_denetleyici_parametreleri_20261028.m` (denetim/ölçüm değişkenleri)
  - `scripts/design_s4_controller_20261028.m` (ortalama model, marjlar)
  - `scripts/build_s4_closed_loop_20261028.m` (S3 `*_d08` + D-09 → S4)
  - `scripts/run_s4_closed_loop_20261028.m` (koşu + metrik)
  - `scripts/queue_s4_20261028.sh` (sıralı/paralel kuyruk, süre sınırı)
  - `scripts/summarize_s4_20261028.m` (özet tablo + şekiller; `s4_onek = 'KC_'`)
- Koşu klasörü: `runs/2026-10-28_s4_kapali_cevrim/`
  - `model/`, `model_a|b|c/`: S4 modeli ve paralel kopyaları (git dışı)
  - `tasarim/`: tasarım marjları ve Bode
  - `results/<koşu>/`: `metrik.csv`, `cihaz_akimlari.csv`, `kayip_ozeti.csv`,
    `kosu_bilgisi.txt`, `dalga.mat` (git dışı)
  - `s4_tarama.csv` (özgün Cdc), `s4_tarama_KC.csv` (kesin tarama)
  - `sekiller/`: 300 dpi PNG + FIG
  - `loglar/kuyruk.txt`

## Model ve denetleyici

- Taban: `runs/2026-10-27_diyot_esleme/model/inverter_senaryo3_d08.slx` (D-03, D-08),
  D-09 uygulanmış. S3 değişkenleri S4 karşılıklarıyla değiştirildi (`Vdc4`, `K14`,
  `K34`, `phase_deg4`, `L1_core_Rp4`).
- Ölçüm: L1 akımı (Current Sensor1), 5 kHz tek kutuplu süzgeç. Referans
  `i_ref = √2·I_ref·sin θ_şebeke` (ideal PLL).
- Denetim K-19: analog eşdeğeri, 1 µs, hesaplama gecikmesi yok. u = u_ff + u_fb;
  u_ff = K14·sin θ + K34·sin³θ (geri besleme yolu dışında, K-07).
  - P: Kp = 0,03 (12.10 tarifi)
  - PI: Ki = Kp·2π·60 = 11,31; geri hesaplamalı anti-windup Kaw = 377 1/s
  - PIR: PI + Kr = 0,3, ω_b = 2π·2 rad/s, 50 Hz
  - Doyum |u| ≤ 1
- Kesin tarama `KC_*`:
  - DC bara 2 × 5,6 mF (D-11)
  - Kalibre S3 ileri beslemesi K14 = 0,44343, K34 = 0,384306, phase_deg4 = 0,6575° (K-20)
  - Değerler bellekteki modelin InitFcn'ine eklenir; etkin değerler her
    `kosu_bilgisi.txt` dosyasında "etkin" satırlarıyla doğrulandı.
- Benzetim 0,06 s (basamak 0,09 s), ode15s, MaxStep 1 µs, Accelerator. Kararlı durum
  ölçütleri son tam şebeke periyodundan; önceki periyotla fark `dP_ac` sütununda.

## Tablo 1 — Kesin tarama (KC_*: D-11 + K-20)

Kaynak: `runs/2026-10-28_s4_kapali_cevrim/results/KC_*/metrik.csv`.

| Koşu | I_L1,1 [A] (ref) | Genlik hatası | Faz hatası | THD_I (h≤50) | I₃/I₁ | P_ac [W] | η [%] (Display) | cosφ₁ | Doyum | u tepe | dP_ac/periyot |
|---|---|---|---|---|---|---|---|---|---|---|---|
| P 2,3 A | 2,336 (2,3) | +%1,6 | +1,0° | %7,0 | %6,5 | 280,7 | 96,24 | 0,992 | %0 | 0,86 | +%0,02 |
| PI 2,3 A | 2,327 (2,3) | +%1,2 | +1,4° | %7,2 | %6,6 | 279,5 | 96,20 | 0,993 | %0 | 0,86 | +%0,12 |
| P 10 A | 7,677 (10) | −%23,2 | −1,1° | %22,6 | %20,9 | 922,5 | 97,44 | 0,997 | %0 | 0,87 | −%0,11 |
| PI 10 A | 8,918 (10) | −%10,8 | −6,3° | %20,8 | %18,7 | 1065 | 97,31 | 0,986 | %0 | 0,88 | −%0,05 |
| P 25 A | 22,15 (25) | −%11,4 | −2,6° | %9,8 | %9,6 | 2662 | 96,69 | 0,993 | %0 | 0,90 | −%0,02 |
| **PI 25 A** | **24,47 (25)** | **−%2,1** | **−4,0°** | **%9,2** | **%8,7** | **2938** | **96,45** | **0,989** | **%0** | **0,90** | **+%0,06** |
| PIR 10 A (0,2 s) | 9,777 (10) | −%2,2 | +0,4° | %19,6 | %18,7 | 1175 | 97,28 | 0,999 | %0 | 0,87 | +%0,04 |
| **PIR 25 A (0,2 s)** | **24,75 (25)** | **−%1,0** | **+0,2°** | **%8,5** | **%8,1** | **2978** | **96,03** | **0,997** | **%0** | **0,93** | **−%0,01** |

- PIR koşuları 0,06 s'de oturmadı: önceki periyotla P_ac farkı 10 A'da %3,8, 25 A'da
  %1,9 idi (`KC_PIR_10A`, `KC_PIR_25A`). Nedeni rezonans teriminin dar bandıdır
  (ω_b = 2π·2 rad/s). Tablodaki değerler 0,2 s koşularındandır (`KC_PIR_*_02s`; 51
  ve 65 dk). Oturmamış 0,06 s koşuları `s4_tarama_KC.csv` içinde durur, özet şekle
  girmez (|dP_ac| > %0,5 süzgeci).

- η sütunu modelin kendi Display ölçümüdür (İP-4 ile aynı kaynak). Koşu betiğinin
  1 µs kayıtlarından hesapladığı η (`verim_pct`) bundan ~1 puan yüksektir
  (ör. PI 25 A: %97,24). Fark, `i_dc` kaydının Display'in DC güç ölçümüyle aynı
  noktada olmamasından gelir; karşılaştırmada Display değerleri kullanılır.
- Doyum hiçbir kararlı durum penceresinde yok; basamak koşusunda yalnız geçişte
  (%0,8 oranında, u tepe 1,49).

## Tablo 2 — Basamak yanıtı (PI, 10 → 25 A, t = 55 ms)

Kaynak: `results/KC_PI_basamak_10_25A/metrik.csv`.

| Büyüklük | Değer |
|---|---|
| Basamak öncesi I_L1,1 (ref 10 A) | 8,91 A |
| Basamak sonrası I_L1,1 (ref 25 A) | 24,48 A (−%2,1) |
| Aşım (son kararlı zarfa göre; İP-6 yeniden tanımı, K-21) | %0,2 |
| i_L1 tepesi / referans tepesi (kararlı durumdaki 3. harmonik dahil) | %7,3 üstünde |
| Yerleşme (hata bandı) | 0,44 ms |
| Geçişte doyum | %0,8 oranında, u tepe 1,49 |
| Basamak sonrası THD | %9,1 |

Basamak sonrası kararlı değerler PI 25 A koşusuyla aynıdır (24,48 / 24,47 A). Bu,
sonucun başlangıç koşulundan bağımsız olduğunu gösterir.

## Tablo 3 — Özgün DC bara (2 × 470 µF), m-dosyası ileri beslemesi

Kaynak: `s4_tarama.csv`. Sınırlılık kanıtı olarak saklanır (D-11).

| Koşu | I_L1,1 [A] | Genlik hatası | THD_I | Doyum | dP_ac/periyot |
|---|---|---|---|---|---|
| P 2,3 A | 2,409 | +%4,8 | %8,1 | %0 | +%0,03 |
| PI 2,3 A | 2,382 | +%3,6 | %9,9 | %0 | +%0,08 |
| P 10 A | 7,832 | −%21,7 | %24,2 | %0 | +%0,92 |
| PI 10 A | 7,201 | −%28,0 | %42,7 | %14,4 | −%14,6 |
| P 25 A | 22,16 | −%11,3 | %14,4 | %0 | +%0,01 |
| PI 25 A | 17,03 | −%31,9 | %57,4 | %20,6 | −%31,1 |

- PI 25 A'da DC bara orta noktası alternans içinde ~±120 V salınıyor. Evirici darbe
  yüksekliği pozitif alternansta ~270 V'tan ~100 V'a iniyor. İntegratör doyumdan
  çıkamıyor ve çözüm periyottan periyoda %31 değişiyor (kararlı durum yok).
- P 25 A özgün baradan geçerli bir sonuçtur: ilk deneme 2700 s süre sınırına takıldı,
  geçersiz `Cb_P_25A` koşusu ise fiilen 470 µF ile koştu
  (`results/P_25A/NOT_Cb_P_25A_kopyasi.txt`).
- 12.10 e-postasındaki "sistem 20 A civarına çıkıyor" gözlemi bu tavanla uyumludur.

## Bulgu 1 — DC bara orta noktası anma akımını sınırlıyor (D-11)

- ΔV_orta,tepe ≈ Î/(ω·(C₊ + C₋)); 2 × 470 µF ile 25 A'da ≈ 120 V (Vdc/2'nin %56'sı).
- 2 × 5,6 mF ile ≈ 10 V (%4,7). PI 25 A sonucu: −%31,9 → −%2,1 genlik hatası,
  doyum %20,6 → %0, THD %57,4 → %9,2.
- Laboratuvar deneyleri ~2,3 A'da yapıldı; orada 470 µF yeterli (≈ 11 V salınım).

## Bulgu 2 — Orta akımda (10 A) süreksiz iletim kazancı düşürüyor

- 10 A koşularında anlık L1 akımı anahtarlama periyotlarının büyük kısmında sıfıra
  iniyor. Nötr IGBT susturması köprüyü senkron olmayan buck gibi çalıştırıyor
  (İP-4'te ölçülen ara seviye zaman oranı ve Z_th ile aynı mekanizma, K-02b).
- L1 dalgalılığı ~9 A tepe-tepe olduğundan |i_L1| ≲ 4,5 A olan her bölge süreksiz
  iletimdedir. 25 A'da bu yalnız sıfır geçişleri çevresinde, 10 A'da çevrimin büyük
  kısmında olur. Bu yüzden izleme hatası akımla monoton değil: 10 A, 25 A'dan kötü.
- 10 A'da 3. harmonik baskın (I₃/I₁ %19–21). Sin³ ileri beslemesinin 3. harmonik
  terimi (−0,0975·sin 3θ, K-06a) 2,3 A noktasının bozulmasına göre kalibre edildi;
  süreksiz iletim bölgesi akımla değiştiği için 10 A'da aynı terim uymuyor.
- PI'nin integral terimi (sıfır 60 Hz) 50 Hz'de sınırlı kazanç verdiğinden genlik
  hatasını kısmen kapatıyor (−%23 → −%11). 50 Hz rezonanslı PIR temel bileşeni
  kapatıyor: 10 A'da −%2,2 ve +0,4°. Ancak THD %19,6'da kalıyor; rezonans yalnız 50 Hz'e
  etkilidir, 3. harmonik bozulması süreksiz iletimden gelir.
- Tez için anlamı: nötr susturma bir **düşük güç** yöntemidir. Orta ve anma akımında
  tamamlayıcı anahtarlamaya dönüş (ya da rezonanslı akım denetimi) gerekir. Kip geçişi
  bu çalışmanın kapsamı dışındadır; Bölüm 8'de öneri olarak yazılır.

## Bulgu 3 — S4 verimi S3 ile doğrudan karşılaştırılamaz

- S4, L1 çekirdek kaybı için m-dosyasındaki `L1_core_Rp4 = 1500 Ω`'u kullanır (K-14).
  S3 `L1_core_Rp = 600 Ω` kullanır.
- 2,3 A'da S4'ün L1 Rp kaybı 4,78 W (`kayip_L1Rp_W`). Aynı gerilimde 600 Ω ile
  ≈ 12,0 W olurdu; fark ≈ 7,2 W.
- Bu yüzden aynı ~280 W çıkışta S4 η %96,2, kalibre S3 η %94,25 çıkıyor. Fark
  denetimden değil, çekirdek kaybı parametresinden gelir.
- Tezde S4 verimi yalnız S4 içinde (2,3 / 10 / 25 A) karşılaştırılır. Senaryolar
  arası verim karşılaştırması S1–S3 kalibre sonuçlarıyla yapılır.

## Belirsizlik ve sınırlar

- Ani IGBT akım tepeleri (PI 25 A: 215 A, i_L1 tepesi 41 A) anahtarlama geçişindeki
  Simscape diyot toparlanma/kapasite akımlarıdır; parazitik endüktanslar modellenmediği
  için genlikleri fiziksel değildir ve SOA değerlendirmesine esas alınmaz.
- L1 doyumu modellenmedi (K-19); 25 A'da i_L1 tepesi 41 A.
- Denetim analog eşdeğeridir. Bir periyot gecikmeli sayısal gerçekleme bu LCL'de
  etkin sönümleme olmadan kararsızdır (K-19, `tasarim/s4_tasarim_marjlari.csv`).
- DC bara 5,6 mF bir boyutlandırma varsayımıdır; donanımda doğrulanmadı.
- 0,06 s benzetim: kararlı durum ölçütü önceki periyotla ≤ %0,12 fark (basamak
  koşusu hariç, o koşu basamağı içerir).
- S4 için deney yok; sayılar yalnız model içi karşılaştırmadır.

## Geçersiz deneme (kayıt için)

`results/_gecersiz_Cb_InitFcn_ezdi/` altındaki `Cb_*` koşuları (14:35–16:07) geçersizdir.
Cdc yalnız taban çalışma alanına yazılmıştı, InitFcn 470 µF'a geri döndürdü; dört
koşunun metrikleri özgün koşularla bayt bayt aynı. Ayrıntı: klasördeki `OKU.txt`.

## Şekiller

`runs/2026-10-28_s4_kapali_cevrim/sekiller/` (300 dpi PNG + FIG):

- `s4_akim_izleme_25A_KC`: P, PI ve PIR (0,2 s) ile 25 A'da i_L1, i_ref, i_ac, v_ac;
  son iki periyot
- `s4_basamak_PI_10_25A_KC`: PI ile 10 → 25 A basamak; i_L1 ortalaması ve modülasyon
- `s4_tarama_ozet_KC`: η (Display), THD ve genlik hatasının akıma göre değişimi
- Özgün Cdc karşılıkları aynı adlarla, `_KC` eki olmadan

## Sonuç (jüri maddesi 8)

- S4 PI ve PIR denetleyicileri 25 A anma akımında doyumsuz çalışıyor ve referansı
  izliyor:
  - PI: −%2,1 genlik hatası
  - PIR: −%1,0 genlik hatası, +0,2° faz hatası, THD %8,5
- 10 → 25 A basamağında son kararlı zarfa göre aşım %0,2 (İP-6, K-21); çözüm başlangıçtan bağımsız aynı kararlı noktaya
  oturuyor.
- Önkoşul: DC baranın orta noktayı tutabilecek boyutta olması (D-11).
- Orta akımda (10 A) susturmanın yarattığı süreksiz iletim THD'yi %20'ye çıkarıyor.
  Bu, yöntemin düşük güç kapsamını sınırlayan bir bulgudur.

## Önerilen kayıtlar

- D-02: doğrulandı (Tablo 1).
- D-11: doğrulandı (Tablo 1 ↔ Tablo 3).
- Plan: İP-5 ☑; İP-6 (Bode) S4 modeli ve `tasarim/` çıktılarıyla başlayabilir.
- Bölüm 8 sınırlılıkları: Bulgu 2 (susturmanın orta akımdaki süreksiz iletim etkisi,
  kip geçişi önerisi), Bulgu 3, DC bara boyutu, sayısal gerçekleme kararsızlığı.
