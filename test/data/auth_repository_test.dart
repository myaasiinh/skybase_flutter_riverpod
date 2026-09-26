import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skybase/core/network/result.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/repositories/auth/auth_repository_impl.dart';
import 'package:skybase/data/sources/server/auth/auth_sources.dart';
import 'package:skybase/domain/entities/user/user.dart' as entity;

class MockAuthSources extends Mock implements AuthSources {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthSources mockSources;

  setUp(() {
    mockSources = MockAuthSources();
    repository = AuthRepositoryImpl(apiService: mockSources);
  });

  group('AuthRepositoryImpl Tests', () {
    const tUserModel = User(id: 1, username: 'testuser');
    
    test('should return entity.User when login is successful', () async {
      // arrange
      when(() => mockSources.login(
            phoneNumber: any(named: 'phoneNumber'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => tUserModel);

      // act
      final result = await repository.login(
        phoneNumber: '123',
        email: 'test@mail.com',
        password: 'password',
      );

      // assert
      expect(result.isSuccess, true);
      result.fold(
        (user) => expect(user.username, tUserModel.username),
        (failure) => fail('Should not return failure'),
      );
      verify(() => mockSources.login(
            phoneNumber: '123',
            email: 'test@mail.com',
            password: 'password',
          )).called(1);
    });
  });
}
