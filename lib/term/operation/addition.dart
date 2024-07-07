import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/operation.dart';

/// Perform addition with two Operands
/// Singleton
class Addition extends Operation {
  @override
  final int requiredOperandNumber = 2;
  @override
  final OperationType operationType = OperationType.addition;
  static final Addition _instance = Addition._();

  Addition._();

  factory Addition() {
    return _instance;
  }

  @override
  Operand execute(List<Operand> operands) {
    // TODO: implement execute
    throw UnimplementedError();
  }
}
