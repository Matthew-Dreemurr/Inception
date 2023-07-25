REQUIREMENT= wordpress nginx mariadb
REQU_PATH=   $(addprefix srcs/requirements/, $(REQUIREMENT))

all: run

build:
	for i in $(REQU_PATH); do make -C $$i; done

run:
	-for i in $(REQU_PATH); do mkdir -p $$i/data; done
	docker compose -f srcs/docker-compose.yml up

up:
	docker compose -f srcs/docker-compose.yml up

down:
	docker compose -f srcs/docker-compose.yml down


dev: rm run


rm:
	-docker compose -f srcs/docker-compose.yml down
	-for i in $(REQUIREMENT); do docker image rm -f inception_$$i; done
	-for i in $(REQUIREMENT); do docker image rm -f inception/$$i; done
	-for i in $(REQUIREMENT); do docker container rm -f inception_$$i; done
	-for i in $(REQU_PATH);   do sudo rm -rf $$i/data ; done
	-docker volume rm srcs_inception_db_data srcs_inception_app_data