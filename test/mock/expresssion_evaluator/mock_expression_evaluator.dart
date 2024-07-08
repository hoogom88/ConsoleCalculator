import 'package:console_calculator/expression_operator/expression_operator.dart';
import 'package:console_calculator/term/term.dart';

class MockExpressionEvaluator implements ExpressionOperator {
  int evaluateCallCount = 0;
  List<Term> evaluateParameter = [];
  String evaluateReturnValue = 0.toString();

  void resetMockData() {
    evaluateCallCount = 0;
    evaluateParameter.clear();
    evaluateReturnValue = 0.toString();
  }

  @override
  String operate(List<Term> expressionTokens) {
    evaluateCallCount++;
    evaluateParameter = expressionTokens;
    return evaluateReturnValue;
  }
}
