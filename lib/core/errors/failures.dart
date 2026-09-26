/* Created by
   Antigravity
*/

sealed class AppFailure {
  final String message;
  final int? statusCode;

  const AppFailure(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ServerFailure extends AppFailure {
  const ServerFailure(super.message, {super.statusCode});
}

class CacheFailure extends AppFailure {
  const CacheFailure(super.message);
}

class NetworkFailure extends AppFailure {
  const NetworkFailure(super.message);
}

class ValidationFailure extends AppFailure {
  const ValidationFailure(super.message);
}

class UnknownFailure extends AppFailure {
  const UnknownFailure(super.message);
}
