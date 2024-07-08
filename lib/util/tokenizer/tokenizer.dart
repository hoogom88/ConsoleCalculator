import 'package:console_calculator/term/term.dart';

/// Breaks expression into Term using an own tokenize method
/// (it didn't validate the expression, just tokenize)
abstract interface class Tokenizer {
  /// Returns separated Terms from given expression
  List<Term> tokenize(List<String> expression);
}
