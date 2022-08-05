# set NR_JOBS to half the processors by default

# default half the cpus are allocated to docker and put 2 jobs per core
NR_JOBS ?= $(shell nproc)
#NR_JOBS ?= 5

# change this as needed
REGISTRY ?= ghcr.io
ORG ?= netdrones
IMAGE ?= covins
TAG ?= latest
PLATFORM ?= linux/amd64,linux/arm64

.PHONY: all
all: help

.PHONY: help
help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   make build        - build docker image"
	@echo "   make buildx       - buildx docker multiarch"
	@echo "   make clean        - remove all images"
	@echo ""

.PHONY: build
build:
	@echo "Use -j$(NR_JOBS) for build commands"
	@docker build -t $(REGISTRY)/$(ORG)/$(IMAGE):$(TAG) \
			-f ./Dockerfile --build-arg NR_JOBS=$(NR_JOBS) ..

.PHONY: buildx
buildx:
	docker buildx build -t $(REGISTRY)/$(ORG)/$(IMAGE):$(TAG) \
			--platform $(PLATFORM) \
			-f ./Dockerfile \
			--build-arg NR_JOBS=$(NR_JOBS) ..

.PHONY: clean
clean:
	@docker rmi -f covins
