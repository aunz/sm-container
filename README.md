# Custom Containers for SageMaker

## Build
```sh
docker build -f <docker-file> -t <reponame>:<tag:version> .

# example
docker build -f Dockerfile.base -t sm-base .
```sh

## Run
```sh
docker run -p 8080:8080 --rm sm-base serve
docker run -v <host-dir>:/opt/ml -p 8080:8080 --rm sm-base serve
docker run -e KEY=VALUE -v <host-dir>:/opt/ml -p 8080:8080 --rm sm-base serve
```

## Extend the base image
Create a new dockerfile with the following content
```sh
FROM sm-base

# copy more stuff
COPY <host-dir> /opt/program
```

## Containers

### The base
- Dockerfile.base, build and call it **sm-base**
- This will run flask
- Has: numpy, pandas, scipy, sklearn
- Also boto3


### The xgboost
- Dockerfile.xgb, call it **sm-xgb**

### The tensorflow
- Dockerfile.tf, call it **sm-tf**

### The nginx & unicorn
- Dockerfile2.base, call it **sm2-base**
- This will run nginx, gunicorn, flask
- Basic stuff rom Dockerfile.base

## The serve file

This file start up flask (optionally gunicorn) and serve request\

In the FrameworkModel, users can specify:
- env={ 'PRINT_SYS': 1 } to print out some default stuff such as os.environ, pip freeze, ls -lah 
- For the entry_point, users need to provide a file, this file need to have:
  - model_fn(model_dir). 
    - model_dir is the dir where the model.tar.gz is stored
    - to return a model
  - transform_fn(raw_data, model)
    - raw_data: could be binary or string, depending on input
    - model: the model from model_fn 
    - to return either a string, or binary or tuple(response, mimetype), so flask can pass onto clients
    
  
## Test

```sh

docker build -f Dockerfile.base -t sm-base .
docker build -f Dockerfile.xgb -t sm-xgb .
docker build -f Dockerfile.tf -t sm-tf .


```

## Save and load

docker save <image>:<tag> | gzip > myimage_latest.tar.gz
```sh
docker save sm-base:latest | gzip > tmp/sm-base-latest.tar.gz
docker save sm-xgb:latest | gzip > tmp/sm-xgb-latest.tar.gz
docker save sm-tf:latest | gzip > tmp/sm-tf-latest.tar.gz
```

docker load
```sh
docker load -i sm-base-latest.tar.gz

```

see packages

```sh
docker run --rm sm-base pip freeze
docker run --rm sm-xgb pip freeze
docker run --rm sm-tf pip freeze
```
