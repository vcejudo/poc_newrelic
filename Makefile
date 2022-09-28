test:
	clj -M:test

run:
	clj -M -m main

build:
	clj -T:build uberjar

run-newrelic-docker:
	docker run \
	-d \
	--name newrelic-infra \
	--network=host \
	--cap-add=SYS_PTRACE \
	--privileged \
	--pid=host \
	-v "/:/host:ro" \
	-v "/var/run/docker.sock:/var/run/docker.sock" \
	-e NRIA_LICENSE_KEY=eu01xx50da91ea3c02e7335f86b19ade332eNRAL \
	newrelic/infrastructure:latest

docker: build
	docker build -t poc/nr-example .

.PHONY: test run build docker
