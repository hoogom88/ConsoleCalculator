import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/term.dart';

/// Type of operation
enum OperationType {
  addition,
  subtraction,
  division,
  multiplication,
}

/// Function which takes zero or more Operands calculate value
abstract class Operation extends Term {
  int get requiredOperandNumber;
  OperationType get operationType;

  /// Calculate value using Operands
  /// (parameter operands' element must be valid)
  Operand execute(List<Operand> operands);
}
