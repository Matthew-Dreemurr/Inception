# Build image
all:
	docker build -t inception_nginx .

# For debug/dev purpose
run:
	docker run --rm  -p 8283:80 -p 8284:443 --name inception_nginx inception_nginx:latest
