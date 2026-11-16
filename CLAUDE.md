# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# Proje

Ümit Pekparlak'ın SAÜ FBE doktora tezi (T-tipi dönüştürücü, düşük güç anahtarlama,
Sin³ kompanzasyon). Üretim hatları: **`yeni_tez/` SAÜ FBE LaTeX şablonuyla
(burhanbarakli/sau-fbe-doktora-latex-sablonu) yazılan ana hattır (15.11.2026'dan
beri ana metin burada ilerler; LuaLaTeX, `.\derle.cmd`, ayrıntı `yeni_tez/README.md`,
karar K-33)**. `sauthesis.cls`/`sauwordline.lua` şablondan aynen alınmıştır,
değiştirilmez; tezin ekleri ve şablon düzeltmeleri `tezpaketleri.sty` içindedir.
`tez-latex-v2/` 15.11.2026 (586ae82) hâlinde kalan önceki temiz hattır; `tez-latex/` etiketli çalışma
kopyasıdır (kanıt köken iskelesi burada korunur); `tez-matlab-simulink/` sayısal
kanıtı üretir. `dosyalar/` ve `tez-word/` salt kaynak/kanıt deposudur; yeni içerik
oraya yazılmaz. Genel giriş noktası: `ANA_SAYFA_TEZ_CALISMA_MERKEZI.html`.

`tez-latex-v2` kuralları (`tez-latex-v2/README.md`): etiket makroları yok,
"önceki tez / eski Şekil X" üst-anlatısı yok; eksik benzetim/veri yalnız
`\eksikistek{...}{...}` turuncu barıyla işaretlenir. Şekiller çoğaltılmaz —
`\graphicspath` `../tez-latex/figures/` deposunu okur; Senaryo ekranları ve
MATLAB sonuçları göreli yolla gelir. Ümit'ten gelen gerçek parametreler
`tez-matlab-simulink/incoming_real_data/` altındadır.

Ümit'ten gelen her e-posta/Drive teslimi önce ham hâliyle
`dosyalar/06_UMIT_ABIDEN_GELENLER/<YYYY-MM-DD>_<konu>/` altına konur (üzerine
yazılmaz; dizin `00_INDEX.md`), sonra kullanılan dosyalar tarihli adla
`incoming_real_data/` altına kopyalanır. Güncel dört senaryo modeli (S1+S2, S3,
S4) ve ortak parametre dosyası: `incoming_real_data/models/2026-10-12_dort_senaryo_paketi/`
— modeller `inverter_common_parameters.m`'yi aynı klasörden okur, birlikte tutulmalı.

# Tamamlama sistemi (27.10.2026'dan beri)

Tez **Ümit'e yeni soru sorulmadan** tamamlanır. İş akışı `tez-tamamlama/` altındadır:

- `00_TAMAMLAMA_PLANI.md`: iş paketleri (İP-xx), jüri maddesi → kabul kanıtı,
  `\eksikistek` barı ve R01–R16 kapanış yolları, bitti tanımı.
- `01_KARAR_DEFTERI.md`: açık noktaların K-xx kararları. Sorulacak soru çıkarsa
  karar buraya yazılır, Ümit'e iletilmez.
- `02_MODEL_DUZELTME_KAYDI.md`: gelen dosyalardaki sorunların ve tez kapsamına
  göre yapılan düzeltmelerin D-xx kaydı. Her model düzeltmesi buraya yazılır.

Alan uzmanı alt ajan: `.claude/agents/tez-beyin.md` (`subagent_type: tez-beyin`).
İş paketleri ona bu üç dosyayla birlikte devredilir. İP durumu değişince plan
tablosu güncellenir.

# LaTeX derleme

