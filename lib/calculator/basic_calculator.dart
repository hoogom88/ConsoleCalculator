import 'package:console_calculator/calculator/calculator.dart';
import 'package:console_calculator/expression_evaluator/expression_evaluator.dart';
import 'package:console_calculator/term/term.dart';
import 'package:console_calculator/util/tokenizer/tokenizer.dart';

// Basic calculator perform calculate using ExpressionEvaluator and Tokenizer
class BasicCalculator implements Calculator {
  final ExpressionEvaluator _expressionEvaluator;
  final Tokenizer _tokenizer;

  BasicCalculator({required expressionEvaluator, required tokenizer})
      : _expressionEvaluator = expressionEvaluator,
        _tokenizer = tokenizer;

  @override
  String calculate(List<String> expression) {
    List<Term> expressionTokens = _tokenizer.tokenize(expression);
    return _expressionEvaluator.evaluate(expressionTokens).toString();
  }
}
