rm -rf layer && unzip layer.zip -d layer

cd test

docker run -i --rm \
  -v "$PWD":/var/task \
  -v "$PWD"/../layer:/opt \
  lambci/lambda:nodejs12.x \
  index.handler

docker run -i --rm \
  -v "$PWD":/var/task \
  -v "$PWD"/../layer:/opt \
  lambci/lambda:python3.7 \
  main.handler
