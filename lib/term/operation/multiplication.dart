import 'package:console_calculator/term/operand/number.dart';
import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/operation.dart';
import 'package:console_calculator/util/exception.dart';

/// Perform multiplication with two Operands
/// Singleton
class Multiplication extends Operation {
  @override
  final int requiredOperandNumber = 2;
  @override
  final OperationType operationType = OperationType.multiplication;
  static final Multiplication _instance = Multiplication._();

  Multiplication._();

  factory Multiplication() {
    return _instance;
  }

  @override
  Operand execute(List<Operand> operands) {
    try {
      return Number((double.parse(operands[0].value) * double.parse(operands[1].value)).toString());
    } catch (e) {
      throw SimpleBusinessException.overflow();
    }
  }
}
