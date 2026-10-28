#!/usr/bin/env bash
# İP-5 S4 koşu kuyruğu: tek MATLAB süreci, koşular sırayla. Her koşu ayrı -batch
# çağrısıdır; süre sınırı (saniye) aşılırsa koşu durdurulur ve kuyruk devam eder.
# Çağrı (Git Bash, proje kökünden): bash scripts/queue_s4_20261028.sh <sinir_s> <kosu1> [<kosu2> ...]
# Koşu adları: P_25A PI_25A PI_basamak_10_25A P_10A PI_10A P_2p3A PI_2p3A PIR_25A
ROOT="/c/CODES/ümit abi/tez-matlab-simulink"
LOG="$ROOT/runs/2026-10-28_s4_kapali_cevrim/loglar"
MATLAB="/c/Program Files/MATLAB/R2023b/bin/matlab.exe"
mkdir -p "$LOG"
LIMIT="$1"; shift
cd "$ROOT" || exit 1
for c in "$@"; do
  case "$c" in
    P_25A)   cmd="run_s4_closed_loop_20261028('P_25A', 'P', 25, 0.06)";;
    PI_25A)  cmd="run_s4_closed_loop_20261028('PI_25A', 'PI', 25, 0.06)";;
    PIR_25A) cmd="run_s4_closed_loop_20261028('PIR_25A', 'PIR', 25, 0.06)";;
    P_10A)   cmd="run_s4_closed_loop_20261028('P_10A', 'P', 10, 0.06)";;
    PI_10A)  cmd="run_s4_closed_loop_20261028('PI_10A', 'PI', 10, 0.06)";;
    P_2p3A)  cmd="run_s4_closed_loop_20261028('P_2p3A', 'P', 2.3, 0.06)";;
    PI_2p3A) cmd="run_s4_closed_loop_20261028('PI_2p3A', 'PI', 2.3, 0.06)";;
    PI_basamak_10_25A) cmd="run_s4_closed_loop_20261028('PI_basamak_10_25A', 'PI', [10 25], 0.09, struct('t_step', 0.055, 'simscape', false))";;
    # KC_<koşu>: D-11 (Cdc_pos = Cdc_neg = 5,6 mF) + İP-4 kalibre S3 ileri beslemesi
    # (K14 = 0.44343, K34 = 0.384306, phase_deg4 = 0.6575; runs/2026-10-28_kalibrasyon s3_k6).
    # Paralel kuyruklarda MK ortam değişkeni ayrı model klasörü verir (aynı klasörde eşzamanlı derleme yok).
    KC_*)
      b="${c#KC_}"
      ext="'Cdc', 5.6e-3, 'ust', struct('K14', 0.44343, 'K34', 0.384306, 'phase_deg4', 0.6575), 'model_kopya', '${MK:-model}'"
      case "$b" in
        P_25A)   cmd="run_s4_closed_loop_20261028('$c', 'P', 25, 0.06, struct($ext))";;
        PI_25A)  cmd="run_s4_closed_loop_20261028('$c', 'PI', 25, 0.06, struct($ext))";;
        PIR_25A) cmd="run_s4_closed_loop_20261028('$c', 'PIR', 25, 0.06, struct($ext))";;
        P_10A)   cmd="run_s4_closed_loop_20261028('$c', 'P', 10, 0.06, struct($ext))";;
        PI_10A)  cmd="run_s4_closed_loop_20261028('$c', 'PI', 10, 0.06, struct($ext))";;
        P_2p3A)  cmd="run_s4_closed_loop_20261028('$c', 'P', 2.3, 0.06, struct($ext))";;
        PI_2p3A) cmd="run_s4_closed_loop_20261028('$c', 'PI', 2.3, 0.06, struct($ext))";;
        PI_basamak_10_25A) cmd="run_s4_closed_loop_20261028('$c', 'PI', [10 25], 0.09, struct('t_step', 0.055, 'simscape', false, $ext))";;
        *) echo "bilinmeyen kosu $c"; continue;;
      esac;;
    *) echo "bilinmeyen kosu $c"; continue;;
  esac
  echo "$(date '+%F %T') BASLA $c" >> "$LOG/kuyruk.txt"
  before=$(tasklist //FI "IMAGENAME eq MATLAB.exe" //FO CSV //NH 2>/dev/null | cut -d, -f2 | tr -d '"' | sort)
  "$MATLAB" -batch "addpath('scripts'); $cmd" > "$LOG/$c.txt" 2>&1 &
  lp=$!
  sleep 20
  after=$(tasklist //FI "IMAGENAME eq MATLAB.exe" //FO CSV //NH 2>/dev/null | cut -d, -f2 | tr -d '"' | sort)
  mine=$(comm -13 <(echo "$before") <(echo "$after") | tr '
' ' ')
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
echo "$(date '+%F %T') KUYRUK BITTI" >> "$LOG/kuyruk.txt"
