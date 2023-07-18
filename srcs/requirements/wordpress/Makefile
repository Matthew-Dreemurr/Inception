IMAGE = inception_wordpress

# Build image
all:
	docker build -t $(IMAGE) .

# For debug/dev purpose
run:
	docker run --rm -it -h $(IMAGE) --name $(IMAGE) $(IMAGE):latest
