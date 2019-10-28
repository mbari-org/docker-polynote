# docker-polynote

This is a docker container for running [polynote](https://polynote.org/) locally. It includes [Apache Spark (using Scala 2.11)](https://spark.apache.org/). I threw in a bunch of useful analysis libraries for oceanographic data too.

## Usage

```bash
docker run --p 8192:8192 -v $HOME/mynotebooks:/opt/polynote/notebooks --name polynote mbari/polynote
```

## Build

```bash
docker build -t mbari/polynote:0.2.8 .
docker push mbari/polynote
```