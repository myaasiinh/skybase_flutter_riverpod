/* Created by
   Antigravity
*/

sealed class Result<S, F> {
  const Result();

  /// Transform the Success value using [fn].
  Result<T, F> map<T>(T Function(S value) fn) {
    return switch (this) {
      Success(value: final v) => Success(fn(v)),
      FailureResult(error: final e) => FailureResult(e),
    };
  }

  /// Transform the Failure value using [fn].
  Result<S, T> mapFailure<T>(T Function(F error) fn) {
    return switch (this) {
      Success(value: final v) => Success(v),
      FailureResult(error: final e) => FailureResult(fn(e)),
    };
  }

  /// Execute [onSuccess] if success, or [onFailure] if failure.
  T fold<T>(
    T Function(S value) onSuccess,
    T Function(F error) onFailure,
  ) {
    return switch (this) {
      Success(value: final v) => onSuccess(v),
      FailureResult(error: final e) => onFailure(e),
    };
  }

  bool get isSuccess => this is Success<S, F>;
  bool get isFailure => this is FailureResult<S, F>;
}

class Success<S, F> extends Result<S, F> {
  final S value;
  const Success(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Success<S, F> &&
          runtimeType == other.runtimeType &&
          value == other.value);

  @override
  int get hashCode => value.hashCode;
}

class FailureResult<S, F> extends Result<S, F> {
  final F error;
  const FailureResult(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FailureResult<S, F> &&
          runtimeType == other.runtimeType &&
          error == other.error);

  @override
  int get hashCode => error.hashCode;
}
