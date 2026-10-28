# S4 akım denetiminin kararlılık analizi ve Sin³ ileri beslemesi (İP-6)

Tarih: 28.10.2026 · MATLAB R2023b Update 7 · bu makine · İP-6 · jüri maddesi 7 · K-07, K-19, K-20, K-02b, K-14, D-02, D-11

## Amaç ve kapsam

Jüri maddesi 7, Sin³ yöntemi için kapalı çevrim ve Bode analizi istiyor. K-07'nin üç
katmanı burada sırayla kanıtlanır:

1. **Analitik:** Sin³ terimi modülasyon toplamına giren dış ileri besleme girişidir;
   karakteristik denklem 1 + L(s) = 0 K34'ten bağımsızdır.
2. **Frekans alanı:** P / PI / PIR için L, S, T Bode eğrileri, marj ve kutup tabloları;
   K34 açık ve kapalı. Simulink Control Design ile ortalama Simulink/Simscape modelinden
   bağımsız doğrulama.
3. **Zaman alanı:** anahtarlamalı S4 modelinde çok tonlu enjeksiyonla L(jω) ölçümü
   (25 A'da K34 açık/kapalı, 10 A, 2,3 A) ve 10 → 25 A basamağında K34 açık/kapalı.

İ5: S4 için deney yoktur. Buradaki bütün sayılar benzetim modelleri arasındaki
karşılaştırmadır; tez bulgusu değil, modelin iç tutarlılığının kanıtıdır.

## Dosyalar

- Betikler (`scripts/`):
  - `kararlilik_ortak_20261028.m`: parametreler, ortalama bitki (durum uzayı), denetleyiciler, marj/Nyquist tanımı, ton tahmincisi
  - `analiz_kararlilik_20261028.m`: katman 1–2 (analitik, marj, kutup, L_g/λ/Td taramaları, şekiller)
  - `ortalama_model_kararlilik_20261028.m`: ortalama Simulink/Simscape modeli (`kur`), SCD `linearize` (`dogrusallastir`), zaman alanı koşuları (`kos`)
  - `build_enjeksiyon_kararlilik_20261028.m`: anahtarlamalı S4'ün ölçüm kopyası (u_x = u_fb + d)
  - `run_enjeksiyon_kararlilik_20261028.m`, `queue_kararlilik_20261028.sh`: anahtarlamalı koşular (KC_* ayarları, süre sınırı 3600 s)
  - `karsilastir_kararlilik_20261028.m`: ortalama ↔ anahtarlamalı karşılaştırma
  - `linearize_anahtarlamali_kararlilik_20261028.m`: anahtarlamalı modelin doğrudan `linearize` denemesi
- Koşu klasörü `runs/2026-10-28_kararlilik/`:
  - `frekans/`: marj, kutup, tarama CSV'leri; şekiller (PDF vektör + 300 dpi PNG)
  - `ortalama/`: SCD sonuçları, ortalama model koşuları (`*.mat`, git dışı)
  - `results/<koşu>/`: `tonlar.csv`, `arka_plan.csv`, `metrik.csv`, `kosu_bilgisi.txt`, `olcum.mat` (git dışı)
  - `karsilastirma/`: ton, harmonik ve basamak karşılaştırma CSV'leri ve şekilleri
  - `model_a|b|c/` (anahtarlamalı ölçüm kopyaları), `model_ort/` (ortalama model): git dışı
  - `loglar/kuyruk.txt`, `inspection/build_enjeksiyon_denetim.txt`

## Ortalama model ve gerçeklemeler

- Bitki G(s) = i_L1/v_inv, girişler [v_inv; v_g]. Güç ağı anahtarlamalı modeldeki sırayla
  kurulur: L1 (L1r) ∥ Rp4 → Cf (Cr) → Ldm (CMC S1) → Cx (Rx) → Ldm (CMC S3) → L2 (L2r)
  → şebeke. Değerler İP-5 model klasöründeki m-dosyasından: L1 = 600 µH, L1r = 0,03 Ω,
  Rp4 = 1500 Ω (K-14), Cf = 8 µF, Cr = 0,01 Ω, Cx = 0,5 µF, Rx = 0,2 Ω (D-09),
  Ldm = 4 µH, L2 = 1000 µH, L2r = 0,01 Ω.
  - G: rezonans 2815 Hz (ζ = 0,0041), antirezonans (sıfır) 1720 Hz (ζ = 0,0018);
    EMC iç modu 116 kHz.
  - İP-5 tasarımındaki toplu varyantla (Cf ∥ Cx, 2Ldm + L2) fark yalnız antirezonans
    çukurunda büyür (en çok %12,8); marjlar ≤ 0,03° ve ≤ 1 Hz değişir.
- K_pwm = Vdc4/2 = 213,75 V (Vdc normalizasyonu yok; yarım periyot ayrımlı tek kutuplu PWM).
- Ölçüm H_m = 5 kHz tek kutup (modelde ayrık, 1 µs). Kapalı çevrim değerleri KC_* (K-20):
  K14 = 0,44343, K34 = 0,384306, φ4 = 0,6575°.
- Denetleyiciler (K-19, İP-5): P Kp = 0,03 1/A; PI Ki = Kp·2π·60 = 11,31 1/(A·s);
  PIR = PI + 2Kr ω_b s/(s² + 2ω_b s + ω0²), Kr = 0,3, ω_b = 2π·2 rad/s.
- Gerçeklemeler:
  - **(A)** modeldeki analog eşdeğeri: sürekli C, H_m, toplam gecikme Td = 2 µs (üst sınır).
  - **(Ad)** aynı yapının 1 µs ayrık karşılığı: modeldeki bloklarla bire bir (ileri Euler
    integratör, ön bükmeli Tustin rezonans, ayrık süzgeç, 1 örnek gecikme, ZOH).
  - **(B)** sayısal: Ts = 100 µs, periyot ortalaması örnekleme, 1 Ts hesaplama gecikmesi,
    ZOH (İP-5 tasarımındaki tanım; K-19 not 1).
  - **(B2)** bilgi için: çift güncelleme, Ts = 50 µs, aynı yapı.

## Katman 1 — Analitik: Sin³ terimi çevrimin dışındadır

Modelde (K-06a, `inverter_senaryo4_kc`, D-02):

```
u_ff = K14·sin(θ+φ4) + K34·sin³(θ+φ4)        (Sine Wave3 → K1 ; Product15 → Product1 → K3)
u    = sat( u_ff + u_fb ),  u_fb = C(s)·(i_ref − H_m·i_L1)
v_inv = K_pwm·e^{−sTd}·u ,  i_L1 = G(s)·v_inv + G_g(s)·v_g
```

θ = ω0·t + φ yalnız zamana bağlıdır (ideal PLL, şebekeye kilitli kaynak); sin³ θ'nın
hiçbir girişi çevrimdeki bir işaretten gelmez. Doyum dışında (|u| < 1, bütün kararlı
durum pencerelerinde u tepe ≤ 0,94) kapalı çevrim:

```
i_L1 = [ K_pwm e^{−sTd} G · (u_ff + C·i_ref) + G_g · v_g ] / (1 + L),
L(s) = C(s) · K_pwm · e^{−sTd} · G(s) · H_m(s)
```

- Karakteristik denklem 1 + L(s) = 0'da K34 yoktur. Kutuplar, kazanç ve faz marjları
  K34'ten bağımsızdır. K34 yalnız sağ taraftaki dış girişin genliğini değiştirir.
- Özdeşlik sin³x = [3 sin x − sin 3x]/4 ile:
  u_ff = (K14 + 3K34/4)·sin(θ+φ4) − (K34/4)·sin(3θ+3φ4) = 0,7317·sin(θ+φ4) − 0,0961·sin(3θ+3φ4).
- İleri beslemenin akıma etkisi S(s) = 1/(1 + L) ile ölçeklenir:
  I_h = S(jhω0)·K_pwm·e^{−jhω0Td}·G(jhω0)·U_ff,h (h = 1, 3). Çevrimsiz (S3 benzeri)
  durumda aynı ifade S = 1 ile geçerlidir.
- 150 Hz bileşeni (PI, gerçekleme A): |S(j2π·150)| = 0,234 (−12,6 dB, ∠ +98,7°).
  K34/4 = 0,0961'lik 3. harmonik modülasyon, çevrimsiz 9,53 A RMS 150 Hz akımı üretirdi;
  çevrim bunu 2,23 A RMS'ye (×0,234) indirir. P'de |S| = 0,231, PIR'de 0,214.
- Temel bileşen: |S(j2π·50)| PI'de 0,0526, P'de 0,0785, PIR'de 0,0072. Sin³'ün temel
  payı (3K34/4 = 0,288) PI'de i_L1 temel bileşenini 22,71 → 25,18 A RMS'ye taşır
  (ortalama model tahmini, `frekans/sin3_bozucu_etkisi.csv`). Yani ileri besleme,
  denetleyicinin karşılaması gereken temel bileşeni azaltır; kararlılığı etkilemez.
- Yorum: kapalı çevrimde Sin³ terimi denetleyiciden önce bilinen bir modülasyon payını
  ekler. Denetleyici için o artık bir bozucu/referans terimidir ve S(jω) kadar bastırılır.
  Çevrimin kendisi (L, S, T) değişmez.

## Katman 2 — Frekans alanı

### (A) marj çelişkisinin çözümü

İP-5'in `tasarim/s4_tasarim_marjlari.csv` dosyası (A) için "fc ≈ 3385 Hz, PM ≈ 54°,
GM ≈ −30,7 dB @ 2808 Hz, 3 geçiş" veriyordu. Özetlerdeki "fc ≈ 585 Hz, PM 74–84°,
GM ≈ 35 dB" ise aynı klasördeki `s4_tasarim_allmargin.csv`'nin ilk satırlarıydı. İkisi
de (A)'ya aittir; çelişki marj tanımından gelir:

- L(jω)'nın **üç kazanç geçişi** vardır: 583 Hz (aşağı), 2454 Hz (yukarı, LCL
  antirezonansından sonra yükselen kol) ve 3386 Hz (aşağı, rezonans tepesinden sonra).
  "585 Hz, PM 78°" birinci geçiştir. "3385 Hz, PM 54°" en küçük faz marjlı (kritik)
  geçiştir. İkisi de doğru, ama tek başına eksik bir tanımdır.
