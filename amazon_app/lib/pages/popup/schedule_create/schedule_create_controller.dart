
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// riverpod
//状態を管理することができる。
//setState　とかで使われる、画面が描画されている間、ずっと実行されるアクション（動的状態）

//https://riverpod.dev/ja/docs/essentials/first_request



// String selectedTeam = 'Team1';
// List<String> teams = ['Team1', 'Team2', 'Team3', 'Team4'];

//   //schedule_create_controllerにて後ほど、管理する。
//   void showTeamPicker(BuildContext context) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (BuildContext context) {
//         return SizedBox(
//           height: 200,
//           child: CupertinoPicker(
//             itemExtent: 40,
//             onSelectedItemChanged: (int index) {
//               setState(() {
//                 selectedTeam = teams[index];
//               });
//             },
//             children: List.generate(
//               teams.length,
//               (index) => Center(
//                 child: Text(teams[index]),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }





// void showTeamPicker(BuildContext context, List<String> teams, String selectedTeam, Function(String) onSelected) {
//   showCupertinoModalPopup(
//     context: context,
//     builder: (BuildContext context) {
//       return SizedBox(
//         height: 200,
//         child: CupertinoPicker(
//           itemExtent: 40,
//           onSelectedItemChanged: (int index) {
//             onSelected(teams[index]);
//           },
//           children: List.generate(
//             teams.length,
//             (index) => Center(
//               child: Text(teams[index]),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
