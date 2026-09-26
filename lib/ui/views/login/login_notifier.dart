import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/domain/repositories/auth_repository.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

final loginProvider = AsyncNotifierProvider.autoDispose<LoginNotifier, bool?>(LoginNotifier.new);

class LoginNotifier extends AutoDisposeAsyncNotifier<bool?> {
  late final IAuthRepository _repository;

  @override
  FutureOr<bool?> build() {
    _repository = ref.read(authRepositoryProvider);
    return null;
  }

  Future<void> login({
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    final result = await _repository.login(
      phoneNumber: phoneNumber,
      email: email,
      password: password,
    );

    state = await AsyncValue.guard(() async {
      return result.fold(
        (user) async {
          await ref.read(authManagerProvider.notifier).login(
                user: user,
                token: user.token ?? '',
                refreshToken: user.refreshToken ?? '',
              );
          return true;
        },
        (failure) => throw failure,
      );
    });
  }

  Future<void> bypassLogin(BuildContext context) async {
    // Implement bypass logic if needed, or just navigate
    ref.read(authManagerProvider.notifier).onAuthChanged(AppType.AUTHENTICATED);
  }
}
