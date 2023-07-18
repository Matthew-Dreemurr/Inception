IMAGE = inception_nginx

# Build image
all:
	docker build -t $(IMAGE) .

# For debug/dev purpose
run:
	docker run --rm  -p 8283:80 -p 8284:443 --name $(IMAGE) $(IMAGE):latest
