import 'package:console_calculator/expression_operator/expression_operator.dart';
import 'package:console_calculator/expression_operator/postfix_expression_operator.dart';
import 'package:console_calculator/term/operand/number.dart';
import 'package:console_calculator/term/operation/addition.dart';
import 'package:console_calculator/term/operation/division.dart';
import 'package:console_calculator/term/operation/multiplication.dart';
import 'package:console_calculator/term/operation/subtraction.dart';
import 'package:console_calculator/term/term.dart';
import 'package:console_calculator/util/exception.dart';
import 'package:test/test.dart';

void main() {
  final ExpressionOperator expressionOperator = PostfixExpressionOperator();

  group('PostfixExpressionOperator class', () {
    group('operate() method', () {
      test(
          'Throw SimpleBusinessException(\'syntaxError\') if operates given expression is impossible or invalid infix expression',
          () {
        // Given
        final List<Term> incomputableExpression1 = [Number('123'), Number('123'), Number('123')];
        final List<Term> incomputableExpression2 = [Addition(), Number('123'), Number('123')];
        final List<Term> incomputableExpression3 = [Division(), Addition(), Number('123')];
        final List<Term> incomputableExpression4 = [Multiplication(), Division(), Subtraction()];
        final List<Term> incomputableExpression5 = [Number('123'), Division(), Subtraction()];
        final List<Term> incomputableExpression6 = [Number('123'), Number('123'), Subtraction()];

        // When Then
        expect(() => expressionOperator.operate(incomputableExpression1),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.syntaxError)));
        expect(() => expressionOperator.operate(incomputableExpression2),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.syntaxError)));
        expect(() => expressionOperator.operate(incomputableExpression3),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.syntaxError)));
        expect(() => expressionOperator.operate(incomputableExpression4),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.syntaxError)));
        expect(() => expressionOperator.operate(incomputableExpression5),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.syntaxError)));
        expect(() => expressionOperator.operate(incomputableExpression6),
            throwsA(predicate((e) => e is SimpleBusinessException && e.exceptionMessage == ExceptionMessage.syntaxError)));
      });

      test('Returns result of give expression using postfix expression if given infix expression is valid', () {
        // Given
        final List<Term> validExpression1 = [Number('123'), Addition(), Number('123')];
        final List<Term> validExpression2 = [Number('123'), Subtraction(), Number('123')];
        final List<Term> validExpression3 = [Number('123'), Multiplication(), Number('123')];
        final List<Term> validExpression4 = [Number('123'), Division(), Number('123')];

        final String expectedResult1 = '246.0';
        final String expectedResult2 = '0.0';
        final String expectedResult3 = '15129.0';
        final String expectedResult4 = '1.0';

        // When
        final String result1 = expressionOperator.operate(validExpression1);
        final String result2 = expressionOperator.operate(validExpression2);
        final String result3 = expressionOperator.operate(validExpression3);
        final String result4 = expressionOperator.operate(validExpression4);

        // Then
        expect(result1 == expectedResult1, isTrue);
        expect(result2 == expectedResult2, isTrue);
        expect(result3 == expectedResult3, isTrue);
        expect(result4 == expectedResult4, isTrue);
      });
    });
  });
}
