import 'package:console_calculator/expression_evaluator/expression_evaluator.dart';
import 'package:console_calculator/expression_evaluator/postfix_expression_evaluator.dart';
import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/addition.dart';
import 'package:console_calculator/term/operation/division.dart';
import 'package:console_calculator/term/operation/multiplication.dart';
import 'package:console_calculator/term/operation/subtraction.dart';
import 'package:console_calculator/term/term.dart';
import 'package:console_calculator/util/exception.dart';
import 'package:test/test.dart';

void main() {
  final ExpressionEvaluator expressionEvaluator = PostfixExpressionEvaluator();

  group('PostfixExpressionEvaluator class', () {
    group('evaluate() method', () {
      // Even though given expression is already validated by previous process, this test is necessary for next versions
      test('Throw SimpleBusinessException.invalidInput() if given expression is invalid', () {
        // Given
        final List<Term> expression1 = [Operand(12422), Addition(), Subtraction()]; // 1 Operand with 2 Operation
        final List<Term> expression2 = [Operand(12422), Operand(0.203857234), Operand(385.203857234)]; // 3 Operand with 0 Operation
        final List<Term> expression3 = [Addition(), Division(), Operand(240)]; // 1 Operand with 2 Operation
        final List<Term> expression4 = [Division(), Multiplication(), Operand(0.12584)]; // 1 Operand with 2 Operation
        final List<Term> expression5 = [Addition(), Division(), Addition()]; // 0 Operand with 3 Operation


        // When Then
        expect(() => expressionEvaluator.evaluate(expression1),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => expressionEvaluator.evaluate(expression2),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => expressionEvaluator.evaluate(expression3),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => expressionEvaluator.evaluate(expression4),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
        expect(() => expressionEvaluator.evaluate(expression5),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.invalidInput)));
      });

      test('Returns evaluate result of given valid expression', () {
        // Given
        final List<Term> expression1 = [Operand(98.547), Addition(), Operand(32158)];
        final List<Term> expression2 = [Operand(12422), Subtraction(), Operand(385.203857234)];
        final List<Term> expression3 = [Operand(12422), Division(), Operand(385.203857)];
        final List<Term> expression4 = [Operand(10000000), Multiplication(), Operand(1000000)];
        final double expectedResult1 = 32256.547;
        final double expectedResult2 = 12036.7961;
        final double expectedResult3 = 32.2478;
        final double expectedResult4 = 10000000000000;

        // When
        final double result1 = expressionEvaluator.evaluate(expression1);
        final double result2 = expressionEvaluator.evaluate(expression2);
        final double result3 = expressionEvaluator.evaluate(expression3);
        final double result4 = expressionEvaluator.evaluate(expression4);

        // Then
        expect(result1 == expectedResult1, isTrue);
        expect(result2 == expectedResult2, isTrue);
        expect(result3 == expectedResult3, isTrue);
        expect(result4 == expectedResult4, isTrue);
      });
    });
  });
}
