.PHONY: all enter

DOCKER_NAME=$(shell basename `pwd`|tr -d '_')_apache2_1
DOCKER_EXEC=$(shell command -v docker > /dev/null && echo "docker exec -it $(DOCKER_NAME)")

enter:
	$(DOCKER_EXEC) ash

start_apache2:
	$(DOCKER_EXEC) s6-svc -u /var/run/s6/services/apache2

stop_apache2:
	$(DOCKER_EXEC) s6-svc -d /var/run/s6/services/apache2

start-vsftpd:
	$(DOCKER_EXEC) s6-svc -u /var/run/s6/services/vsftpd

stop-vsftpd:
	$(DOCKER_EXEC) s6-svc -d /var/run/s6/services/vsftpd
