## Dockerized Make for Covins
SHELL := /usr/bin/env bash
NR_JOBS != $(($(nproc)/2))
# NR_JOBS ?= $(shell nproc)

TAG ?= v1.0.1

# registry can be docker.io, ghcr.io, gcr.io for exmaple
# REGISTRY ?= docker.io
REGISTRY ?= docker.io
ORG ?= vis4rob
IMAGE ?= covins
# pushing is optional
ifdef PUSH
  FLAGS += --push
endif
MEMORY != docker info | grep "Total Memory" | sed 's/[^0-9\.]*//g'

# to push set PUSH ?= --push
# set to the sha of the current commit
TAG ?= $(shell git rev-parse HEAD)
# Cannot run multiple arch if memory <= 7GB
#PLATFORM ?= linux/amd64,linux/arm64
#PLATFORM ?= $(shell echo $(MULTI_PLATFORM) | sed 's/ /,/g')
# these can work with regular docker build to change the platform
PLATFORM ?= linux/amd64
#PLATFORM ?= linux/arm64

.DEFAULT_GOAL := help
.PHONY: help
# https://swcarpentry.github.io/make-novice/08-self-doc/ is simpler just need
help: $(MAKEFILE_LIST)
	@sed -n 's/^##//p' $(MAKEFILE_LIST)


## build: build multiple architecture in single image with buildx
# create a builder with large log file
.PHONY: build
build: warning
	@time ( \
		if ! docker buildx ls | grep -q build-$(IMAGE); then \
			docker buildx create --name build-$(IMAGE) --use \
				--driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=100000000 \
		; fi && \
		docker buildx build -t $(REGISTRY)/$(ORG)/$(IMAGE):$(TAG) \
			$(FLAGS) \
			--platform $(PLATFORM) \
			--build-arg NR_JOBS=$(NR_JOBS) \
			-f ./Dockerfile \
			.. && \
		docker tag $(REGISTRY)/$(ORG)/$(IMAGE):$(TAG) \
			$(REGISTRY)/$(ORG)/$(IMAGE):latest && \
		docker push --all-tags $(REGISTRY)/$(ORG)/$(IMAGE) && \
		docker buildx rm build-$(IMAGE) \
	)	

## single: build one architecture at time to lower memory used
.PHONY: single
single: warning
	@time ( \
		docker build -t $(REGISTRY)/$(ORG)/$(IMAGE):$(TAG) \
			--build-arg NR_JOBS=$(NR_JOBS) \
			-f ./Dockerfile \
			.. && \
		docker tag $(REGISTRY)/$(ORG)/$(IMAGE):$(TAG) \
			$(REGISTRY)/$(ORG)/$(IMAGE):latest && \
		docker push --all-tags $(REGISTRY)/$(ORG)/$(IMAGE) \
	)

## debug: dump all docker buildx messages out
# https://stackoverflow.com/questions/65819424/is-there-a-way-to-increase-the-log-size-in-docker-when-building-a-container
.PHONY: debug
debug:
	@time ( \
		if ! docker buildx ls | grep -q "^big"; then \
		docker buildx create --name big --driver-opt \
			env.BUILDKIT_STEP_LOG_MAX_SIZE=100000000; \
		fi && \
		docker buildx use big && \
		docker buildx build -t $(REGISTRY)/$(ORG)/$(IMAGE):$(TAG) \
				--push \
				--progress plain  \
				--platform $(PLATFORM) \
				--build-arg NR_JOBS=$(NR_JOBS) \
				-f ./Dockerfile \
				.. && \
		docker tag $(REGISTRY)/$(ORG)/$(IMAGE):$(TAG) \
			$(REGISTRY)/$(ORG)/$(IMAGE):latest && \
		docker push --all-tags $(REGISTRY)/$(ORG)/$(IMAGE) && \
		docker buildx use default \
	)	

## tag: tag image with TAG=semvar
.PHONY: tag
tag:
	@git tag -a $(TAG) -m "tagged with $(TAG)" && \
	git push --tags


## warning: RAM and processor requirements
# note need to use bc because bash does not support floating comparison
# https://stackoverflow.com/questions/33111191/bash-bc-curl-comparing-variables
# Note that the values in a GiB so slightly more than a GB
.PHONY: warning
warning:
	@echo "$(MEMORY) RAM available need at least 7GB and 32GB for multiarch" && \
	if [[ $(PLATFORM) =~ , ]] && (( $$(bc <<<"$(MEMORY) <= 31") )); then \
		echo "WARNING: Multiple build require at least 32GB of RAM"; \
	fi && \
	if (( $$(bc <<<"$(MEMORY) <= 6.8") )); then \
	    echo "WARNING: build requires more than 7GB of RAM"; \
	fi

## stats: memory and other stats of containers
.PHONY: stats
stats:
	@docker stats

## clean: remove docker images
.PHONY: clean
clean:
	@docker rmi -f $(REGIStRY)/$(ORG)/$(IMAGE)
