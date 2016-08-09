# docker-wordpress-nginx

A Dockerfile that installs the latest wordpress, nginx, php-apc and php-fpm.

NB: A big thanks to [jbfink](https://github.com/jbfink/docker-wordpress) who did most of the hard work on the wordpress parts!

You can check out his [Apache version here](https://github.com/jbfink/docker-wordpress).

## Installation

The easiest way to get this docker image installed is to pull the latest version
from the Docker registry:

```bash
$ docker pull traqy/acme-su-webapp
```

If you'd like to build the image yourself then:

```bash
$ git clone git@github.com:traqy/test-teralytics-docker-wp-nginx.git
$ cd test-teralytics-docker-wp-nginx
$ docker build -t="traqy/acme-su-webapp" .
```

## Usage

To spawn a new instance of wordpress on port 80.  The -p 80:80 maps the internal docker port 80 to the outside port 80 of the host machine.

```bash
$ docker run -p 80:80 --name acme-su-webapp -d traqy/acme-su-webapp
```

Start your newly created docker.

```
$ docker start acme-su-webapp
```

After starting the docker-wordpress-nginx check to see if it started and the port mapping is correct.  This will also report the port mapping between the docker container and the host machine.

```
$ docker ps

0.0.0.0:80->80/tcp, 3306/tcp   acme-su-webapp
```
Get your docker machine IP address
```
docker-machine ip
```
You can the visit the following URL in a browser on your host machine to get started:

```
http://<your_machine_ip_address>:80
```

## Tagging and Deploying to AWS ECS

Tag your docker image
```
docker tag traqy/acme-su-webapp 593360083597.dkr.ecr.us-west-2.amazonaws.com/acme-su-webapp:vX.Y.Z
```
```
docker tag traqy/acme-su-webapp 593360083597.dkr.ecr.us-west-2.amazonaws.com/acme-su-webapp:v0.0.1
```

Push your docker image to Amazon ECS Repo
```
docker push 593360083597.dkr.ecr.us-west-2.amazonaws.com/acme-su-webapp:v0.0.1
``` 
