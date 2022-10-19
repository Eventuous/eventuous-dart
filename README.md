[![Dart](https://github.com/Eventuous/eventuous-dart/actions/workflows/dart.yml/badge.svg)](https://github.com/Eventuous/eventuous-dart/actions/workflows/dart.yml)

A mono-repo for [eventuous](https://pub.dev/packages/eventuous) and associated packages for building event sourced applications.

## About

Eventuous ia a lightweight Event Sourcing library for Dart, which is:
- Very volatile
- Extremely opinionated
- [EventStoreDB](https://eventstore.com)-oriented

Authors:
- [Kenneth Gulbrandsøy](https://medium.com/kengu)
- [Alexey Zimarev](https://zimarev.com)

This library is porting concepts and features from
[Eventuous for .NET](https://github.com/Eventuous/eventuous/) to
[Eventuous for Dart](https://pub.dev/packages/eventuous) and is still in active
development not yet reached a stable version. Use it on your own risk. You should
expect breaking changes that will require refactoring both code and behaviors of
code depending on this package. When stable 1.0.0 is released, we pledge to keep
the package backwards compatible within each major version.

## Usage and documentation
This mono-repo contains the following packages
* [Eventuous for Dart Library](packages/eventuous/README.md) - used by application
* [Eventuous for Dart Code Generator](packages/eventuous_generator/README.md) - generate code from annotations
* [Eventuous for Dart Test Library](packages/eventuous_test/README.md) - used by developers to test application code

These packages are not yet properly documented, use
[docs](https://eventuous.dev) (incomplete) written for
the [.NET version](https://github.com/Eventuous/eventuous/).

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Eventuous/eventuous-dart/issues