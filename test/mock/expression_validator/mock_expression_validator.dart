import 'package:console_calculator/expression_validator/expression_validator.dart';
import 'package:console_calculator/term/term.dart';

class MockExpressionValidator implements ExpressionValidator {
  int validateCallCount = 0;
  List<Term> validateParameter = [];
  bool validateReturnValue = true;
  Exception? error;

  void resetMockData() {
    validateCallCount = 0;
    validateParameter.clear();
    validateReturnValue = true;
    error = null;
  }

  @override
  bool validate(List<Term> expressionTokens) {
    if (error != null) throw error!;
    validateCallCount++;
    validateParameter = expressionTokens;
    return validateReturnValue;
  }
}
