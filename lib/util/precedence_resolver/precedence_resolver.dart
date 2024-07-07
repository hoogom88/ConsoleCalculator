import 'package:console_calculator/term/operation/operation.dart';

/// Provide precedence of Operation
class PrecedenceResolver {

  /// Returns precedence of given Operation
  static int precedence(Operation operation) {
    return switch(operation.operationType) {
      OperationType.addition => 0,
      OperationType.subtraction => 0,
      OperationType.division => 1,
      OperationType.multiplication => 1,
    };
  }
}
