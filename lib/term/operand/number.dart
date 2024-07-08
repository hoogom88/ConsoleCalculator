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

  /// Only value whose length is less than 15, not Nan, and finite
  factory Number(String value) {
    if (value.length > _maxLength) throw SimpleBusinessException.overflow();
    return Number._(value);
  }

  // implements by generator
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Number &&
          runtimeType == other.runtimeType &&
          value == other.value;

  // implements by generator
  @override
  int get hashCode => value.hashCode;
}
