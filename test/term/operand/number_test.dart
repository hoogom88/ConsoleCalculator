import 'package:console_calculator/term/operand/number.dart';
import 'package:test/test.dart';
import 'package:console_calculator/util/exception.dart';

void main() {
  group('Number class', () {
    group('factory constructor Number()', () {
      test('Returns Number if given String is valid', () {
        // Given
        final String numberUnderMaxLength1 = '123456789.0';
        final String numberUnderMaxLength2 = '1234567890.0';
        final String numberUnderMaxLength3 = '12345678901.0';
        final String numberUnderMaxLength4 = '123456789012.0';

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
        expect(result4.value, equals(numberUnderMaxLength4));
      });

      test('Throw SimpleBusinessException.overflow() if given String\'s length over 14', () {
        // Given
        final String numberOverMaxLength1 = '123456789012345';
        final String numberOverMaxLength2 = '123456789012356';
        final String numberOverMaxLength3 = '123456.78901234';
        final String numberOverMaxLength4 = '123456.789012345';

        // When Then
        expect(() => Number(numberOverMaxLength1),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.overflow)));
        expect(() => Number(numberOverMaxLength2),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.overflow)));
        expect(() => Number(numberOverMaxLength3),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.overflow)));
        expect(() => Number(numberOverMaxLength4),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.overflow)));
      });
    });
  });
}