`yeni_tez/` LuaLaTeX ister: MiKTeX 25.12 `%LOCALAPPDATA%\Programs\MiKTeX\miktex\bin\x64`
altında kurulu (PATH'te değil; `yeni_tez\derle.cmd` yolu kendisi ekler, ~1 dk, ~231 sayfa;
`.\derle.cmd notlu` → `tez_notlu.pdf`). Mac'te tez yerel Overleaf sunucusu Ayakaleaf'te
(http://localhost:8080) yazılır ve orada derlenir; depo ↔ proje eşitlemesi `./ayakaleaf_esitle.sh
gonder|al|github|durum` (ayrıntı `yeni_tez/README.md`, "Mac'te Ayakaleaf"). Eski hatlar (`tez-latex`, `tez-latex-v2`)
Tectonic 0.17.0 ile derlenir: `%USERPROFILE%\.local\bin\tectonic.exe`.

```bat
cd tez-latex
.\build.cmd
```

Çıktı `build/main.pdf`. Doğrudan çağrı:

```bat
tectonic main.tex --outdir build --keep-logs --keep-intermediates
```

- Beklenen sonuç: ~191 sayfa, ~71 MB, 2–4 dakika. `build/main.log` içinde
  `Output written` satırını ve tanımsız referans/atıf olmadığını denetle
  (`grep "Undefined" build/main.log` boş dönmeli). Underfull hbox/vbox uyarıları
  normaldir.
- Sürüm kuralı: kalıcı derlemeler `build_YYYY-MM-DD/` klasörüne, kopyası
  `tez_guncel_YYYY-MM-DD.pdf` adıyla `tez-latex/` köküne; kökteki `main.pdf`
  her zaman en son sürümdür.

# MATLAB deneyleri

Bu makinede (27.10.2026'dan beri) **MATLAB R2023b** tam kurulu: Simulink,
Simscape Electrical (Specialized Power Systems dahil), Control System, Simulink
Control Design, Simulink Design Optimization, Signal Processing. Ümit'in modelleri
de R2023b'dir. `matlab` PATH'te değildir; tam yolla çağır (PowerShell):

```powershell
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "run('scripts/run_demo.m')"
```

Ağustos 2026 koşuları başka bir makinede R2025b ile yapılmıştır; o tarihli
review notlarındaki "R2025b uyumsuzluğu" bu makine için geçerli değildir.
Ümit'in paket modelleri `runs/<tarih>_<konu>/model/` altındaki kopyada koşturulur
(ham paket ve `slprj` artıkları ayrı kalsın); 16 iş parçacığı / 63 GB RAM ile
birkaç `-batch` süreci paralel koşabilir.

Ümit'in modellerini koştururken (`scripts/run_umit_dort_senaryo_20261027.m`):
- `inverter_common_parameters.m` taban çalışma alanında `load_system`'dan
  **önce** çalıştırılmalı; yoksa Simscape diyotları "Qrr/didt … type string"
  hatası verir (InitFcn yetmez, modelde PreLoadFcn yok).
- Modeller Accelerator modunda kayıtlı; makinedeki tek derleyici LCC'dir.
  Ham S1+S2 modeli LCC ile bağlanamıyor (`rt_InitInfAndNaN` tanımsız), bu yüzden
  Normal modda koşar. Onarılmış S1+S2 (`inverter_s1s2_s2onarim`) ve S3
  Accelerator'da derleniyor. Aynı klasörde eşzamanlı derleme yapma; paralel
  koşular ayrı klasörlerde yapılmalı. Süre (0,1 s benzetim): S3 Accelerator ~27 dk, S1+S2
  Normal ~1,9 saat. `logsout.mat` 0,8–1,8 GB olur, git'e girmez.

- Betikler **proje kökünden** çağrılır, `scripts/` içine `cd` edilmez; hepsi
  `root_dir = fileparts(fileparts(mfilename('fullpath')))` kalıbıyla yol kurar.
- `scripts/build_*.m` modeli sıfırdan kurar; `scripts/run_*.m` koşturup
  `results/<deney>/` altına CSV + PNG + FIG yazar. Model dosyası yoksa run betiği
  build betiğini kendisi çağırır.
- **Yeniden koşmadan önce `results/` yedekle** — betikler mevcut tez kanıtının
  üzerine yazar. Deneyler deterministiktir: aynı betik aynı CSV değerlerini
  15 anlamlı basamağa kadar yeniden üretir (doğrulama: 28.08.2026).
- `-batch` sarmalayıcısında `t0` gibi genel değişken adı kullanma; betikler taban
  çalışma alanını paylaşır ve örn. `run_switching_demo.m` `t0`'ı ezer.
- Kısa duman testi (~7 s): `run('scripts/evaluate_l2_candidates_20260826.m')`.

# Mimari — dosyalardan hemen görülmeyenler

- **Kanıt köken etiketleri** (`config/tez-preamble.tex` içinde tanımlı):
  `\eskitezetiketi`, `\juriistegietiketi`, `\tezcalismanotu`, `\hatalieskitag`,
  `\diskaynaketiketi`, `\hatalidenklemetiketi`. Bölüm metinlerinde yüzlerce kez
  kullanılır; PDF üzerinde her şeklin/denklemin kökenini ve neyin doğrulanmadığını
  görünür tutar. Çalışma kopyası iskelesidir, nihai teslimden önce tek noktadan
  kaldırılacaktır — **kendiliğinden silme, sor.**
- **Kanıt döngüsü**: MATLAB koşusu → `tez-matlab-simulink/review/<tarih>_*.md`
  kaydı → bölüm metni. Yeni koşu sonucu doğrudan bölüme yazılmaz; önce tarihli
  review notu düşülür (örnek biçim: `2026-08-26_R2025B_SENARYO1_DOGRULAMA.md`).
- **Parametre disiplini**: devre değerlerinin çoğu `DENEME` işaretlidir; gerçek
  değerler tez sahibinden beklenmektedir (`tez-matlab-simulink/TODO.md` içindeki
  R01–R16 istek listesi). README'lerdeki "tez bulgusu olarak kullanılamaz"
  ifadeleri bilinçlidir — benzetim sayılarını tez bulgusu gibi sunma.
- **Biçim kilitli**: sayfa geometrisi, başlık stilleri ve İçindekiler ayarları
  SAÜ FBE kılavuzu (04.08.2022, Senato 621-9) + resmî Word şablonu + teslim
  kontrol formundan türetilmiştir. Kozmetik gerekçeyle değiştirilmez.
- Açık teknik sorun: R2025b Senaryo 1 diyot yakınsaması
  (`review/2026-08-26_R2025B_SENARYO1_DOGRULAMA.md`, "Kalan teknik iş").

# Kurallar

- `dosyalar/00_ORIJINAL_ARSIVLER` referans katmanıdır — üzerine yazma.
- Şekil/tablo numaraları elle yazılmaz; `\label`/`\ref` kullanılır.
- Şekil dosya adlarında boşluk ve Türkçe karakter yok; tercih sırası
  vektör PDF > ≥300 dpi PNG > JPEG (`figures/README.md`).
- Tez kimlik bilgileri yalnızca `config/tez-metadata.tex` içinde tutulur;
  öğrenci no, anabilim dalı ve savunma tarihi hâlâ yer tutucudur.
- Doğru özdeşlik: `sin³(x) = [3sin(x) − sin(3x)]/4`. Kaynak PDF'teki katsayı
  hatasını modele taşıma.

# Windows tuzakları

- Yol `ü` içeriyor: PowerShell'den `cmd.exe` çağrılırken çift tırnak + backtick
  kaçışı kullan (`"cd /d \`"$yol\`" && ..."`); tek tırnaklı biçimler bozulur.
- Ortamda `NoDefaultCurrentDirectoryInExePath=1` olabilir → çıplak `build.cmd`
  bulunmaz, `.\build.cmd` yaz.
- Git Bash'ten `cmd /c` çağrısı `/c`'yi yola çevirir; `.cmd` dosyalarını
  PowerShell üzerinden çalıştır.
- Simulink modelini yanlış dizinden koşturursan proje köküne `slprj/` ve `*.slxc`
  artıkları düşer (kökte hâlihazırda örnekleri var).