- "GM = −30,7 dB @ 2808 Hz" bir **hesap hatasıdır**. İP-5 betiğinin `margins()`
  yardımcısı faz geçişini sarılmış fazın (mod 360) işaret değişiminden arıyor. Sarılmış
  faz ∠L = 0°'da da sıçradığı için, LCL rezonansında fazın 0°'dan geçtiği nokta
  (L pozitif gerçel eksende, |L| ≈ +30 dB) −180° geçişi sanılmış. Faz 2793 Hz'de +31°,
  2823 Hz'de −66°'dir; −180°'ye hiç ulaşmaz. Bu noktanın kararlılıkla ilgisi yoktur.
- Gerçek tek −180° geçişi 22,0–22,2 kHz'dedir: GM = +35,2 dB (kazanç ×57'ye kadar artabilir).
- Bu notta marj tanımı açıkça şöyledir (`kararlilik_ortak_20261028.m/marjlar`):
  - her kazanç geçişi için PM_i = 180° − |∠L| (−1 noktasına açısal uzaklık) ve saat
    yönünde gereken dönüşten gecikme marjı DM_i = mod(∠L + 180°, 360°)/(360°·f_i);
  - faz geçişi = L'nin negatif gerçel eksen kesişimi (Im L = 0, Re L < 0); GM_i = −20 log|L|;
  - Nyquist: (−∞, −1) ışınının ω > 0 yarısındaki net kesişim sayısı (yukarı +1, aşağı −1);
    açık çevrim kararsız kutbu yokken (P = 0, bütün durumlarda doğrulandı) kararlılık
    koşulu net = 0;
  - modül marjı min|1 + L| = 1/‖S‖∞;
  - ek olarak kapalı çevrim kutupları doğrudan hesaplanır (sürekli: Pade(2) gecikme;
    ayrık: |z|).
  Üç ölçüt (Nyquist, kutup, SCD) her satırda aynı sonucu verir.

### Tablo 1 — Marjlar (K34 açık ve kapalı aynı)

