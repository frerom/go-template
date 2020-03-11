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
2. Run `.template/configure` to set project template variables
3. Run `make` to run make the whole project
4. Commit your chosen template variables and the vendored dependencies
