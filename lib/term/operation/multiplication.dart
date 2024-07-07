import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/operation.dart';

/// Perform multiplication with two operands
/// Singleton
class Multiplication extends Operation {
  @override
  final int requiredOperandNumber = 2;
  static final Multiplication _instance = Multiplication._();

  Multiplication._();

  factory Multiplication() {
    return _instance;
  }

  @override
  Operand execute(List<Operand> operands) {
    // TODO: implement execute
    throw UnimplementedError();
  }
}
