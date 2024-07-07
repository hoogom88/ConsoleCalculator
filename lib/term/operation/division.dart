import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/operation.dart';

/// Perform division with two operands
/// Singleton
class Division implements Operation {
  static final Division _instance = Division._();

  Division._();

  factory Division() {
    return _instance;
  }

  @override
  double execute(List<Operand> operands) {
    // TODO: implement execute
    throw UnimplementedError();
  }
}
