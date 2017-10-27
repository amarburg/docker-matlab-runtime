
TAG = amarburg/matlab-runtime:latest

build:
	docker build . --tag ${TAG}

force_build:
	docker build . --tag ${TAG} --no-cache

push:
	docker push ${TAG}


help:
	@echo "make build              Build the image"
	@echo "make force_build        Build the image with --no-cache"
	@echo "make push               Push to Dockerhub"


.PHONY: build force_build push help
