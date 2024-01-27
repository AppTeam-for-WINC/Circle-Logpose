import 'package:amazon_app/database/group/group/group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../group/setting/group_setting_page.dart';

class GroupBox extends ConsumerStatefulWidget {
  const GroupBox({super.key, required this.groupProfile});

  final Future<Group> groupProfile;
  @override
  ConsumerState createState() => GroupBoxState();
}

class GroupBoxState extends ConsumerState<GroupBox> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Group>(
      future: widget.groupProfile,
      builder: (context, snapshot) {
        // 非同期処理が完了しているかチェック
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final group = snapshot.data!;
            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                    builder: (context) => const GroupSettingPage(groupId: ''),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(36),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        width: 37,
                        height: 37,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              group.image,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    // Icon(Icons.rocket),
                    Text(
                      group.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        // データ取得中の場合の処理
        return const SizedBox.shrink();
      },
    );
  }
}
