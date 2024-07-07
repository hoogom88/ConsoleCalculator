import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/term.dart';

/// Function that operate value with operands
abstract class Operation extends Term {
  int get requiredOperandNumber;

  double execute(List<Operand> operands);
}