Kaynak: `frekans/kararlilik_marjlar.csv`, `frekans/kararlilik_gecisler.csv`. Her satır
K34 = 0,384306 ve K34 = 0 için ayrı ayrı hesaplandı; bütün sütunlar bit düzeyinde
aynıdır (`k34_degismezlik.csv`: max |ΔL|/|L| = max |ΔS|/|S| = max |ΔT|/|T| = 0).

| Gerç. | Den. | Kazanç geçişleri [Hz] | PM_i [°] | PM_min [°] | DM_min [µs] | Faz geçişleri [Hz] → GM [dB] | ‖S‖∞ [dB] | Nyquist net | Kutup ölçütü | Kararlı |
|---|---|---|---|---|---|---|---|---|---|---|
| A | P | 583 / 2454 / 3386 | 83,6 / 119,4 / 55,2 | 55,2 | 45,3 | 22 167 → +35,3 | 2,28 | 0 | max Re = −3583 1/s | evet |
| A | PI | 586 / 2454 / 3386 | 77,7 / 120,8 / 54,2 | 54,2 | 44,4 | 22 029 → +35,2 | 2,36 | 0 | −416 1/s | evet |
| A | PIR | 590 / 2454 / 3386 | 73,8 / 121,7 / 53,5 | 53,5 | 43,9 | 21 937 → +35,2 | 2,42 | 0 | −39 1/s | evet |
| Ad | P | 583 / 2454 / 3386 | 83,6 / 119,4 / 55,2 | 55,2 | 45,3 | 22 150 → +35,4 | 2,28 | 0 | max\|z\| = 0,99642 | evet |
| Ad | PI | 585 / 2454 / 3386 | 77,7 / 120,8 / 54,2 | 54,2 | 44,4 | 22 013 → +35,3 | 2,36 | 0 | 0,99958 | evet |
| Ad | PIR | 590 / 2454 / 3386 | 73,8 / 121,7 / 53,5 | 53,5 | 43,9 | 21 921 → +35,2 | 2,42 | 0 | 0,99996 | evet |
| B | P | 581 / 2474 / 3254 | 48,8 / 90,2 / 142,1 | 48,8 | 101 | 1258 → +11,2; 1704 → +47,4; **2811 → −30,3** | 5,12 | **1** | **max\|z\| = 1,179** | **hayır** |
| B | PI | 574 / 2479 / 3246 | 43,3 / 88,7 / 142,1 | 43,3 | 99 | 1220 → +10,6; 1705 → +48,0; **2811 → −30,1** | 5,57 | **1** | **1,175** | **hayır** |
| B | PIR | 579 / 2479 / 3246 | 39,1 / 88,0 / 142,6 | 39,1 | 99 | 1193 → +10,1; 1705 → +48,2; **2810 → −30,0** | 6,02 | **1** | **1,175** | **hayır** |
| B2 | PI | 583 / 2440 / 3444 | 63,7 / 179,4 / 33,3 | 33,3 | 204 | **2863 → −20,4** | 4,97 | **1** | **1,085** | **hayır** |

