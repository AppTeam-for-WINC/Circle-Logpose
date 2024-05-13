class GroupUpdateException implements Exception {
  GroupUpdateException(this.message);
  final String message;

  @override
  String toString() => 'GroupUpdateException: $message';
}
