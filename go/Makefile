PROGRAM := $(shell cat ../.template/.program)

# Everything below runs in a Golang build container
SHELL := $(shell pwd)/../.template/golang-build-environment/bash.sh

.PHONY: default
default: all

.PHONY: all
all: clean vendor lint test build

.PHONY: lint
lint:
	golangci-lint run

.PHONY: lint-continously
lint-continously:
	filewatcher -x ./Makefile -x '**/.*.sw*' bash -c 'clear; golangci-lint run'

.PHONY: test
test:
	go test

.PHONY: test-continously
test-continously:
	filewatcher -x ./Makefile -x '**/.*.sw*' bash -c 'clear; go test'

SRC := $(shell find . -name '*.go' | xargs)

bin/$(PROGRAM)-linux-amd64: $(SRC)
	GOOS=linux GOARCH=amd64 go build -o $@ ./...

bin/$(PROGRAM)-linux-arm32v6: $(SRC)
	@# For Raspberry Pi 1, etc.
	GOOS=linux GOARCH=arm GOARM=6 go build -o $@ ./...

bin/$(PROGRAM)-darwin-amd64: $(SRC)
	GOOS=darwin GOARCH=amd64 go build -o $@ ./...

.PHONY: build
build: \
	bin/$(PROGRAM)-linux-amd64 \
	bin/$(PROGRAM)-linux-arm32v6 \
	bin/$(PROGRAM)-darwin-amd64

.PHONY: vendor
vendor:
	go mod vendor

.PHONY: clean
clean:
	rm -rfv bin
