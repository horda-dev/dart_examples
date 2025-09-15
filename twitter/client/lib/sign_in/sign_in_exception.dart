class SignInException implements Exception {
  final String message;

  const SignInException(this.message);

  @override
  String toString() => 'SignInException: $message';
}
