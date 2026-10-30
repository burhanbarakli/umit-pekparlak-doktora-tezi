# Ümit Pekparlak — Doktora Tezi Çalışma Deposu

**Enerji depolama sistemleri için geliştirilmiş T-tipi dönüştürücü mimarisi ve düşük
güç performansını iyileştiren anahtarlama ve Sin³ tabanlı kompanzasyon yöntemleri**
(Sakarya Üniversitesi Fen Bilimleri Enstitüsü, doktora tezi).

Depo; tezin LaTeX kaynağını, MATLAB/Simulink benzetim modellerini ve koşu kayıtlarını,
tamamlama planını ve karar kayıtlarını bir arada tutar.

## Hızlı bağlantılar

| | Belge | Not |
|---|---|---|
| 📕 | **[Son tez, teslim sürümü (PDF)](https://github.com/burhanbarakli/umit-pekparlak-doktora-tezi/releases/download/tez-2026-10-29/tez_guncel_2026-10-29.pdf)** | 29.10.2026 · 226 sayfa · not kutuları kapalı |
| 📘 | [Son tez, notlu sürüm (PDF)](https://github.com/burhanbarakli/umit-pekparlak-doktora-tezi/releases/download/tez-2026-10-29/tez_guncel_2026-10-29_notlu.pdf) | 230 sayfa · mavi "ÜMİT ABİ İÇİN NOT" kutuları açık |
| 📄 | [İlk tez (Word)](https://github.com/burhanbarakli/umit-pekparlak-doktora-tezi/releases/download/tez-2026-10-29/ilk_tez_tez_tumu_8.docx) | Jüriye sunulan önceki sürüm, `tez_tumu_8.docx` |
| 🏷️ | [Bütün sürümler (Releases)](https://github.com/burhanbarakli/umit-pekparlak-doktora-tezi/releases) | PDF'ler depo geçmişini şişirmesin diye sürüm eki olarak tutulur |
| ✍️ | [Tez kaynağı: `tez-latex-v2/`](tez-latex-v2/) | Ana yazım hattı |
| 🔁 | [İlk tez ↔ son tez karşılaştırması](tez-tamamlama/03_ILK_TEZ_YENI_TEZ_KARSILASTIRMA.md) | Bölüm bölüm ne değişti |
| 🖼️ | [Şekil ve tablo eşlemesi](tez-tamamlama/05_SEKIL_TABLO_ESLEME.md) | İlk tezde olup son tezde olmayanlar ve tersi |
| ✅ | [Tamamlama planı (İP-0 … İP-14)](tez-tamamlama/00_TAMAMLAMA_PLANI.md) | İş paketleri, jüri maddesi → kanıt |
| ⚖️ | [Karar defteri (K-xx)](tez-tamamlama/01_KARAR_DEFTERI.md) · [Model düzeltme kaydı (D-xx)](tez-tamamlama/02_MODEL_DUZELTME_KAYDI.md) | Açık noktaların kapanışı |
| 🧭 | [Yapı hakem raporu (İP-14)](tez-tamamlama/04_YAPI_HAKEM_RAPORU.md) | Bölüm akışı ve hacim önerileri; karar bekliyor |
| 🧪 | [Benzetim deposu: `tez-matlab-simulink/`](tez-matlab-simulink/) | Modeller, betikler, koşular, review notları |
| 🏠 | [`ANA_SAYFA_TEZ_CALISMA_MERKEZI.html`](ANA_SAYFA_TEZ_CALISMA_MERKEZI.html) | Yerel çalışma merkezi (indirip tarayıcıda açın) |

## Klasör yapısı

```text
.
├── tez-latex-v2/            Son tez (temiz yazım hattı, 01.09.2026'dan beri)
│   ├── main.tex             Notlu sürüm  → build.cmd        → build/main.pdf
│   ├── main_notsuz.tex      Teslim sürümü → build_notsuz.cmd → build_notsuz/main_notsuz.pdf
│   ├── chapters/            Bölüm 1-8
│   ├── frontmatter/ backmatter/ config/ references/
│   └── figures/             TikZ ve MATLAB vektör şekiller (+ üreten betikler)
├── tez-latex/               Etiketli çalışma kopyası; şekil deposu (v2 buradan okur)
├── tez-matlab-simulink/     Sayısal kanıt
│   ├── incoming_real_data/  Ümit'ten gelen modeller, parametreler, veri sayfaları
│   │   └── models/2026-10-12_dort_senaryo_paketi/   S1+S2, S3, S4 modelleri (README)
│   ├── runs/<tarih>_<konu>/ Her koşu: model kopyası, sonuç CSV/PDF, README
│   ├── scripts/             build_*, run_*, calibrate_*, analiz betikleri
│   ├── review/              Tarihli koşu kayıtları (kanıt döngüsü)
│   ├── results/             Ağustos 2026 ve öncesi deneme sonuçları
│   └── models/ parameters/  Eğitim/demo modelleri (DENEME parametreli)
├── tez-tamamlama/           Plan, karar defteri, düzeltme kaydı, karşılaştırmalar
├── dosyalar/                Ham kaynak deposu (yalnız .md dizinleri + tezin okuduğu Senaryo ekranları git'te)
├── jüri istekleri/          Jüri yorumları
├── tez-word/                Word çalışma kopyası
└── .claude/agents/          tez-beyin (alan uzmanı) ve tez-hakem (yapı hakemi) ajan tanımları
```

## Senaryolar

| Senaryo | Yöntem | Tezdeki yeri | Model ve parametreler |
|---|---|---|---|
| **S1** | Komplement (klasik) anahtarlama | Bölüm 4 | `inverter_s1_kal.slx` · Vdc 431,5 V · Vac 119,8 V · K11 = 0,7865 |
| **S2** | Nötr anahtar susturma | Bölüm 4 | `inverter_s2_kal.slx` · Vdc 395,0 V · Vac 121,0 V · K12 = 0,7680 |
| **S3** | Susturma + Sin³ ileri besleme | Bölüm 5 | `inverter_senaryo3_kal.slx` · Vdc 427,5 V · Vac 124,3 V · K13 = 0,4434, K33 = 0,3843 |
| **S4** | S3 + L1 akım geri beslemesi (PI) | Bölüm 5 | `inverter_senaryo4_kc.slx` · 25 A RMS · Kp = 0,03, Ki = 11,31 · DA bara 2 × 5,6 mF |

Ortak devre: L1 = 600 µH, Cf = 8 µF, L2 = 1000 µH, fs = 10 kHz, ölü zaman 1 µs.

- **Bütün parametreler (senaryo bazında, paket ve kalibre değerler):**
  [`incoming_real_data/models/2026-10-12_dort_senaryo_paketi/README.md`](tez-matlab-simulink/incoming_real_data/models/2026-10-12_dort_senaryo_paketi/README.md)
- **Tezin dayandığı son model seti (dört senaryo bir arada):**
  [`runs/2026-10-28_parametre_tablosu/model/tez/`](tez-matlab-simulink/runs/2026-10-28_parametre_tablosu/model/tez/)
- **Koşu klasörleri** (her birinde README: amaç, model, parametre, komut, çıktı):

| Koşu | İş paketi | Ne yapar |
|---|---|---|
| [`2026-10-27_dort_senaryo_ilk_kosu`](tez-matlab-simulink/runs/2026-10-27_dort_senaryo_ilk_kosu/) | İP-0 | Paket değiştirilmeden koşturuldu, hedeflerle karşılaştırıldı |
| [`2026-10-27_s2_kapi_onarimi`](tez-matlab-simulink/runs/2026-10-27_s2_kapi_onarimi/) | İP-1 | S2 kapı yolu onarımı (D-01) |
| [`2026-10-27_topoloji_denetimi`](tez-matlab-simulink/runs/2026-10-27_topoloji_denetimi/) | İP-2 | Cihaz ve bağlantı denetimi (D-07) |
| [`2026-10-27_diyot_esleme`](tez-matlab-simulink/runs/2026-10-27_diyot_esleme/) | İP-2b | Diyot parametre takası düzeltmesi (D-08) |
| [`2026-10-27_q_isaret_dalga`](tez-matlab-simulink/runs/2026-10-27_q_isaret_dalga/) | İP-3 | Reaktif güç işaretinin dalga biçiminden belirlenmesi |
| [`2026-10-28_kalibrasyon`](tez-matlab-simulink/runs/2026-10-28_kalibrasyon/) | İP-4 | S1–S3 kazanç/faz kalibrasyonu |
| [`2026-10-28_s4_kapali_cevrim`](tez-matlab-simulink/runs/2026-10-28_s4_kapali_cevrim/) | İP-5 | S4 kapalı çevrim: P/PI, 2,3 / 10 / 25 A |
| [`2026-10-28_kararlilik`](tez-matlab-simulink/runs/2026-10-28_kararlilik/) | İP-6 | Bode, kazanç/faz marjı, L_g duyarlılığı |
| [`2026-10-28_parametre_tablosu`](tez-matlab-simulink/runs/2026-10-28_parametre_tablosu/) | İP-7 | Tek parametre tablosu envanteri |
| [`2026-10-29_tez_sekilleri`](tez-matlab-simulink/runs/2026-10-29_tez_sekilleri/) | İP-11 | Kalibre S1/S2/S3 yeniden koşusu, tez şekilleri |

- **Ümit'in kalibrasyon öncesi ekran kayıtları:**
  [`Senaryo_1`](dosyalar/05_sonradan_gelenler/Senaryo_1/) ·
  [`Senaryo_2`](dosyalar/05_sonradan_gelenler/Senaryo_2/) ·
  [`Senaryo_3`](dosyalar/05_sonradan_gelenler/Senaryo_3/)

## Nasıl çalıştırılır

### Gereksinimler

| Araç | Sürüm | Not |
|---|---|---|
| Tectonic | 0.17.0 | LaTeX derleyici; `%USERPROFILE%\.local\bin\tectonic.exe`. MiKTeX/TeX Live gerekmez; paketler ilk derlemede indirilir |
| MATLAB | R2023b | Simulink, Simscape Electrical (Specialized Power Systems dahil), Control System Toolbox, Simulink Control Design, Signal Processing |
| Python | 3.x | Yalnız yardımcı betikler (`scripts/*.py`) |

Depo yolunda boşluk ve Türkçe karakter olabilir; PowerShell'de yolu çift tırnakla yazın.

### Tezi derlemek

```powershell
cd tez-latex-v2
.\build.cmd            # notlu sürüm  → build\main.pdf
.\build_notsuz.cmd     # teslim sürümü → build_notsuz\main_notsuz.pdf
```

- Süre 2–4 dakikadır.
- Denetim: `build\main.log` içinde `Output written` satırı bulunmalı.
  `Select-String "Undefined" build\main.log` boş dönmeli. Underfull uyarıları normaldir.
- `tez-latex-v2`, şekilleri `../tez-latex/figures/`, Senaryo ekranlarını `../dosyalar/05_sonradan_gelenler/`
  ve MATLAB çıktılarını `../tez-matlab-simulink/` altından göreli yolla okur. Klasör tek başına
  taşınamaz; deponun tamamı gerekir.

### Benzetimleri koşturmak

Bütün betikler `tez-matlab-simulink/` kökünden çağrılır; `scripts/` içine `cd` edilmez.
`matlab` PATH'te değilse tam yolu yazın:

```powershell
$M = "C:\Program Files\MATLAB\R2023b\bin\matlab.exe"
$K = "<depo yolu>\tez-matlab-simulink"
```

| Amaç | Komut (`& $M -sd $K -batch "..."`) | Süre |
|---|---|---|
| Duman testi | `run('scripts/evaluate_l2_candidates_20260826.m')` | ~7 s |
| Paket modelini değiştirmeden koşturma (S3) | `addpath('scripts'); run_umit_dort_senaryo_20261027('inverter_senaryo3')` | ~27 dk (Accelerator) |
| Onarılmış S1+S2 | `addpath('scripts'); run_umit_dort_senaryo_20261027('inverter_s1s2_s2onarim', '2026-10-27_s2_kapi_onarimi', 'accelerator')` | saatler |
| Kalibre S1 / S2 / S3 yeniden koşusu | `addpath('scripts'); run_tez_sekilleri_20261029('s1')` (`'s2'`, `'s3'`; üç süreç paralel koşabilir) | uzun (0,1 s benzetim) |
| S1–S3 kalibrasyonu | `scripts/calibrate_s1s3_20261028.m` (ayrıntı: koşu README'si) | saatler |
| S4 kapalı çevrim | `scripts/run_s4_closed_loop_20261028.m` (ayrıntı: koşu README'si) | ~20 dk / koşu |
| Kararlılık / Bode (analiz adımı) | `addpath('scripts'); analiz_kararlilik_20261028` (ayrıntı: koşu README'si) | dakikalar |
| Harmonik mekanizma şekli (Şekil 5.1) | `run('../tez-latex-v2/figures/sin3/uret_harmonik_mekanizma.m')` | saniyeler (`sekil_kayit.mat` gerekir) |

Her koşunun tam komutu ve ön koşulları kendi `runs/<koşu>/README.md` dosyasındadır.

**Bilinmesi gerekenler**

- `inverter_common_parameters.m` taban çalışma alanında `load_system`'dan **önce**
  çalıştırılmalıdır; yoksa Simscape diyotları "Qrr/didt … type string" hatası verir (D-03).
- Makinedeki tek C derleyicisi LCC ise ham S1+S2 Accelerator'da bağlanamaz, Normal modda koşar.
- Aynı klasörde eşzamanlı derleme yapmayın; paralel koşular ayrı `model_*` klasörlerinde yapılır.
- `logsout.mat` ve diğer `.mat` dalga kayıtları (0,8–1,8 GB) git'e girmez; betik yeniden koşturularak üretilir.
- Yeniden koşmadan önce ilgili `results/` klasörünü yedekleyin; betikler mevcut kanıtın üzerine yazar.
- Kanıt döngüsü: koşu → `review/<tarih>_*.md` kaydı → bölüm metni.

### Eğitim / demo modelleri

`tez-matlab-simulink/models/` ve `parameters/thesis_demo_parameters.m`, Temmuz–Ağustos 2026'da
yöntemi öğrenmek ve sınamak için kurulan ortalama değerli ve anahtarlamalı deneme
modelleridir (tek faz, üç faz, kapalı çevrim, sıfır dizi geri beslemesi). Parametreleri
`DENEME` işaretlidir; tez bulgusu olarak kullanılmaz. Kurulum ve koşturma:
[`tez-matlab-simulink/README.md`](tez-matlab-simulink/README.md) ("Eğitim/demo modelleri" bölümü).

## Durum (30.10.2026)

- İP-0 … İP-13 tamamlandı: dört senaryo düzeltildi ve kalibre edildi, S4 kapalı çevrim ve
  kararlılık analizi yapıldı, tek parametre tablosu kuruldu, bütün `\eksikistek` barları kapandı.
- Son derleme: notlu 230, notsuz 226 sayfa; tanımsız atıf ve taşma yok.
- İP-14 (yapı hakem önerileri) tez sahibinin kararını bekliyor.

## Yapılacaklar (teslim öncesi)

- [ ] Öğrenci numarası, savunma tarihi ve onay sayfası jürisi: `tez-latex-v2/config/tez-metadata.tex`
- [ ] İP-14 kararı: hakem önerileri uygulanacak mı? ([rapor](tez-tamamlama/04_YAPI_HAKEM_RAPORU.md))
- [ ] Notlu sürümdeki "%15'ten %47'ye" cümleleri için A/B seçimi (notta açıklandı)
- [ ] Teslim PDF'i `build_notsuz.cmd` ile üretilsin; notlu sürüm teslim edilmez
- [ ] `tez-latex/` etiket iskelesi (`\eskitezetiketi` vb.) yalnız çalışma kopyasında; son teze etkisi yok, kaldırma kararı tez sahibinde

## Kontrol edilecekler

- [ ] Derleme günlüğü: `Output written` var, `Undefined` yok, `Overfull` yok
- [ ] Notsuz PDF'te mavi not kutusu ve turuncu `EKSİK ÇALIŞMA` barı yok
- [ ] Metinde "bu" ailesi yok ("bu", "bunlar", "bu nedenle", "bu yüzden", "bu durum", "buna göre", "söz konusu"…)
- [ ] Sin³ özdeşliği: `sin³(x) = [3 sin(x) − sin(3x)] / 4`
- [ ] Şekil/tablo numaraları elle yazılmamış; hepsi `\label`/`\ref`
- [ ] SAÜ FBE kılavuzu ve teslim kontrol formu: kenar boşlukları, başlık stilleri, içindekiler (biçim kilitli; kozmetik değişiklik yapılmaz)
- [ ] Kaynakça: her kaynak metinde atıflı, uydurma kaynak yok
- [ ] Benzetim sayıları kalibre koşulara ve review notlarına dayanıyor; `DENEME` değer bulgu gibi sunulmuyor
- [ ] Kapak, özet, summary ve özgeçmişte kimlik alanları tutarlı

## Git'e girmeyenler

| Ne | Neden | Nerede |
|---|---|---|
| `dosyalar/` ham arşivleri (RAR/ZIP/DOCX/PDF, ~1,3 GB) | Tekil dosyalar 100 MB'ı aşıyor; telifli kaynaklar ve kişisel yazışmalar | Yerel diskte; `.md` dizinleri git'te |
| `runs/**/*.mat`, `logsout.mat` | 0,8–1,8 GB dalga kayıtları | Betik yeniden koşturularak üretilir |
| `slprj/`, `*.slxc`, `*_acc.*`, `*.mexw64` | Simulink derleme artıkları | Kendiliğinden oluşur |
| `build*/`, `main.pdf`, `tez_guncel_*.pdf` | Derleme çıktıları | PDF'ler [Releases](https://github.com/burhanbarakli/umit-pekparlak-doktora-tezi/releases) altında |
