PHONY: build

JAVA_VERSION=8-jre
DOCKER_TAG_NAME=jakegough/javawithdocker

build:
	docker build --build-arg JAVA_VERSION=$(JAVA_VERSION) -t $(DOCKER_TAG_NAME):$(JAVA_VERSION) .
	docker tag $(DOCKER_TAG_NAME):$(JAVA_VERSION) $(DOCKER_TAG_NAME):latest

push: build
	docker push $(DOCKER_TAG_NAME):$(JAVA_VERSION)
	docker push $(DOCKER_TAG_NAME):latest
