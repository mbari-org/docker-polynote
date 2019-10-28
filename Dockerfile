FROM alpine:3.10.3
LABEL maintainer="bschlining@gmail.com"

WORKDIR /opt

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV SPARK_HOME /opt/spark
ENV PYTHONUNBUFFERED TRUE

# bash required to run polynote
RUN apk add --no-cache \
  bash \
  openjdk8 \
  python3

# Install python prereqs
RUN set -e; \
  apk add --no-cache --virtual .build-deps \
    curl \
    freetype-dev \
    g++ \
    gcc \
    libc-dev \
    libpng-dev \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    mariadb-dev \
    postgresql-dev \
    python3-dev \
    zlib-dev

# Install python deps
RUN pip3 install \
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
    scipy \
    seawater \
    shapely[vectorized] \
    statsmodels \
    virtualenv \
    xarray


# Install polynote
# RUN curl -L https://github.com/polynote/polynote/releases/download/0.2.8/polynote-dist.tar.gz | tar -xzvpf - \
#   && curl -L http://mirrors.gigenet.com/apache/spark/spark-2.4.4/spark-2.4.4-bin-without-hadoop-scala-2.12.tgz | tar -xvf - \
#   && mv spark* spark \
#   && apk del .build-deps

RUN curl -L https://github.com/polynote/polynote/releases/download/0.2.8/polynote-dist.tar.gz | tar -xzvpf - \
  && curl -L http://apache.mirrors.hoobly.com/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz | tar -xzvpf - \
  && mv spark* spark \
  && apk del .build-deps

ENV PATH "$PATH:$JAVA_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin"

COPY config.yml ./polynote/config.yml

EXPOSE 8192

CMD bash polynote/polynote