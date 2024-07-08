import 'package:console_calculator/expression_operator/expression_operator.dart';
import 'package:console_calculator/term/term.dart';

/// Evaluate a expression using postfix expression algorithm (to support tokenizing some complex operation (ex, trigonometric functions, differential, integrate)
class PostfixExpressionOperator implements ExpressionOperator {

  // Evaluate expression by converting infix expression to postfix expression
  @override
  String operate(List<Term> expressionTokens) {
    // TODO: implement evaluate
    throw UnimplementedError();
  }
}