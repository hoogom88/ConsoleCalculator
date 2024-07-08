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
      BasicCalculator(expressionOperator: evaluator, tokenizer: tokenizer, expressionValidator: validator);

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

        // When
        final String result = basicCalculator.calculate(expression);

        //Then
        expect(result == ExceptionMessage.syntaxError.message, isTrue);
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

      test('Returns Error message if error occurred during calculate', () {
        // Given
        final List<String> expression = ['1', '+', '123'];

        // When
        validator.error = SimpleBusinessException.syntaxError();
        final String result1 = basicCalculator.calculate(expression);

        validator.error = SimpleBusinessException.overflow();
        final String result2 = basicCalculator.calculate(expression);

        validator.error = SimpleBusinessException.invalidInput();
        final String result3 = basicCalculator.calculate(expression);

        validator.error = SimpleBusinessException.undefinedError();
        final String result4 = basicCalculator.calculate(expression);

        validator.error = Exception();
        final String result5 = basicCalculator.calculate(expression);

        // Then
        expect(result1 == ExceptionMessage.syntaxError.message, isTrue);
        expect(result2 == ExceptionMessage.overflow.message, isTrue);
        expect(result3 == ExceptionMessage.invalidInput.message, isTrue);
        expect(result4 == ExceptionMessage.undefinedError.message, isTrue);
        expect(result5 == ExceptionMessage.undefinedError.message, isTrue);
      });
    });
  });
}
