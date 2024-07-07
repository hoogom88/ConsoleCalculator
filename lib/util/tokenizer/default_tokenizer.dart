import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/addition.dart';
import 'package:console_calculator/term/operation/division.dart';
import 'package:console_calculator/term/operation/multiplication.dart';
import 'package:console_calculator/term/operation/operation.dart';
import 'package:console_calculator/term/operation/subtraction.dart';
import 'package:console_calculator/term/term.dart';
import 'package:console_calculator/util/exception.dart';
import 'package:console_calculator/util/tokenizer/tokenizer.dart';

class DefaultTokenizer implements Tokenizer {

  // Tokenize input expression using String index accessing and regular expression
  @override
  List<Term> tokenize(List<String> expression) {
    List<Term> tokens = [];

    // join elements to support tokenizing some complex operation (ex, trigonometric functions, differential, integrate)
    String expressionString = expression.join('');

    int i = 0;
    while (i < expressionString.length) {
      // Operand(Number)
      if (RegExp(r'[0-9]').hasMatch(expressionString[i])) {
        int j = i;

        // tokenize continuous digit or dot(.)
        while (j < expressionString.length && RegExp(r'[0-9.]').hasMatch(expressionString[j])) {
          j++;
        }

        tokens.add(Operand(
            double.tryParse(expressionString.substring(i, j)) ?? (throw SimpleBusinessException.invalidInput())));
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

      // Unclassified input
      throw SimpleBusinessException.invalidInput();
    }

    if (!_isTokenFormatValid(tokens)) throw SimpleBusinessException.invalidInput();
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

  // Check input format is 'Operand Operation Operand'
  bool _isTokenFormatValid(List<Term> tokens) {
    return (tokens.length == 3 && tokens[0] is Operand && tokens[1] is Operation && tokens[2] is Operand);
  }
}
