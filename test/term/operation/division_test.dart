import 'package:console_calculator/term/operation/division.dart';
import 'package:test/test.dart';

void main() {
  final Division division = Division();
  group('Division class', () {
    group('constructor Division()', () {
      test('ensure singleton instance ', () {
        // Given When
        final Division instance1 = Division();
        final Division instance2 = Division();
        final Division instance3 = Division();

        // Then
        expect(identical(division, instance1), isTrue);
        expect(identical(division, instance2), isTrue);
        expect(identical(division, instance3), isTrue);
      });
    });
  });
}
