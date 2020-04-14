#!/bin/bash

group=(`cat gradle.properties | grep "group" | cut -d= -f2`)
name=(`cat gradle.properties | grep "serviceName" | cut -d= -f2`)
image_tag=(`cat gradle.properties | grep "serviceVersion" | cut -d= -f2`)

echo "Building Memory service docker image tagged as [$image_tag]"
read -p "Press [Enter] to continue..." any_key;

docker build --tag="$group/$name:$image_tag" . \
  && echo "Built Memory Service image successfully tagged as $group/$name:$image_tag" \
  && docker images "$group/$name:$image_tag"
