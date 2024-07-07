import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/operation.dart';

/// Perform subtraction with two Operands
/// Singleton
class Subtraction extends Operation {
  @override
  final int requiredOperandNumber = 2;
  @override
  final OperationType operationType = OperationType.subtraction;
  static final Subtraction _instance = Subtraction._();

  Subtraction._();

  factory Subtraction() {
    return _instance;
  }

  @override
  Operand execute(List<Operand> operands) {
    // TODO: implement execute
    throw UnimplementedError();
  }
}
