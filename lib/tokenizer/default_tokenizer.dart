import 'package:console_calculator/term/operand/number.dart';
import 'package:console_calculator/term/operation/addition.dart';
import 'package:console_calculator/term/operation/division.dart';
import 'package:console_calculator/term/operation/multiplication.dart';
import 'package:console_calculator/term/operation/operation.dart';
import 'package:console_calculator/term/operation/subtraction.dart';
import 'package:console_calculator/term/term.dart';
import 'package:console_calculator/util/exception.dart';
import 'package:console_calculator/tokenizer/tokenizer.dart';

/// Breaks expression into Term using String index accessing and regular expression
/// (only can tokenize double format number ([0-9]+[.]?[0-9]*) and +,-/*
class DefaultTokenizer implements Tokenizer {

  @override
  List<Term> tokenize(List<String> expression) {
    List<Term> tokens = [];

    // join elements to support tokenizing some any complex operation in future
    String expressionString = expression.join(' ');

    int i = 0;
    while (i < expressionString.length) {
      // Operand(Number)
      if (RegExp(r'[0-9]').hasMatch(expressionString[i])) {
        int j = i;

        // tokenize continuous digit or dot(.)
        while (j < expressionString.length && RegExp(r'[0-9.]').hasMatch(expressionString[j])) {
          j++;
        }
        final String subString = expressionString.substring(i, j);
        if (subString.contains('..')) throw SimpleBusinessException.invalidInput();

        tokens.add(Number(subString));
        i = j;
        continue;
      }

      // Operation(Addition, Subtraction, Division, Multiplication)
      if ('+-*/^'.contains(expressionString[i])) {
        tokens.add(_stringToOperation(expressionString[i]));
        i++;
        continue;
      }

      // Skip space
      if (expressionString[i] == ' ') {
        i++;
        continue;
      }

      // Unacceptable input
      throw SimpleBusinessException.invalidInput();
    }

    return tokens;
  }

  Operation _stringToOperation(String operation) {
    return switch (operation) {
      '+' => Addition(),
      '-' => Subtraction(),
      '/' => Division(),
      '*' => Multiplication(),
      _ => throw SimpleBusinessException.invalidInput(),
    };
  }
}
