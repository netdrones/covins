## Dockerized Make for Covins
SHELL=/bin/bash
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
.PHONY: warning
warning:
	@echo "32GB RAM and 5 cores in docker required for NR_JOBS=10"
	@echo "24GB RAM and 5 cores in docker required for NR_JOBS=5"
	@echo "16GB RAM and 5 cores in docker fails with NR_JOBS=10"
	@echo "7GB RAM and 2-core CPU (eg GitHub Actions) NR_JOBS=1, single PLATFORM"

## stats: memory and other stats of containers
.PHONY: stats
stats:
	@docker stats

## clean: remove docker images
.PHONY: clean
clean:
	@docker rmi -f $(REGIStRY)/$(ORG)/$(IMAGE)
