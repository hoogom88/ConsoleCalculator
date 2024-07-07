import 'package:console_calculator/term/term.dart';

/// Breaks expression into Term
abstract interface class Tokenizer {
  /// Returns separated Terms from given expression
  List<Term> tokenize(List<String> expression);
}