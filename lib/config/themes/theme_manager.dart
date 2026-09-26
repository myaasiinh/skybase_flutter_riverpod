import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

final themeManagerProvider = NotifierProvider<ThemeManager, bool>(ThemeManager.new);

class ThemeManager extends Notifier<bool> {
  late final StorageManager _storage;

  @override
  bool build() {
    _storage = ref.read(storageManagerProvider);
    return _storage.get<bool?>(StorageKey.IS_DARK_THEME) ?? false;
  }

  void toDarkMode() {
    state = true;
    _storage.save<bool>(StorageKey.IS_DARK_THEME, state);
  }

  void toLightMode() {
    state = false;
    _storage.save<bool>(StorageKey.IS_DARK_THEME, state);
  }

  Future<bool> changeTheme() async {
    state = !state;
    _storage.save<bool>(StorageKey.IS_DARK_THEME, state);
    return state;
  }
}
