RELEASE?=1.0.0
PLATFORM?=linux/amd64,linux/arm64
IMAGE=performance

all: image

image:
	docker buildx build -t "platinumcd/plugin-performance:$(RELEASE)-$(IMAGE)" --load .

push:
	docker buildx build -t "platinumcd/plugin-performance:$(RELEASE)-$(IMAGE)" --platform "$(PLATFORM)" --push .
