**Konu:** Tez 15.11 sürümü: Q1–Q3 / Q2–Q4 düzeltmeleri ve bakman gerekenler

**Ekler:** tez_guncel_2026-11-15.pdf (218 sayfa),
tez_guncel_2026-11-15_degisiklikler_isaretli.pdf

Ümit Abi merhaba,

09.11 mailindeki düzeltmeleri ve gönderdiğin dosyaları teze işledim. Yeni sürüm
ekte. İkinci ek aynı PDF'in işaretli hâli: değişen yazılar sarı, değişen şekil
ve tablolar çerçeveli, ilk sayfada her değişikliğe giden bağlantılı özet var.
Sayfa numaraları yeni sürüme göre.

Şekillerin çoğu LaTeX içinde çizildiği için düzeltmeleri yine ben yaptım.
Senden istediğim, aşağıdaki "Bakman gerekenler" ve "Doldurman gerekenler"
kısımlarına göz atman.

**1. Yapılanlar**

- **Adlandırma:** Tez boyunca $Q_3$ faz düğümü tarafındaki, $Q_4$ DA bara orta
  noktası tarafındaki nötr IGBT. Tümleyen çiftler Q1–Q3 ve Q2–Q4. Bölüm 2, 3 ve
  4'teki metin, Tablo 3.2, 3.4 ve 4.2 yeni adlandırmaya göre yeniden yazıldı. Simulink
  modeliyle de karşılaştırdım: modeldeki IGBT3/IGBT7 Q3'e, IGBT2/IGBT6 Q4'e
  karşılık geliyor; modeldeki S1–S4 sırası tezdeki Q1–Q4 ile aynı.
- **Şekil 2.5, 7.3, 7.4 (s. 15, 136, 137):** Gönderdiğin düzeltilmiş
  çizimlerle değiştirildi.
- **Şekil 3.4 ve 3.5 (s. 34, 36):** Q3 ve Q4'ün yerleri değişti.
  **Şekil 3.6 (s. 37)** dediğin gibi tümleyen ilişkisiyle aynı kaldı. Araya
  yeni bir şekil girdiği için eski 3.3–3.5 şimdi 3.4–3.6 oldu.
- **Şekil 4.3 (s. 69):** Q3 ve Q4 dalga şekilleri yer değiştirdi. Şekil
  kayıtlı benzetim verisinden yeniden çizildi; sayısal sonuçlar aynı.
- **Şekil 3.2 (s. 32):** Nötr hatlı yeni PDF'in vektör olarak kondu. Genel
  görünüm küçük kaldığı için birinci faz hücresini büyüterek ayrı bir tam
  sayfa şekil yaptım: **Şekil 3.3 (s. 33)**.
- **Şekil 4.4 (s. 70):** S3 SVG'sinden vektör olarak çizildi. Sorunun cevabı:
  her senaryo için ayrı şema koymadım. Güç katı dört senaryoda da aynı
  olduğundan S3 şeması Şekil 4.4'te tam duruyor. S4 için yalnız farklı olan
  anahtarlama girişi ayrı şekil olarak var: **Şekil 5.5 (s. 87)**. Altyazıya
  senaryoların anahtarlama girişi, DA bara gerilimi ve ileri besleme
  katsayılarıyla ayrıldığı yazıldı.
- **Öğrenci numarası** (1050D08208) girildi.

**2. Bakman gerekenler**

Senin çizimlerinde ve bir teknik cümlede değişiklik yaptım. Doğru olup
olmadıklarını en iyi sen bilirsin:

- **Şekil 3.2 ve 3.3 (s. 32–33):** Gönderdiğin PDF'te birinci fazın Q3/Q4
  etiketleri öteki iki fazın tersineydi. Birinci fazdaki iki etiketi yer
  değiştirdim; şimdi üç fazda da Q4 orta nokta, Q3 faz tarafında.
- **Şekil 7.6 (s. 138):** Eski PFC kipi şeklinde Q3_Lx ve Q4_Lx etiketleri
  eski adlandırmadaydı. Etiketleri yer değiştirdim, altyazıya hangi IGBT'nin
  hangi tarafta olduğunu ekledim.
- **Şekil 3.5(a) (s. 36):** Ters paralel diyotların adı $D_k$ yerine $DS_k$
  oldu (DS1–DS4). $D_1$–$D_2$ harici diyotlarla ve Sin³'teki $D_1$, $D_3$
  katsayılarıyla karışıyordu.
- **Şekil 3.6(b) (s. 37):** Negatif yarım periyotta yeşil gösterilen anahtar
  Q4 yerine Q2 oldu; enerji aktaran anahtar Q2, Q4 onun tümleyeni. Etiketler
  ve tümleyen ilişkisi değişmedi.
- **Bölüm 4, s. 67, susturma sırasında ters akım:** Eski cümle, $L_1$ akımı
  ters yöne dönünce akımın $D_1$–$D_2$ üzerinden DA rayına aktığını
  söylüyordu. Bölüm 3'teki düşük akım modellemesiyle çelişiyordu. Yeni hâli:
  ters yönde akım yolu yoktur; $L_1$ akımı sıfıra inince kesilir, kutup
  gerilimi filtre tarafının gerilimini izler. $D_1$–$D_2$ yalnız kutup
  gerilimi DA rayını aşarsa iletime girer. Deneyde gördüğünle uyuşup
  uyuşmadığına bakarsan iyi olur.

**3. Doldurman gerekenler**

- **Onay sayfası:** Jüri üyelerinin adları elimde. SAÜ kılavuzu jüri
  başkanını ve her üyenin üniversitesini de istediği için sayfayı şimdilik
  boş bıraktım. Jüri başkanı, üniversiteler ve savunma tarihi belli
  olduğunda ekleyeceğim.
- **Kapaktaki tarih:** "EKİM 2026" yazıyor. Teslim ayı belli olunca
  güncellenecek.

Benim tarafımda da birkaç küçük iş kaldı (simgeler listesine Q1–Q4 ve
DS1–DS4'ün eklenmesi, birkaç yazım düzeltmesi). Onlar bir sonraki sürümde
gelecek.

Kolay gelsin,
Burhan
