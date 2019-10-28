FROM alpine:3.10.3
LABEL maintainer="bschlining@gmail.com"

WORKDIR /opt

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV SPARK_HOME /opt/spark
ENV PYTHONUNBUFFERED TRUE

# Install dependencies we need to keep in final image
RUN apk add --no-cache \
  bash \
  freetype \
  lcms2 \
  libjpeg-turbo \
  libpng \
  libwebp \
  libxml2 \
  libxslt \
  openjdk8 \
  openjpeg \
  python3 \
  zlib

# Install python build prereqs. We'll delete these later
RUN set -e; \
  apk add --no-cache --virtual .build-deps \
    curl \
    freetype-dev \
    g++ \
    gcc \
    lcms2-dev \
    libc-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    mariadb-dev \
    openjpeg-dev \
    postgresql-dev \
    python3-dev \
    zlib-dev

# Install python deps
RUN pip3 install --upgrade pip \
   && pip3 install \
      cmocean \
      dask[complete] \
      iso8601 \
      jaydebeapi \
      jedi \
      jep \
      matplotlib \
      numpy \
      pandas \
      pyspark \
      requests \
      seawater \
      virtualenv \
      xarray

# Install polynote, spark, and then cleanup
RUN curl -L https://github.com/polynote/polynote/releases/download/0.2.8/polynote-dist.tar.gz | tar -xzvpf - \
  && curl -L http://apache.mirrors.hoobly.com/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz | tar -xzvpf - \
  && mv spark* spark \
  && apk del .build-deps

ENV PATH "$PATH:$JAVA_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin"

COPY config.yml ./polynote/config.yml

EXPOSE 8192

CMD bash polynote/polynote