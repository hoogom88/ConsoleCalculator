import 'package:console_calculator/calculator/basic_calculator.dart';
import 'package:console_calculator/calculator/calculator.dart';
import 'package:console_calculator/util/exception.dart';
import 'package:test/test.dart';

import '../mock/expression_validator/mock_expression_validator.dart';
import '../mock/expresssion_evaluator/mock_expression_evaluator.dart';
import '../mock/tokenizer/mock_tokenizer.dart';

void main() {
  final MockExpressionEvaluator evaluator = MockExpressionEvaluator();
  final MockTokenizer tokenizer = MockTokenizer();
  final MockExpressionValidator validator = MockExpressionValidator();
  final Calculator basicCalculator =
      BasicCalculator(expressionEvaluator: evaluator, tokenizer: tokenizer, expressionValidator: validator);

  setUp(() {
    evaluator.resetMockData();
    tokenizer.resetMockData();
    // default validate return value is true
    validator.resetMockData();
  });

  group('BasicCalculator class', () {
    group('calculate() method', () {
      test('Pass given expression to Tokenizer.tokenize()', () {
        // Given
        final List<String> expression = ['1', '+' '3'];

        // When
        basicCalculator.calculate(expression);

        // Then
        expect(tokenizer.tokenizeParameter, expression);
      });

      test('Calls Tokenizer.tokenize() once.', () {
        // Given
        final List<String> expression = ['1', '+', '3'];
        final expectedCallCount = 1;

        // When
        basicCalculator.calculate(expression);

        // Then
        expect(tokenizer.tokenizeCallCount, expectedCallCount);
      });

      test('Pass return value of Tokenizer.tokenize() to ExpressionValidator.validate()', () {
        // Given
        final List<String> expression = ['1', '+' '3'];

        // When
        basicCalculator.calculate(expression);

        // Then
        expect(tokenizer.tokenizeReturnValue, validator.validateParameter);
      });

      test('Calls ExpressionValidator.validate() once.', () {
        // Given
        final List<String> expression = ['1', '+', '3'];
        final expectedCallCount = 1;

        // When
        basicCalculator.calculate(expression);

        // Then
        expect(validator.validateCallCount, expectedCallCount);
      });

      test('If ExpressionValidator.validate() == false, throw SimpleBusinessException(\'syntaxError\')', () {
        // Given
        final List<String> expression = ['1', '+' '+'];
        validator.validateReturnValue = false;

        // When Then
        expect(() => basicCalculator.calculate(expression),
            throwsA(predicate((e) => e is SimpleBusinessException && e.message == ExceptionMessage.syntaxError)));
      });

      test(
          'If ExpressionValidator.validate() == true, pass return value of Tokenizer.tokenize() to ExpressionEvaluator.evaluate()',
          () {
        // Given
        final List<String> expression = ['1', '+' '3'];

        // When
        basicCalculator.calculate(expression);

        // Then
        expect(tokenizer.tokenizeReturnValue, evaluator.evaluateParameter);
      });

      test('If ExpressionValidator.validate() == true, calls ExpressionEvaluator.evaluate() once.', () {
        // Given
        final List<String> expression = ['1', '+', '3'];
        final expectedCallCount = 1;

        // When
        basicCalculator.calculate(expression);

        // Then
        expect(evaluator.evaluateCallCount, expectedCallCount);
      });

      test('Returns String converted return value of ExpressionEvaluator.evaluate()', () {
        // Given
        final List<String> expression = ['1', '+', '3'];

        // When
        final String result = basicCalculator.calculate(expression);

        // Then
        expect(evaluator.evaluateReturnValue.toString(), result);
      });
    });
  });
}
