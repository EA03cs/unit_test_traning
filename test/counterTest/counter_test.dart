import 'package:flutter_test/flutter_test.dart';
import 'package:unit_test_traning/counterClass/counter.dart';

void main() {
  group('counter class tests', () {
    test('initial value should be 0', () {
      final c = Counter();
      expect(c.count, 0);
    });

    test('increment() should increase value by 1', () {
      final c = Counter();
      c.increment();
      expect(c.count, 1);
    });

    test('decrement() should decrease value by 1', () {
      final c = Counter();
      c.decrement();
      expect(c.count, -1);
    });

    test('multiple increments and decrements', () {
      final c = Counter();
      c.increment();
      c.increment();
      c.decrement();
      expect(c.count, 1);
    });
  });
}
