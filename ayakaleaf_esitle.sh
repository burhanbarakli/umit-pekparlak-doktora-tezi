#!/usr/bin/env bash
# ayakaleaf_esitle.sh — yeni_tez/ ile Ayakaleaf (yerel Overleaf) projesi arasinda iki yonlu eslitleme.
#
#   ./ayakaleaf_esitle.sh gonder            depo -> Ayakaleaf  (once GitHub'dan git pull yapar)
#   ./ayakaleaf_esitle.sh al ["mesaj"]      Ayakaleaf -> depo  (yerel commit, push yok)
#   ./ayakaleaf_esitle.sh github ["mesaj"]  al + GitHub'a push
#   ./ayakaleaf_esitle.sh durum             iki tarafta bekleyen degisiklikleri gosterir
#
# Ayakaleaf projesinin yerlesimi:
#   <kok>/            yeni_tez/ icerigi (tez.tex, bolumler/, onkisim/, ...)
#   <kok>/depo/       depo kokunun aynasi: tez-latex-v2/figures (tamami), tez-latex/figures ve
#                     tez-matlab-simulink altindan yalniz tezin kullandigi dosyalar.
#                     tezpaketleri.sty \graphicspath'i bunlari okur; .tex dosyalari iki tarafta aynidir.
#   <kok>/fonts/      Times New Roman + Cambria Math (yalniz Ayakaleaf'te; git'e girmez)
#
# Ayarlar: depo kokunde .ayakaleaf.local (git'e girmez):
#   AYAKALEAF_PROJE_ID=<24 haneli proje kimligi>
#   AYAKALEAF_URL=http://localhost:8080        (istege bagli)
#   AYAKALEAF_KLON=<klon klasoru>              (istege bagli; varsayilan: depo yaninda ayakaleaf-tez/)
# Git parolasi: Overleaf git belirteci (olp_...). Git kimlik yardimcisinda yoksa ~/.claude.json
# icindeki overleaf MCP baglantisinin belirteci kullanilir; ekrana yazilmaz.
set -euo pipefail

DEPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEZ="$DEPO/yeni_tez"
[ -f "$DEPO/.ayakaleaf.local" ] && . "$DEPO/.ayakaleaf.local"
: "${AYAKALEAF_PROJE_ID:?.ayakaleaf.local icinde AYAKALEAF_PROJE_ID tanimli degil}"
AYAKALEAF_URL="${AYAKALEAF_URL:-http://localhost:8080}"
KLON="${AYAKALEAF_KLON:-$(dirname "$DEPO")/ayakaleaf-tez}"
DURUM_DOSYASI="$KLON/.git/ayakaleaf_son_esitleme"   # son esitlemedeki depo yeni_tez agac ozeti

# Derleme ciktilari ve yalniz-Ayakaleaf klasorleri: yeni_tez <-> kok kopyasinda dokunulmaz.
DISLA=(--exclude=.git/ --exclude=/depo/ --exclude=/fonts/
       --exclude='*.aux' --exclude='*.log' --exclude='*.bbl' --exclude='*.blg' --exclude='*.out'
       --exclude='*.toc' --exclude='*.lof' --exclude='*.lot' --exclude='*.synctex.gz'
       --exclude='*.fls' --exclude='*.fdb_latexmk' --exclude='/tez.pdf' --exclude='/tez_notlu.pdf'
       --exclude='.DS_Store')

renk() { printf '\033[1;34m== %s\033[0m\n' "$*"; }
hata() { printf '\033[1;31mHATA: %s\033[0m\n' "$*" >&2; exit 1; }

kimlik_yardimcisi_yaz() {
  # git credential helper betigi: username=git, password=<belirtec> (~/.claude.json'dan)
  local y="$KLON/.git/ayakaleaf-kimlik.sh"
  cat > "$y" <<'EOF2'
#!/bin/sh
test "$1" = get || exit 0
echo username=git
python3 -c '
import json,os,sys
d=json.load(open(os.path.expanduser("~/.claude.json")))
def bul(o):
    if isinstance(o,dict):
        for k,v in o.items():
            if k=="mcpServers":
                for n,c in v.items():
                    a=(c.get("headers") or {}).get("Authorization","")
                    if "overleaf" in n and a.startswith("Bearer "): print("password="+a[7:]); sys.exit()
            else: bul(v)
bul(d)'
EOF2
  chmod +x "$y"; echo "$y"
}

