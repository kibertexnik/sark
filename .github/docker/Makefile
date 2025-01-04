# Reference followed: https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux

TAG := main

default: local

local:
	cp ../../Gemfile .
	docker build                                           \
	    --tag ghcr.io/kibertexnik/sark-dev:$(TAG)              \
	    --build-arg VCS_REF=`git rev-parse --short HEAD` .
	rm Gemfile

push:
	cp ../../Gemfile .
	docker buildx build                                    \
	    --push                                             \
	    --platform linux/arm64/v8,linux/amd64              \
	    --tag ghcr.io/kibertexnik/sark-dev:$(TAG)              \
	    --build-arg VCS_REF=`git rev-parse --short HEAD` .
	rm Gemfile
