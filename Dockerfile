FROM amazonlinux:2

RUN target=/etc/yum.repos.d/linuxtech.repo && echo [linuxtech] > $target \
  && echo name=LinuxTECH >> $target \
  && echo baseurl=http://pkgrepo.linuxtech.net/el6/release/ >> $target\
  && echo enabled=1 >> $target\
  && echo gpgcheck=1 >> $target\
  && echo gpgkey=http://pkgrepo.linuxtech.net/el6/release/RPM-GPG-KEY-LinuxTECH.NET >> $target

RUN yum update -y

RUN yum install -y make zip tar file libpng-devel libjpeg-devel libtiff-devel libuuid-devel gcc gzip liblcms2-devel freetype libXext libSM

ARG GM_VERSION
ARG GS_VERSION

RUN curl https://versaweb.dl.sourceforge.net/project/graphicsmagick/graphicsmagick/${GM_VERSION}/GraphicsMagick-${GM_VERSION}.tar.gz | tar -xvz && \
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
  cp /usr/lib64/libuuid.so /opt/lib/libuuid.so.1
#cp /usr/lib64/libbz2.so* /opt/lib/libbz2.so.1



# RUN mkdir -p /opt/share/fonts/default && \
#   cp -R /usr/share/fonts/default/Type1 /opt/share/fonts/default/Type1

RUN curl -L https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs${GS_VERSION//./}/ghostscript-${GS_VERSION}.tar.gz | tar -xvz
RUN cd ghostscript-${GS_VERSION} && ./configure && make
RUN cd ghostscript-${GS_VERSION} && make install
RUN cp /usr/local/bin/gs /opt/bin/
RUN gs --version

RUN cd /opt && \
  find . ! -perm -o=r -exec chmod +400 {} \; && \
  zip -yr /tmp/gm-${GM_VERSION}.zip ./*


