import 'package:console_calculator/term/term.dart';
import 'package:console_calculator/tokenizer/tokenizer.dart';

class MockTokenizer implements Tokenizer {
  int tokenizeCallCount = 0;
  List<String> tokenizeParameter = [];
  List<Term> tokenizeReturnValue = [];

  void resetMockData() {
    tokenizeCallCount = 0;
    tokenizeParameter.clear();
    tokenizeReturnValue.clear();
  }

  @override
  List<Term> tokenize(List<String> expression) {
    tokenizeCallCount++;
    tokenizeParameter = expression;
    return tokenizeReturnValue;
  }
}
