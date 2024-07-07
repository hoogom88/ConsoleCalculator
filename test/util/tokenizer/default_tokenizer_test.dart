import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/addition.dart';
import 'package:console_calculator/term/operation/division.dart';
import 'package:console_calculator/term/operation/multiplication.dart';
import 'package:console_calculator/term/operation/subtraction.dart';
import 'package:console_calculator/term/term.dart';
import 'package:console_calculator/util/exception.dart';
import 'package:console_calculator/util/extension/list_extension.dart';
import 'package:console_calculator/util/tokenizer/default_tokenizer.dart';
import 'package:console_calculator/util/tokenizer/tokenizer.dart';
import 'package:test/test.dart';

void main() {
  final Tokenizer tokenizer = DefaultTokenizer();

  group('DefaultTokenizer class', () {
    group('tokenizer() method', () {
      test('Returns separated Terms(Operand or Operation) list if input Operand string is valid', () {
        // Given
        // integer input
        final List<String> expression1 = ['1234567890123', '+', '32']; // not exceed, len13
        final List<String> expression2 = ['145', '+', '1234567890123']; // not exceed, len13
        final List<String> expression3 = ['12345678901234', '+', '32']; // not exceed, len14
        final List<String> expression4 = ['145', '+', '12345678901234']; // not exceed, len14

        final List<Term> expectedResult1 = [
          Operand(1234567890123),
          Addition(),
          Operand(32)
        ];
        final List<Term> expectedResult2 = [
          Operand(145),
          Addition(),
          Operand(1234567890123)
        ];
        final List<Term> expectedResult3 = [
          Operand(12345678901234),
          Addition(),
          Operand(32)
        ];
        final List<Term> expectedResult4 = [
          Operand(145),
          Addition(),
          Operand(12345678901234)
        ];


        // float input
        final List<String> expression7 = ['1234567.89012', '+', '32']; // not exceed, len13
        final List<String> expression8 = ['145', '+', '123456789.012']; // not exceed, len13
        final List<String> expression9 = ['0.123456789012', '+', '32']; // not exceed, len14
        final List<String> expression10 = ['145', '+', '1234567890123.']; // not exceed, len14

        final List<Term> expectedResult7 = [
          Operand(1234567.89012),
          Addition(),
          Operand(32)
        ];
        final List<Term> expectedResult8 = [
          Operand(145),
          Addition(),
          Operand(123456789.012)
        ];
        final List<Term> expectedResult9 = [
          Operand(0.123456789012),
          Addition(),
          Operand(32)
        ];
        final List<Term> expectedResult10 = [
          Operand(145),
          Addition(),
          Operand(1234567890123)
        ];

        // When
        final List<Term> result1 = tokenizer.tokenize(expression1);
        final List<Term> result2 = tokenizer.tokenize(expression2);
        final List<Term> result3 = tokenizer.tokenize(expression3);
        final List<Term> result4 = tokenizer.tokenize(expression4);
        final List<Term> result7 = tokenizer.tokenize(expression7);
        final List<Term> result8 = tokenizer.tokenize(expression8);
        final List<Term> result9 = tokenizer.tokenize(expression9);
        final List<Term> result10 = tokenizer.tokenize(expression10);


        // Then
        expect(result1.equals(expectedResult1), isTrue); // not exceed, len13
        expect(result2.equals(expectedResult2), isTrue); // not exceed, len13
        expect(result3.equals(expectedResult3), isTrue); // not exceed, len14
        expect(result4.equals(expectedResult4), isTrue); // not exceed, len14
        expect(result7.equals(expectedResult7), isTrue); // not exceed, len13
        expect(result8.equals(expectedResult8), isTrue); // not exceed, len13
        expect(result9.equals(expectedResult9), isTrue); // not exceed, len14
        expect(result10.equals(expectedResult10), isTrue); // not exceed, len14
      });

      test('Throw SimpleBusinessException.invalidInput() if input Operand string\'s length exceeds 14', () {
        // Given
        // integer input
        final List<String> expression5 = ['123456789012345', '+', '32']; // exceed, len15
        final List<String> expression6 = ['145', '+', '123456789012345']; // exceed, len15

        // float input
        final List<String> expression11 = ['1234567890.1234', '+', '32']; // exceed, len15
        final List<String> expression12 = ['145', '+', '1.2345678901234']; // exceed, len15

        // When Then
        expect(() => tokenizer.tokenize(expression5), // exceed, len15
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(expression6), // exceed, len15
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(expression11), // exceed, len15
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(expression12), // exceed, len15
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
      });

      test('Returns separated Terms(Operand or Operation) list if input Operation string is valid', () {
        // Given
        // integer input
        final List<String> expression1 = ['1234567890123', '+', '32'];
        final List<String> expression2 = ['145', '-', '1234567890123'];
        final List<String> expression3 = ['12345678901234', '/', '32'];
        final List<String> expression4 = ['145', '*', '12345678901234'];

        final List<Term> expectedResult1 = [
          Operand(1234567890123),
          Addition(),
          Operand(32)
        ];
        final List<Term> expectedResult2 = [
          Operand(145),
          Subtraction(),
          Operand(1234567890123)
        ];
        final List<Term> expectedResult3 = [
          Operand(12345678901234),
          Division(),
          Operand(32)
        ];
        final List<Term> expectedResult4 = [
          Operand(145),
          Multiplication(),
          Operand(12345678901234)
        ];


        // float input
        final List<String> expression7 = ['1234567.89012', '+', '32'];
        final List<String> expression8 = ['145', '-', '123456789.012'];
        final List<String> expression9 = ['0.123456789012', '/', '32'];
        final List<String> expression10 = ['145', '*', '1234567890123.'];

        final List<Term> expectedResult7 = [
          Operand(1234567.89012),
          Addition(),
          Operand(32)
        ];
        final List<Term> expectedResult8 = [
          Operand(145),
          Subtraction(),
          Operand(123456789.012)
        ];
        final List<Term> expectedResult9 = [
          Operand(0.123456789012),
          Division(),
          Operand(32)
        ];
        final List<Term> expectedResult10 = [
          Operand(145),
          Multiplication(),
          Operand(1234567890123)
        ];

        // When
        final List<Term> result1 = tokenizer.tokenize(expression1);
        final List<Term> result2 = tokenizer.tokenize(expression2);
        final List<Term> result3 = tokenizer.tokenize(expression3);
        final List<Term> result4 = tokenizer.tokenize(expression4);
        final List<Term> result7 = tokenizer.tokenize(expression7);
        final List<Term> result8 = tokenizer.tokenize(expression8);
        final List<Term> result9 = tokenizer.tokenize(expression9);
        final List<Term> result10 = tokenizer.tokenize(expression10);


        // Then
        expect(result1.equals(expectedResult1), isTrue);
        expect(result2.equals(expectedResult2), isTrue);
        expect(result3.equals(expectedResult3), isTrue);
        expect(result4.equals(expectedResult4), isTrue);
        expect(result7.equals(expectedResult7), isTrue);
        expect(result8.equals(expectedResult8), isTrue);
        expect(result9.equals(expectedResult9), isTrue);
        expect(result10.equals(expectedResult10), isTrue);
      });

      test('Throw SimpleBusinessException.invalidInput() if input Operand or Operation string is invalid', () {
        // Given
        final List<String> expression1 = ['123456789012345', '++', '32']; // != 'Operand Operation Operand'
        final List<String> expression2 = ['145', '*/', '123456789012345']; // != 'Operand Operation Operand'
        final List<String> expression3 = ['1as', '+', '32'];
        final List<String> expression4 = ['145', '-', '가나5'];
        final List<String> expression5 = ['1234567890.1234', '#', '32'];
        final List<String> expression6 = ['145', 'a', '1.2345678901234'];
        final List<String> expression7 = ['1234567890.1234', '[', '32'];
        final List<String> expression8 = ['145', '}', '1.2345678901234'];

        // When Then
        expect(() => tokenizer.tokenize(expression1),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(expression2),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(expression3),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(expression4),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(expression5),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(expression6),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(expression7),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(expression8),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
      });
    });
  });
}
