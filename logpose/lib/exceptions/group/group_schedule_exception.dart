class GroupScheduleException implements Exception {
  GroupScheduleException(this.message);
  final String message;

  @override
  String toString() => 'GroupScheduleException: $message';
}
