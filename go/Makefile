PROGRAM := $(shell cat .program)
SHELL := $(shell pwd)/bash.sh

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

SRC := $(shell find . -maxdepth 1 -name '*.go' | xargs)

bin/$(PROGRAM)-linux-amd64: $(SRC)
	GOOS=linux GOARCH=amd64 go build -o $@ $(SRC)

bin/$(PROGRAM)-darwin-amd64: $(SRC)
	GOOS=darwin GOARCH=amd64 go build -o $@ $(SRC)

.PHONY: build
build: bin/$(PROGRAM)-linux-amd64 bin/$(PROGRAM)-darwin-amd64

.PHONY: vendor
vendor:
	go mod vendor

.PHONY: clean
clean:
	rm -rfv bin/*
