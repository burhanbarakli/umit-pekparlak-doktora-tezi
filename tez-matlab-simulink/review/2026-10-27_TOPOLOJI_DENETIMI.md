# 12.10.2026 dört senaryo paketi: topoloji, cihaz eşlemesi ve modülasyon denetimi

Tarih: 27.10.2026 · MATLAB R2023b · bu makine · İP-2 (D-07, K-06a)

## Amaç ve kapsam

12.10 paketindeki üç modelin güç devresi bağlantısı, yarı iletken parametre
eşlemesi ve PWM yapısı tez tanımına (K-03, tam topoloji şeması, 12.10 m-dosyası)
göre denetlendi. Denetim **salt okumadır**: modeller yalnız `load_system` ile açıldı,
benzetim koşturulmadı, hiçbir model kaydedilmedi. Bu notta sayısal benzetim sonucu
yoktur; yalnız yapı ve parametre bağları vardır.

- Girdi: `incoming_real_data/models/2026-10-12_dort_senaryo_paketi/`
  (kopya `runs/2026-10-27_topoloji_denetimi/model/`, SHA-256 ile bayt bayt aynı;
  denetim sonrası kopyaların özetleri değişmedi).
- Betik: `scripts/audit_topology_20261027.m` (proje kökünden
  `run('scripts/audit_topology_20261027.m')`, ~1 dk).
