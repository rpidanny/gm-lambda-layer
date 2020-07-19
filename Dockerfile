FROM lambci/lambda-base:build

RUN yum update -y

RUN yum install -y libpng-devel libjpeg-devel libtiff-devel libuuid-devel gcc

ARG GM_VERSION
ARG GM_MINOR_VERSION

RUN curl "ftp://ftp.graphicsmagick.org/pub/GraphicsMagick/$GM_MINOR_VERSION/GraphicsMagick-$GM_VERSION.tar.xz" | tar -xJ && \
  cd GraphicsMagick-${GM_VERSION} && \
  ./configure --prefix=/opt --enable-shared=no --enable-static=yes --with-gs-font-dir=/opt/share/fonts/default/Type1 && \
  make && \
  make install

RUN cp /usr/lib64/liblcms2.so* /opt/lib && \
  cp /usr/lib64/libtiff.so* /opt/lib && \
  cp /usr/lib64/libfreetype.so* /opt/lib && \
  cp /usr/lib64/libjpeg.so* /opt/lib && \
  cp /usr/lib64/libpng*.so* /opt/lib && \
  cp /usr/lib64/libXext.so* /opt/lib && \
  cp /usr/lib64/libSM.so* /opt/lib && \
  cp /usr/lib64/libICE.so* /opt/lib && \
  cp /usr/lib64/libX11.so* /opt/lib && \
  cp /usr/lib64/liblzma.so* /opt/lib && \
  cp /usr/lib64/libxml2.so* /opt/lib && \
  cp /usr/lib64/libgomp.so* /opt/lib && \
  cp /usr/lib64/libjbig.so* /opt/lib && \
  cp /usr/lib64/libxcb.so* /opt/lib && \
  cp /usr/lib64/libXau.so* /opt/lib && \
  cp /usr/lib64/libuuid.so /opt/lib/libuuid.so.1 && \  
  cp /usr/lib64/libbz2.so /opt/lib/libbz2.so.1

RUN mkdir -p /opt/share/fonts/default && \
  cp -R /usr/share/fonts/default/Type1 /opt/share/fonts/default/Type1

RUN cd /opt && \
  find . ! -perm -o=r -exec chmod +400 {} \; && \
  zip -yr /tmp/gm-${GM_VERSION}.zip ./*
