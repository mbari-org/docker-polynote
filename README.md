# docker-polynote

This is a docker container for running [polynote](https://polynote.org/) locally. It includes [Apache Spark 3 (using Scala 2.12)](https://spark.apache.org/).

## Usage

```bash
docker run -p 8192:8192 -v $HOME/Documents/Notebooks:/opt/polynote/notebooks --name polynote mbari/polynote
```

## Build

### Java 11

```bash
docker build ---push -t mbari/polynote:0.4.2 -t mbari/polynote:latest -f Dockerfile.jdk11 .
docker push mbari/polynote
```

```bash
docker buildx build --platform linux/amd64,linux/arm64 --push -t mbari/polynote:latest -f Dockerfile.jdk11 .
```

