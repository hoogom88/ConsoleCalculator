import 'package:console_calculator/expression_validator/expression_validator.dart';
import 'package:console_calculator/term/term.dart';

class MockExpressionValidator implements ExpressionValidator {
  int validateCallCount = 0;
  List<Term> validateParameter = [];
  bool validateReturnValue = true;

  void resetMockData() {
    validateCallCount = 0;
    validateParameter.clear();
    validateReturnValue = true;
  }

  @override
  bool validate(List<Term> expressionTokens) {
    validateCallCount++;
    validateParameter = expressionTokens;
    return validateReturnValue;
  }

}