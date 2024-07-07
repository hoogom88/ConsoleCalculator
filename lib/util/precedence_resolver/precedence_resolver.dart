import 'package:console_calculator/term/operation/operation.dart';

/// Provide precedence of operation
class PrecedenceResolver {
  static final Map<Operation, int> _precedence = {};

  /// Returns precedence of given Operation
  static int precedence(Operation operation) {
    return 0;
  }
}
