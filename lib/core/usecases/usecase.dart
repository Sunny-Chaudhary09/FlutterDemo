/// Base contract for application-specific business rules (Clean Architecture).
abstract class UseCase<T, Params> {
  T call(Params params);
}

/// Use when a use case takes no input.
class NoParams {
  const NoParams();
}
