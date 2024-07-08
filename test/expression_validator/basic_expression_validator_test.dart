import 'package:console_calculator/expression_validator/basic_expression_validator.dart';
import 'package:console_calculator/expression_validator/expression_validator.dart';
import 'package:console_calculator/term/operand/number.dart';
import 'package:console_calculator/term/operation/addition.dart';
import 'package:console_calculator/term/operation/operation.dart';
import 'package:console_calculator/term/term.dart';
import 'package:test/test.dart';

void main() {
  final ExpressionValidator validator = BasicExpressionValidator();
  final Number operand = Number('0.0');
  final Operation operation = Addition();

  group('BasicExpressionValidator class', () {
    group('validate() method', () {
      test('Returns false if given expression is invalid(!= [Operand, Operation, Operand])', () {
        // Given
        final List<Term> expression1 = [operand, operand, operand];
        final List<Term> expression2 = [operand, operand, operation];
        final List<Term> expression3 = [operand, operation, operation];
        final List<Term> expression4 = [operation, operand, operand];
        final List<Term> expression5 = [operation, operation, operand];
        final List<Term> expression6 = [operation, operation, operation];
        final List<Term> expression7 = [operand, operand];
        final List<Term> expression8 = [operation, operation];

        // When
        final result1 = validator.validate(expression1);
        final result2 = validator.validate(expression2);
        final result3 = validator.validate(expression3);
        final result4 = validator.validate(expression4);
        final result5 = validator.validate(expression5);
        final result6 = validator.validate(expression6);
        final result7 = validator.validate(expression7);
        final result8 = validator.validate(expression8);

        // Then
        expect(result1, isFalse);
        expect(result2, isFalse);
        expect(result3, isFalse);
        expect(result4, isFalse);
        expect(result5, isFalse);
        expect(result6, isFalse);
        expect(result7, isFalse);
        expect(result8, isFalse);
      });

      test('Returns true if given expression is valid(== [Operand, Operation, Operand])', () {
        // Given
        final List<Term> expression = [operand, operation, operand];


        // When
        final result = validator.validate(expression);

        // Then
        expect(result, isTrue);
      });
    });
  });
}
