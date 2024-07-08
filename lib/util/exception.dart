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
  final ExceptionMessage message;

  SimpleBusinessException.invalidInput()
      : message = ExceptionMessage.invalidInput;

  SimpleBusinessException.overflow()
      : message = ExceptionMessage.overflow;

  SimpleBusinessException.syntaxError()
      : message = ExceptionMessage.syntaxError;

  SimpleBusinessException.undefinedError()
    : message = ExceptionMessage.undefinedError;

  @override
  String toString() => 'SimpleBusinessException: $message';
}
