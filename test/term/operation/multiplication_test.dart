import 'package:console_calculator/term/operation/multiplication.dart';
import 'package:test/test.dart';

void main() {
  final Multiplication multiplication = Multiplication();
  group('Multiplication class', () {
    group('constructor Multiplication()', () {
      test('ensure singleton instance ', () {
        // Given When
        final Multiplication instance1 = Multiplication();
        final Multiplication instance2 = Multiplication();
        final Multiplication instance3 = Multiplication();

        // Then
        expect(identical(multiplication, instance1), isTrue);
        expect(identical(multiplication, instance2), isTrue);
        expect(identical(multiplication, instance3), isTrue);
      });
    });
  });
}
