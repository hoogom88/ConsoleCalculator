import 'package:console_calculator/term/term.dart';

/// Breaks expression into Term using an own tokenize method
abstract interface class Tokenizer {
  /// Returns separated Terms from given expression
  List<Term> tokenize(List<String> expression);
}
