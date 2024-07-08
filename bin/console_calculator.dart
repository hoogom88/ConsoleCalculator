import 'package:console_calculator/calculator/basic_calculator.dart';
import 'package:console_calculator/calculator/calculator.dart';
import 'package:console_calculator/expression_operator/expression_operator.dart';
import 'package:console_calculator/expression_operator/postfix_expression_operator.dart';
import 'package:console_calculator/expression_validator/basic_expression_validator.dart';
import 'package:console_calculator/expression_validator/expression_validator.dart';
import 'package:console_calculator/tokenizer/default_tokenizer.dart';
import 'package:console_calculator/tokenizer/tokenizer.dart';

void main(List<String> arguments) {
  // Tokenize given Strings (also check each String matched allowed token pattern)
  final Tokenizer tokenizer = DefaultTokenizer();

  // Validate given expression is allowed format before calculating(in this version == [operand, operation, operand])
  final ExpressionValidator expressionValidator = BasicExpressionValidator();

  // Operate(actual calculation) given expression
  final ExpressionOperator expressionOperator = PostfixExpressionOperator();

  // Calculator which is kind of Facade Object perform calculation to given arguments
  final Calculator calculator = BasicCalculator(expressionOperator: expressionOperator, tokenizer: tokenizer, expressionValidator: expressionValidator);

  final String calculateResult = calculator.calculate(arguments);

  print(calculateResult);
}
