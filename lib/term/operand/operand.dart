import 'package:console_calculator/term/term.dart';
import 'package:console_calculator/util/exception.dart';

/// Contains a value used as input for operation
class Operand extends Term {
  final double value;
  // allowed maxValue (length <= 14)
  static const double _maxValue = 14;

  Operand._(this.value);

  /// Only value whose length is less than 15, not Nan, and finite
  factory Operand(double value) {
    if (value.toString().length > _maxValue || value.isNaN || value.isInfinite) throw SimpleBusinessException.overflow();
    return Operand._(value);
  }

  // implements by generator
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Operand &&
          runtimeType == other.runtimeType &&
          value == other.value;

  // implements by generator
  @override
  int get hashCode => value.hashCode;
}