klon_hazirla() {
  if [ ! -d "$KLON/.git" ]; then
    renk "Ayakaleaf projesi klonlaniyor: $KLON"
    git init -q "$KLON"
    local y; y="$(kimlik_yardimcisi_yaz)"
    git -C "$KLON" config credential.helper ""
    git -C "$KLON" config --add credential.helper "!\"$y\""
    git -C "$KLON" remote add origin "$AYAKALEAF_URL/git/$AYAKALEAF_PROJE_ID"
    git -C "$KLON" fetch -q origin || hata "Ayakaleaf projesine baglanilamadi"
    git -C "$KLON" checkout -q -b master --track origin/master
  fi
  git -C "$KLON" pull -q --ff-only || hata "Ayakaleaf klonu guncellenemedi ($KLON)"
}

depo_agaci() { git -C "$DEPO" rev-parse HEAD:yeni_tez; }
yeni_tez_temiz_mi() { [ -z "$(git -C "$DEPO" status --porcelain -- yeni_tez)" ]; }

ayakaleaf_degisti_mi() {
  # Son esitlemeden beri Ayakaleaf'te yeni commit var mi?
  local son; son="$(git -C "$KLON" tag -l son-esitleme)"
  [ -z "$son" ] && return 1
  [ "$(git -C "$KLON" rev-parse HEAD)" != "$(git -C "$KLON" rev-parse son-esitleme)" ] &&
    ! git -C "$KLON" diff --quiet son-esitleme HEAD
}

depo_degisti_mi() {
  # Son esitlemeden beri depoda (GitHub/diger bilgisayar) yeni_tez degisti mi?
  [ -f "$DURUM_DOSYASI" ] || return 1
  [ "$(cat "$DURUM_DOSYASI")" != "$(depo_agaci)" ]
}

isaretle() {
  git -C "$KLON" tag -f son-esitleme >/dev/null
  depo_agaci > "$DURUM_DOSYASI"
}

sekil_listesi() {
  # Tezin kullandigi, depo/ altina aynalanacak dosyalar (depo kokune gore goreli yollar).
  python3 - "$DEPO" <<'EOF'
import glob,os,re,sys
kok=sys.argv[1]; os.chdir(kok)
yollar=['tez-latex-v2/figures','tez-latex/figures']
dosyalar=glob.glob('yeni_tez/**/*.tex',recursive=True)+glob.glob('yeni_tez/*.sty')
cikti=set()
for f in dosyalar:
    s=re.sub(r'(?<!\\)%.*','',open(f,encoding='utf-8').read())
    for m in re.finditer(r'\\includegraphics\s*(?:\[[^\]]*\])?\s*\{([^}#]*)\}',s):
        r=m.group(1).strip()
        adaylar=[os.path.normpath(os.path.join('yeni_tez',r))] if r.startswith('../') else [os.path.join(p,r) for p in yollar]
        for c in adaylar:
            hit=next((c+e for e in ['','.pdf','.png','.jpg','.jpeg'] if os.path.isfile(c+e)),None)
            if hit: cikti.add(hit); break
for c in sorted(cikti):
    if not c.startswith('tez-latex-v2/figures/'): print(c)
EOF
}

fontlari_koy() {
  local hedef="$KLON/fonts"; mkdir -p "$hedef"
  local tnr="/System/Library/Fonts/Supplemental"
  local word="/Applications/Microsoft Word.app/Contents/Resources/DFonts"
  local -a kaynak=("$tnr/Times New Roman.ttf:times.ttf" "$tnr/Times New Roman Bold.ttf:timesbd.ttf"
                   "$tnr/Times New Roman Italic.ttf:timesi.ttf" "$tnr/Times New Roman Bold Italic.ttf:timesbi.ttf"
                   "$word/Cambria.ttc:Cambria.ttc")
  for k in "${kaynak[@]}"; do
    local src="${k%%:*}" ad="${k##*:}"
    [ -f "$hedef/$ad" ] && continue
    if [ -f "$src" ]; then cp "$src" "$hedef/$ad"
    elif [ -f "$word/$ad" ]; then cp "$word/$ad" "$hedef/$ad"
    else echo "  uyari: $ad bulunamadi; Ayakaleaf TeX Gyre yazi tiplerine duser"; fi
  done
}

