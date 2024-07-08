import 'package:console_calculator/term/operand/operand.dart';
import 'package:test/test.dart';
import 'package:console_calculator/util/exception.dart';

void main() {
  group('Operand class', () {
    group('factory constructor Operand()', () {
      test('Returns Operand if given number is valid', () {
        // Given
        final double numberUnderMaxLength1 = 123456789.0;
        final double numberUnderMaxLength2 = 1234567890.0;
        final double numberUnderMaxLength3 = 12345678901.0;
        final double numberUnderMaxLength4 = 123456789012.0;

        // When
        final result1 = Operand(numberUnderMaxLength1);
        final result2 = Operand(numberUnderMaxLength2);
        final result3 = Operand(numberUnderMaxLength3);
        final result4 = Operand(numberUnderMaxLength4);

        // Then
        expect(result1, isA<Operand>());
        expect(result1.value, equals(numberUnderMaxLength1));
        expect(result2, isA<Operand>());
        expect(result2.value, equals(numberUnderMaxLength2));
        expect(result3, isA<Operand>());
        expect(result3.value, equals(numberUnderMaxLength3));
        expect(result4, isA<Operand>());
        expect(result4.value, equals(numberUnderMaxLength4));
      });

      test('Throw SimpleBusinessException.overflow() if given number\'s length over 14', () {
        // Given
        final double numberOverMaxLength1 = 1234567890123.0;
        final double numberOverMaxLength2 = 1234567890123; // 1234567890123.0 over length 14
        final double numberOverMaxLength3 = 123456.78901234;
        final double numberOverMaxLength4 = 123456.789012345;


        // When Then
        expect(() => Operand(numberOverMaxLength1), throwsA(isA<SimpleBusinessException>()));
        expect(() => Operand(numberOverMaxLength2), throwsA(isA<SimpleBusinessException>()));
        expect(() => Operand(numberOverMaxLength3), throwsA(isA<SimpleBusinessException>()));
        expect(() => Operand(numberOverMaxLength4), throwsA(isA<SimpleBusinessException>()));
      });

      test('Throw SimpleBusinessException.overflow() if given number is infinite or NaN', () {
        // Given
        final double infiniteNumber = double.infinity;
        final double nanNumber = double.nan;

        // When Then
        expect(() => Operand(infiniteNumber), throwsA(isA<SimpleBusinessException>()));
        expect(() => Operand(nanNumber), throwsA(isA<SimpleBusinessException>()));
      });
    });
  });
}