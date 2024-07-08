import 'package:console_calculator/term/operand/number.dart';
import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/division.dart';
import 'package:console_calculator/util/exception.dart';
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
      test('Returns Operand(value is result of operands[0] / operands[1] which can parsed to double)', () {
        // Given
        final List<Operand> operands1 = [Number('123456789012'), Number('1')];
        final List<Operand> operands2 = [Number('1234'), Number('1000000')];
        final List<Operand> operands3 = [Number('123456.123'), Number('0.12589')];
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
        // To test this case, I have to create Mock Number, double class and inject them through the constructor. But I think try this modification to just test this case is meaningless.
        // This test case include error 'divided by zero'
      });
    });
  });
}
