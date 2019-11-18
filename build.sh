#!/bin/sh

export GM_VERSION=1.3.31
export GS_VERSION=9.50

docker build --build-arg GM_VERSION --build-arg GS_VERSION -t gm-lambda-layer .
docker run --rm gm-lambda-layer cat /tmp/gm-${GM_VERSION}.zip > ./layer.zip
