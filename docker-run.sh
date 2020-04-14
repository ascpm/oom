#!/bin/bash

docker stop memory > /dev/null 2>&1
docker rm memory > /dev/null 2>&1

group=(`cat gradle.properties | grep "group" | cut -d= -f2`)
name=(`cat gradle.properties | grep "serviceName" | cut -d= -f2`)
image_tag=(`cat gradle.properties | grep "serviceVersion" | cut -d= -f2`)

docker run -d -p 8080:8080 --name="memory" $group/$name:"${image_tag}"
docker logs -f memory
