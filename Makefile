
TAG = amarburg/matlab-runtime:2020a

default: help

$(warning $(http_proxy) $(origin http_proxy))

ifdef http_proxy
	HTTP_PROXY_ARG := --build-arg http_proxy=$(http_proxy)
endif

build:
	docker build ${HTTP_PROXY_ARG} . --tag ${TAG}

force_build:
	docker build ${HTTP_PROXY_ARG} . --tag ${TAG} --no-cache

push:
	docker push ${TAG}

PROXY_PORT = 51234

proxy:
	echo "Set: export http_poxy=http://<local ip address>:${PROXY_PORT}/"
	docker run --rm -t --name docker-matlab-runtime-cache \
							-p ${PROXY_PORT}:80 \
							--sysctl net.ipv4.ip_local_port_range="1024 64000" \
							-v $(shell pwd)/proxy/nginx.conf:/etc/nginx/nginx.conf:ro \
							-v /tmp/docker-matlab-runtime-cache:/tmp/httpcache \
							nginx:stable-alpine



help:
	@echo "make build              Build the image"
	@echo "make force_build        Build the image with --no-cache"
	@echo "make push               Push to Dockerhub"
	@echo "make proxy              Start a local Nginx proxy for caching the huge downloads from Matlab"

.PHONY: build force_build push help proxy
