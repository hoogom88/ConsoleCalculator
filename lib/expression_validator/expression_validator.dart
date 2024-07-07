import 'package:console_calculator/term/term.dart';

abstract interface class ExpressionValidator {
  bool validate(List<Term> expressions);
}