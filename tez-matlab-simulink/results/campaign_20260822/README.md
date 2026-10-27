# 2026-08-22 tez deney kampanyası

Bu klasör, sonradan gelen Senaryo 1 modeli, özet çalışma kitabı ve tezde istenen
Senaryo 2-4 ilişkisi için yapılan koşuların tek izlenebilirlik kaydıdır. Hedef
verim/THD değerleri ayar amacıyla zorlanmamıştır.

## Kaynak Senaryo 1 yeniden üretimi

- Kaynak: `incoming_real_data/models/Inverter2_senaryo1_2026-08-16.slx`
- Kaynak SHA-256: `92c472f5f13d02d89c2f75fb57b025cfe28fde8ab1a8b9be406b854943ca487a`
- Model sürümü: R2023b
- R2025b sonucu: Specialized Power Systems blokları kaldırıldığı için kaynak
  dosya değişmeden çalıştırılamadı.
- `spsConversionAssistant` ile ayrı çalışma kopyası üretildi:
  `models/Inverter2_senaryo1_20260816_simscape_conversion_candidate.slx`.
- Dönüşüm kopyası 0.0299048413 s benzetim zamanında doğrusal olmayan çözücü
  yakınsama hatasıyla durdu. Hata D3, D5, D6, D7 ve D9 diyot denklemlerinde
  raporlandı. Bu nedenle kaynak modelin verim/THD göstergeleri yeniden
  üretilemedi ve dönüştürülmüş model sayısal olarak eşdeğer kabul edilmedi.

Kaynak model üzerinde kayıt eklemek için kullanılan betik:
`scripts/run_received_scenario1_reproduction.m`. Model yapısını değiştirmeyen
denetim betiği: `scripts/inspect_received_scenario1.m`.

## Senaryo 1-3 fiziksel yöntem kontrolü

Betik: `scripts/compare_three_phase_neutral_sin3.m`

Sonuç dizini: `results/campaign_20260822_physical_s123/`

- Klasik: faz RMS 2.2272 A, ortalama THD %10.8979, nötr RMS 0.6386 A.
- Nötr susturma: faz RMS 2.2377 A, ortalama THD %13.6249, nötr RMS 0.7113 A.
- Susturma + Sin3, Ksin3=-2 V: faz RMS 2.2094 A, ortalama THD %13.7725,
  nötr RMS 0.6937 A.
- Üç koşulda da geçersiz kapı durumu sayısı sıfırdır.

Bu model 400 V, L1=2 mH, L2=1 mH ve 2 us deneme ölü zamanı kullanır. Gelen
Senaryo 1 modelinin kayıp/verim yeniden üretimi değildir. Sin3 kolunun tarihsel
THD iyileşmesini üretmemesi negatif doğrulama olarak korunmuştur.

## Senaryo 4: yaklaşık 30 A PI fizibilitesi

Betik: `scripts/run_scenario4_pi_30a_average.m`

Sonuç dizini: `results/scenario4_pi_30a_average/`

Gelen notta 30 A'nın tepe veya RMS olduğu belirtilmediği için iki yorum da
sınanmıştır. Kullanılan temel değerler Vdc=431 V, Vgrid=120 V RMS,
L1=600 uH, R1=0.02 ohm, K3=-2 V, Kp=3 V/A, Ki=100 V/(A.s) ve 100 us kontrol
periyodudur.

- 30 A tepe yorumu: PI ile 20.922 A RMS, 0.665 A RMSE, %0.559 THD,
  |m|max=0.791; doyum yok.
- 30 A RMS yorumu: PI ile 29.715 A RMS, 0.662 A RMSE, %0.393 THD,
  |m|max=0.793; doyum yok.

Bu deney ortalama-değerli akım döngüsü fizibilitesidir. Anahtarlama kaybı,
termal port, LCL rezonansı ve verim sonucu sağlamaz.

## 2026-08-26 eki: L2 karar deneyi

Betik: `scripts/evaluate_l2_candidates_20260826.m`

Sonuç dizini: `results/l2_candidate_evaluation_20260826/`

Tam topolojideki `L1/L2/L3=600 uH` etiketlerinin üç faz bobini olduğu,
LCL sırasını göstermediği belirlendi. En yeni parametre notu ve Excel gerçek
uygulama Senaryo 1-2 satırları birlikte değerlendirilerek nihai faz-başına set
`L1=600 uH`, `Cf=8 uF`, `L2=200 uH` seçildi. `CL1=400 uH` kaynak modelin eski
ayarı olarak tutuldu. İdeal 10 kHz duyarlılık hesabında seçilen setin rezonansı
4.594 kHz'dir; `fs/2` sınırına yakınlık nedeniyle gerçek denetleyici ve sönümle
kararlılık doğrulaması gereklidir.

## Kanıt sınıfları

- Excel Senaryo 1-3: deney özeti, ham zaman serisi değil.
- Gelen `.slx`: Senaryo 1 kaynak modeli; R2025b'de doğrudan çalışmıyor.
- Fiziksel üç faz koşusu: kapı durumu ve yöntem yönelimi kontrolü.
- Senaryo 4 ortalama modeli: yaklaşık 30 A akım izleme fizibilitesi.
- L2 aday hesabı: kaynak ayrıştırması ve ideal LCL duyarlılığı; anahtarlamalı
  THD/verim kanıtı değil.
