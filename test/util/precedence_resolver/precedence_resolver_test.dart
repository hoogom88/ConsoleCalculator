import 'package:console_calculator/term/operation/addition.dart';
import 'package:console_calculator/term/operation/division.dart';
import 'package:console_calculator/term/operation/multiplication.dart';
import 'package:console_calculator/term/operation/operation.dart';
import 'package:console_calculator/term/operation/subtraction.dart';
import 'package:console_calculator/util/precedence_resolver/precedence_resolver.dart';
import 'package:test/test.dart';

void main() {
  group('PrecedenceResolver class', () {
    group('precedence() static method', () {
      test('Returns precedence of give Operation', () {
        // Given
        final Operation addition = Addition();
        final Operation subtraction = Subtraction();
        final Operation division = Division();
        final Operation multiplication = Multiplication();
        final int expectedAdditionPrecedence = 0;
        final int expectedSubtractionPrecedence = 0;
        final int expectedDivisionPrecedence = 1;
        final int expectedMultiplicationPrecedence = 1;

        // When
        final int additionPrecedence = PrecedenceResolver.precedence(addition);
        final int subtractionPrecedence = PrecedenceResolver.precedence(subtraction);
        final int divisionPrecedence = PrecedenceResolver.precedence(division);
        final int multiplicationPrecedence = PrecedenceResolver.precedence(multiplication);

        // Then
        expect(expectedAdditionPrecedence == additionPrecedence, isTrue);
        expect(expectedSubtractionPrecedence == subtractionPrecedence, isTrue);
        expect(expectedDivisionPrecedence == divisionPrecedence, isTrue);
        expect(expectedMultiplicationPrecedence == multiplicationPrecedence, isTrue);
      });
    });
  });
}
