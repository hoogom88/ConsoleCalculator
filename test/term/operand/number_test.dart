import 'package:console_calculator/term/operand/number.dart';
import 'package:test/test.dart';
import 'package:console_calculator/util/exception.dart';

void main() {
  group('Number class', () {
    group('factory constructor Number()', () {
      test('Throw SimpleBusinessException(\'invalidInput\') if given String contains invalid character (to check String is Infinite, NaN, null)', () {
        // Given
        final String numberOverMaxLength1 = double.infinity.toString();
        final String numberOverMaxLength2 = double.negativeInfinity.toString();
        final String numberOverMaxLength3 =  double.nan.toString();
        final String numberOverMaxLength4 = null.toString();

        // When Then
        expect(() => Number(numberOverMaxLength1),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => Number(numberOverMaxLength2),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => Number(numberOverMaxLength3),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => Number(numberOverMaxLength4),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
      });

      test('Throw SimpleBusinessException(\'invalidInput\') if given String can\'t be parsed to double', () {
        // Given
        final String numberOverMaxLength1 = '1234567890..12345';
        final String numberOverMaxLength2 = 'as56789012356';
        final String numberOverMaxLength3 = '123456.789014-';
        final String numberOverMaxLength4 = '123456.734 5';

        // When Then
        expect(() => Number(numberOverMaxLength1),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => Number(numberOverMaxLength2),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => Number(numberOverMaxLength3),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => Number(numberOverMaxLength4),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
      });

      test('Returns Number if given String can be parsed to double', () {
        // Given
        final String numberUnderMaxLength1 = '12345678901234';
        final String numberUnderMaxLength2 = '12345678.9012';
        final String numberUnderMaxLength3 = '0.123456789012';
        final String numberUnderMaxLength4 = '123456.00000';

        // When
        final result1 = Number(numberUnderMaxLength1);
        final result2 = Number(numberUnderMaxLength2);
        final result3 = Number(numberUnderMaxLength3);
        final result4 = Number(numberUnderMaxLength4);

        // Then
        expect(result1, isA<Number>());
        expect(result1.value, equals(numberUnderMaxLength1));
        expect(result2, isA<Number>());
        expect(result2.value, equals(numberUnderMaxLength2));
        expect(result3, isA<Number>());
        expect(result3.value, equals(numberUnderMaxLength3));
        expect(result4, isA<Number>());
        expect(result4.value, equals('123456'));
      });

      test('Pass sliced string to Number if given string\'s length over 14', () {
        // Given
        final String numberUnderMaxLength1 = '123456789012345678';
        final String numberUnderMaxLength2 = '12345678.901234';
        final String numberUnderMaxLength3 = '0.1234567890123456';
        final String numberUnderMaxLength4 = '12345678901234.';
        final String expectedResult1 = '12345678901234';
        final String expectedResult2 = '12345678.90123';
        final String expectedResult3 = '0.123456789012';
        final String expectedResult4 = '12345678901234';

        // When
        final result1 = Number(numberUnderMaxLength1);
        final result2 = Number(numberUnderMaxLength2);
        final result3 = Number(numberUnderMaxLength3);
        final result4 = Number(numberUnderMaxLength4);

        // Then
        expect(result1.value == expectedResult1, isTrue);
        expect(result2.value == expectedResult2, isTrue);
        expect(result3.value == expectedResult3, isTrue);
        expect(result4.value == expectedResult4, isTrue);
      });
    });
  });
}
