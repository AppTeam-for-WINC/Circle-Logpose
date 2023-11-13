// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:amazon_app/database/database.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: Text('予約アプリ'),
//       ),
//       child: Center(
//         child: CupertinoButton(
//           onPressed: () {
//             showCupertinoModalPopup(
//               context: context,
//               builder: (BuildContext context) {
//                 return Center(
//                   child: ReservationForm(),
//                 );
//               },
//             );
//           },
//           child: Text('予約を作成'),
//         ),
//       ),
//     );
//   }
// }

// class ReservationForm extends StatefulWidget {
//   @override
//   _ReservationFormState createState() => _ReservationFormState();
// }

// class _ReservationFormState extends State<ReservationForm> {
//   TextEditingController titleController = TextEditingController();
//   DateTime selectedDate = DateTime.now();
//   TimeOfDay selectedTime = TimeOfDay.now();
//   TextEditingController placeController = TextEditingController();
//   TextEditingController detailController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoActionSheet(
//       title: Text('予約を作成'),
//       message: Text('情報を入力してください'),
//       actions: <Widget>[
//         CupertinoActionSheetAction(
//           onPressed: () async {
//             final pickedDate = await showCupertinoModalPopup<DateTime>(
//               context: context,
//               builder: (BuildContext context) {
//                 return ReservationDateSelector(selectedDate);
//               },
//             );
//             if (pickedDate != null) {
//               setState(() {
//                 selectedDate = pickedDate;
//               });
//             }
//           },
//           child: Text('日付を選択'),
//         ),
//         CupertinoActionSheetAction(
//           onPressed: () async {
//             final pickedTime = await showCupertinoModalPopup<TimeOfDay>(
//               context: context,
//               builder: (BuildContext context) {
//                 return ReservationTimeSelector(selectedTime);
//               },
//             );
//             if (pickedTime != null) {
//               setState(() {
//                 selectedTime = pickedTime;
//               });
//             }
//           },
//           child: Text('時間を選択'),
//         ),
//         CupertinoTextField(
//           controller: titleController,
//           placeholder: 'タイトル',
//         ),
//         CupertinoTextField(
//           controller: placeController,
//           placeholder: '場所',
//         ),
//         CupertinoTextField(
//           controller: detailController,
//           placeholder: '詳細',
//           maxLines: 5,
//         ),
//         CupertinoButton(
//           onPressed: () {
//             String title = titleController.text;
//             DateTime dateTime = DateTime(
//               selectedDate.year,
//               selectedDate.month,
//               selectedDate.day,
//               selectedTime.hour,
//               selectedTime.minute,
//             );
//             String place = placeController.text;
//             String detail = detailController.text;

//             updateScheduleInfoData(
//                 "primary_id", title, "", dateTime, "", place, detail, 0);
//           },
//           child: Text('予約する'),
//         ),
//       ],
//       cancelButton: CupertinoActionSheetAction(
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//         child: Text('キャンセル'),
//       ),
//     );
//   }
// }

// class ReservationDateSelector extends StatelessWidget {
//   final DateTime selectedDate;

