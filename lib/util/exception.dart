/// Message for SimpleBusinessException
enum ExceptionMessage {
  invalidInput('invalid input');

  const ExceptionMessage(this.message);

  final String message;
}

/// Simple exception which is considered a business exception
class SimpleBusinessException implements Exception {
  final ExceptionMessage message;

  SimpleBusinessException.invalidInput()
      : message = ExceptionMessage.invalidInput;

  @override
  String toString() => 'CustomException: $message';
}
