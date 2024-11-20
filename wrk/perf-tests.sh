#!/usr/bin/env bash
set -e

echo "Single client:"
docker run --rm -it \
    -v $(pwd)/wrk:/wrk \
    --network host \
    ruslanys/wrk:alpine \
    -t1 -c1 -d1m --latency --timeout 10s -s ./wrk/random-latlng.lua http://localhost:8080

echo "Many clients:"
docker run --rm -it \
    -v $(pwd)/wrk:/wrk \
    --network host \
    ruslanys/wrk:alpine \
    -t8 -c100 -d1m --latency --timeout 10s -s ./wrk/random-latlng.lua http://localhost:8080