- Çıktılar (`runs/2026-10-27_topoloji_denetimi/`, her model için):
  - `<model>_netlist.txt`: fiziksel düğüm listesi ve blok → düğüm tablosu
  - `<model>_bacak_eslemesi.txt`: otomatik rol çıkarımı (bu notun Tablo 1'i)
  - `<model>_cihaz_eslemesi.csv`: IGBT/diyot → parametre tablosu öneki, sabit sayılar
  - `<model>_simscape_params.csv`: bütün Simscape blok diyalog parametreleri
  - `<model>_signal_graph.txt`: PWM/kapı/ölçüm sinyal grafiği ve Goto/From tablosu
  - `<model>_mdosyasi_kullanim.txt`: m-dosyası değişkenlerinin doğrudan kullanımı
- Ek kaynak: `incoming_real_data/schematics/tam_topoloji_2026-08-22_rendered.png`
  (Proteus `guc_yapi_01`).

## Yöntem

- **Bağlantı grafiği.** Simscape çizgilerinde `SrcPortHandle/DstPortHandle` çoğu kez
  −1 döndüğü için düğümler port → `Line` ve çizgi ağacı (`LineParent/LineChildren`)
  üzerinden birleşim-bul (union-find) ile kuruldu. Alt sistem sınırları Connection
  Port (`Side`, `Port`) eşlemesiyle çözüldü. Sonuç, her Simscape portunun
  `PortConnectivity.DstBlock` kümesiyle çapraz denetlendi: üç modelde **0 uyumsuzluk**.
- **Port sırası.** foundation bileşenlerinde `.ssc` düğüm bildirimlerinden okundu.
  ee bileşenleri (IGBT, diyot, ortak kip bobini) korumalı `.sscp` olduğundan IGBT
  sırası bağlantıyla doğrulandı: her kapı sürücüsünün referans ucu IGBT'nin `R2`
  ucuna (E) gider; 12 ters paralel diyotun (S1+S2: 8, S3: 4; S4 aynı) hepsi A = E, K = C ile tutarlıdır.
- **Rol çıkarımı.** DA− = kaynak eksi ucu; dış alt IGBT = E'si DA−'de olan; dış üst
  = E'si dış alt C'sine bağlı olan; orta nokta = iki DA kapasitörünün ortak ucu;
  nötr IGBT'ler = ortak emetörlü çift; faz düğümü = orta noktaya bağlı olmayan nötr
  IGBT'nin C ucu. Diyotlar (A, K) düğüm çiftine göre sınıflandı.

## Bulgular

### 1. Güç devresi topolojisi

Üç modelde (S1+S2'nin iki devresi, S3, S4) faz kolu aynı yapıdadır ve donanım
şemasıyla örtüşür:

- **Dış kol:** `N-Channel IGBT` (S1) DA+ → dış kol orta düğümü; `N-Channel IGBT1`
  (S2) dış kol orta düğümü → DA−. Bu orta düğüm faz düğümüne seri `Resistor`
  (`Rdc` = 1 mΩ) üzerinden bağlanır. Donanımda bu konumda RL2 rölesi vardır
  (SKM yarım köprü orta noktası → RL2 → faz/L1 düğümü); `Resistor` röle kontak
  direncine karşılık gelir.
- **Nötr kol:** `N-Channel IGBT2` (C = orta nokta) ve `N-Channel IGBT3` (C = faz)
  ortak emetörlü çift yönlü anahtardır. Bu nedenle tezdeki S3 = orta nokta tarafı,
  S4 = faz tarafıdır.
- **Harici diyotlar:** `Diode5` faz → DA+, `Diode3` DA− → faz. Donanımda D1–D2
  (DSEI2X61-12B) tam bu konumdadır: DA+ ile DA− arasında seri, orta uçları
  L1/faz hattına bağlı.
- **DA bara:** `Capacitor` (DA+–orta) ve `Capacitor1` (orta–DA−), `Cdc_pos/neg`
  = 470 µF, ESR `Cdc_esr`. Donanımda C10/C11 470 µF/450 V. Dengeleme dirençleri
  `Resistor1/2` (`R_bleed_1/2` = 220 kΩ). Kaynak tarafında `Voltage Source` →
  `DC Blocking Diode` (DCB_*) → `DC Source R` (`Rdc`) → `Current Sensor` → DA+.
- **AA tarafı (evirici → şebeke):** faz → `Current Sensor1` (i_L1) → `Inductor`
  (L1 = `L1`, `L1r`) ∥ `L1 Core Loss Rp` (`L1_core_Rp`) → `Capacitor2`
  (Cf = `C`, `Cr`) **orta noktaya** → `EMC Common Mode Choke S1` → `Capacitor6`
  (X kapasitörü, hat–dönüş) → `EMC Common Mode Choke S3` → `CL1` (L2 = `L2`,
  `L2r`) → `Grid1` (+ → −) → `AC Current Sensor1` → CMC dönüş sargıları → orta
  nokta. Donanımdaki sıra aynıdır: şebeke → CM1 → X2 ağı → CM2 → C7–C9 (8 µF,
  hat–N) → L1 600 µH → faz kolu; N hattı DA orta noktasına gider.
- **Ortak kip bobinleri:** dört CMC'nin hepsinde 1+ ve 2+ uçları şebeke tarafındadır.
  Diferansiyel akımda iki sargı akısı birbirini götürür; eşdeğer seri endüktans
  m-dosyasındaki `EMC_Ldm_stage = 2(Lw − M) = 4 µH`'dir. Her sargıya paralel
  `EMC_Rcore` vardır. (Varsayım: ee `mutual_inductor` port sırası foundation
  sürümüyle aynıdır, LConn = 1+, 1−; RConn = 2+, 2−.)

**Tablo 1 — T-tipi bacak eşlemesi (S3; S4 bayt bayt aynı; S1+S2'nin A devresi aynı adlar)**

| Blok | Bağlantı | Tez rolü | Beklenen cihaz (tablo) | Modeldeki tablo | Durum |
|---|---|---|---|---|---|
| `N-Channel IGBT` | C = DA+, E = dış orta | S1 dış üst | SKM100GB12T4 (`S12_*`) | `S12_*` | uygun |
| `N-Channel IGBT1` | C = dış orta, E = DA− | S2 dış alt | SKM100GB12T4 (`S12_*`) | `S12_*` | uygun |
| `N-Channel IGBT2` | C = orta nokta, E = ortak | S3 nötr (orta n. tarafı) | IXYN100N65C3H1 (`S34_*`) | `S34_*` | uygun |
| `N-Channel IGBT3` | C = faz, E = ortak | S4 nötr (faz tarafı) | IXYN100N65C3H1 (`S34_*`) | `S34_*` | uygun |
| `Diode9` | A = dış orta, K = DA+ | DS1 (S1 ters paralel) | SKM iç diyot (`DS12_*`) | `DS12_*` | uygun |
| `Diode2` | A = DA−, K = dış orta | DS2 (S2 ters paralel) | SKM iç diyot (`DS12_*`) | `DS12_*` | uygun |
| `Diode6` | A = ortak E, K = orta nokta | DS3 (S3 ters paralel) | IXYN iç FRD (`DS34_*`) | **`D12_*` (DSEI)** | **uyumsuz** |
| `Diode7` | A = ortak E, K = faz | DS4 (S4 ters paralel) | IXYN iç FRD (`DS34_*`) | **`D12_*` (DSEI)** | **uyumsuz** |
| `Diode5` | A = faz, K = DA+ | D1 harici | DSEI2x61-12B (`D12_*`) | **`DS34_*` (IXYN)** | **uyumsuz** |
| `Diode3` | A = DA−, K = faz | D2 harici | DSEI2x61-12B (`D12_*`) | **`DS34_*` (IXYN)** | **uyumsuz** |
| `Resistor` | dış orta – faz | RL2 röle kontağı | — | `Rdc` | değer makul, ad yanlış |

S1+S2'nin B (S2) devresinde karşılıklar: `IGBT4`/`IGBT5` (S1/S2, `S12`),
`IGBT6`/`IGBT7` (S3/S4, `S34`), `Diode12`/`Diode1` (DS1/DS2, `DS12`, uygun),
`Diode10`/`Diode11` (DS3/DS4, **`D12`**), `Diode8`/`Diode4` (D1/D2, **`DS34`**),
seri eleman `Resistor3`. Tam liste: `*_bacak_eslemesi.txt`.

**IGBT'ler:** 12 IGBT'nin tamamında (S1+S2: 8, S3: 4; S4 aynı) etkin parametreler (`Tj_vec1`, `Ic_vec1`,
`Vce_mat1`, `Rmiller`, `Goff`, `t_on/t_rise/t_off/t_fall`, `v_meas`,
`Tj_vec_loss`, `Ic_vec_loss`, `E_turn_on_mat1`, `E_turn_off_mat1`) doğru tabloya
bağlıdır. Ağustos incelemesindeki "veri sayfası parametreli ama bağlantısız IGBT"
sorunu 12.10 modellerinde **yoktur**: sarkık (devreye bağlı olmayan) IGBT ya da diyot
bulunmadı.

**Diyotlar:** her diyot kendi içinde tutarlıdır (bütün parametreleri tek önekten
gelir). Sorun yalnız iki grubun **konumlarının yer değiştirmesidir**: DSEI
(`D12_*`) nötr IGBT'lerin ters paralel diyotlarına, IXYN iç FRD'si (`DS34_*`) faz–ray
harici diyotlarına atanmıştır. Bu, m-dosyasının kendi başlıklarıyla çelişir
("HARICI D1-D2 DIYOTLARI" = DSEI; "S3-S4 PARALEL DIYOTLARI (DS3-DS4)" = IXYN FRD).
Şemayla da çelişir: D1–D2 DSEI faz–ray konumundadır, IXYN sembolleri iç diyotludur.
Gerilim sınıfı da aynı sonucu verir. Faz–ray diyotları tam Vdc'yi keser (1200 V DSEI).
Nötr kol diyotları en çok Vdc/2'yi keser (650 V IXYN). 16.08 `Inverter2` modelinde
de `Diode6/7` nötr kol ters paralel konumundadır (bu oturumda PortConnectivity ile
denetlendi). Bu yüzden tezin Bölüm 3 Tablo `tab:yariiletken-esleme` içindeki
"D1–D2 = Diode6, Diode7" satırı da yanlıştır.

### 2. Değerler ve sabit kodlanmış parametreler

Bütün pasif ve kaynak değerleri m-dosyası değişkenlerine bağlıdır:

| Eleman | Blok parametresi | m-dosyası |
|---|---|---|
| L1 | `Inductor.l/r` | `L1` = 600 µH, `L1r` = 0,03 Ω |
| L1 çekirdek kaybı | `L1 Core Loss Rp.R` | `L1_core_Rp` = 600 Ω |
| Cf | `Capacitor2.c/r` | `C` = 8 µF, `Cr` = 0,01 Ω |
| L2 | `CL1.l/r` | `L2` = 1000 µH, `L2r` = 0,01 Ω |
| CMC | `L1, L2, k, r` | `EMC_Lw` = 400 µH, `EMC_k` = 0,995, `EMC_Rw` |
| CMC çekirdek | `EMC Core Loss R*.R` | `EMC_Rcore` = 100 kΩ |
| X kapasitörü | `Capacitor6.c/r` | **`C_emc_aux` = 1 µF, `R_emc_aux` = 0,01 Ω** |
| DA bara | `Capacitor`, `Capacitor1` | `Cdc_pos/neg` = 470 µF, `Cdc_esr` |
| DA kaynak | `Voltage Source.dc_voltage` | `Vdc1` / `Vdc2` / `Vdc3` |
| Şebeke | `Grid*.amp/frequency` | `Vac*_peak`, `f_grid` |

S1+S2'nin iki devresi blok blok karşılaştırıldı. Bütün parametreler aynıdır; yalnız
`Vdc1`↔`Vdc2` ve `Vac1_peak`↔`Vac2_peak` farklıdır. S3'ün güç katı da S1'in A
devresiyle aynıdır (`Vdc3`, `Vac3_peak` dışında).

Sabit sayı girilmiş (değişkene bağlı olmayan) etkin parametreler. Hepsi m-dosyasındaki
karşılığıyla sayısal olarak aynıdır, bu yüzden sonucu etkilemez; yalnız
izlenebilirliği bozar:

- IGBT `Vth = 6` (m-dosyası `S12/S34_Vge_threshold` = 6, kullanılmıyor).
- IGBT ısıl ağ parametreleri: `thermal_network_parameterization`,
  `Rth = [0, 10]`, `thermal_mass = [0, 1]`, `thermal_time_constant = [0, 10]`,
  `thermal_mass_initial_temperatures = [25, 25]` (m-dosyası `S12_*`/`S34_*`
  ısıl değişkenleri, kullanılmıyor).
- Diyot `Tdevice = 25` (`*_Tdevice`). Sıcaklık modeli kapalı, değer etkisiz.
- `Resistor`/`Resistor3` röle kontağı için `Rdc` değişkenini kullanıyor
  (anlam: "DC kaynak bağlantı direnci").
- Kapı sürücüsü girişinde `Gain = 5` (mantık 1 → 5 V).

Model dışı kalan donanım öğeleri (D kaydı gerektirmez, K-09 tablosunda not):
SKM modülü üzerindeki 4 µF C12 snubber, Y kapasitörü C6 (26 nF, PE yolu bilinçli
olarak modellenmemiş) ve CM1'in 460 µH değeri (modelde iki CMC de 400 µH; DK
eşdeğerinde 4,6 µH yerine 4 µH, etkisi ihmal edilebilir). `DC Blocking Diode`
donanımda yoktur; laboratuvar kaynağının akım çekememesini temsil eden bir
modelleme öğesidir.

Doğrudan kullanılmayan m-dosyası değişkenleri: `*_mdosyasi_kullanim.txt`. Bunların
arasında D-05 listesi (`Kp`, `K12`, `phase_deg2`, `L1_core_Rp4`), `K14`, `K34`,
`phase_deg4` ve `EMC_Cx_eq/EMC_Rx_eq` de vardır. `sim_*` değişkenleri model
yapılandırmasında kullanılır, blok diyaloğunda görünmez.

### 3. Ölçüm noktaları

| Etiket | Sensör | Konum | Kullanım |
|---|---|---|---|
| `i_ac1` / `i_ac2` | `AC Current Sensor1/2` | **Şebeke tarafı, dönüş iletkeninde:** `Grid−` ucu → (+) sensör (−) → şebeke tarafı CMC dönüş sargısı | AC RMS, THD, `Power Measurement`, `Power3`, cosφ, verim |
| `v_ac1` / `v_ac2` | `AC Voltage Sensor1/3` | L2'nin (`CL1`) evirici ucu – `Grid−`; EMC çıkışındaki uç gerilimi | aynı bloklar |
| `v_inv1` / `v_inv2` | `AC Voltage Sensor2/4` | faz düğümü – DA orta noktası (kutup gerilimi) | yalnız Scope |
| `i_dc1` / `i_dc2` | `Current Sensor` / `Current Sensor2` | `DC Source R` → DA+ | P_dc, verim |
| — | `Current Sensor1` / `Current Sensor3` | faz → L1 (**i_L1**) | yalnız Scope; denetimde kullanılmıyor |

- `i_ac` **L1 tarafında değil**, şebeke tarafında ölçülür. Ölçülen akım Cf ve X
  kapasitörünün akımını da içerir, yani şebeke akımıdır (i_g = i_L2). Akım
  ölçüm noktasına kadar bütün şönt elemanlardan geçmiştir.
- **İşaret kuralı (İP-3/D-06 için).** Sensörün pozitif yönü `Grid−` → evirici dönüşüdür.
  Bu yön, evirici fazından çıkıp şebekenin + ucuna giren akıma eşittir; yani
  **üretici (evirici → şebeke) kuralı** geçerlidir. P > 0, şebekeye verilen güçtür.
  Q > 0, akımın uç gerilimine göre geride olduğu ve evirici + filtrenin şebekeye
  reaktif güç verdiği durumdur. Cf ve X kapasitörü bu kuralda pozitif Q üretir.
  Benzetimdeki +33…+35 var bununla tutarlıdır.
- S4 akım denetimi (D-02) için gereken L1 akımı `Current Sensor1`'de zaten ölçülür.
  `PS-Simulink Converter3` → `Scope8` yolundan alınabilir.

### 4. Modülasyon

**Ortak PWM yapısı.** Sinüs referansı `Sine Wave*` bloğundan gelir:
genlik `pwm_ref_amp` = 1, frekans `2*pi*f_grid`, faz `phase_deg*·pi/180`,
örnekleme `pwm_ref_Ts` = 1 µs. PWM alt sisteminde iki `Switch` (u ≥ 0) referansı
yarım periyotlara ayırır. Pozitif yarıda görev oranı d = u, negatif yarıda
d = −u'dur (`Gain11` = −1). `PWM Generator (DC-DC)` (SPS) d'yi 0→1 testere dişi
taşıyıcıyla karşılaştırır: çıkış, d ≥ taşıyıcı ve d ≠ 0 olduğunda 1'dir.
Taşıyıcı frekansı `fsw` = 10 kHz, d girişi `1/fsw/100` = 1 µs ile örneklenir.
Vdc normalizasyonu yoktur.

**Ölü zaman.** Dört kapı komutunun her birinde `On Delay` bloğu vardır
(spsOnDelayLib, DelayType = On delay, `delay = deadtime` = 1 µs, sürekli). Yalnız
yükselen kenar geciktirilir. Kapı sürücüsü (ee Gate Driver) parametreleri:
`Vgate_on/off` = +15/−5 V, `RG_total` = 15 Ω, `gate_driver_rise/fall` = 20 ns,
mantık eşikleri 0,7/0,3. Dış anahtar sürücülerinde giriş PS, nötr anahtar
sürücülerinde elektriksel girişlidir (5 V).

**Kapı etiketi eşlemesi** (her iki devrede ve S3'te aynı; Y = senaryo numarası):
`g1Y` → S1 (dış üst), `g2Y` → S2 (dış alt), **`g3Y` → S4 (faz tarafı nötr)**,
**`g4Y` → S3 (orta nokta tarafı nötr)**. D-01 onarımında S3 PWM alt sisteminin
`Out1…Out4` çıkışları sırasıyla `g12, g22, g32, g42`'ye bağlanmalıdır. Bu sıra,
A devresindeki `g11…g41` eşlemesiyle birebir aynıdır.

**Senaryo 1, klasik tamamlayıcı (`inverter_scenario1_parametric5_etiquetli/Subsystem`).**
Giriş `u = K11·sin(θ + phase_deg1)`; `Gain K11` = 0,7865, `phase_deg1` = −0,44°.
S1 = PWM(u⁺), S2 = PWM(u⁻). S4 = NOT(PWM₁₀), S3 = NOT(PWM₁₁): `Logic NOT`
blokları PWM çıkışlarının tümleyenini alır, ardından On Delay gelir.

| Yarım periyot | Durum | S1 | S2 | S3 (orta n.) | S4 (faz) | v_xN |
|---|---|---|---|---|---|---|
| u ≥ 0 | P (PWM = 1) | 1 | 0 | 1 | 0 | +Vdc/2 |
| u ≥ 0 | O (PWM = 0) | 0 | 0 | 1 | **1** | 0 |
| u < 0 | N (PWM = 1) | 0 | 1 | 0 | 1 | −Vdc/2 |
| u < 0 | O (PWM = 0) | 0 | 0 | **1** | 1 | 0 |

Bu tablo tezdeki `tab:t-tipi-durumlar` tablosuyla (Q1…Q4 = S1…S4) birebir aynıdır.
Model "yarım periyot etkinleştirme" gösterimini kullanır: P'de S3 = 1, N'de S4 = 1.
O durumunda karşı nötr anahtar (pozitif yarıda S4, negatif yarıda S3) tamamlayıcı
iletimdedir. Ters akım (senkron buck) yolu buradan açılır.

**Senaryo 3, susturma + Sin³ (`inverter_senaryo3/Subsystem2`).**
S1 = PWM(u⁺) ve S2 = PWM(u⁻) aynıdır. Nötr kapılar PWM'den bağımsız sabit
değerlerdir:
`Switch4` (u ≥ 0 → `Constant5` = 1, değilse `Constant6` = 0) → `g43` → S3;
`Switch3` (u ≥ 0 → `Constant3` = 0, değilse `Constant4` = 1) → `g33` → S4.

| Yarım periyot | Durum | S1 | S2 | S3 | S4 |
|---|---|---|---|---|---|
| u ≥ 0 | P | 1 | 0 | 1 | 0 |
| u ≥ 0 | O | 0 | 0 | 1 | **0** |
| u < 0 | N | 0 | 1 | 0 | 1 |
| u < 0 | O | 0 | 0 | **0** | 1 |

Nötr IGBT'ler alternans boyunca 1/0'dır; tamamlayıcı iletim iptal edilmiştir.
Bu, K-03'teki susturma tanımıyla uyumludur. O durumunda yalnız yük akımı yönündeki
yol açıktır (pozitif yarıda orta nokta → S3 → DS4 → faz). Ters akım nötr koldan
dönemez; harici diyotlar ve dış ters paralel diyotlar üzerinden DA rayına gider.

**Sin³ terimi (K-06a için kesin biçim).** Blok yolu:

```
inverter_senaryo3/Sine Wave3  (Amplitude=pwm_ref_amp, Frequency=2*pi*f_grid,
                               Phase=phase_deg3*pi/180, SampleTime=pwm_ref_Ts)
  ├─ K1        Gain = K13                          → K13·sin θ
  └─ Product15 (u·u) → Product1 (·u) → K3 Gain = K33 → K33·sin³ θ
Sum (Inputs = |++)  →  Subsystem2/In1  (görev oranı u; Switch/PWM girişi)
```

- Biçim **K33·sin³θ**'dir (aynı birim genlikli sinüsün küpü). `sin(3θ)` bloğu yoktur.
- İşaret pozitiftir (`|++`). `K33` = 0,39, `K13` = 0,45, `phase_deg3` = 0.
- Ayrı normalizasyon yoktur. Toplam doğrudan PWM görev oranı girişidir. Akım
  denetleyicisi ya da geri besleme yolu yoktur, yani terim açık çevrim ileri
  besleme olarak eklenir.
- Özdeşlikle m(θ) = (K13 + 3K33/4)·sin θ − (K33/4)·sin 3θ
  = 0,7425·sin θ − 0,0975·sin 3θ. Üçüncü harmonik/temel = −%13,1. Tepe değer
  θ = 90°'de K13 + K33 = 0,84 (aşırı modülasyon yok).
- sin³θ, sin θ ile aynı işaretlidir. Bu yüzden u ≥ 0 yarım periyot ayrımı ek sıfır
  geçişi üretmez.
- Kullanım yerleri: `K11` S1 PWM girişinde, `phase_deg1` `Sine Wave1`'de, `K13`/`K33`
  S3 toplamında, `phase_deg3` `Sine Wave3`'te. `K12`, `K14`, `K34`,
  `phase_deg2`, `phase_deg4` ve `Kp` hiçbir blokta yoktur (D-05, D-01, D-02).

### 5. S1+S2 modelinde iki devrenin özdeşliği

İki devre rol bazında özdeştir: aynı bacak yapısı, aynı LCL/EMC dizilimi, aynı
sensör konumları, aynı CMC nokta yönü ve aynı kapı sürücüsü tipleri. Her devrenin
kendi `Electrical Reference` bloğu vardır ve devreler elektriksel olarak ayrıdır.
Parametreler `Vdc`/`Vac` dışında bloğu bloğuna aynıdır. D-01 dışındaki tek ortak
kusur D-08'dir; o da iki devrede aynı biçimde vardır. S2 devresinin ölçüm zinciri
(`i_ac2`, `v_ac2`, `Power1`, `Power Measurement1`) A devresinin kopyasıdır.

## Uyumsuzluklar ve D-xx önerileri

Numaralar öneridir; ana oturum `02_MODEL_DUZELTME_KAYDI.md` dosyasına işlerken
diğer ajanların kayıtlarıyla çakışırsa kaydırılabilir.

**D-07: kapanış önerisi.** IGBT eşlemesi 12/12 uygundur ve sarkık blok yoktur.
Diyot eşlemesi D-08'e devredilir. Durum: "denetlendi; IGBT uygun, diyot → D-08".

**D-08: harici diyotlarla nötr kol ters paralel diyotlarının parametreleri yer değiştirmiş**

- *Sınıf:* Topoloji / cihaz eşlemesi.
- *Sorun ve kanıt:*
  - S1+S2 A devresi, S3 ve S4'te `Diode5` (faz→DA+) ile `Diode3` (DA−→faz)
    `DS34_*` (IXYN FRD) kullanıyor; `Diode6`/`Diode7` (S3/S4 ters paralel)
    `D12_*` (DSEI) kullanıyor.
  - S2 devresinde aynı durum `Diode8`/`Diode4` ve `Diode10`/`Diode11` için geçerli.
  - Kanıt: `runs/2026-10-27_topoloji_denetimi/*_bacak_eslemesi.txt`, `*_cihaz_eslemesi.csv`.
  - Ayrıca tam topoloji şeması (D1/D2 DSEI2X61-12B faz–ray konumunda), m-dosyası
    başlıkları ve cihaz gerilim sınıfları.
- *Tez kapsamındaki doğru durum:* D1–D2 (harici, faz–ray) = DSEI2x61-12B
  (`D12_*`); DS3–DS4 (nötr IGBT ters paralel) = IXYN iç FRD (`DS34_*`). Dayanak:
  İ1, D-07 tanımı, şema.
- *En küçük düzeltme:* yalnız diyot parametre öneklerini takas etmek.
  - `Diode3`, `Diode5`, `Diode4`, `Diode8`: `DS34_` → `D12_`
  - `Diode6`, `Diode7`, `Diode10`, `Diode11`: `D12_` → `DS34_`
  - 17 parametre: `ModelType, Vf, Ron, Goff, C_param, CJ, Q_param, iRM, iF, didt,
    trr, Qrr, Vr, Ls, T_param, fidelity_level, thermal_network_parameterization,
    junction_thermal_mass`.
  - Bağlantıya dokunulmaz. Önerilen betik: `scripts/fix_diode_mapping_20261027.m`,
    `runs/<tarih>/model/` kopyasında `set_param`.
- *Etki (beklenen, ölçülmedi):* sıfır durumunun serbest dolaşım akımı her
  senaryoda DS3/DS4 üzerinden akar. Bu diyotların Qrr değeri (DSEI ≈ 3 µC, IXYN
  ≈ 9,5 µC) S1/S2'nin açılma kaybını, Vf/Ron değeri (1,58 V/8,5 mΩ ↔ 1,70 V/6 mΩ)
  iletim kaybını belirler. Verim ve P_dc değişeceği için **İP-4 kalibrasyonundan
  önce uygulanmalıdır.** İP-1 (D-01) koşusu bu düzeltme olmadan yapıldıysa S2
  sayıları da yeniden koşulmalıdır.
- *Tez metni:* Bölüm 3 `tab:yariiletken-esleme` satırı ("D1–D2 … Diode6, Diode7")
  İP-8'de düzeltilmelidir.

**D-09: X kapasitörü tek faz eşdeğeri m-dosyasının kendi tanımına uymuyor**

- *Sınıf:* Parametre.
- *Sorun ve kanıt:* `Capacitor6`/`Capacitor7` (iki CMC kademesi arasındaki
  hat–dönüş kapasitörü) `C_emc_aux` = 1 µF ve `R_emc_aux` = 0,01 Ω kullanıyor.
  m-dosyasının EMC bölümü X2 ağını "iki adet 1 µF/0,1 Ω seri kol, yüzer orta nokta"
  diye tanımlıyor ve tek faz eşdeğerini `EMC_Cx_eq` = 0,5 µF, `EMC_Rx_eq` = 0,2 Ω
  olarak hesaplıyor. Ancak bu iki değişken hiçbir blokta kullanılmıyor. Şemada her
  hat 1 µF X2 ile yüzer yıldız noktasına bağlı (C2–C5).
- *Doğru durum (K-17 önerisi):* tek faz diferansiyel modelde X ağı
  `EMC_Cx_eq`/`EMC_Rx_eq` ile temsil edilir. Dayanak: İ1 (m-dosyası EMC yorumu) ve şema.
- *En küçük düzeltme:* `Capacitor6`/`Capacitor7`: `c = EMC_Cx_eq`, `r = EMC_Rx_eq`.
- *Etki (hesap):* kapasitör şebeke tarafı sensörünün önünde olduğundan ölçülen Q'ya
  doğrudan girer. ΔQ ≈ −V²ω·0,5 µF ≈ −2,3 var (119,8 V) / −2,4 var (124,3 V).
  P'ye etkisi ihmal edilebilir. Düşük öncelikli; D-06/İP-3 işaret
  karşılaştırmasından önce karar verilmeli.

**D-10: izlenebilirlik, sabit kodlanmış eşdeğer değerler (sayısal etkisiz)**

- *Sınıf:* Parametre.
- *Sorun:* IGBT `Vth = 6` ve ısıl ağ dizileri literal yazılmış; m-dosyasının
  `S12/S34_Vge_threshold` ve `S12/S34_thermal_*` değişkenleri kullanılmıyor.
  Diyot `Tdevice = 25` da literal. Röle kontak direnci `Rdc` değişkenini paylaşıyor.
- *Düzeltme:* `set_param` ile ilgili değişkenlere bağlamak. Röle için K-09
  tablosunda "`Rdc` = 1 mΩ, DA bağlantısı ve RL2 kontağı" notu ya da kopya
  m-dosyasında `R_relay`. Değerler aynı kaldığından sonuç değişmez.
- *Öncelik:* düşük (İP-7 parametre tablosunun tek kaynaklı olması için).

## Doğrulanamayan / varsayıma dayanan noktalar

1. **CMC nokta yönü** ee `mutual_inductor` port sırasının (1+, 1− sol; 2+, 2− sağ)
   foundation sürümüyle aynı olduğu varsayımına dayanır; ee kaynağı korumalıdır.
   Ters olsaydı DK endüktansı kademe başına 4 µH yerine ~1,6 mH olurdu. Küçük bir
   AC tarama koşusuyla doğrulanabilir; bu denetimde yapılmadı.
2. **Diyot A/K sırası** (LConn1 = A, RConn1 = K) korumalı bileşenden okunamadı.
   12/12 ters paralel diyotun A = E, K = C ile tutarlı olması güçlü dolaylı kanıttır.
3. **Etkin IGBT parametre kümesi.** "Event-based, thermal port" varyantında
   `Tj_vec1`/`Vce_mat1` tablolarının etkin, `Vce_vec1`'in (literal) etkisiz olduğu
   blok sürümünden çıkarıldı. Derleme (`SimulationCommand update`) yapılmadı.
4. D-08 ve D-09'un sayısal etkisi koşu yapılmadığı için ölçülmedi.
5. Donanım şemasındaki nötr IXYN çiftinin emetör ortaklığı (ortak emetör mi ortak
   kolektör mü) şema çiziminden kesin okunamadı. Model ortak emetörlüdür; tezin
   işlevsel tanımı açısından fark yaratmaz.

## Sonuç ve sonraki adım

- İP-2: denetim tamamlandı. D-07 kapanabilir (IGBT uygun); yeni öneriler D-08
  (yüksek öncelik), D-09, D-10.
- K-06a önerisi: **Sin³ terimi modelde K33·sin³θ (gerçek küp), pozitif, normalizasyonsuz;
  görev oranı toplamına açık çevrim ileri besleme olarak eklenir.**
  m = 0,7425·sin θ − 0,0975·sin 3θ.
- Tez metni (İP-8):
  - `tab:t-tipi-durumlar` gösterimi modelle doğrulandı (yarım periyot etkinleştirme).
  - `tab:yariiletken-esleme` D1–D2 satırı düzeltilmeli.
  - Bölüm 3'teki L2 = 200 µH ifadesi 12.10 değeri 1000 µH (İ1) ile güncellenmeli.
- İP-1/İP-4 sırası: D-08 düzeltmesi D-01 onarımıyla aynı kopya modele uygulanmalı,
  kalibrasyon ondan sonra yapılmalıdır.
