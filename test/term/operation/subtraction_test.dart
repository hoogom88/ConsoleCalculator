import 'package:console_calculator/term/operation/subtraction.dart';
import 'package:test/test.dart';

void main() {
  final Subtraction subtraction = Subtraction();
  group('Subtraction class', () {
    group('constructor Subtraction()', () {
      test('ensure singleton instance ', () {
        // Given When
        final Subtraction instance1 = Subtraction();
        final Subtraction instance2 = Subtraction();
        final Subtraction instance3 = Subtraction();

        // Then
        expect(identical(subtraction, instance1), isTrue);
        expect(identical(subtraction, instance2), isTrue);
        expect(identical(subtraction, instance3), isTrue);
      });
    });
  });
}
