import 'package:console_calculator/term/operand/number.dart';
import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/operation.dart';
import 'package:console_calculator/util/exception.dart';

/// Perform division with two Operands
/// Singleton
class Division extends Operation {
  @override
  final int requiredOperandNumber = 2;
  @override
  final OperationType operationType = OperationType.division;
  static final Division _instance = Division._();

  Division._();

  factory Division() {
    return _instance;
  }

  @override
  Operand execute(List<Operand> operands) {
    try {
      return Number((double.parse(operands[1].value) / double.parse(operands[0].value)).toString());
    } catch (e) {
      throw SimpleBusinessException.overflow();
    }
  }
}
