class ScheduleResponseParams {
  const ScheduleResponseParams({
    required this.memberScheduleId,
    required this.attendance,
    required this.leaveEarly,
    required this.lateness,
    required this.absence,
  });

  final String memberScheduleId;
  final bool attendance;
  final bool leaveEarly;
  final bool lateness;
  final bool absence;
}
