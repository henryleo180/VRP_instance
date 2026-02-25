#!/usr/bin/env bash
#SBATCH --job-name=gen
#SBATCH --partition=hpg-default
#SBATCH --qos=yu.yang1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=64GB
#SBATCH -t 1:00:00
#SBATCH --output=gen.out
#SBATCH --error=gen.err

set -euo pipefail

cd /blue/yu.yang1/haoran.liu/VRPinstance/Vrp-Set-XML100

SCRIPT_DIR="${SLURM_SUBMIT_DIR:-/blue/yu.yang1/haoran.liu/VRPinstance/Vrp-Set-XML100}"
JOBS="${SLURM_CPUS_PER_TASK:-10}"

cd "$SCRIPT_DIR"
JOBS="$JOBS" ./traindata.sh
JOBS="$JOBS" ./test.sh
