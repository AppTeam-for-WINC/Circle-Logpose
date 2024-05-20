class UserException implements Exception {
  UserException(this.message);
  final String message;

  @override
  String toString() => 'UserException: $message';
}
