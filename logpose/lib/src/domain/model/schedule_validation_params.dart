class ScheduleValidationParams {
  ScheduleValidationParams({
    required this.title,
    required this.place,
    required this.detail,
    required this.startAt,
    required this.endAt,
  });

  final String title;
  final String place;
  final String detail;
  final DateTime startAt;
  final DateTime endAt;
}
