# UpdateHub Local Server Docker Image

UpdateHub provides a generic and safe Firmware Over-The-Air agent for
Embedded and Industrial Linux-based devices. This repository provides
a UpdateHub local server for test and development.

## Usage

```
docker run --rm \
       -v $PWD:/data \
       -p 8080 \
       -it updatehub/local-server
```
