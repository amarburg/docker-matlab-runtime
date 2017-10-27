
TAG = amarburg/matlab-runtime:latest

build:
	docker build . --tag ${TAG}

force_build:
	docker build . --tag ${TAG} --no-cache


help:
	@echo "make build              Build the image"
	@echo "make force_build        Build the image with --no-cache"


.PHONY: build force_build help
