FROM lambci/lambda-base

RUN yum install -y libpng-devel libjpeg-devel libtiff-devel gcc

ARG GM_VERSION

RUN curl -O https://versaweb.dl.sourceforge.net/project/graphicsmagick/graphicsmagick/${GM_VERSION}/GraphicsMagick-${GM_VERSION}.tar.xz | tar -xJ && \
  cd GraphicsMagick-${GM_VERSION} && \
  ./configure --prefix=/opt --enable-shared=no --enable-static=yes && \
  make && \
  make install

RUN cd /opt && \
  find . ! -perm -o=r -exec chmod +400 {} \; && \
  zip -yr /tmp/gm-${GIT_VERSION}.zip ./*
