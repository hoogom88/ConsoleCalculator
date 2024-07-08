import 'package:console_calculator/term/operand/number.dart';
import 'package:console_calculator/term/operation/addition.dart';
import 'package:console_calculator/term/operation/division.dart';
import 'package:console_calculator/term/operation/multiplication.dart';
import 'package:console_calculator/term/operation/subtraction.dart';
import 'package:console_calculator/term/term.dart';
import 'package:console_calculator/tokenizer/default_tokenizer.dart';
import 'package:console_calculator/util/exception.dart';
import 'package:console_calculator/util/extension/list_extension.dart';
import 'package:console_calculator/tokenizer/tokenizer.dart';
import 'package:test/test.dart';

void main() {
  final Tokenizer tokenizer = DefaultTokenizer();

  group('DefaultTokenizer class', () {
    group('tokenizer() method', () {
      // focus on operand tokenize, it can tokenize only double format number ([0-9]+[.]?[0-9]*) and +,-/*
      test('Returns separated Terms(Operand or Operation) by space and symbol if given expression is valid - case1', () {
        // Given
        // integer input
        final List<String> expression1 = ['1234567890123', '2345.', '32'];
        final List<String> expression2 = ['145', '65915654', '/'];
        final List<String> expression3 = ['12345678901234', '126584365', '32'];
        final List<String> expression4 = ['145', '0', '12345678901234'];

        final List<Term> expectedResult1 = [Number('1234567890123'), Number('2345.'), Number('32')];
        final List<Term> expectedResult2 = [Number('145'), Number('65915654'), Division()];
        final List<Term> expectedResult3 = [Number('12345678901234'), Number('126584365'), Number('32')];
        final List<Term> expectedResult4 = [Number('145'), Number('0'), Number('12345678901234')];

        // float input
        final List<String> expression7 = ['1234567890123.', '2345.', '32.'];
        final List<String> expression8 = ['0.145', '0.65915654', '/'];
        final List<String> expression9 = ['1234567890123.', '1.26584365', '0.32'];
        final List<String> expression10 = ['145', '0.0', '123456789012.3'];

        final List<Term> expectedResult7 = [Number('1234567890123.'), Number('2345.'), Number('32.')];
        final List<Term> expectedResult8 = [Number('0.145'), Number('0.65915654'), Division()];
        final List<Term> expectedResult9 = [Number('1234567890123.'), Number('1.26584365'), Number('0.32')];
        final List<Term> expectedResult10 = [Number('145'), Number('0.0'), Number('123456789012.3')];

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

      // focus on operation tokenize, it can tokenize only double format number ([0-9]+[.]?[0-9]*) and +,-/*
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

      // it can't tokenize character without [0-9]+[.]?[0-9]* and +,-/*
      test('Throw SimpleBusinessException(\'invalidInput\') if input Operand or Operation string is invalid', () {
        // Given
        final List<String> invalidExpression1 = ['1as', '+', '32'];
        final List<String> invalidExpression2 = ['145', ' ', '가나5'];
        final List<String> invalidExpression3 = ['1234567890..1234', '#', '32'];
        final List<String> invalidExpression4 = ['145', 'a', '1.23456789012'];
        final List<String> invalidExpression5 = ['12345678901234', '[', '32'];
        final List<String> invalidExpression6 = ['145', '}', '1.23456789012'];
        final List<String> invalidExpression7 = ['90..62', '/', '654.12'];
        final List<String> invalidExpression8 = ['145', '-', '가나5'];
        final List<String> invalidExpression9 = ['12345678901234', '#', '32'];
        final List<String> invalidExpression10 = ['145', 'a', '1234567.89012'];
        final List<String> invalidExpression11= ['1234567890.12', '[', '32'];
        final List<String> invalidExpression12 = ['145', '}', '0.123456789012'];

        // When Then
        expect(() => tokenizer.tokenize(invalidExpression1),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(invalidExpression2),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(invalidExpression3),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(invalidExpression4),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(invalidExpression5),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(invalidExpression6),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(invalidExpression7),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(invalidExpression8),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(invalidExpression9),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(invalidExpression10),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(invalidExpression11),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
        expect(() => tokenizer.tokenize(invalidExpression12),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.invalidInput)));
      });
    });
  });
}
