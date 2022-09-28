# PoC NewRelic

This is a proof of concept of using NewRelic and storing events and whatnot in there.

## Prerequisites

To run it, you need to be aware of several things:

- You need Docker installed
- You need an account of NewRelic. You need to edit the `license_key` from the `newrelic/newrelic.yml` file and set the valid license key.
- You need to have a NewRelic agent installed on your computer. If you had a NewRelic account, it would following the instructions to do so.
- Before running the application, you need to run the Docker agent. There's a command to do so: `make run-newrelic-docker`

## Running the application

To run the application, you need to create a Docker image and then run it:

```sh
make docker
docker run poc/nr-example
```
