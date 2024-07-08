import 'package:console_calculator/expression_operator/expression_operator.dart';
import 'package:console_calculator/term/operand/operand.dart';
import 'package:console_calculator/term/operation/operation.dart';
import 'package:console_calculator/term/term.dart';
import 'package:console_calculator/util/exception.dart';
import 'package:console_calculator/util/precedence_resolver/precedence_resolver.dart';

/// Evaluate a expression using postfix expression algorithm (to support any complex operation in future)
class PostfixExpressionOperator implements ExpressionOperator {
  // Evaluate expression by converting infix expression to postfix expression
  @override
  String operate(List<Term> expressionTokens) {
    final List<Term> postfix = _infixToPostfix(expressionTokens);
    List<Operand> stack = [];
    for (Term token in postfix) {
      if (token is Operand) {
        stack.add(token);
        continue;
      }

      if (token is Operation) {
        final int requiredOperandNumber = token.requiredOperandNumber;
        if (stack.length < requiredOperandNumber) throw SimpleBusinessException.syntaxError();
        final List<Operand> operands = [];
        for (int i = 0; i < requiredOperandNumber; i++) {
          operands.add(stack.removeLast());
        }

        stack.add(token.execute(operands));
      }
    }
    if (stack.length != 1) throw SimpleBusinessException.syntaxError();
    return stack.first.value;
  }

  // convert expression postfix expression
  List<Term> _infixToPostfix(List<Term> tokens) {
    List<Term> postfix = [];
    List<Operation> stack = [];
    bool isLastOperand = false;
    for (Term token in tokens) {
      if (token is Operand) {
        if (isLastOperand) throw SimpleBusinessException.syntaxError();
        isLastOperand = true;
        postfix.add(token);
        continue;
      }

      if (token is Operation) {
        if (!isLastOperand) throw SimpleBusinessException.syntaxError();
        isLastOperand = false;

        while (stack.isNotEmpty && PrecedenceResolver.precedence(stack.last) >= PrecedenceResolver.precedence(token)) {
          postfix.add(stack.removeLast());
        }
        stack.add(token);
        continue;
      }
    }

    while (stack.isNotEmpty) {
      postfix.add(stack.removeLast());
    }
    return postfix;
  }
}
