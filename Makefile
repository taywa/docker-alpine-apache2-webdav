version=0.3

default: build

build:
	cd files; tar cf ../files.tar *
	docker build -t yvess/alpine-apache2-webdav:$(version) .
	rm files.tar

push:
	docker push yvess/alpine-apache2-webdav:$(version)
