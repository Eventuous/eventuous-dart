#Example code

Eventuous code in library [test_lib](lib/test_lib.dart) is generated with the command:
```bash
pub run build_runner build
```

This will generate the following files

* [lib/test_lib.g.dart](lib/test_lib.g.dart) - bootstrapping code for aggregates Foo and Bar
* [lib/src/foo.g.dart](lib/src/foo.g.dart) - Foo example aggregate with all classes in one file
* [lib/src/bar/bar.g.dart](lib/src/bar) - Bar example aggregate with all classes in separate files

###Configuring code generation in a dart project 

When using in a new dart project, the following dependencies must be added to `pubspec.yaml`:

```yaml
environment:
  sdk: '>=2.12.0 <3.0.0'

dependencies:
  get_it: ^7.2.0
  eventuous: ^0.0.4
  json_annotation: ^4.1.0

dev_dependencies:
  build_runner: ^2.1.4
  eventuous_generator: ^0.0.6
  json_serializable: ^5.0.2
```
