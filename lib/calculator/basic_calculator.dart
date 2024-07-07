import 'package:console_calculator/calculator/calculator.dart';
import 'package:console_calculator/expression_evaluator/expression_evaluator.dart';
import 'package:console_calculator/expression_validator/expression_validator.dart';
import 'package:console_calculator/term/term.dart';
import 'package:console_calculator/util/tokenizer/tokenizer.dart';

// Basic calculator perform calculate using ExpressionEvaluator and Tokenizer
class BasicCalculator implements Calculator {
  final ExpressionEvaluator _expressionEvaluator;
  final Tokenizer _tokenizer;
  final ExpressionValidator _expressionValidator;

  BasicCalculator(
      {required ExpressionEvaluator expressionEvaluator,
      required Tokenizer tokenizer,
      required ExpressionValidator expressionValidator})
      : _expressionEvaluator = expressionEvaluator,
        _tokenizer = tokenizer,
        _expressionValidator = expressionValidator;

  @override
  String calculate(List<String> expression) {
    List<Term> expressionTokens = _tokenizer.tokenize(expression);
    return _expressionEvaluator.evaluate(expressionTokens).toString();
  }
}
