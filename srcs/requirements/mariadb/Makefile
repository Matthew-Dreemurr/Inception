IMAGE = inception_mariadb

# Build image
all:
	docker build -t inception_mariadb .

# For debug/dev purpose
run:
	docker run --rm -p 8383:3306  --name inception_mariadb \
							-e SQL_DATABASE=test3 \
							-e SQL_USER=qwer \
							-e SQL_PASSWORD=0000 \
							-e SQL_ROOT_PASSWORD=0000 \
							-v ./data:/var/lib/mysql \
							inception_mariadb:latest
debug:
	docker run -it --rm  --name inception_mariadb \
							-e SQL_DATABASE=test \
							-e SQL_USER=mysql \
							-e SQL_PASSWORD=0000 \
							-e SQL_ROOT_PASSWORD=0000 \
							inception_mariadb:latest
