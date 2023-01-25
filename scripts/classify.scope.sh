#!/usr/bin/env bash
if [ ! -d "logs" ]
then
    mkdir logs
fi
exec 1>logs/$(basename "$0").$(date +"%r%d%h%y" | awk '{print $1"_"$2}')."$RANDOM".log 2>&1

echo "$CONDA_PREFIX"

set -u
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
set -o verbose

data_matrix="$1"
outdir="$2"

singularity exec \
    -B "$outdir":/output \
    -B "$data_matrix":/rpkm.txt \
    scope_debug.sif /usr/bin/python3.7 -c \
    'import cancerscope as cs; \
    scope_obj = cs.scope(); \
    predictions_from_file = scope_obj.get_predictions_from_file("/rpkm.txt",outdir = "/output")'
