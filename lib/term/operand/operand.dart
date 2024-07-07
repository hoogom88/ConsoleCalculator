import 'package:console_calculator/term/term.dart';

/// Contains a value used as input for operation
class Operand extends Term {
  final double value;

  Operand(this.value);

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
