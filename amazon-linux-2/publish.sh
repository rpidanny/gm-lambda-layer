#!/bin/bash

GM_VERSION=1.3.35
LAYER_NAME='graphicsmagick-amzn2'

REGIONS='
ap-northeast-1
ap-northeast-2
ap-south-1
ap-southeast-1
ap-southeast-2
ca-central-1
eu-north-1
eu-central-1
eu-west-1
eu-west-2
eu-west-3
sa-east-1
us-east-1
us-east-2
us-west-1
us-west-2
'

PROFILE='dev'

for region in $REGIONS; do
  aws lambda add-layer-version-permission --region $region --layer-name $LAYER_NAME \
    --statement-id sid1 --action lambda:GetLayerVersion --principal '*' \
    --version-number $(aws lambda publish-layer-version --region $region --layer-name $LAYER_NAME --zip-file fileb://layer.zip \
      --description "GraphicsMagick ${GM_VERSION} binaries for AmazonLinux2" --query Version --output text --profile $PROFILE) --profile $PROFILE
done
