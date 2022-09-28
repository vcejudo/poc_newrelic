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

## The NewRelic

Allegedly this also can be used to track the execution in NewRelic. This proof of concept has a piece of code that is using some Terraform to create some alerts in NewRelic if some threshold is over some dummy values.

Note the code is a long-running process (pretty long, like 5 minutes or so) to ensure that alerts would happen if more than 15 errors happen in one minute, and we're forcing hundreds of them in 5 minutes or so.

However alerts would appear later in the time.

## Problems so far

Something funny happens with the alert channel. Creating and linking it manually seems to work. No idea why the email alert channel doesn't seem to work yet.
