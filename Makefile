IMAGE_VERSION=6.11.1
IMAGE_NAME=chrisgarrett/node

all: build

build:
	VERSION=${IMAGE_VERSION} envsubst '$${VERSION}' < ./templates/Dockerfile.template > Dockerfile
	VERSION=${IMAGE_VERSION} envsubst '$${VERSION}' < ./templates/README.md.template > README.md

	docker build --rm=true -t ${IMAGE_NAME}:${IMAGE_VERSION} .

run:
	docker run --rm -it ${IMAGE_NAME}:${IMAGE_VERSION} bash
