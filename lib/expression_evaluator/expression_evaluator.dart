import 'package:console_calculator/term/term.dart';

/// Evaluate a expression using an own calculation method
/// (calculate actual result value)
abstract interface class ExpressionOperator {
  /// return the result of given expression tokens
  double evaluate(List<Term> expressionTokens);
}