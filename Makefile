PHONY: build

TAG_VERSION=beta-20230705172314
DOCKER_TAG_NAME=jakegough/javawithdocker

build:
	docker build -t $(DOCKER_TAG_NAME):$(TAG_VERSION) .
	docker tag $(DOCKER_TAG_NAME):$(TAG_VERSION) $(DOCKER_TAG_NAME):latest

push: build
	docker push $(DOCKER_TAG_NAME):$(TAG_VERSION)
	docker push $(DOCKER_TAG_NAME):latest
