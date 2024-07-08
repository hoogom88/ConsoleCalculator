import 'package:console_calculator/expression_evaluator/expression_evaluator.dart';
import 'package:console_calculator/term/term.dart';

class MockExpressionEvaluator implements ExpressionOperator {
  int evaluateCallCount = 0;
  List<Term> evaluateParameter = [];
  double evaluateReturnValue = 0;

  void resetMockData() {
    evaluateCallCount = 0;
    evaluateParameter.clear();
    evaluateReturnValue = 0;
  }

  @override
  double evaluate(List<Term> expressionTokens) {
    evaluateCallCount++;
    evaluateParameter = expressionTokens;
    return evaluateReturnValue;
  }
}
