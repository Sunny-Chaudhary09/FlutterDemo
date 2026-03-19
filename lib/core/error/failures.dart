/// Base type for domain / data failures (extend for specific cases).
abstract class Failure {
  const Failure([this.message]);

  final String? message;
}

class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}