- (A) ve (Ad) aynı sonucu verir; 1 µs ayrıklaştırma marjları ≤ 0,02° ve ≤ 0,1 dB değiştirir.
- (A)'da faz, rezonans çevresinde +60°'den −121°'ye iner ama −180°'ye ulaşmaz
  (5 kHz süzgeç + 2 µs gecikme 2,8 kHz'de yalnız ~31° gecikme verir). Bu yüzden
  rezonans tepesi (|L| ≈ +30 dB) −1 noktasını çevrelemez.
- (B)'de 2 Ts toplam gecikme (ortalama Ts/2 + hesaplama Ts + ZOH Ts/2 = 200 µs)
  rezonansta fazı −180°'nin altına iter; L, |L| ≈ +30 dB iken negatif gerçel ekseni
  −32,7'de keser. Nyquist net kesişim 1 → saat yönünde 2 çevreleme → 2,72 kHz'de bir çift
  kararsız kutup (|z| = 1,18; s = +1614 ± j17 017 1/s). Bu, K-19 not 1'in sayısal
  dayanağıdır: f_res = 2,8 kHz > fs/6 = 1,67 kHz olan LCL'de L1 akımı geri beslemesi
  etkin sönümlemesiz kararsızdır.
- (B2) çift güncelleme (Ts = 50 µs) de yetmez (|z| = 1,085): gecikme 100 µs'ye
  inse de (A)'nın gecikme marjının (44 µs) üstündedir.
- Gecikme marjı ile tutarlılık (`frekans/gecikme_taramasi.csv`, PI, A): Td = 45 µs'de
  kararlı (PM_min 1,7°), Td = 50 µs'de kararsız (Nyquist net 1). Kritik gecikme
  ≈ 44–50 µs, DM_min = 44,4 µs ile uyumludur.

### Tablo 2 — Kapalı çevrim kutupları (A, |s| < 2π·20 kHz, en az sönümlüden)

Kaynak: `frekans/kararlilik_kutuplar.csv` (Ad ve B satırları da orada).

| Den. | Kutuplar (f_n, ζ) |
|---|---|
| P | 3097 Hz, ζ = 0,184 (−3583 ± j19 123) · 918 Hz gerçel (−5770) · 2883 Hz gerçel (−18 112) |
| PI | 3109 Hz, ζ = 0,181 (−3535 ± j19 211) · 66 Hz gerçel (−416, PI sıfırına yakın) · 799 Hz gerçel · 2951 Hz gerçel |
| PIR | 40,1 Hz, ζ = 0,155 (−39 ± j249, rezonans terimi) · 3117 Hz, ζ = 0,179 · 113 Hz, 712 Hz, 2994 Hz gerçel |
| B, PI | **2721 Hz, ζ = −0,094 (\|z\| = 1,175)** · 5126 Hz ζ = 0,22 · 825 Hz ζ = 0,40 · 67 Hz gerçel |

- Bitkinin 116 kHz'lik EMC iç modu (ζ = 0,038) ve Pade kutupları tabloda yoktur; ikisi
  de ≥ 20 kHz'dir ve kararlıdır.
- PIR'nin 40 Hz'lik yavaş çifti (ζ = 0,155, zaman sabiti 1/39 s = 26 ms), İP-5'te PIR
  koşularının 0,06 s'de oturmamasının nedenidir (0,2 s gerekti).

### Simulink Control Design doğrulaması (ortalama Simulink/Simscape modeli)

Kaynak: `ortalama/scd_dogrusallastirma.csv`; model `model_ort/s4_ortalama_kararlilik.slx`.

- Model betikle kuruldu. Denetleyici alt sistemi (`S4 Akim Denetleyicisi`)
  `inverter_senaryo4_kc`'den kopyalandı. Ölçüm süzgeci, doyum, anti-windup ve ileri
  besleme blokları aynıdır. Köprü, K_pwm = Vdc4/2 kazançlı denetimli gerilim kaynağıdır.
  Güç ağı Simscape Foundation elemanlarıyla anahtarlamalı modeldeki sırada kuruldu.
- `linearize`: giriş d (enjeksiyon), çıkışlar u_fb ve u_x. 25 A kararlı durum anlık
  görüntüsü `findop(…, 0,08 s)`, örnekleme 1 µs. L = −H_{d→u_fb}/H_{d→u_x},
  S = H_{d→u_x}, T = −H_{d→u_fb}. Ayrıca `looptransfer` noktası ile.
- Sonuçlar:
  - P, PI, PIR ile analitik (Ad) farkı: max |ΔL|/|L| = 1,6·10⁻¹¹ / 3,5·10⁻¹⁰ / 6,4·10⁻⁴
    (faz ≤ 0,04°). SCD marjları Tablo 1'in (Ad) satırlarıyla aynı.
  - K34 açık/kapalı: L'deki fark tam 0.
  - t = 0 ve t = 0,08 s çalışma noktaları aynı sonucu verir (fark ≤ 10⁻⁸): ağ doğrusaldır,
    |u| < 1'de doyum etkin değildir.
  - `looptransfer` pozitif geri besleme kuralıyla −L döndürür (fark 10⁻¹⁰–10⁻⁸).
  - **Dikkat:** SCD, `S4 AW Asim` Dead Zone bloğunu varsayılan olarak 1 kazançla
    doğrusallaştırdı (ölçülen). Bu, anti-windup geri hesaplama yolunu (Kaw = 377 1/s)
    çevrime ikinci bir yol olarak ekler ve PI/PIR'de L'yi bozar (max fark 16,7, fc 634 Hz).
    |u_top| ≤ 0,94 < 1 çalışma noktasında Dead Zone'un yerel türevi 0'dır. Bu yüzden blok
    yerine koyma (`Value = 0`) uygulandı; yukarıdaki sonuçlar böyledir. P'de Kaw = 0
    olduğundan iki yol aynıdır.
- Anahtarlamalı modelin doğrudan `linearize`'ı (`ortalama/anahtarlamali_linearize.txt`):
  derleme aşamasında duruyor ("`Sine Wave3` … disallow model API calls for the
  'update' method"; SPS/powerlib blokları SCD model API'sine kapalı). Bu engel aşılsa
  bile sonuç anlamsız olurdu: PWM karşılaştırıcısı (d ≥ taşıyıcı) ve anahtar kip
  mantığının yerel türevi hemen her yerde 0'dır, doğrusallaştırma bitki yolunu keser.
  Bu nedenle anahtarlamalı model, doğrusallaştırma yerine **enjeksiyonla ölçülür**
  (katman 3).

### L_g duyarlılığı (şebeke endüktansı L2'ye ek)

Kaynak: `frekans/lg_taramasi.csv`, şekil `frekans/kararlilik_Lg_taramasi`.

| L_g [mH] | f_res / f_antirez [Hz] | PI (A): kazanç geçişleri [Hz] | PM_i [°] | PM_min [°] | DM_min [µs] | GM [dB] | max Re p (A) [1/s] | (B) max\|z\| |
|---|---|---|---|---|---|---|---|---|
| 0 | 2815 / 1720 | 586 / 2454 / 3386 | 77,7 / 120,8 / 54,2 | 54,2 | 44,4 | 35,2 | −416 | 1,175 |
| 0,5 | 2635 / 1406 | 450 / 2212 / 3279 | 77,6 / 118,1 / 54,9 | 54,9 | 46,5 | 35,2 | −434 | 1,215 |
| 1 | 2540 / 1218 | 367 / 2077 / 3226 | 76,9 / 116,7 / 55,3 | 55,3 | 47,6 | 35,2 | −456 | 1,236 |
| 2 | 2441 / 995 | 271 / 1927 / 3173 | 74,8 / 115,1 / 55,7 | 55,7 | 48,8 | 35,2 | −522 | 1,257 |
| 5 | 2337 / 704 | 158 / 1759 / 3120 | 67,8 / 113,3 / 56,1 | 56,1 | 49,9 | 35,2 | −506 | 1,277 |

- Aralık gerekçesi: L2 = 1 mH zaten şebeke + varyak endüktansını içerir (12.10 m-dosyası).
  0,5–2 mH zayıf şebeke/uzun hat eki, 5 mH aşırı uç olarak alındı.
- (A) bütün aralıkta kararlıdır. Kritik (üçüncü) geçişin PM'i 54 → 56°'ye hafifçe artar,
  GM değişmez (yüksek frekansta L, L1 ile belirlenir). P ve PIR'de eğilim aynıdır.
- Bedeli izleme bant genişliğidir: L_g büyüdükçe antirezonans aşağı iner, birinci geçiş
  586 → 158 Hz'e düşer ve 50 Hz'de |L| azalır.
- (B) her L_g'de kararsızdır ve kötüleşir (f_res, fs/6'ya yaklaşsa da altına inmez).

### Etkin köprü kazancı (λ) taraması

Kaynak: `frekans/kazanc_taramasi.csv`. K_pwm → λ·K_pwm (PI, A). Süreksiz iletim ve
köprü Z_th'si (K-02b) köprünün küçük işaret kazancını değiştirir; bu tarama bunun
kararlılık sınırını verir.

- λ = 0,05 … 50: kararlı. Kritik geçişin PM'i 46–64° (λ ≤ 2), λ = 5'te 35°, λ = 10'da 24°.
- λ = 60'ta kararsız (GM = +35,2 dB = ×57,6 ile tutarlı).
- Kazanç azalması (λ < 1) kararlılığı bozmaz; yalnız birinci geçişi aşağı çeker
  (λ = 0,1: 79 Hz, λ = 0,3: 197 Hz) ve izleme hatasını büyütür. Bu, 10 A'daki genlik
  hatalarının (İP-5 Bulgu 2) kararlılık değil izleme sorunu olduğunu gösterir.

## Katman 3 — Zaman alanı: anahtarlamalı modelde ölçüm

### Yöntem

- Ölçüm kopyası: `inverter_senaryo4_kc`'ye yalnız bir toplama bloğu eklendi
  (`S6 Enjeksiyon Toplami`: u_x = u_fb + d). d = 0 iken model matematiksel olarak İP-5
  modeliyle aynıdır. Bu bir model düzeltmesi değildir; D-xx kaydı gerektirmez.
- d: üç tonlu (Schroeder fazlı) sinüs toplamı; her tonun genliği 0,015 (görev oranı birimi).
  - Pencere 0,03–0,11 s (80 ms, 12,5 Hz ızgarası). Tonlar 50 Hz harmoniklerine ve
    birbirlerinin 100 Hz dönüşüm ürünlerine dik seçildi: n = f/12,5 sınıfları
    {1,7}, {2,6}, {3,5}.
  - Küme A = 212,5 / 525 / 1037,5 Hz; küme B = 587,5 / 2025 / 3362,5 Hz.
- Tahminci: L = −U_fb/U_x, S = U_x/D, T = −U_fb/D, P = Y_m/U_x, C = U_fb/(I_ref − Y_m),
  etkin köprü kazancı K_ef = V_inv/U_x, pasif ağ G_v = I_L1/V_inv.
- Tahmincinin kendisi ortalama modelde denendi: analitik L ile fark ≤ 0,004 dB ve
  ≤ 0,37° (`karsilastirma/ton_karsilastirma.csv`, "ort" satırları).
- Belirsizlik: tona komşu, harmonik ve ton olmayan ızgara noktalarındaki u_x düzeyi n
  (orada d = 0, dolayısıyla u_x = u_fb). Bu düzey anahtarlama ve kip dönüşümü kaynaklı
  arka planı verir; δ ≈ n/|U_x| + n/|U_fb|.
- Bütün anahtarlamalı koşular KC_* ayarlarıyla yapıldı (K-20 + D-11). Etkin değerler her
  `kosu_bilgisi.txt` dosyasında "etkin" satırıyla doğrulandı: K14 = 0,44343,
  K34 = 0,384306 (ya da 0), φ4 = 0,6575°, Cdc = 5,6 mF.
- Koşu süresi 0,11 s; duvar süresi 29–31 dk (Accelerator, iki paralel kuyruk).

### Tablo 3 — L(jω): anahtarlamalı model ölçümü ↔ ortalama model (PI)

Kaynak: `karsilastirma/ton_karsilastirma.csv`. "Analitik" = gerçekleme (A). Belirsizlik δ
yukarıdaki tanımla (25 A, K34 açık koşusu).

| f [Hz] | Analitik \|L\| [dB] / ∠L | 25 A, K34 açık | 25 A, K34 = 0 | 10 A | 2,3 A | Belirsizlik (25 A) |
|---|---|---|---|---|---|---|
| 212,5 | 9,74 / −106,7° | 9,90 / −94,4° | 10,19 / −90,2° | 8,36 / −68,5° | −7,25 / −25,8° | ±1,4 dB / ±10° |
| 525 | 1,11 / −102,2° | 1,29 / −94,5° | 1,31 / −93,4° | 0,66 / −84,7° | −8,11 / −30,1° | ±0,8 dB / ±6° |
| 587,5 | −0,03 / −102,3° | 0,18 / −95,3° | 0,32 / −93,8° | −0,19 / −86,5° | — | ±0,6 dB / ±4° |
| 1037,5 | −7,10 / −105,3° | −6,05 / −98,6° | −6,75 / −90,4° | −7,00 / −91,6° | −10,05 / −48,8° | ±1,0 dB / ±7° |
| 2025 | −12,67 / +63,9° | −11,00 / +60,5° | −10,08 / +54,4° | −10,62 / +49,1° | — | ±0,7 dB / ±5° |
| 3362,5 | 0,31 / −125,6° | 0,47 / −126,7° | 0,59 / −122,5° | 0,25 / −114,9° | — | ±0,4 dB / ±2,5° |

Yöntemin denetimi (aynı CSV):

- Ölçülen denetleyici C, tasarım değerine 0,995–1,004 oranında ve ≤ 0,6° farkla eşit.
- Ölçülen pasif ağ G_v = I_L1/V_inv, bütün koşularda analitik G'ye 0,987–1,028 oranında
  ve ≤ 3,4° farkla eşit. Ağ modeli (L1 ∥ Rp4, Cf, EMC, L2) anahtarlamalı modelle
  doğrulanmış olur.
- Bu yüzden ölçülen L ile analitik L arasındaki farkın tamamı köprünün etkin küçük işaret
  kazancından gelir: K_ef = V_inv/U_x.
  - 25 A: K_ef/K_pwm = 1,01–1,04, +7…+15° (212–1037 Hz). 2025 Hz'de 1,2–1,35; burada
    |L| ≈ −11 dB olduğundan marja etkisi yok. 3362,5 Hz'de 1,02–1,03, −3…+2°.
  - 10 A: 0,87∠+40° (212 Hz) → 1,0∠+13° (1 kHz).
  - 2,3 A: 0,14∠+84° (212 Hz), 0,35∠+74° (525 Hz), 0,71∠+56° (1037 Hz).
- Enjeksiyonlu koşuların temel bileşeni, enjeksiyonsuz İP-5 koşularıyla aynıdır:
  - PI 25 A: 24,46 A, −%2,14, −4,06° ↔ 24,47 A, −%2,1, −4,0°;
  - PI 10 A: 8,92 A ↔ 8,92 A.

  Enjeksiyon çalışma noktasını bozmadı.

### Tablo 4 — Anahtarlamalı ölçümden marj kestirimi (PI)

Birinci geçiş, komşu ton çiftlerinden log-doğrusal ara değerle bulundu. Üçüncü geçiş
3362,5 Hz noktasından, analitik eğimle (≈ −100 dB/dekad) kestirildi.

| Durum | 1. geçiş [Hz] / PM | Kritik (3.) geçiş [Hz] / PM | DM_min [µs] |
|---|---|---|---|
| Analitik (A) | 586 / 77,7° | 3386 / 54,2° | 44,4 |
| Anahtarlamalı 25 A, K34 açık | ≈ 598 / ≈ 85° | ≈ 3400 / ≈ 53° (±3°) | ≈ 43 |
| Anahtarlamalı 25 A, K34 = 0 | ≈ 609 / ≈ 86° | ≈ 3400 / ≈ 57° (±3°) | ≈ 47 |
| Anahtarlamalı 10 A | ≈ 573 / ≈ 94° | ≈ 3370 / ≈ 65° (±2°) | ≈ 54 |
| Anahtarlamalı 2,3 A | < 212 Hz (212–1037 Hz'de \|L\| = −7…−10 dB, faz −26…−49°) | ölçülmedi | — |

### Bulgular (katman 3)

1. **Ortalama model, anma akımında (25 A) anahtarlamalı modelin çevrim kazancını kritik
   bölgede ±0,2 dB ve ±1° içinde yeniden üretiyor.**
   - Kritik geçiş 3,4 kHz'dedir. 3362,5 Hz'de fark +0,16 dB / −1,1°, ölçüm belirsizliği
     ±0,4 dB / ±2,5°.
   - Faz marjı ölçümle ≈ 53 ± 3°, analitik hesapla 54,2°.
   - 212–1037 Hz aralığında anahtarlamalı model +7…+12° faz önü gösterir; bu fark
     yalnız 212 Hz'de belirsizlik bandının (±10°) sınırına gelir.
   - Faz önünün kaynağı, köprünün sıfır geçişleri çevresindeki süreksiz iletim ve ölü
     zaman davranışıdır. Mekanizma, K-02b'deki dirençli Z_th ile aynıdır. Faz önü marjı
     artırır.
2. **K34 açık ve kapalıyken L aynı.**
   - İki ölçüm arasındaki fark 0,02–0,9 dB ve 1–8°'dir.
   - Fark her noktada iki ölçümün birleşik belirsizliği içinde ya da sınırındadır
     (en büyük aşım 3362,5 Hz'de: 4,2° ↔ ±3,6°).
   - Kalan fark çalışma noktasının değişmesinden gelir: K34 = 0'da I_L1 = 21,9 A,
     açıkken 24,5 A.
   - Ortalama modelde ve SCD'de fark tam sıfırdır.
3. **Sin³'ün etkisi bozucu tarafında kalır ve öngörüyle örtüşür.** K34 açık − kapalı akım
   farkı (80 ms pencere):
   - Temel bileşen: anahtarlamalı model 4,44 A RMS ∠−43,4°, ortalama model 4,51 A ∠−40,7°
     (fark −%1,5; −2,7°).
   - 3. harmonik: anahtarlamalı model 2,32 A ∠110,4°, ortalama model 2,23 A ∠102,9°
     (fark +%3,8; +7,5°).
   - Doğrusal üst üste binme anahtarlamalı modelde de geçerlidir: Sin³ girişinin akıma
     katkısı S(jω)·K_pwm·G·ΔU_ff'dir (`karsilastirma/k34_harmonik_farki.csv`).
4. **Anma akımında 3. harmoniğin kaynağı Sin³ teriminin kendisidir.**
   - 25 A'da I_L1,3 = 2,13 A (K34 açık) ↔ 0,43 A (K34 = 0).
   - THD_I_L1 %9,4 ↔ %5,6 (son periyot, `results/*/metrik.csv`; 20 ms pencerede küçük ton sızıntısı dahil).
   - K34, 2,3 A'daki süreksiz iletim bozulmasına göre kalibre edildi (K-20). 25 A'da bu
     bozulma küçüktür, bu yüzden terim fazla gelir.
   - Çevrim bu terimi |S(j2π·150)| = 0,23 ile bastırır ama sıfırlamaz.
   - Temel bileşende K34 yararlıdır: K34 = 0'da PI genlik hatası −%2,1'den −%12,3'e
     çıkar (ortalama model: +%0,7 → −%9,1).
   - Tez için anlamı: kapalı çevrimde ileri besleme genliği akım düzeyine göre
     ayarlanmalıdır. Bu bir öneridir, uygulanmadı.
5. **Basamak yanıtı (10 → 25 A, t = 55 ms).**

   | Koşu | Zarf aşımı (son tepeye göre) | Yerleşme (hata bandı) | Geçici bileşenin, aynı K34'lü ortalama modelden RMS farkı (ilk 15 ms) |
   |---|---|---|---|
   | Anahtarlamalı, K34 açık (İP-5 `KC_PI_basamak_10_25A`) | %0,17 | 0,43 ms | 0,38 A (basamak tepesinin %1,8'i) |
   | Anahtarlamalı, K34 = 0 (İP-6) | −%0,5 | 0,69 ms | 0,67 A (%3,1) |
   | Ortalama, K34 açık | %0,0 | 0,41 ms | — |
   | Ortalama, K34 = 0 | %1,5 | 0,66 ms | — |

   - Geçici bileşen i_L1(t) − i_L1(t + 20 ms) olarak tanımlanır. Kaynak
     `karsilastirma/basamak_*.csv`, şekil `karsilastirma/kararlilik_basamak_K34`.
   - Anahtarlamalı modelde K34 açık ile kapalı arasındaki geçici bileşen farkı
     0,61 A RMS'dir (%2,9).
   - Dört koşuda da geçici bileşen aynı biçimde yaklaşık 1 ms'de söner. Bu süre 3,1 kHz
     (ζ = 0,18) kutup çiftiyle ve 0,8–3 kHz'lik gerçel kutuplarla uyumludur. Ardından
     66 Hz'lik PI modu gelir (τ = 2,4 ms).
   - **İP-5'teki "aşım %7,3" değeri yeniden tanımlanmalı.** O değer i_L1 tepesinin
     *referans* tepesine (35,36 A) oranıdır. Kararlı durumda da i_L1 tepesi 37,9 A'dır,
     çünkü dalgada Sin³ kaynaklı 3. harmonik vardır. Son kararlı zarfa göre gerçek aşım
     %0,17'dir.
6. **Orta ve düşük akımda kazanç düşer, faz önü artar; kararlılık bozulmaz.**
   - 10 A: 212 Hz'de −1,4 dB / +38°. Birinci geçiş ≈ 573 Hz (PM ≈ 94°), kritik geçişte
     PM ≈ 65°.
   - 2,3 A: köprü süreksiz iletimde akım kaynağına yakın davranır.
     - Bitki P = Y_m/U_x 212–1037 Hz aralığında neredeyse düzdür (22,9 → 20,4 dB) ve fazı
       yalnız −10…−46°'dir. Çevrim tümlev davranışını kaybeder.
     - |L| < 1 (−7…−10 dB) ve faz ≥ −49°: çevrim yavaş ama kararlıdır.
     - 2,3 A'daki küçük izleme hatası (+%1,9), ileri beslemenin bu noktaya kalibre
       olmasından gelir.
   - λ taraması bu gözlemle tutarlıdır: köprü kazancının azalması kararlılığı bozmaz,
     yalnız izleme bant genişliğini düşürür.

## Sınırlılıklar

1. **Doğrusal model ve geçerlilik bölgesi.**
   - Ortalama model sürekli iletimde (≈ 25 A) kritik bölgede ±0,2 dB / ±1° doğrudur
     (Tablo 3).
   - Orta ve düşük akımda köprünün etkin kazancı frekansa bağlı değişir. Ölçülen
     değerler: 10 A'da 212 Hz'de 0,87∠+40°, 2,3 A'da 0,14…0,71∠+56…+84°.
   - Bu bölgede ortalama model, izleme başarımını (bant genişliği, 50 Hz kazancı)
     gerçekte olduğundan iyi gösterir.
   - Kararlılık sonucu ise korunur: ölçülen bütün noktalarda faz, analitik değerden
     önde ya da ona eşittir. λ ∈ (0, 50] aralığının tamamı kararlıdır.
   - Sonuç: İP-5 Bulgu 2'deki 10 A genlik hatası (−%11) bir kararlılık sorunu değildir;
     kazanç ve izleme sorunudur.
2. **Ölçülmeyen noktalar.**
   - 2,3 A'da 2–3,4 kHz bölgesi (küme B) ölçülmedi; koşu bütçesi 10 A'ya ayrıldı.
   - P ve PIR anahtarlamalı modelde ayrıca ölçülmedi. Bitki ölçüldüğü ve denetleyicinin
     doğrusal olduğu doğrulandığı için L_P = Kp·P ve L_PIR = C_PIR·P yazılabilir.
   - PIR'nin PI'dan farkı yalnız 50 Hz çevresindedir (40 Hz'lik yavaş kutup). Ölçüm
     0,2 s koşu gerektireceğinden enjeksiyonla ölçülmedi.
3. **Sayısal gerçekleme (B).**
   - Ts = 100 µs, periyot ortalamalı örnekleme ve 1 Ts hesaplama gecikmesiyle
     P/PI/PIR'nin üçü de kararsızdır: |z| = 1,175–1,179, 2,72 kHz (Tablo 1).
   - Çift güncelleme (Ts = 50 µs) de kararsızdır: |z| = 1,085.
   - Analog eşdeğerin gecikme marjı 44 µs'dir; bunu aşan her gecikme kararsızlık
     getirir (Td taraması: 45 µs kararlı, 50 µs kararsız).
   - Donanımın gerçek denetim kodu ve örnekleme yapısı bilinmiyor (K-19, İ2). Bu yüzden
     tezde S4 analog eşdeğeri olarak sunulur.
   - Sayısal gerçekleme için etkin sönümleme (ör. kapasitör akımı geri beslemesi) ya da
     şebeke akımı geri beslemesi gerekir. Bu, çalışmanın kapsamı dışında bir öneridir.
4. **Gecikme varsayımı.** Td = 2 µs bir üst sınırdır (1 µs denetim adımı + 1 µs görev
   oranı örneklemesi). Td 0–10 µs aralığında PM_min 56,6°'den 44,4°'ye iner; kararlılık
   sonucu değişmez.
5. **L1 doyumu ve DC bara.**
   - L1 doğrusal modellendi (K-19).
   - Ortalama modelde DC bara sabit Vdc4/2'dir; anahtarlamalı modelde D-11'in
     2 × 5,6 mF barası kullanıldı.
   - Özgün 470 µF'lık barada (D-11) 25 A'da kararlı durum yoktur; bu durum burada
     analiz edilmedi.
6. **Ton ölçümünün belirsizliği.**
   - Arka plan, tona komşu ızgara noktalarındaki anahtarlama ve kip dönüşüm
     bileşenlerinden kestirildi.
   - Tonlar 100 Hz dönüşüm ürünlerine dik seçildi. 50 Hz'in tek katlarındaki dönüşümlere
     karşı (küme içinde 1. ve 3. sınıf arasında) diklik yoktur.
   - Bu katkı küçüktür (DC bara orta nokta dalgalanması %5) ve δ belirsizliği içinde
     kalır.
7. **Tez dili (İ5).** Bu sonuçlar benzetim modelinin kendi içindeki kararlılık
   kanıtıdır. Önerilen ifade: "S4 kapalı çevrim modeli, ortalama ve anahtarlamalı
   benzetimde … marjlarıyla kararlıdır." S4 için donanım deneyi yoktur.

## Önerilen kayıtlar

### D-13 (yeni, öneri) — Modellerin CloseFcn'i taban çalışma alanından `C` ve `L`'yi siliyor

- **Dosya / blok:** 12.10 paketindeki üç modelin model CloseFcn'i ve bunlardan türetilen
  bütün kopyalar:
  - modeller: `inverter_scenario1_parametric5_etiquetli`, `inverter_senaryo3`, `inverter_senaryo4`;
  - geri çağrı: `try,close(h1_SolarPowerInverter),end … clear C L efficiency f_pwm …`
    (MathWorks "Solar Power Inverter" örneğinden kalma).
- **Sınıf:** Paket.
- **Sorun ve kanıt:**
  - Model kapatılınca taban çalışma alanındaki `C` (= Cf, 8 µF) ve `L` silinir.
  - İP-6'da S4 modelinden blok kopyalayıp modeli kapattıktan sonra, yeni modelin
    derlemesi "Unrecognized function or variable 'C'" hatası verdi
    (`ortalama_model_kararlilik_20261028.m`, `kur` adımı).
  - Geri çağrının ham pakette de olduğu `blockdiagram.xml` taramasıyla doğrulandı
    (üç dosyada da 4 eşleşme).
- **Tez kapsamındaki doğru durum:** Model kapanışı parametreleri değiştirmemeli. Bu,
  D-03'teki tekrar üretilebilirlik ilkesinin aynısıdır.
- **Düzeltme:** Model değiştirilmez. Betikler, model kapandıktan sonra parametre
  dosyasını yeniden çalıştırır (`taban()` çağrısı).
- **Etki:** Koşu sonuçlarına etkisi yok; koşu betikleri modeli en sonda kapatır.
- **Durum:** düzeltildi (betikte). Tezde yer almaz.

### K-21 (yeni, öneri) — S4 kararlılığının tanımı ve tezde ifadesi

- **Açık nokta:** İP-5 özetlerinde (A) gerçeklemesi için iki farklı marj takımı geçiyordu:
  "fc 585 Hz, PM 74–84°, GM 35 dB" ve "fc 3,4 kHz, PM 54°, GM −30 dB".
- **Karar:**
  - Çok geçişli L için marjlar her kazanç geçişinde ayrı verilir. Kararlılık hükmü
    Nyquist ölçütüne (−1'in solunda negatif gerçel eksenin net kesişimi, P = 0) ve
    kapalı çevrim kutuplarına dayanır.
  - Tezde kullanılacak değerler ((A) analog eşdeğeri, 25 A, PI):
    - kazanç geçişleri 586 / 2454 / 3386 Hz; PM 77,7 / 120,8 / 54,2°;
    - kritik PM 54° (3,4 kHz), GM +35 dB (22 kHz), gecikme marjı 44 µs, ‖S‖∞ = 2,4 dB;
    - en az sönümlü kutup çifti 3,1 kHz, ζ = 0,18.
  - P ve PIR değerleri Tablo 1'den alınır.
  - "GM −30,7 dB @ 2808 Hz" değeri geçersizdir (İP-5 betiğindeki 0° sarma hatası) ve
    kullanılmaz.
  - Sin³ için tezde üç cümle kullanılır:
    1. "K34·sin³θ terimi modülasyon toplamına çevrim dışından eklenen bilinen bir
       işarettir; 1 + L(s) = 0 bu terimi içermez."
    2. "L, S ve T, K34 açık ve kapalıyken aynıdır. Fark ortalama modelde ve Simulink
       Control Design doğrusallaştırmasında sıfır, anahtarlamalı modelde ölçüm
       belirsizliği düzeyindedir."
    3. "Terimin akıma etkisi S(jω)·K_pwm·G(jω) ile belirlenir; 150 Hz bileşeni çevrim
       tarafından |S| = 0,23 oranında bastırılır."
  - Sayısal gerçeklemenin (B) kararsızlığı, K-19 not 1'in sayısal dayanağı olarak aynı
    tabloda verilir.
- **Dayanak:** bu notun Tablo 1–4'ü; `frekans/kararlilik_marjlar.csv`,
  `ortalama/scd_dogrusallastirma.csv`, `karsilastirma/ton_karsilastirma.csv`.
- **Yeniden açılır mı:** Donanımın gerçek denetim kodu ya da örnekleme yapısı gelirse
  (K-19 ile birlikte).

### Ana oturumun kararına bırakılan düzeltmeler

- `review/2026-10-28_S4_KAPALI_CEVRIM.md` Tablo 2 ve D-02 doğrulama metni:
  - şimdiki ifade: "aşım %7,3";
  - önerilen ifade: "son kararlı zarfa göre aşım %0,2; i_L1 tepesi referans tepesinin %7
    üstünde (kararlı durumdaki 3. harmonik nedeniyle)".

  Fark yalnız tanımdan gelir; koşunun yinelenmesi gerekmez.
- K-19 metnine ek: "Analog eşdeğerin gecikme marjı 44 µs. Çift güncelleme (50 µs) de
  kararsızdır (|z| = 1,085)."
- Plan: İP-6 ☑ (jüri maddesi 7).
- `\eksikistek` barları (İP-8/İP-9'da kapatılır):
  - 05:240 ("gerçek parametrelerle kararlılık doğrulaması") bu notla kapanabilir;
  - 05:42'nin "harmonik bağlaşım" kısmı Bulgu 3–4 ile kapanabilir.

## Şekiller (tez için vektör PDF + 300 dpi PNG)

- `frekans/kararlilik_L_bode_K34`: L Bode, P/PI/PIR; K34 açık (çizgi), K34 = 0 (işaretçi)
- `frekans/kararlilik_S_T`: |S| ve |T|; 50 ve 150 Hz işaretli
- `frekans/kararlilik_nyquist_A_B`: (A) ve (B) Nyquist eğrileri, −1 çevresi
- `frekans/kararlilik_kutuplar_A_B`: (A) s-düzlemi, (B) z-düzlemi
- `frekans/kararlilik_Lg_taramasi`: L_g = 0…5 mH, PI
- `karsilastirma/kararlilik_L_olcum_karsilastirma`: analitik L ile ortalama ve anahtarlamalı ölçüm noktaları
- `karsilastirma/kararlilik_basamak_K34`: 10 → 25 A basamağı; K34 açık/kapalı, ortalama/anahtarlamalı

## Koşu bütçesi

- Anahtarlamalı model: 8 koşu.
  - 7 enjeksiyon koşusu (0,11 s) ve 1 basamak koşusu (0,09 s).
  - Duvar süresi koşu başına 25–31 dk; iki paralel kuyrukla toplam ≈ 2 saat.
  - Süre sınırını aşan koşu olmadı.
- Ek olarak 4 ms'lik bir duman testi yapıldı (`results/duman_PI25`); sonuç olarak kullanılmaz.
- Ortalama model koşuları 1–6 s sürdü. SCD doğrusallaştırması 6 durumda yapıldı (3 denetleyici × K34 açık/kapalı).
