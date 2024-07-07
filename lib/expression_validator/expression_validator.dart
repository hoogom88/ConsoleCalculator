import 'package:console_calculator/term/term.dart';

/// Validate Expression using an own validate method
/// (only validate composition of expression)
abstract interface class ExpressionValidator {
  /// Validate whether given expression is valid or not
  bool validate(List<Term> expressions);
}