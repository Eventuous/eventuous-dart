import 'package:eventuate/eventuate.dart';
import 'package:test/test.dart';

import 'harness.dart';
import 'model/foo.dart';

void main() {
  group('With type maps only', () {
    _doAll(TestHarness()
      ..withTypeMaps()
      ..withAggregateStore()
      ..install());
  });

  group('With stores only', () {
    _doAll(TestHarness()
      ..withAggregateStore()
      ..install());
  });

  group('With both type maps and stores', () {
    _doAll(TestHarness()
      ..withAggregateStore()
      ..install());
  });
}

void _doAll(TestHarness harness) {
  test('Load fails with AggregateNotFound', () async {
    // Assert
    expect(
      await harness.aggregateStore.load('any'),
      isA<AggregateStateFailure>().having(
        (result) => result.failure,
        'has failure AggregateNotFound',
        isA<AggregateNotFound>(),
      ),
    );
  });

  test('Save completes with AggregateStateOk', () async {
    // Arrange
    final foo = Foo.from('any');
    final init = foo.current.value;
    final data = {'key': 'value'};
    final local = foo.apply(FooCreated(data));

    // Act
    final remote = await harness.aggregateStore.save(foo);

    // Assert
    expect(init, isEmpty);
    expect(local.current, data);
    expect(
      remote,
      isA<AggregateStateOk<JsonMap>>().having(
        (result) => result.current,
        'has data $data',
        equals(data),
      ),
    );
  });
}
