import 'package:console_calculator/calculator/calculator.dart';
import 'package:console_calculator/expression_evaluator/expression_evaluator.dart';
import 'package:console_calculator/expression_validator/expression_validator.dart';
import 'package:console_calculator/term/term.dart';
import 'package:console_calculator/util/exception.dart';
import 'package:console_calculator/util/tokenizer/tokenizer.dart';

/// Basic calculator perform calculate using ExpressionEvaluator, Tokenizer, ExpressionValidator
/// (it only support [operand, operation, operand] expression)
/// operand : double format number, max length 14
/// operation : _, -, /, *
class BasicCalculator implements Calculator {
  final ExpressionOperator _expressionEvaluator;
  final Tokenizer _tokenizer;
  final ExpressionValidator _expressionValidator;

  BasicCalculator(
      {required ExpressionOperator expressionEvaluator,
      required Tokenizer tokenizer,
      required ExpressionValidator expressionValidator})
      : _expressionEvaluator = expressionEvaluator,
        _tokenizer = tokenizer,
        _expressionValidator = expressionValidator;

  @override
  String calculate(List<String> expression) {
    List<Term> expressionTokens = _tokenizer.tokenize(expression);
    if (!_expressionValidator.validate(expressionTokens)) throw SimpleBusinessException.syntaxError();
    return _expressionEvaluator.operate(expressionTokens);
  }
}
