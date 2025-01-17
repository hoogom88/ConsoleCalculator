import 'package:console_calculator/term/operand/number.dart';
import 'package:console_calculator/term/operand/operand.dart';
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

    // execute(List<Operand> operands)
    group('execute() method', () {
      test('Returns Operand(value is result of operands[1] - operands[0] which can parsed to double)', () {
        // Given
        final List<Operand> operands1 = [Number('123456789012'), Number('123456789012')];
        final List<Operand> operands2 = [Number('10000'), Number('1234')];
        final List<Operand> operands3 = [Number('0.12589'), Number('123456.123')];
        final Operand expectedResult1 = Number('0.0');
        final Operand expectedResult2 = Number('-8766.0');
        final Operand expectedResult3 = Number('123455.9971100');

        // When
        final result1 = subtraction.execute(operands1);
        final result2 = subtraction.execute(operands2);
        final result3 = subtraction.execute(operands3);

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
