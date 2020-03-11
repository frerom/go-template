NAME_OF_PROJECT
===============

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
- `cd src`
    - `make test-continously` to run the unit tests directly on file change.
    - `make lint-continously` to run the linter directly on file change.
