import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/core/utils/app_logger.dart';

class AppProviderObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    AppLogger.d('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    AppLogger.d('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "action": "added"
}''');
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    AppLogger.d('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "action": "disposed"
}''');
  }
}
