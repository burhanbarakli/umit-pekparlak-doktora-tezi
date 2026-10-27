# Sin³ katsayı taramasının doğru özdeşlikle yeniden hesabı

Tarih: 2026-09-01
Betik: `scripts/rescan_sin3_coefficients_20260901.m`
Çıktılar: `results/sin3_rescan_20260901/`
Koşu ortamı: MATLAB R2025b, `-batch`, deterministik (rastgelelik yok).

## Amaç

TODO'daki iki açık madde:
- "Doğru özdeşliği kullanma: sin³(x)=[3sin(x)-sin(3x)]/4",
- "Eski Tablo 4.1–4.3 ve Şekil 4.25–4.28'i doğru Sin³ denklemiyle yeniden hesaplama".

## Model ve parametreler

Nötr anahtarı susturulmuş T-tipi faz kolunun pozitif yarım periyot senkron-buck
eşdeğeri; anahtarlama periyodu bazında parçalı doğrusal çözüm, akım tabanı 0
(susturma nedeniyle ters akım yok), DCM–CCM geçişi I0 taşımasıyla doğal.
Negatif alternans tek simetri. Parametreler 2026-08-22 doğrulanmış setinden:
Vdc=431,5 V (Vh=215,75 V), Vm=169,4 V, f0=50 Hz, fs=10 kHz, L=L1=600 µH.
Görev oranı: d(θ)=D1·sin θ + D3·sin³θ; eşdeğeri A1=D1+3D3/4, A3=−D3/4.

Kanıt sınırı: tek-L ideal analitik katman (Bölüm 3 model katmanları tablosundaki
"ortalama/analitik" düzey). Ölü zaman, denetleyici, Cf–L2 dinamiği ve kayıplar
yok; verim üretmez. Anahtarlamalı model ve donanım doğrulaması ayrı iştir.

## Sonuçlar

1. **Saf sinüs görev oranı (eski Tablo 4.1'in karşılığı):** dm=0,1–0,7
   aralığında I3/I1 sabit **%39,96** (eski tezdeki %43,93 sabitiyle aynı
   nitel davranış, farklı sayı — eski betik yok, fark modellemeden geliyor;
   eski değer yeniden üretilemedi). dm=0,8'de alternans ortası CCM'ye geçiyor
   (d_krit tepe değeri Vm/Vh≈0,785) ve tablo satırı geçersizleşiyor; eski
   "d_krit=0,8007" tek sayısının evrensel olmadığı doğrulandı.
2. **Eski aday katsayılar taşınamıyor:** (V1m,V3m)=(0,45, 0,37), (0,44, 0,38),
   (0,41, 0,41) doğrulanmış parametre setinde I1≈8,5–9,2 A (çalışma noktasının
   ~4 katı akım), I3/I1≈%50, THD≈%68 veriyor. 2026-08-22 fiziksel yeniden
   koşusunun "tarihsel iyileşme yeniden üretilemedi" bulgusuyla tutarlı:
   katsayılar çalışma noktasına bağlı, evrensel değil.
3. **Doğrulanmış set için düzeltilmiş optimum:** Gerçek düşük güç noktasına
   (Irms≈2,26 A; kısıt 2,0–2,6 A) uyan, görev oranı kırpılmayan en iyi nokta
   **(D1, D3)=(0,34, 0,40)** → I3/I1=%0,15, THD=%4,72, I1=2,85 A, Irms=2,02 A,
   d_max=0,74. Doğrudan-harmonik eşdeğeri **(A1, A3)=(0,64, −0,10)**.
   İlk 25 aday `en_iyi_adaylar.csv` içinde.

## Dosyalar

- `saf_sinus_dcm_harmonikleri.csv` — dm taraması, I1/I3/I5/I7/I9 ve oran.
- `katsayi_taramasi.csv` — 51×81 (D1,D3) ızgarası, tüm metrikler.
- `en_iyi_adaylar.csv` — kısıtlı ilk 25 aday.
- `eski_aday_noktalarin_kontrolu.csv` — eski üç noktanın kontrolü.
- `sin3_katsayi_taramasi_20260901.{png,pdf,fig}` — ısı haritası + zarf.
- `OZET.txt`.

## Teze aktarım

Bölüm 5'e (tez-latex-v2) "doğru özdeşlikle yeniden hesap" alt bölümü olarak
girdi; eski çelişkili optimumların yerini aldı. Gerçek kod geldiğinde
(K1/K3'ün kodda sin³ mü sin(3θ) mu olduğu — R07) katsayılar aynı betikle
yeniden taranacak.
