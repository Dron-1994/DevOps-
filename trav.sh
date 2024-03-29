#!/bin/bash

function tag_and_push {
	    if [ -n "$1" ] && [ -n "$IMAGE_NAME" ]; then
		echo "Pushing docker image to hub tagged as $IMAGE_NAME:$1"
                docker build -t $IMAGE_NAME:$1 -t $IMAGE_NAME -f Dockerfile_Travis . 
		docker push $IMAGE_NAME
		docker push $IMAGE_NAME:$1
	    fi
}

VERSION_TAG=v.$TRAVIS_BUILD_NUMBER

if [ "${TRAVIS_GO_VERSION}" = "${GO_FOR_RELEASE}" ]; then

cat > ~/.dockercfg << EOF

{
  "https://index.docker.io/v1/": {
    "auth": "${ZHJvbjI2Mzc6RHJvbl8yNjM3}",
    "email": "${dronbarabash2637@gmail.com}"
  }
}
EOF
 
    tag_and_push $VERSION_TAG
else
    echo "No image to build"
fi	
