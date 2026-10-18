/// Typed failures thrown by the data layer and translated into user-facing
/// messages by the presentation layer.
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Sign-in / sign-up / OTP failures.
class AuthException extends AppException {
  const AuthException(super.message);
}

/// Connectivity, timeout or 5xx style failures.
class NetworkException extends AppException {
  const NetworkException(super.message);
}

/// Expected business-rule failures (e.g. duplicate account).
class DomainException extends AppException {
  const DomainException(super.message);
}
