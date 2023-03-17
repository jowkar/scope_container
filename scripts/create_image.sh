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

sudo docker build -t scope:debug -f Dockerfile .
#export SINGULARITY_CACHEDIR=/data/s_cache
#export SINGULARITY_TMPDIR=/data/s_tmp
#export SINGULARITY_LIBRARYDIR=/data/s_lib
singularity pull scope_debug.sif docker-daemon:scope:debug
