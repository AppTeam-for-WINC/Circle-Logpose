import 'package:amazon_app/pages/src/popup/schedule_join_member/schedule_join_member.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponsedMembers extends ConsumerStatefulWidget {
  const ResponsedMembers({super.key});
  @override
  ConsumerState createState() => _ResponsedMemberState();
}

class _ResponsedMemberState extends ConsumerState<ResponsedMembers> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showCupertinoModalPopup<ScheduleJoinMember>(
          context: context,
          builder: (BuildContext context) {
            return const Center(
              child: ScheduleJoinMember(),
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Row(
          children: [
            const Icon(
              Icons.group,
              size: 25,
              color: Colors.grey,
            ),
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: const Text(
                '参加メンバー |',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            // Added schedule responsed members.
          ],
        ),
      ),
    );
  }
}

// class PresentMember extends ConsumerWidget {
//   // 参加メンバーのアイコンを取得するように変更してください
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     List<Widget> iconWidgets = [];

//     int iconCount = 0;
//     while (iconCount < maxIcons) {
//       iconWidgets.add(
//         Container(
//           margin: const EdgeInsets.only(right: 5),
//           child: GestureDetector(
//             onTap: () async{
//               await showCupertinoModalPopup<ScheduleJoinMember>(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return const Center(
//                     child: ScheduleJoinMember(),
//                   );
//                 },
//               );
//             },
//             child: Icon(
//               memberIcon,
//               size: 20,
//             ),
//           ),
//         ),
//       );
//       iconCount++;
//     }

//     if (iconCount >= maxIcons) {
//       iconWidgets.add(
//         const Text(
//           '…',
//           style: TextStyle(color: Colors.grey),
//         ),
//       );
//     }

//     return Row(
//       children: iconWidgets,
//     );
//   }
// }
// //参加メンバーのアイコン↑
