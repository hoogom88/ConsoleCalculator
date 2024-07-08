import 'package:console_calculator/term/term.dart';

/// Type of operand
enum OperandType {
  number
}

abstract class Operand extends Term {
  OperandType get operandType;
  String get value;
}