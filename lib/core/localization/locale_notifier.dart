import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);

class LocaleNotifier extends Notifier<Locale> {
  late StorageManager _storageManager;

  final Map<String, Locale> locales = {
    'en': const Locale('en'),
    'id': const Locale('id'),
  };

  Locale get fallbackLocale => const Locale('en');

  @override
  Locale build() {
    _storageManager = ref.read(storageManagerProvider);
    final localeCode = _storageManager.get<String?>(StorageKey.CURRENT_LOCALE);
    if (localeCode != null && localeCode.isNotEmpty) {
      return Locale(localeCode);
    }
    return fallbackLocale;
  }

  void onUpdateLocale(Locale locale) {
    state = locale;
    _storageManager.save(StorageKey.CURRENT_LOCALE, locale.languageCode);
  }
}