//   ReservationDateSelector(this.selectedDate);

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoDatePicker(
//       mode: CupertinoDatePickerMode.date,
//       initialDateTime: selectedDate,
//       onDateTimeChanged: (newDate) {
//         Navigator.of(context).pop(newDate);
//       },
//     );
//   }
// }

// class ReservationTimeSelector extends StatelessWidget {
//   final TimeOfDay selectedTime;

//   ReservationTimeSelector(this.selectedTime);

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

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:amazon_app/database/database.dart';

// void main() {
//   runApp(CupertinoApp(
//     home: HomeScreen(),
//   ));
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: Text('予約アプリ'),
//       ),
//       child: Center(
//         child: CupertinoButton(
//           onPressed: () {
//             showCupertinoModalPopup(
//               context: context,
//               builder: (BuildContext context) {
//                 return Center(
//                   child: ReservationForm(),
//                 );
//               },
//             );
//           },
//           child: Text('予約を作成'),
//         ),
//       ),
//     );
//   }
// }

// class ReservationForm extends StatefulWidget {
//   @override
//   _ReservationFormState createState() => _ReservationFormState();
// }

// class _ReservationFormState extends State<ReservationForm> {
//   TextEditingController titleController = TextEditingController();
//   DateTime selectedStartDate = DateTime.now();
//   TimeOfDay selectedStartTime = TimeOfDay.now();
//   DateTime selectedEndDate = DateTime.now();
//   TimeOfDay selectedEndTime = TimeOfDay.now();
//   TextEditingController placeController = TextEditingController();
//   TextEditingController detailController = TextEditingController();
//   String selectedColor = "Red";
//   String selectedOrganization = "";

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPopupSurface(
//       child: Column(
//         children: [
//           Container(
//             child: Text('予約を作成') ,
//           ),
//           Container(
//             child: Text('情報を入力してください'),
//           ),
//           Container(
//             child: ,
//           ),
//           CupertinoButton(
//             child: Text("開始日付を選択"),
//             onPressed: () async{
//               final pickedStartDate = await showCupertinoModalPopup<TimeOfDay>(
//                 context: context,
//                 builder: (BuildContext context) {
//                  return ReservationTimeSelector(selectedStartTime);
//                 },
//               );
//               if (pickedStartDate != null) {
//                 setState(() {
//                   selectedStartDate = pickedStartDate;
//                 });
//               }
//             },
            
//           ),
//           CupertinoButton(
//             child: Text('開始時間を選択'),
//             onPressed: () async{
//               final pickedStartTime = await showCupertinoModalPopup<TimeOfDay>(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return ReservationTimeSelector(selectedStartTime);
//                 },
//               );
//               if (pickedStartTime != null) {
//                 setState(() {
//                   selectedStartTime = pickedStartTime;
//                 });
//               }
//             },
//           ),
//           CupertinoButton(
//             child: Text('終了日付を選択'),
//             onPressed: () async{
//               final pickedEndDate = await showCupertinoModalPopup<DateTime>(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return ReservationDateSelector(selectedEndDate);
//                 },
//               );
//               if (pickedEndDate != null) {
//                 setState(() {
//                   selectedEndDate = pickedEndDate;
//                 });
//               }
//             },
//           ),
//         ],
//       ),
//       title: Text('予約を作成'),
//       message: Text('情報を入力してください'),
//       actions: <Widget>[
//         //CupertinoPopupSurface
//         CupertinoActionSheetAction(
//           onPressed: () async {
//             final pickedStartDate = await showCupertinoModalPopup<DateTime>(
//               context: context,
//               builder: (BuildContext context) {
//                 return ReservationDateSelector(selectedStartDate);
//               },
//             );
//             if (pickedStartDate != null) {
//               setState(() {
//                 selectedStartDate = pickedStartDate;
//               });
//             }
//           },
//           child: Text('開始日付を選択'),
//         ),
//         CupertinoActionSheetAction(
//           onPressed: () async {
//             final pickedStartTime = await showCupertinoModalPopup<TimeOfDay>(
//               context: context,
//               builder: (BuildContext context) {
//                 return ReservationTimeSelector(selectedStartTime);
//               },
//             );
//             if (pickedStartTime != null) {
//               setState(() {
//                 selectedStartTime = pickedStartTime;
//               });
//             }
//           },
//           child: Text('開始時間を選択'),
//         ),
//         CupertinoActionSheetAction(
//           onPressed: () async {
//             final pickedEndDate = await showCupertinoModalPopup<DateTime>(
//               context: context,
//               builder: (BuildContext context) {
//                 return ReservationDateSelector(selectedEndDate);
//               },
//             );
//             if (pickedEndDate != null) {
//               setState(() {
//                 selectedEndDate = pickedEndDate;
//               });
//             }
//           },
//           child: Text('終了日付を選択'),
//         ),
//         CupertinoActionSheetAction(
//           onPressed: () async {
//             final pickedEndTime = await showCupertinoModalPopup<TimeOfDay>(
//               context: context,
//               builder: (BuildContext context) {
//                 return ReservationTimeSelector(selectedEndTime);
//               },
//             );
//             if (pickedEndTime != null) {
//               setState(() {
//                 selectedEndTime = pickedEndTime;
//               });
//             }
//           },
//           child: Text('終了時間を選択'),
//         ),
//         CupertinoTextField(
//           controller: titleController,
//           placeholder: 'タイトル',
//         ),
//         CupertinoTextField(
//           controller: placeController,
//           placeholder: '場所',
//         ),
//         CupertinoTextField(
//           controller: detailController,
//           placeholder: '詳細',
//           maxLines: 5,
//         ),
//         CupertinoFormRow(
//           prefix: Text('団体を選択: '),
//           child: CupertinoTextField(
//             placeholder: '団体',
//             onChanged: (value) {
//               selectedOrganization = value;
//             },
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('カラーを選択: '),
//             CupertinoSegmentedControl(
//               children: {
//                 'Red': Text('Red'),
//                 'Green': Text('Green'),
//                 'Blue': Text('Blue'),
//               },
//               groupValue: selectedColor,
//               onValueChanged: (value) {
//                 setState(() {
//                   selectedColor = value;
//                 });
//               },
//             ),
//           ],
//         ),
//         CupertinoButton(
//           onPressed: () {
//             String title = titleController.text;
//             DateTime dateStartTime = DateTime(
//               selectedStartDate.year,
//               selectedStartDate.month,
//               selectedStartDate.day,
//               selectedStartTime.hour,
//               selectedStartTime.minute,
//             );
//             DateTime dateEndTime = DateTime(
//               selectedEndDate.year,
//               selectedEndDate.month,
//               selectedEndDate.day,
//               selectedEndTime.hour,
//               selectedEndTime.minute,
//             );
//             String place = placeController.text;
//             String detail = detailController.text;
//             String color = selectedColor;
//             updateScheduleInfoData("primary_id", title, color , dateStartTime,
//                 dateEndTime, place, detail, 0);
//             Navigator.of(context).pop();
//           },
//           child: Text('予約する'),
//         ),
//       ],
//       cancelButton: CupertinoActionSheetAction(
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//         child: Text('キャンセル'),
//       ),
//     );
//   }
// }

// class ReservationDateSelector extends StatelessWidget {
//   final DateTime selectedDate;

//   ReservationDateSelector(this.selectedDate);

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoDatePicker(
//       mode: CupertinoDatePickerMode.date,
//       initialDateTime: selectedDate,
//       onDateTimeChanged: (newDate) {
//         Navigator.of(context).pop(newDate);
//       },
//     );
//   }
// }

// class ReservationTimeSelector extends StatelessWidget {
//   final TimeOfDay selectedTime;

//   ReservationTimeSelector(this.selectedTime);

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
