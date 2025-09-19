class SignUpException implements Exception {
  final String message;

  const SignUpException(this.message);

  @override
  String toString() => 'SignUpException: $message';
}
