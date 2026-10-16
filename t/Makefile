#!/usr/bin/make -f

SHELL=bash

help:
	@echo "make prepare|update|test"

update:
	docker compose pull
	docker pull $$(awk '/^FROM / { print $$2 }' ../Dockerfile.debian-xfce-vnc)

clean:
	docker compose kill
	docker compose rm -f
	-docker network prune -f

prepare:
	docker compose build --no-cache
	docker compose up --remove-orphans -d
	docker ps
	@while read LOGLINE; do \
		echo "$${LOGLINE}"; \
		[[ "$${LOGLINE}" == *"connect via"*":6901/?password="* ]] && exit 0; \
		[[ "$${LOGLINE}" == *"ERROR"* ]] && exit 1; \
	done < <(docker compose logs -f)

test: prepare
	perl -MExtUtils::Command::MM -e "test_harness(1)" *.t
