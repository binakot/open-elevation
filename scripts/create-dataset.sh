#!/usr/bin/env bash
set -eu

CUR_DIR=$(pwd)

OUTDIR="data/"
mkdir -p "$OUTDIR"

cd $OUTDIR
../scripts/download-srtm-data.sh
../scripts/create-tiles.sh SRTM_NE_250m.tif 10 10
../scripts/create-tiles.sh SRTM_SE_250m.tif 10 10
../scripts/create-tiles.sh SRTM_W_250m.tif 10 20
#rm -rf SRTM_NE_250m.tif SRTM_SE_250m.tif SRTM_W_250m.tif *.rar

cd $CUR_DIR
