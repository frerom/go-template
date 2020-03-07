simlun's Golang Project Template
================================

Features
--------

- Containerized build and test environment for portability and super quick
  project setup
- The container image may optionally be cached in a container registry for
  blazingly fast workflows, both for CI servers and developers
- Support for Mac OS and Linux (both amd64 arch)
- Support for Docker and Podman container runtimes
- Linting
- Unit testing (runs containerized on Linux)
- Feature testing (runs the native binary)
- Continous test runners
- Vendored gomodules with a sample YAML parser third party dependency


Getting started
---------------

1. Fork this repo
2. Run `./configure` to set project template variables
3. Run `make` to run make the whole project
4. Commit your chosen template variables and the vendored dependencies


Development
-----------

There are a few `make` commands that provides a development environment with
lots of fast feedback to the developer. It's nice to have these running in
terminal windows/panes next to your favorite editor:

- `make test-features-repeatedly` - just hit the return key to build and run
  all the feature tests.
- `cd go`
    - `make test-continously` to run the unit tests directly on file change.
    - `make lint-continously` to run the linter directly on file change.
