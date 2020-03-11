ifeq ($(shell test -e .template/.program && echo ok || echo fail), fail)
$(error Please run '.template/configure' first)
endif

SHELL := bash

export PATH := $(shell pwd)/scripts:$(PATH)
export PATH := $(shell pwd)/bin:$(PATH)

export PROGRAM := $(shell cat .template/.program)

BUILD_OS := $(shell uname | tr '[:upper:]' '[:lower:]')

# TODO Auto detect to support building on ARM
BUILD_ARCH := amd64

.PHONY: default
default: all

.PHONY: all
all:
	$(MAKE) clean
	@echo
	@echo
	@echo "Building and unit testing the Golang code"
	@echo "in a containerized build environment"
	@echo "========================================="
	@echo
	$(MAKE) -C src
	@echo
	@echo
	@echo "Building program container images"
	@echo "================================="
	@echo
	$(MAKE) -C src -f Makefile.images
	@echo
	@echo
	@echo "Running native feature tests on your current platform"
	@echo "====================================================="
	@echo
	$(MAKE) test-features
	@echo
	@echo
	@echo "Running containerized feature tests for your architecture"
	@echo "========================================================="
	@echo
	$(MAKE) test-features-container
	@echo
	@echo
	@echo "============================================="
	@echo "Complete project build finished successfully!"

bin:
	mkdir -p bin

# Not really phony but I want to rebuild each time:
.PHONY: bin/$(PROGRAM)
bin/$(PROGRAM): | bin
	$(MAKE) -C src bin/$(PROGRAM)-$(BUILD_OS)-$(BUILD_ARCH)
	cp src/bin/$(PROGRAM)-$(BUILD_OS)-$(BUILD_ARCH) bin/$(PROGRAM)

# The feature tests are language agnostic and only requires '$(PROGRAM)' to be
# found on the $PATH.
.PHONY: test-features
test-features: bin/$(PROGRAM)
	run-feature-tests

.PHONY: test-features-repeatedly
test-features-repeatedly:
	@bash -c 'while true; do \
		export TIMEFORMAT='%3lR'; \
		time make --quiet test-features; \
		echo "> Hit return to repeat..."; \
		read; \
		clear; \
		done'

.PHONY: test-features-container
test-features-container:
	$(MAKE) -C src -f Makefile.images "image($(BUILD_ARCH))"
	PROGRAM=run-program-container \
			PROGRAM_IMAGE=$(PROGRAM):linux-$(BUILD_ARCH)-latest
			run-feature-tests

.PHONY: clean
clean:
	$(MAKE) -C src clean
	rm -rf bin

.PHONY: clean-template
clean-template: clean
	rm -rfv \
		src/go.mod \
		src/vendor/* \
		.template/golang-build-environment/.home \
		.template/.program \
		.template/.registry \
		.template/.runtime.log
	git clean -fx
