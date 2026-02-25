#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${SCRIPT_DIR}/train"
JOBS="${JOBS:-${SLURM_CPUS_PER_TASK:-1}}"

DEPOT_POS=2
CUST_POS=1
DEMAND_DIST=7
AVG_ROUTE=3
SEED_BASE="${SEED_BASE:-100000}"
SEED="$SEED_BASE"

mkdir -p "$OUT_DIR"
cd "$OUT_DIR"

emit_group() {
  local n=$1
  local count=$2
  local start_id=${3:-1}

  for ((i=0; i<count; i++)); do
    local id=$((start_id + i))
    local seed=$SEED
    SEED=$((SEED + 1))
    printf '%s\n' "$n" "$DEPOT_POS" "$CUST_POS" "$DEMAND_DIST" "$AVG_ROUTE" "$id" "$seed"
  done
}

run_cmds() {
  local jobs=$1
  xargs -P "$jobs" -n 7 python "$SCRIPT_DIR/generator.py"
}

run_cmds "$JOBS" < <(
  emit_group 50 25
  emit_group 75 25
  emit_group 100 50
)