gonder() {
  local zorla="${1:-}"
  renk "GitHub'dan guncelleniyor"
  git -C "$DEPO" pull -q --ff-only || hata "depo git pull basarisiz; once elle birlestirin"
  yeni_tez_temiz_mi || hata "yeni_tez/ icinde commit edilmemis degisiklik var; once commit edin"
  klon_hazirla
  if ayakaleaf_degisti_mi && [ "$zorla" != "--zorla" ]; then
    git -C "$KLON" diff --stat son-esitleme HEAD -- . ':!depo' ':!fonts' | tail -20
    hata "Ayakaleaf'te alinmamis duzenlemeler var. Once './ayakaleaf_esitle.sh al' calistirin (ustune yazmak icin: gonder --zorla)"
  fi
  renk "yeni_tez/ -> Ayakaleaf"
  rsync -a --delete "${DISLA[@]}" "$TEZ/" "$KLON/"
  renk "Sekiller -> depo/"
  mkdir -p "$KLON/depo/yeni_tez"
  printf 'Bu klasor bos kalmamali: ../tez-matlab-simulink/... yollari depo/yeni_tez/ uzerinden cozulur.\n' \
    > "$KLON/depo/yeni_tez/BENIOKU.txt"
  rsync -a --delete --exclude=README.md "$DEPO/tez-latex-v2/figures/" "$KLON/depo/tez-latex-v2/figures/"
  rm -rf "$KLON/depo/tez-latex" "$KLON/depo/tez-matlab-simulink"
  sekil_listesi | while IFS= read -r f; do
    mkdir -p "$KLON/depo/$(dirname "$f")"; cp "$DEPO/$f" "$KLON/depo/$f"
  done
  fontlari_koy
  git -C "$KLON" add -A
  if git -C "$KLON" diff --cached --quiet; then
    echo "Ayakaleaf zaten guncel."
  else
    git -C "$KLON" diff --cached --stat | tail -5
    git -C "$KLON" commit -q -m "Depodan esitleme: $(git -C "$DEPO" log -1 --format='%h %s')"
    git -C "$KLON" push -q || hata "Ayakaleaf'e push basarisiz"
    echo "Ayakaleaf guncellendi."
  fi
  isaretle
}

al() {
  local mesaj="${1:-Tez: Ayakaleaf duzenlemeleri ($(date +%d.%m.%Y))}"
  yeni_tez_temiz_mi || hata "yeni_tez/ icinde commit edilmemis degisiklik var; once commit edin"
  klon_hazirla
  if depo_degisti_mi; then
    hata "Depoda Ayakaleaf'e gonderilmemis yeni_tez degisiklikleri var (orn. diger bilgisayardan). Iki taraf da degistiyse elle birlestirin: 'git -C \"$KLON\" diff son-esitleme HEAD' ile Ayakaleaf farkini gorun."
  fi
  renk "Ayakaleaf -> yeni_tez/"
  rsync -a --delete "${DISLA[@]}" "$KLON/" "$TEZ/"
  renk "depo/ -> depo koku (yeni/degisen sekiller)"
  rsync -a --exclude=/yeni_tez/ "$KLON/depo/" "$DEPO/"
  git -C "$DEPO" add -A yeni_tez tez-latex-v2/figures tez-latex/figures tez-matlab-simulink 2>/dev/null || true
  if git -C "$DEPO" diff --cached --quiet; then
    echo "Ayakaleaf'te yeni duzenleme yok."
  else
    git -C "$DEPO" diff --cached --stat | tail -15
    git -C "$DEPO" commit -q -m "$mesaj"
    echo "Yerel commit: $(git -C "$DEPO" log -1 --format='%h %s')"
  fi
  isaretle
}

github() {
  al "${1:-}"
  renk "GitHub'a gonderiliyor"
  git -C "$DEPO" pull -q --rebase || hata "GitHub'dan rebase basarisiz; elle cozun"
  git -C "$DEPO" push -q && echo "GitHub guncel: $(git -C "$DEPO" log -1 --format='%h %s')"
  depo_degisti_mi && echo "Not: GitHub'dan gelen yeni_tez degisiklikleri var; Ayakaleaf'e tasimak icin: ./ayakaleaf_esitle.sh gonder"
  true
}

durum() {
  klon_hazirla
  if ayakaleaf_degisti_mi; then renk "Ayakaleaf'te alinmamis degisiklikler:"; git -C "$KLON" diff --stat son-esitleme HEAD | tail -20
  else echo "Ayakaleaf: son esitlemeden beri degisiklik yok."; fi
  git -C "$DEPO" fetch -q
  if depo_degisti_mi; then echo "Depo: yeni_tez son esitlemeden beri degisti (gonder gerekli)."; else echo "Depo: yeni_tez son esitlemeyle ayni."; fi
  local geride; geride="$(git -C "$DEPO" rev-list --count HEAD..@{u} 2>/dev/null || echo 0)"
  local ileride; ileride="$(git -C "$DEPO" rev-list --count @{u}..HEAD 2>/dev/null || echo 0)"
  echo "GitHub: $geride commit geride, $ileride commit ileride."
}

case "${1:-}" in
  gonder) gonder "${2:-}" ;;
  al) al "${2:-}" ;;
  github) github "${2:-}" ;;
  durum) durum ;;
  *) sed -n '2,8p' "$0" | sed 's/^# \{0,1\}//'; exit 1 ;;
esac
