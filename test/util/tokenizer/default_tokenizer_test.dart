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
      // focus on operand tokenize
      test('Returns separated Terms(Operand or Operation) by space and symbol if given expression is valid - case1', () {
        // Given
        // integer input
        final List<String> expression1 = ['1234567890123', '2345.', '32'];
        final List<String> expression2 = ['145', '65915654', '/'];
        final List<String> expression3 = ['12345678901234', '126584365', '32'];
        final List<String> expression4 = ['145', '0', '12345678901234'];

        final List<Term> expectedResult1 = [Operand(1234567890123), Operand(2345), Operand(32)];
        final List<Term> expectedResult2 = [Operand(145), Operand(65915654), Division()];
        final List<Term> expectedResult3 = [Operand(12345678901234), Operand(126584365), Operand(32)];
        final List<Term> expectedResult4 = [Operand(145), Operand(0), Operand(12345678901234)];

        // float input
        final List<String> expression7 = ['1234567890123.', '2345.', '32.'];
        final List<String> expression8 = ['0.145', '0.65915654', '/'];
        final List<String> expression9 = ['12345678901234.', '1.26584365', '0.32'];
        final List<String> expression10 = ['145', '0.0', '123456789012.34'];

        final List<Term> expectedResult7 = [Operand(1234567890123), Operand(2345), Operand(32)];
        final List<Term> expectedResult8 = [Operand(0.145), Operand(0.65915654), Division()];
        final List<Term> expectedResult9 = [Operand(12345678901234), Operand(1.26584365), Operand(0.32)];
        final List<Term> expectedResult10 = [Operand(145), Operand(0.0), Operand(123456789012.34)];

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

      // focus on operation tokenize
      test('Returns separated Terms(Operand or Operation) by space and symbol if given expression is valid - case2', () {
        // Given
        final List<String> expression1 = ['+', '+', '/'];
        final List<String> expression2 = ['-', '-', '-'];
        final List<String> expression3 = ['*', '/', '*'];
        final List<String> expression4 = ['/', '*', '-'];
        final List<String> expression5 = ['/', '*', '*'];
        final List<Term> expectedResult1 = [Addition(), Addition(), Division()];
        final List<Term> expectedResult2 = [Subtraction(), Subtraction(), Subtraction()];
        final List<Term> expectedResult3 = [Multiplication(), Division(), Multiplication()];
        final List<Term> expectedResult4 = [Division(), Multiplication(), Subtraction()];
        final List<Term> expectedResult5 = [Division(), Multiplication(), Multiplication()];

        // When
        final List<Term> result1 = tokenizer.tokenize(expression1);
        final List<Term> result2 = tokenizer.tokenize(expression2);
        final List<Term> result3 = tokenizer.tokenize(expression3);
        final List<Term> result4 = tokenizer.tokenize(expression4);
        final List<Term> result5 = tokenizer.tokenize(expression5);

        // Then
        expect(result1.equals(expectedResult1), isTrue);
        expect(result2.equals(expectedResult2), isTrue);
        expect(result3.equals(expectedResult3), isTrue);
        expect(result4.equals(expectedResult4), isTrue);
        expect(result5.equals(expectedResult5), isTrue);
      });

      test('Throw SimpleBusinessException.invalidInput() if input Operand or Operation string is invalid', () {
        // Given
        final List<String> expression1 = ['1as', '+', '32'];
        final List<String> expression2 = ['145', ' ', '가나5'];
        final List<String> expression3 = ['1234567890.1234', '#', '32'];
        final List<String> expression4 = ['145', 'a', '1.2345678901234'];
        final List<String> expression5 = ['1234567890.1234', '[', '32'];
        final List<String> expression6 = ['145', '}', '1.2345678901234'];
        final List<String> expression7 = ['90..62', '/', '654.12'];
        final List<String> expression8 = ['145', '-', '가나5'];
        final List<String> expression9 = ['1234567890.1234', '#', '32'];
        final List<String> expression10 = ['145', 'a', '1.2345678901234'];
        final List<String> expression11= ['1234567890.1234', '[', '32'];
        final List<String> expression12 = ['145', '}', '1.2345678901234'];

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
        expect(() => tokenizer.tokenize(expression9),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(expression10),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(expression11),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(expression12),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
      });
    });
  });
}
