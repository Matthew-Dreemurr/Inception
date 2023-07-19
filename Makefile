REQUIREMENT= wordpress nginx mariadb
REQU_PATH=   $(addprefix srcs/requirements/, $(REQUIREMENT))

all: build

build:
	for i in $(REQU_PATH); do make -C $$i; done

run:

rm:
	for i in $(REQUIREMENT); do docker image rm -f inception_$$i; done
	for i in $(REQUIREMENT); do docker container rm -f inception_$$i; done
