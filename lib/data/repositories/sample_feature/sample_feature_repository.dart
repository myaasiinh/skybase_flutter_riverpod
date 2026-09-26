import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository_impl.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources.dart';
import 'package:skybase/domain/repositories/sample_feature_repository.dart';

final sampleFeatureRepositoryProvider = Provider<ISampleFeatureRepository>((ref) {
  final apiService = ref.watch(sampleFeatureSourcesProvider);
  final storageManager = ref.watch(storageManagerProvider);
  return SampleFeatureRepositoryImpl(
    apiService: apiService,
    storageManager: storageManager,
  );
});
