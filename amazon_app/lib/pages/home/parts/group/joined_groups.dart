import 'package:amazon_app/pages/home/parts/group/controller/joined_group_controller.dart';
import 'package:amazon_app/pages/home/parts/group/group_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../group/create/group_create_page.dart';

class GroupPage extends ConsumerWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsProfile = ref.watch(readJoinedGroupsProfileProvider);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFF5F3FE),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            top: deviceHeight * 0.15,
            child: SizedBox(
              width: deviceWidth,
              height: deviceHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.count(
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2,
                      children: groupsProfile.when(
                        data: (groupProfile) {
                          if (groupProfile.isEmpty) {
                            return const [SizedBox.shrink()];
                          }
                          return groupProfile.map((groupWithId) {
                            return GroupBox(groupWithId: groupWithId);
                          }).toList();
                        },
                        loading: () => const [CupertinoActivityIndicator()],
                        error: (error, stack) => [Text('Error: $error')],
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0, // 画面の底部に配置
            child: Container(
              width: deviceWidth,
              height: deviceHeight * 0.12,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff76548C).withOpacity(0),
                    const Color.fromARGB(255, 26, 7, 100).withOpacity(0.3),
                    const Color.fromARGB(255, 22, 0, 109).withOpacity(0.4),
                    const Color.fromARGB(255, 159, 146, 225).withOpacity(0.7),
                  ],
                  stops: const [0, 0.5, 0.8, 0.99],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: deviceHeight * 0.875,
            child: Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                color: const Color.fromARGB(255, 107, 88, 252),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(225, 127, 145, 145),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: CupertinoButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                      builder: (context) => const GroupCreatePage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Text(
                      '新しい団体を作成',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
