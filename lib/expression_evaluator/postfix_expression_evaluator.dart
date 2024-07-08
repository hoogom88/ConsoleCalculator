import 'package:console_calculator/expression_evaluator/expression_evaluator.dart';
import 'package:console_calculator/term/term.dart';

/// Evaluate a expression using postfix expression algorithm (to support tokenizing some complex operation (ex, trigonometric functions, differential, integrate)
class PostfixExpressionEvaluator implements ExpressionEvaluator {

  // Evaluate expression by converting infix expression to postfix expression
  @override
  double evaluate(List<Term> expressionTokens) {
    // TODO: implement evaluate
    throw UnimplementedError();
  }
}