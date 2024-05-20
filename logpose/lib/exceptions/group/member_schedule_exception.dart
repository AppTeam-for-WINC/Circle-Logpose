class MemberScheduleException implements Exception {
  MemberScheduleException(this.message);
  final String message;

  @override
  String toString() => 'MemberScheduleException: $message';
}
