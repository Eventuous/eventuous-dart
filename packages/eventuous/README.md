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


This library is porting concepts and features from
[Eventuous for .NET](https://github.com/Eventuous/eventuous/) to 
[Eventuous for Dart](https://pub.dev/packages/eventuous) and is still in active 
development not yet reached a stable version. Use it on your own risk. You should 
expect breaking changes that will require refactoring both code and behaviors of 
code depending on this package. When stable 1.0.0 is released, we pledge to keep 
the package backwards compatible within each major version. 

## Usage and documentation
This package is not yet properly documented, use 
[docs](https://eventuous.dev) (incomplete) written for 
the [.NET version](https://github.com/Eventuous/eventuous/) for an introduction to 
core principles for developing event sourced applications. We also highly recommend
that you use the [code generation tool][generator] to remove the
boilerplate code needed to build you application using event sourcing using this library. 

## Features and bugs
The following features are currently ported:

* ✅ [Eventuous Core](https://www.nuget.org/packages/Eventuous) - Aggregate, AggregateStore, EventStore og ApplicationService
* ✅ [Eventuous EventStore](https://www.nuget.org/packages/Eventuous.EventStore) - Supports [EventStore](https://www.eventstore.com/) as AggregateStore using [eventstore_client](https://pub.dev/packages/eventstore_client)
* ✅ [Eventuous Code Generation](https://pub.dev/packages/eventuous_generator) - Annotations for generating boilerplate code

We are working on the following features:

* ⏱ [Eventuous Core](https://www.nuget.org/packages/Eventuous) - Add archive support AggregateStore 
* ⏱ [Eventuous Code Generation](https://pub.dev/packages/eventuous_generator) - Annotations for generating application apis with gRPC

These features are coming later:

* 1️⃣ [Eventuous Subscriptions](https://www.nuget.org/packages/Eventuous.Subscriptions) - Handle or project events (streaming)
* 2️⃣ [Eventuous Producers](https://www.nuget.org/packages/Eventuous.Producers) - Produce and publish arbitrary messages, commands or events
* 3️⃣ [Eventuous Gateway](https://www.nuget.org/packages/Eventuous.Gateway) - Engine to bridge Event Sourcing with Event-Driven Architecture (EDA)
* 5️⃣ [Eventuous Diagnostics](https://www.nuget.org/packages/Eventuous.Diagnostics) - Logging and Metrics

Features currently not on the roadmap
* [Eventuous Postgresql](https://www.nuget.org/packages/Eventuous.Postgresql) - Supports Postgres as an event store
* [Eventuous ElasticSearch](https://www.nuget.org/packages/Eventuous.ElasticSearch) - Supports storing and archiving events in Elasticsearch
* [Eventuous ElasticSearch](https://www.nuget.org/packages/Eventuous.ElasticSearch) - Supports storing and archiving events in Elasticsearch

Please file feature requests and bugs at the [issue tracker][tracker].

[generator]: https://pub.dev/packages/eventuous_generator
[tracker]: https://github.com/Eventuous/eventuous-dart/issues
