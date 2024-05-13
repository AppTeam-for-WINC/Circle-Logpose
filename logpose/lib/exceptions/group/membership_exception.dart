class MembershipException implements Exception {
  MembershipException(this.message);
  final String message;

  @override
  String toString() => 'MembershipException: $message';
}
