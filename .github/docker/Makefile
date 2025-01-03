# Reference followed: https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux

TAG := 2025.01

default: build_local

build_local:
	cp ../../Gemfile .
	docker build                                           \
	    --tag kibertexnik/sark-dev:$(TAG)              \
	    --build-arg VCS_REF=`git rev-parse --short HEAD` .
	rm Gemfile

buildx_push:
	cp ../../Gemfile .
	docker buildx build                                    \
	    --push                                             \
	    --platform linux/arm64/v8,linux/amd64              \
	    --tag kibertexnik/sark-dev:$(TAG)              \
	    --build-arg VCS_REF=`git rev-parse --short HEAD` .
	rm Gemfile
