import 'package:console_calculator/calculator/basic_calculator.dart';
import 'package:console_calculator/calculator/calculator.dart';
import 'package:console_calculator/term/term.dart';
import 'package:test/test.dart';

import '../mock/expresssion_evaluator/mock_expression_evaluator.dart';
import '../mock/util/tokenizer/mock_tokenizer.dart';

void main() {
  final MockExpressionEvaluator expressionEvaluator = MockExpressionEvaluator();
  final MockTokenizer tokenizer = MockTokenizer();
  final Calculator basicCalculator = BasicCalculator(
      expressionEvaluator: expressionEvaluator, tokenizer: tokenizer);

  setUp(() {
    expressionEvaluator.resetMockData();
    tokenizer.resetMockData();
  });

  group('BasicCalculator class', () {
    group('calculate() method', () {
      test('Pass given expression to Tokenizer.tokenize()', () {
        // Given
        final List<String> expression = ['1', '+' '3'];

        // When
        basicCalculator.calculate(expression);
        final List<String >passedParameter = tokenizer.tokenizeParameter;

        // Then
        expect(passedParameter, expression);
      });

      test('Calls Tokenizer.tokenize() one time.', () {
        // Given
        final List<String> expression = ['1', '+', '3'];

        // When
        basicCalculator.calculate(expression);
        final int callCount = tokenizer.tokenizeCallCount;

        // Then
        expect(callCount, 1);
      });

      test(
          'Pass return value of Tokenizer.tokenize() to ExpressionEvaluator.evaluate()',
          () {
        // Given
        final List<String> expression = ['1', '+' '3'];

        // When
        basicCalculator.calculate(expression);
        final List<Term> returnValue = tokenizer.tokenizeReturnValue;
        final List<Term> passedParameter = expressionEvaluator.evaluateParameter;

        // Then
        expect(returnValue, passedParameter);
      });

      test('Calls ExpressionEvaluator.evaluate() one time.', () {
        // Given
        final List<String> expression = ['1', '+', '3'];

        // When
        basicCalculator.calculate(expression);
        final int callCount = expressionEvaluator.evaluateCallCount;

        // Then
        expect(callCount, 1);
      });

      test('Returns String converted return value of ExpressionEvaluator.evaluate()', () {
        // Given
        final List<String> expression = ['1', '+', '3'];

        // When
        final String methodResult = basicCalculator.calculate(expression);
        final double returnValue = expressionEvaluator.evaluateReturnValue;

        // Then
        expect(returnValue.toString(), methodResult);
      });
    });
  });
}
