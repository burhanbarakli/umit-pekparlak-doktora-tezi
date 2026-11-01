# Yeni tez hattı (tez-latex-v2)

Kuruluş: 1 Eylül 2026. `tez-latex/` çalışma kopyası referans alınarak kurulan
**temiz yazım hattıdır**; nihai teze giden metin buradan ilerler.

## tez-latex'ten farkları

- **Etiket iskelesi yok.** `\eskitezetiketi`, `\juriistegietiketi`,
  `\tezcalismanotu` vb. kaldırıldı; metinde "önceki tez / eski Şekil X"
  üst-anlatısı yok. Kanıt sınırları normal akademik dille ifade edilir.
- **Tek bar sistemi:** `\eksikistek{Başlık}{Ne istiyoruz}` — turuncu
  "EKSİK ÇALIŞMA — BUNU İSTİYORUZ" kutusu. Eksik MATLAB koşusu/veri, sonucun
  geleceği yerde işaretlenir. Nihai teslimden önce bütün barlar kapatılmalı
  veya Bölüm 8 sınırlılıklarına dönüştürülmelidir.
- **Tez sahibine bilgi notu:** `\umitnot{Başlık}{Metin}` — mavi "ÜMİT ABİ İÇİN NOT" kutusu; tez metninin parçası değildir. Teslimden önce `config/tez-preamble.tex` içindeki `\umitnotlaritrue` satırı `\umitnotlarifalse` yapılır, bütün notlar kalkar (K-28).
- **Hatalı eski türetim zinciri (4.2–4.26) ana metinden çıkarıldı**; yerine
  geçerlilik sınırı gerekçesi + HTF çerçevesi + 01.09.2026 tarihli doğru
  özdeşlikli katsayı taraması girdi
  (`tez-matlab-simulink/results/sin3_rescan_20260901/`).
- Parametre tablosu 22.08.2026 e-posta seti, tam topoloji şeması ve Senaryo-1
  modelinden gelen gerçek değerlerle güncellendi (kaynak:
  `tez-matlab-simulink/incoming_real_data/`).

## Derleme

```bat
cd tez-latex-v2
.\build.cmd
```

Çıktı `build/main.pdf`. Şekiller çoğaltılmadı: `\graphicspath` önce yerel
`figures/`, sonra `../tez-latex/figures/` deposunu okur; MATLAB sonuçları
`../tez-matlab-simulink/results/` altından göreli yolla gelir. Bu yüzden
klasör tek başına taşınamaz; proje köküyle birlikte taşınmalıdır.

## Yazım kuralları (teknik-makale skill kuralları geçerli)

- Türkçe terim + ilk geçişte parantez içinde İngilizce karşılık.
- Her bölüm/kesim köprüyle açılır (önceki bölümden devir + neden şimdi + ne yapacak).
- Şekil/tablo/denklem yalnız `\label`/`\ref`; metin içinde amaç–bulgu–sınır
  yorumu olmadan "verilmiştir" denip geçilmez.
- Göndergesel bağlaç ve gösterme sözcükleri kullanılmaz: "bu", "bunlar",
  "bundan dolayı", "bu nedenle", "bu yüzden", "bu durum", "buna göre",
  "bununla birlikte", "söz konusu". Yerine kavramın kendi adı yazılır ya da
  cümle neden–sonuç yapısıyla yeniden kurulur ("Orta nokta salınımı … ;
  sonuç olarak …" değil, "DA bara orta nokta salınımı akım genliğini sınırlar").
  "Bu çalışmada" yerine "tezde" ya da "önerilen yöntemde" yazılır.
- İddialar metrik + baz çizgi + koşul + belirsizlikle yazılır.
- Benzetim ve deney sonuçları ayrı raporlanır; DENEME/temsilî veriler tez
  bulgusu gibi sunulmaz.

## İlgili belgeler

- `review/2026-09-01_ESKI_TEZ_SORUN_TESPITI.md` — eski tezin bağımsız sorun
  tespiti (22 bulgu).
- `tez-matlab-simulink/review/2026-09-01_SIN3_KATSAYI_YENIDEN_TARAMA.md` —
  yeni katsayı taramasının koşu kaydı.
- Jüri istekleri: `dosyalar/03_INCELEME_VE_PLANLAMA/JURI_ISTEKLERI_EYLEM_MATRISI.md`.
