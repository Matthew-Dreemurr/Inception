REQUIREMENT= wordpress nginx mariadb
REQU_PATH=   $(addprefix srcs/requirements/, $(REQUIREMENT))
VOLUME= db wp
VOLUME_PATH=   $(addprefix $(HOME)/data/, $(VOLUME))

all: run

run:
	for i in $(VOLUME_PATH); do mkdir -p $$i; done
	docker compose -f srcs/docker-compose.yml up


down:
	docker compose -f srcs/docker-compose.yml down


dev: rm run


rm:
	-docker compose -f srcs/docker-compose.yml down
	-for i in $(REQUIREMENT); do docker image rm -f inception_$$i; done
	-for i in $(REQUIREMENT); do docker image rm -f inception/$$i; done
	-for i in $(REQUIREMENT); do docker container rm -f inception_$$i; done
	for i in $(VOLUME_PATH); do sudo rm -rf $$i; done
	-docker volume rm srcs_inception_db_data srcs_inception_app_data