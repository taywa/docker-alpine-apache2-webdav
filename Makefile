version=0.3

default: build

build:
	cd files; gtar cf ../files.tar --owner=0 --group=0 *
	docker build -t yvess/alpine-apache2-webdav:$(version) .
	rm files.tar

push:
	docker push yvess/alpine-apache2-webdav:$(version)
