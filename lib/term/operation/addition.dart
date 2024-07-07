import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/operation.dart';

/// Perform addition with two operands
/// Singleton
class Addition implements Operation {
  static final Addition _instance = Addition._();

  Addition._();

  factory Addition() {
    return _instance;
  }

  @override
  double execute(List<Operand> operands) {
    // TODO: implement execute
    throw UnimplementedError();
  }
}
