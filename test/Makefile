.PHONY: all

DOCKER_NAME=$(shell basename `pwd`|tr -d '_')_apache2_1
DOCKER_EXEC=$(shell command -v docker > /dev/null && echo "docker exec -it $(DOCKER_NAME)")

enter:
	$(DOCKER_EXEC) ash

start:
	$(DOCKER_EXEC) s6-svc -u /var/run/s6/services/apache2

stop:
	$(DOCKER_EXEC) s6-svc -d /var/run/s6/services/apache2
