

          // CupertinoDatePicker(
          //   mode: CupertinoDatePickerMode.time,
          //   initialDateTime: formatString(scheduleNotifier.startAt),
          //   onDateTimeChanged: (newDateTime) {

          //   },
          // ),

        //  CupertinoDatePicker(
          //   mode: CupertinoDatePickerMode.time,
          //   initialDateTime: formatString(scheduleNotifier.endAt),
          //   onDateTimeChanged: (newDateTime) {

          //   }
          // ),












// class ReservationTimeSelector extends StatelessWidget {
//   final TimeOfDay selectedTime;

//   const ReservationTimeSelector(this.selectedTime, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoDatePicker(
//       mode: CupertinoDatePickerMode.time,
//       initialDateTime: DateTime(
//         DateTime.now().year,
//         DateTime.now().month,
//         DateTime.now().day,
//         selectedTime.hour,
//         selectedTime.minute,
//       ),
//       onDateTimeChanged: (newDateTime) {
//         Navigator.of(context).pop(TimeOfDay(
//           hour: newDateTime.hour,
//           minute: newDateTime.minute,
//         ));
//       },
//     );
//   }
// }
