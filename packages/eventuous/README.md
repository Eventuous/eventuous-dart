[![Pub](https://img.shields.io/pub/v/eventuous.svg)](https://pub.dev/packages/eventuous)
[![Dart](https://github.com/Eventuous/eventuous-dart/actions/workflows/dart.yml/badge.svg)](https://github.com/Eventuous/eventuous-dart/actions/workflows/dart.yml)
[![codecov](https://codecov.io/gh/Eventuous/eventuous-dart/branch/master/graph/badge.svg?token=HAHS8DUBHM)](https://codecov.io/gh/Eventuous/eventuous-dart)


A lightweight Event Sourcing library for Dart, which is:
- Very volatile
- Extremely opinionated
- [EventStoreDB](https://eventstore.com)-oriented

Authors:
- [Kenneth Gulbrandsøy](https://medium.com/kengu)
- [Alexey Zimarev](https://zimarev.com)

This package is still in active development and not yet reached a stable version. 
Use it on your own risk. You should expect breaking changes that will require 
refactoring both code and behaviors of code depending on this package. When 
stable 1.0.0 is released, we pledge to keep the package backwards compatible 
within each major version. 

## Usage and documentation
This package is not yet properly documented, use 
[docs](https://eventuous.dev) (incomplete) written for 
the [.NET version](https://github.com/Eventuous/eventuous/) for an introduction to 
core principles for developing event sourced applications. We also highly recommend
that you use the [code generation tool][generator] to remove the
boilerplate code needed to build you application using event sourcing using this library. 

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[generator]: https://pub.dev/packages/eventuous_generator
[tracker]: https://github.com/Eventuous/eventuous-dart/issues
