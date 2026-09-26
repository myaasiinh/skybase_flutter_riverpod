import 'package:flutter_test/flutter_test.dart';
import 'package:skybase/core/network/result.dart';

void main() {
  group('Result Class Tests', () {
    test('should return success value when Result is Success', () {
      // arrange
      const result = Success<String, Exception>('Success Data');

      // act
      final value = result.fold((s) => s, (f) => 'Failed');

      // assert
      expect(value, 'Success Data');
      expect(result.isSuccess, true);
      expect(result.isFailure, false);
    });

    test('should return failure value when Result is Failure', () {
      // arrange
      final exception = Exception('Error occurred');
      final result = FailureResult<String, Exception>(exception);

      // act
      final value = result.fold((s) => 'Success', (f) => f.toString());

      // assert
      expect(value, exception.toString());
      expect(result.isSuccess, false);
      expect(result.isFailure, true);
    });
  });
}
