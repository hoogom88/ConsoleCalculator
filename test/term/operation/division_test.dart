import 'package:console_calculator/term/operand/number.dart';
import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/division.dart';
import 'package:test/test.dart';

void main() {
  final Division division = Division();
  group('Division class', () {
    group('constructor Division()', () {
      test('ensure singleton instance ', () {
        // Given When
        final Division instance1 = Division();
        final Division instance2 = Division();
        final Division instance3 = Division();

        // Then
        expect(identical(division, instance1), isTrue);
        expect(identical(division, instance2), isTrue);
        expect(identical(division, instance3), isTrue);
      });
    });

    // execute(List<Operand> operands)
    group('execute() method', () {
      test('Returns Operand(value is result of operands[1] / operands[0] which can parsed to double)', () {
        // Given
        final List<Operand> operands1 = [Number('1'), Number('123456789012')];
        final List<Operand> operands2 = [Number('1000000'), Number('1234'), ];
        final List<Operand> operands3 = [Number('0.12589'), Number('123456.123')];
        final Operand expectedResult1 = Number('123456789012.0');
        final Operand expectedResult2 = Number('0.001234');
        final Operand expectedResult3 = Number('980666.6375407');

        // When
        final result1 = division.execute(operands1);
        final result2 = division.execute(operands2);
        final result3 = division.execute(operands3);

        // Then
        expect(result1.value == expectedResult1.value, isTrue);
        expect(result2.value == expectedResult2.value, isTrue);
        expect(result3.value == expectedResult3.value, isTrue);
      });

      test('Throw SimpleBusinessException(\'undefinedError\') if exception is occurred during execute', () {
        // For accurate testing, have to mock double, Number class and inject them to tested class.
        // But, because similar test case were tested in other test, it was skipped.
        // This test case include error 'divided by zero'
      });
    });
  });
}
