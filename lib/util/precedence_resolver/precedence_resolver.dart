import 'package:console_calculator/term/operation/addition.dart';
import 'package:console_calculator/term/operation/division.dart';
import 'package:console_calculator/term/operation/multiplication.dart';
import 'package:console_calculator/term/operation/operation.dart';
import 'package:console_calculator/term/operation/subtraction.dart';
import 'package:console_calculator/util/exception.dart';

/// Provide precedence of operation
class PrecedenceResolver {

  /// Returns precedence of given Operation
  static int precedence(Operation operation) {
    return switch(operation) {
      Addition _ => 0,
      Subtraction _ => 0,
      Division _ => 1,
      Multiplication _ => 1,
      _ => throw SimpleBusinessException.invalidInput()
    };
  }
}
