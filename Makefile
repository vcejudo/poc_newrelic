test:
	clj -M:test

run:
	clj -M -m main

build:
	clj -T:build uberjar

docker: build
	docker build -t poc/nr-example .

.PHONY: test run docker
