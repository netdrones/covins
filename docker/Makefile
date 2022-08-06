# set NR_JOBS to half the processors by default

# assume docker gets half the cpus on the bare metal and put 2 jobs per core
# so NR_JOBS is the number of processors in the machine given by `nproc`
NR_JOBS ?= $(shell nproc)
#NR_JOBS ?= 5

# registry can be docker.io, ghcr.io, gcr.io for exmaple
# REGISTRY ?= docker.io
REGISTRY ?= ghcr.io
ORG ?= netdrones
IMAGE ?= covins
# set to the sha of the current commit
TAG ?= $(shell git rev-parse HEAD)
# multiplatform builds only work with buildx
PLATFORM ?= linux/amd64,linux/arm64
# these can work with regular docker build to change the platform
#PLATFORM ?= linux/amd64
#PLATFORM ?= linux/arm64

.DEFAULT_GOAL := help
.PHONY: help
# https://swcarpentry.github.io/make-novice/08-self-doc/ is simpler just need
help: $(MAKEFILE_LIST)
	@sed -n 's/^##//p' $(MAKEFILE_LIST)

## build: build single image with amd64 architecture
.PHONY: build
build:
	@echo "Use -j$(NR_JOBS) for build commands"
	@docker build -t $(REGISTRY)/$(ORG)/$(IMAGE):$(TAG) \
			--build-arg NR_JOBS=$(NR_JOBS) \
			-f ./Dockerfile \
			.. && \
	@docker tag $(REGISTRY)/$(ORG)/$(IMAGE):$(TAG) \
		$(REGISTRY)/$(ORG)/$(IMAGE):latest && \
	@docker push --all-tags $(REGISTRY)/$(ORG)/$(IMAGE)

## buildx: build multiple architecture in single image
.PHONY: buildx
buildx:
	docker buildx build -t $(REGISTRY)/$(ORG)/$(IMAGE):$(TAG) \
			--push \
			--platform $(PLATFORM) \
			--build-arg NR_JOBS=$(NR_JOBS) \
			-f ./Dockerfile \
			.. && \
	docker tag $(REGISTRY)/$(ORG)/$(IMAGE):$(TAG) \
		$(REGISTRY)/$(ORG)/$(IMAGE):latest && \
	docker push --all-tags $(REGISTRY)/$(ORG)/$(IMAGE)

## debug: dump all docker buildx messages out
# https://stackoverflow.com/questions/65819424/is-there-a-way-to-increase-the-log-size-in-docker-when-building-a-container
.PHONY: debug
debug:
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
	docker buildx use default

.PHONY: clean
clean:
	@docker rmi -f $(REGIStRY)/$(ORG)/$(IMAGE)
