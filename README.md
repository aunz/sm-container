# Custom Base Container for SageMaker

## Build

docker build -t sm-base:<version> .

## Run

docker run -p 8080:8080 --rm sm-base serve
docker run -v <host-dir>:/opt/ml -p 8080:8080 --rm sm-base serve
docker run -e KEY=VALUE -v <host-dir>:/opt/ml -p 8080:8080 --rm sm-base serve


## Extend the base image
Create a new dockerfile with the following content
```sh
FROM sm-base

# copy more stuff
COPY <host-dir> /opt/program
```

