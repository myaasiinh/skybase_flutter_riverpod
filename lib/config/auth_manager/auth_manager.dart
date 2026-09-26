import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:skybase/config/themes/theme_manager.dart';
import 'package:skybase/config/base/navigation.dart';
import 'package:skybase/core/database/storage/cache_data.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
import 'package:skybase/data/models/user/user.dart' as dto;
import 'package:skybase/domain/entities/user/user.dart' as entity;
import 'package:skybase/ui/views/intro/intro_view.dart';
import 'package:skybase/ui/views/login/login_view.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';

enum AppType {
  INITIAL,
  FIRST_INSTALL,
  UNAUTHENTICATED,
  AUTHENTICATED,
}

final authManagerProvider = NotifierProvider<AuthManager, AppType>(AuthManager.new);

class AuthManager extends Notifier<AppType> {
  late final StorageManager _storage;
  late final SecureStorageManager _secureStorage;
  late final ThemeManager _themeManager;
  late final Navigation _navigation;

  @override
  AppType build() {
    _storage = ref.read(storageManagerProvider);
    _secureStorage = ref.read(secureStorageManagerProvider);
    _themeManager = ref.read(themeManagerProvider.notifier);
    _navigation = ref.read(navigationProvider);

    _init();
    return AppType.INITIAL;
  }

  Future<void> _init() async {
    await setup();
  }

  Future<void> setup() async {
    checkFirstInstall();
    await checkAppTheme();
    await clearExpiredCache();
  }

  Future<void> clearExpiredCache() async {
    await Future.wait(
      _storage.sharedPreferences.getKeys().map((key) async {
        List<String> permanentKeys = [
          StorageKey.FIRST_INSTALL,
          StorageKey.CURRENT_LOCALE,
          StorageKey.IS_DARK_THEME,
          StorageKey.USERS,
        ];

        if (!permanentKeys.contains(key)) {
          final now = DateTime.now();
          dynamic storageItem = await _storage.get(key);
          if (storageItem != null) {
            CacheData cacheData = CacheData.fromJson(jsonDecode(storageItem));
            if (cacheData.expiredDate.isBefore(now)) await _storage.delete(key);
          }
        }
      }),
    );
  }

  Future<void> checkFirstInstall() async {
    final bool isFirstInstall =
        await _storage.get(StorageKey.FIRST_INSTALL) ?? true;

    if (isFirstInstall) {
      await _secureStorage.setToken(value: '');
      state = AppType.FIRST_INSTALL;
    } else {
      await checkUser();
    }
  }

  Future<void> checkAppTheme() async {
    final bool isDarkTheme =
        await _storage.get(StorageKey.IS_DARK_THEME) ?? false;

    if (isDarkTheme) {
      _themeManager.toDarkMode();
    } else {
      _themeManager.toLightMode();
    }
  }

  Future<void> checkUser() async {
    final token = await _secureStorage.getToken();

    if (token != null && token.isNotEmpty) {
      setAuth();
    } else {
      await logout();
    }
  }

  Future<void> setAuth() async {
    if (await _secureStorage.isLoggedIn()) {
      state = AppType.AUTHENTICATED;
    }
  }

  Future<void> logout() async {
    await clearData();
    state = AppType.UNAUTHENTICATED;
  }

  Future<void> clearData() async {
    await _secureStorage.logout();
    await _storage.logout();
  }

  Future<void> login({
    required entity.User user,
    required String token,
    required String refreshToken,
  }) async {
    await saveAuthData(
      user: user,
      token: token,
      refreshToken: refreshToken,
    );
    await setAuth();
  }

  Future<void> saveAuthData({
    required entity.User user,
    required String token,
    required String refreshToken,
  }) async {
    await saveUserData(user: user);
    await _secureStorage.setToken(value: token);
    await _secureStorage.setRefreshToken(value: refreshToken);
  }

  Future<void> saveUserData({required entity.User user}) async {
    final userDto = dto.User(
      id: user.id,
      token: user.token,
      refreshToken: user.refreshToken,
      username: user.username,
      name: user.name,
      location: user.location,
      company: user.company,
      gitUrl: user.gitUrl,
      bio: user.bio,
      avatarUrl: user.avatarUrl,
      repository: user.repository,
      followers: user.followers,
      following: user.following,
    );
    await _storage.save<String>(
      StorageKey.USERS,
      jsonEncode(userDto.toJson()),
    );
  }

  entity.User? get user {
    if (_storage.has(StorageKey.USERS)) {
      final userDto = dto.User.fromJson(
        jsonDecode(_storage.get<String>(StorageKey.USERS)),
      );
      return userDto.toEntity();
    }
    return null;
  }

  void onAuthChanged(AppType state) {
    switch (state) {
      case AppType.INITIAL:
        break;
      case AppType.FIRST_INSTALL:
        _navigation.pushAllReplacementNoContext(IntroView.route);
        break;
      case AppType.UNAUTHENTICATED:
        _navigation.pushAllReplacementNoContext(LoginView.route);
        break;
      case AppType.AUTHENTICATED:
        _navigation.pushAllReplacementNoContext(MainNavView.route);
        break;
    }
  }
}
