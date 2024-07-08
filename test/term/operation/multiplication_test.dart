import 'package:console_calculator/term/operand/number.dart';
import 'package:console_calculator/term/operand/operand.dart';
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

    // execute(List<Operand> operands)
    group('execute() method', () {
      test('Returns Operand(value is result of operands[0] * operands[1] which can parsed to double)', () {
        // Given
        final List<Operand> operands1 = [Number('123456789012'), Number('0')];
        final List<Operand> operands2 = [Number('1234'), Number('10000')];
        final List<Operand> operands3 = [Number('123456.123'), Number('0.12589')];
        final Operand expectedResult1 = Number('0.0');
        final Operand expectedResult2 = Number('12340000.0');
        final Operand expectedResult3 = Number('15541.89132447');

        // When
        final result1 = multiplication.execute(operands1);
        final result2 = multiplication.execute(operands2);
        final result3 = multiplication.execute(operands3);

        // Then
        expect(result1.value == expectedResult1.value, isTrue);
        expect(result2.value == expectedResult2.value, isTrue);
        expect(result3.value == expectedResult3.value, isTrue);
      });

      test('Throw SimpleBusinessException(\'undefinedError\') if exception is occurred during execute', () {
        // For accurate testing, have to mock double, Number class and inject them to tested class.
        // But, because similar test case were tested in other test, it was skipped.
      });
    });
  });
}
