import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/term.dart';

/// Function which takes zero or more operands calculate value
abstract class Operation extends Term {
  /// Calculate value using operands
  double execute(List<Operand> operands);
}
