version=0.2

default: build

build:
	cd files; tar cf ../files.tar *
	docker build -t yvess/alpine-apache2-webdav:$(version) .
	rm files.tar
