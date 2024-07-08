/// Message for SimpleBusinessException
enum ExceptionMessage {
  invalidInput('invalid input'),
  overflow('overflow error'),
  syntaxError('syntax error'),
  undefinedError('undefined error');

  const ExceptionMessage(this.message);

  final String message;
}

/// Simple exception which is considered a business exception
class SimpleBusinessException implements Exception {
  final ExceptionMessage exceptionMessage;

  SimpleBusinessException.invalidInput()
      : exceptionMessage = ExceptionMessage.invalidInput;

  SimpleBusinessException.overflow()
      : exceptionMessage = ExceptionMessage.overflow;

  SimpleBusinessException.syntaxError()
      : exceptionMessage = ExceptionMessage.syntaxError;

  SimpleBusinessException.undefinedError()
    : exceptionMessage = ExceptionMessage.undefinedError;

  @override
  String toString() => 'SimpleBusinessException: $exceptionMessage';
}
