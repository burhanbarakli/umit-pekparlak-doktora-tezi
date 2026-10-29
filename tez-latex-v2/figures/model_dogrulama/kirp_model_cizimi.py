"""uret_model_cizimi.m çıktısını etkin devreye kırpar (İP-11).

Kalibre S3 modelinin üst düzeyinde, modelde yorum satırına alınmış (Commented) ikinci
bir devre kopyası alt yarıda gri olarak çizilir. Çizim nesnelerinden üst yarıdaki
(y < 300 pt) etkin devrenin sınırı bulunur ve sayfanın kırpma kutusu ona ayarlanır;
vektör içerik değişmez.
Çağrı: python -I kirp_model_cizimi.py   (bu klasörde)
"""
import os
import pymupdf

here = os.path.dirname(os.path.abspath(__file__))
src = os.path.join(here, "s3_model_ust_duzey_tam.pdf")
dst = os.path.join(here, "s3_model_ust_duzey.pdf")
d = pymupdf.open(src)
p = d[0]
rr = [dr["rect"] for dr in p.get_drawings() if dr["rect"].y1 < 300]
r = pymupdf.Rect(min(x.x0 for x in rr) - 4, min(x.y0 for x in rr) - 4,
                 max(x.x1 for x in rr) + 4, max(x.y1 for x in rr) + 4)
p.set_cropbox(r)
d.save(dst)
print("kırpma kutusu:", r)
