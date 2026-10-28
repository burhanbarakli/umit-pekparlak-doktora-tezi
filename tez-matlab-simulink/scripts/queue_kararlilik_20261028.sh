#!/usr/bin/env bash
# İP-6 anahtarlamalı doğrulama kuyruğu: tek MATLAB süreci, koşular sırayla; her koşu ayrı
# -batch çağrısı, süre sınırı (s) aşılırsa durdurulur ve kuyruk devam eder.
# Paralel kuyruklar ayrı model klasörü kullanır (MK = model_a | model_b | model_c).
# Çağrı (Git Bash, proje kökünden): MK=model_a bash scripts/queue_kararlilik_20261028.sh <sinir_s> <kosu1> [...]
# Bütün koşular KC_* ayarlarıyla (K-20 + D-11; run_enjeksiyon_kararlilik_20261028.m içinde).
#   Ton kümesi A = [212.5 525 1037.5] Hz, B = [587.5 2025 3362.5] Hz; genlik 0,015; 0,11 s; pencere 0,03–0,11 s
ROOT="/c/CODES/ümit abi/tez-matlab-simulink"
LOG="$ROOT/runs/2026-10-28_kararlilik/loglar"
MATLAB="/c/Program Files/MATLAB/R2023b/bin/matlab.exe"
mkdir -p "$LOG"
LIMIT="$1"; shift
MK="${MK:-model_a}"
cd "$ROOT" || exit 1
A="[212.5 525 1037.5]"; B="[587.5 2025 3362.5]"
for c in "$@"; do
  base="'model_kopya', '$MK', 'pencere', [0.03 0.11]"
  case "$c" in
    PI25_K34_A)   cmd="run_enjeksiyon_kararlilik_20261028('$c', 'PI', 25, 0.11, struct($base, 'tonlar', $A))";;
    PI25_K34_B)   cmd="run_enjeksiyon_kararlilik_20261028('$c', 'PI', 25, 0.11, struct($base, 'tonlar', $B))";;
    PI25_K340_A)  cmd="run_enjeksiyon_kararlilik_20261028('$c', 'PI', 25, 0.11, struct($base, 'tonlar', $A, 'ust', struct('K34', 0)))";;
    PI25_K340_B)  cmd="run_enjeksiyon_kararlilik_20261028('$c', 'PI', 25, 0.11, struct($base, 'tonlar', $B, 'ust', struct('K34', 0)))";;
    PI10_K34_A)   cmd="run_enjeksiyon_kararlilik_20261028('$c', 'PI', 10, 0.11, struct($base, 'tonlar', $A))";;
    PI10_K34_B)   cmd="run_enjeksiyon_kararlilik_20261028('$c', 'PI', 10, 0.11, struct($base, 'tonlar', $B))";;
    PI2p3_K34_A)  cmd="run_enjeksiyon_kararlilik_20261028('$c', 'PI', 2.3, 0.11, struct($base, 'tonlar', $A))";;
    P25_K34_A)    cmd="run_enjeksiyon_kararlilik_20261028('$c', 'P', 25, 0.11, struct($base, 'tonlar', $A))";;
    PI_basamak_10_25A_K340) cmd="run_enjeksiyon_kararlilik_20261028('$c', 'PI', [10 25], 0.09, struct('model_kopya', '$MK', 'pencere', [0.07 0.09], 'A', 0, 't_step', 0.055, 'ust', struct('K34', 0)))";;
    *) echo "bilinmeyen kosu $c"; continue;;
  esac
  echo "$(date '+%F %T') BASLA $c ($MK)" >> "$LOG/kuyruk.txt"
  before=$(tasklist //FI "IMAGENAME eq MATLAB.exe" //FO CSV //NH 2>/dev/null | cut -d, -f2 | tr -d '"' | sort)
  "$MATLAB" -batch "addpath('scripts'); $cmd" > "$LOG/$c.txt" 2>&1 &
  lp=$!
  sleep 20
  after=$(tasklist //FI "IMAGENAME eq MATLAB.exe" //FO CSV //NH 2>/dev/null | cut -d, -f2 | tr -d '"' | sort)
  mine=$(comm -13 <(echo "$before") <(echo "$after") | tr '\n' ' ')
  echo "$(date '+%F %T') PID $c: $mine" >> "$LOG/kuyruk.txt"
  t=0; rc=0
  while kill -0 $lp 2>/dev/null; do
    sleep 30; t=$((t+30))
    if [ $t -ge "$LIMIT" ]; then
      echo "$(date '+%F %T') SURE SINIRI ($LIMIT s) ASILDI: $c durduruluyor (PID $mine)" >> "$LOG/kuyruk.txt"
      for p in $mine; do taskkill //F //PID $p >/dev/null 2>&1; done
      kill $lp 2>/dev/null; rc=124; break
    fi
  done
  [ $rc -eq 0 ] && { wait $lp; rc=$?; }
  echo "$(date '+%F %T') BITTI $c rc=$rc" >> "$LOG/kuyruk.txt"
done
echo "$(date '+%F %T') KUYRUK BITTI ($MK)" >> "$LOG/kuyruk.txt"
