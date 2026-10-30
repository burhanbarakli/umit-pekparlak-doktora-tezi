# Senaryo_2: Senaryo 2 ekranları (13.07.2026 teslimi)

Ümit Pekparlak'ın kendi Simulink benzetiminden aldığı ekran kayıtları. Ham arşiv
`../Senaryo_2.rar` olarak korunur; klasör arşivin açılmış hâlidir. Tez metni JPG
dosyalarını göreli yolla okur (`tez-latex-v2/chapters/04-dusuk-guc-anahtarlama.tex`), bu yüzden JPG'ler
git'e dahildir; EMF kopyaları yalnız diskte durur.

- **Yöntem:** nötr anahtar susturma; Q4 pozitif, Q3 negatif yarım periyotta kapalı
- **Kalibrasyon:** yok. Ekranlar 12.10 paketinden ve kalibrasyondan önceki modele
  aittir; tezde "ekran kaydı" olarak, kalibre sonuçlardan ayrı sunulur.

| Dosya | İçerik | Tezdeki şekil etiketi |
|---|---|---|
| `dalga_sekilleri_s2.jpg` | Filtre giriş gerilimi, filtrelenmiş gerilim, L1 akımı, LC çıkış akımı | `fig:susturma-dort-kanal` |
| `THD_IL1.jpg` | L1 akımı FFT (temel bileşen 3,396 A tepe) | `fig:susturma-l1-fft` |
| `THD_Iout.jpg` | LC filtre çıkış akımı FFT (temel bileşen 3,412 A tepe) | `fig:susturma-iout-fft` |

## Parametreler

Ekranların üretildiği model dosyası teslim edilmedi. En yakın parametre kaynağı
22.08.2026 e-postasıdır
(`tez-matlab-simulink/incoming_real_data/parameters/2026-08-22_umit_senaryo_parametreleri.md`):

| Büyüklük | Değer |
|---|---|
| DA bara | 431 V |
| L1 / L1r | 600 µH / 0,02 Ω |
| L2 / L2r | 200 µH / 0,02 Ω |
| Cf / Cr | 8 µF / 0,01 Ω |
| Anahtarlama frekansı | 10 kHz |
| Şebeke frekansı | 50 Hz |

Tezin kalibre sonuçlarında kullanılan güncel parametreler (L2 = 1000 µH, senaryoya
özgü DA bara ve kazançlar) için:
[`tez-matlab-simulink/incoming_real_data/models/2026-10-12_dort_senaryo_paketi/README.md`](../../../tez-matlab-simulink/incoming_real_data/models/2026-10-12_dort_senaryo_paketi/README.md).
