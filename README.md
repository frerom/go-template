Foo
===

Project Template
----------------

See [.template/README.md](.template/README.md).


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

Building
--------

`make build` will compile Go binaries for all supported architectures.


Program Container Images
------------------------

The `go/Makefile.images` file is for building slim Linux container images that
run your program.

- Build for all architectures:
    - `make -f Makefile.images`
- Build only for AMD64:
    - `make -f Makefile.images "image(amd64)"`
- Build only for ARM32v6 (Raspberry Pi 1 for example):
    - `make -f Makefile.images "image(arm32v6)"`
