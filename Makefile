
build: build-debian-xfce-vnc

build-debian-xfce-vnc:
	docker build --no-cache -t local/debian-xfce-vnc -f ./Dockerfile.debian-xfce-vnc .

run: run-debian-xfce-vnc

run-debian-xfce-vnc:
	docker run -ti --rm -p 6901:6901 -p 5901:5901 local/debian-xfce-vnc

clean:
	$(MAKE) -C t clean

test:
	$(MAKE) -C t test
