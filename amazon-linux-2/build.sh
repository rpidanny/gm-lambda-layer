#!/bin/sh

export GM_VERSION=1.3.35

docker build --build-arg GM_VERSION -t gm-lambda-layer .
docker run --rm gm-lambda-layer cat /tmp/gm-${GM_VERSION}.zip > ./layer.zip
