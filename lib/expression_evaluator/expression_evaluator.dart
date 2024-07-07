import 'package:console_calculator/term/term.dart';

/// Evaluate a expression using an own calculation method
abstract interface class ExpressionEvaluator {
  /// return the result of given expression tokens
  double evaluate(List<Term> expressionTokens);
}