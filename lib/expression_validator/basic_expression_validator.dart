import 'package:console_calculator/expression_validator/expression_validator.dart';
import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/operation.dart';
import 'package:console_calculator/term/term.dart';

/// Validate a expression based on four fundamental arithmetic operations(+, -, /, *)
/// (only [Operand, Operation, Operand] is allow)
class BasicExpressionValidator implements ExpressionValidator {
  @override
  bool validate(List<Term> expressions) {
    return (expressions.length == 3 && expressions[0] is Operand && expressions[1] is Operation && expressions[2] is Operand);
  }
}
