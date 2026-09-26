import 'package:skybase/config/base/request_param.dart';
import 'package:skybase/core/errors/failures.dart';
import 'package:skybase/core/network/result.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';

abstract interface class ISampleFeatureRepository {
  Future<Result<List<SampleFeature>, AppFailure>> getUsers({
    required RequestParams requestParams,
    required int page,
    required int perPage,
    String? username,
  });

  Future<Result<SampleFeature, AppFailure>> getDetailUser({
    required RequestParams requestParams,
    required int id,
    required String username,
  });
}
