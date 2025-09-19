class TweetDetailsException implements Exception {
  final String message;

  const TweetDetailsException(this.message);

  @override
  String toString() => 'TweetDetailsException: $message';
}
