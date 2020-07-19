#!/bin/sh

export GM_VERSION=1.3.31
export GM_MINOR_VERSION=$(echo $GM_VERSION | sed -e "s/\.[0-9]*$//g")

docker build --build-arg GM_VERSION --build-arg GM_MINOR_VERSION -t gm-lambda-layer .
docker run --rm gm-lambda-layer cat /tmp/gm-${GM_VERSION}.zip > ./layer.zip
