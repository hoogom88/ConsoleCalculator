import 'package:console_calculator/term/operation/addition.dart';
import 'package:test/test.dart';

void main() {
  final Addition addition = Addition();
  group('Addition class', () {
    group('constructor Addition()', () {
      test('ensure singleton instance ', () {
        // Given When
        final Addition instance1 = Addition();
        final Addition instance2 = Addition();
        final Addition instance3 = Addition();

        // Then
        expect(identical(addition, instance1), isTrue);
        expect(identical(addition, instance2), isTrue);
        expect(identical(addition, instance3), isTrue);
      });
    });
  });
}
