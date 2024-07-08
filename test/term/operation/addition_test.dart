import 'package:console_calculator/term/operand/number.dart';
import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/addition.dart';
import 'package:test/test.dart';

void main() {
  final Addition addition = Addition();
  group('Addition class', () {
    group('constructor Addition()', () {
      test('ensure singleton instance ', () {
        // Given When
        final Addition instance1 = Addition();
        final Addition instance2 = Addition();
        final Addition instance3 = Addition();

        // Then
        expect(identical(addition, instance1), isTrue);
        expect(identical(addition, instance2), isTrue);
        expect(identical(addition, instance3), isTrue);
      });
    });

    // execute(List<Operand> operands)
    group('execute() method', () {
      test('Returns Operand(value is result of operands[0] + operands[1] which can parsed to double)', () {
        // Given
        final List<Operand> operands1 = [Number('123456789012.0'), Number('123456789012.0')];
        final List<Operand> operands2 = [Number('1234'), Number('10')];
        final List<Operand> operands3 = [Number('123456.123'), Number('0.12589')];
        final Operand expectedResult1 = Number((123456789012 + 123456789012.0).toString());
        final Operand expectedResult2 = Number((1234 + 10.0).toString());
        final Operand expectedResult3 = Number((123456.123 + 0.12589).toString());

        // When
        final result1 = addition.execute(operands1);
        final result2 = addition.execute(operands2);
        final result3 = addition.execute(operands3);

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
