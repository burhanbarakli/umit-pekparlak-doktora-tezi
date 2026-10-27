# Ortam ve yeniden üretim doğrulaması

Tarih: 28.08.2026

Amaç: Çalışma ortamının bugünkü hâliyle tez deneylerini ve LaTeX derlemesini
yeniden üretip üretemediğini sınamak. Yeni bir mühendislik sonucu üretmek
amaçlanmamıştır; kayıtlı değerlerin tekrar elde edilip edilmediği ölçülmüştür.

## Ortam

| Bileşen | Durum |
|---|---|
| MATLAB | R2025b (25.2), tam kurulum |
| Simulink / Simscape / Simscape Electrical | Kurulu ve lisanslı |
| Control System, Signal Processing, DSP System Toolbox | Kurulu ve lisanslı |
| LaTeX dağıtımı (MiKTeX/TeX Live) | Kurulu **değil** |
| Tectonic | 0.17.0; `%USERPROFILE%\.local\bin\tectonic.exe` konumuna kuruldu |

`build.cmd` içindeki eski Tectonic yolu
(`.codex\plugins\cache\openai-bundled\latex\0.2.4\bin\tectonic.exe`) artık
mevcut değildir. Betik, derleyiciyi PATH → `~/.local/bin` → codex eklenti
önbelleği sırasıyla arayacak biçimde güncellenmiştir. Eski sürüm
`build.cmd.bak` olarak korunmuştur.

## Koşturulan deneyler

Bütün koşular `matlab -batch` ile, kaynak betikler değiştirilmeden yapılmıştır.

| # | Betik | Süre | Durum |
|---|---|---|---|
| 1 | `run_demo.m` | 68,6 s | Başarılı |
| 2 | `run_switching_demo.m` | ölçülmedi | Başarılı |
| 3 | `evaluate_l2_candidates_20260826.m` | 6,8 s | Başarılı |
| 4 | `run_closed_loop_comparison.m` | 37,7 s | Başarılı |
| 5 | `run_three_phase_average_comparison.m` | 15,7 s | Başarılı |

## Yeniden üretim sonucu

Beş deneyin ürettiği bütün metrik CSV dosyaları, koşudan önce alınan yedekle
15 anlamlı basamağa kadar birebir aynıdır. Yalnız satır sonu karakterlerinde
(CRLF/LF) fark oluşmuştur; sayısal içerik değişmemiştir.

| Ölçüt | Kayıtlı değer | 28.08.2026 koşusu |
|---|---|---|
| `run_demo` Sin3 kapalı THD | %5,85228 | %5,85228 |
| `run_demo` Sin3 açık THD | %0,0218573 | %0,0218573 |
| Anahtarlamalı açık çevrim şebeke akımı | 1,23239 A RMS | 1,23239 A RMS |
| Anahtarlamalı açık çevrim THD | %7,76278 | %7,76278 |
| P/O/N kapı durumları | 1010 / 0011 / 0101 | Aynı; geçersiz durum 0 |
| Kapalı çevrim klasik ideal THD | %3,97095 | %3,97095 |
| Kapalı çevrim klasik + ölü zaman THD | %10,07018 | %10,07018 |
| Kapalı çevrim nötr susturma THD | %11,37664 | %11,37664 |
| Kapalı çevrim susturma + Sin3 THD | %11,18350 | %11,18350 |
| Üç faz ortalama susturma nötr RMS | 0,573836 A | 0,573836 A |
| L2=200/400/600 uH rezonans | 4594,4 / 3632,2 / 3248,7 Hz | Aynı |

## LaTeX derlemesi

`main.tex` ve bölüm dosyalarının en son hâli (kaynak dosyalarda son değişiklik
26.08.2026) yeniden derlenmiştir.

- Çıktı: 191 sayfa, 71,35 MB; 26.08.2026 derlemesiyle aynı sayfa sayısı.
- Tanımsız referans veya tanımsız atıf yoktur.
- Uyarılar yalnız tipografiktir (underfull hbox/vbox).
- Dosyalar: `build/main.pdf`, `build_2026-08-28/main.pdf`,
  `tez_guncel_2026-08-28.pdf`, `main.pdf`.
- Önceki `build/main.pdf` (14.07.2026, 185 sayfa) `build/main_2026-07-14_yedek.pdf`
  olarak korunmuştur.

## Kapsam dışı

Bu doğrulama, aşağıdaki açık işleri kapatmaz:

- R2025b Senaryo 1 diyot yakınsama sorunu (bkz. `2026-08-26_R2025B_SENARYO1_DOGRULAMA.md`).
- Fiziksel üç faz anahtarlamalı ve sıfır-dizi geri besleme koşuları bu turda
  koşturulmamıştır.
- Bütün parametreler hâlâ geçicidir; TODO listesindeki R01--R16 istekleri açıktır.
  Yeniden üretilebilirlik, sonuçların tez kanıtı olduğu anlamına gelmez.
