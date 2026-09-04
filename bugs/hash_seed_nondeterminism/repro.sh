#!/bin/zsh
# Reproduces the PYTHONHASHSEED-dependent solving time described in README.md.
#
#   ./repro.sh                 # 6 runs, seed left random  -> mixed fast / timeout
#   ./repro.sh 0               # 6 runs, PYTHONHASHSEED=0
#   ./repro.sh 1               # 6 runs, PYTHONHASHSEED=1
#   N=12 TO=180 REPS=3 ./repro.sh 0
#   OPTS="-t 4 --configuration=trendy" ./repro.sh 1     # the workaround
#
# Env: METASP (binary), N (horizon, default 12), TO (timeout s, default 180),
#      REPS (default 6), OPTS (extra solver options).
#
# Note: ~25s of every run is metasp transform + reify + grounding, before any
# search happens. Keep TO well above that.

set -u
zmodload zsh/datetime   # $EPOCHREALTIME

HERE=bugs/hash_seed_nondeterminism
cd "$(dirname "$0")/../.."   # examples/flingdia, so generated files land in ./out

METASP=${METASP:-/opt/anaconda3/envs/metasp/bin/metasp}
N=${N:-12}
TO=${TO:-180}
REPS=${REPS:-6}
OPTS=${OPTS:-}
SEED=${1:-}

if [[ ! -x $METASP ]]; then
  print -u2 "metasp binary not found at $METASP; set METASP=<path>"
  exit 1
fi

# `timeout` is not available on stock macOS; perl's alarm does the same job.
run_with_timeout() { perl -e 'alarm shift; exec @ARGV' "$@" }

solve=($METASP solve flingo --meta-config config.yaml --warn=no-atom-undefined
       --printer none $HERE/rush_hour_one_mover.lp 1 --project=show
       -c n=$N -c xmax=6 -c ymax=6 ${=OPTS})

print "instance=rush_hour_one_mover.lp n=$N timeout=${TO}s reps=$REPS seed=${SEED:-<random>} opts=${OPTS:-<none>}"

for i in {1..$REPS}; do
  start=$EPOCHREALTIME
  if [[ -n $SEED ]]; then
    out=$(run_with_timeout $TO env PYTHONHASHSEED=$SEED $solve 2>&1)
  else
    out=$(run_with_timeout $TO $solve 2>&1)
  fi
  elapsed=$(printf "%.1f" $((EPOCHREALTIME - start)))
  res=$(print -r -- $out | grep -oE "(UN)?SATISFIABLE" | tail -1)
  print "  run $i: ${elapsed}s ${res:-TIMEOUT}"
done
