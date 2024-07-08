import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/util/exception.dart';

/// Contains a value used as input for operation
class Number extends Operand {
  @override
  final OperandType operandType = OperandType.number;

  @override
  final String value;

  // allowed maxValue (length <= 14)
  static const double _maxLength = 14;

  Number._(this.value);

  /// Throw SimpleBusinessException('invalidInput') if value can't parsed to double
  /// (longer than 15 characters are truncated)
  factory Number(String value) {
    String subString = value.length <= _maxLength ? value : value.substring(0, 14);
    if (double.tryParse(subString) == null) throw SimpleBusinessException.invalidInput();
    return Number._(subString);
  }

  // implements by generator
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Number && runtimeType == other.runtimeType && value == other.value;

  // implements by generator
  @override
  int get hashCode => value.hashCode;
}
