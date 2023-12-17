import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../group/create/group_create_page.dart';
import '../../group/setting/group_setting_page.dart';

class GroupBox extends ConsumerWidget {
  const GroupBox({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute<MaterialPageRoute<dynamic>>(
              builder: (context) => const GroupSettingPage(),),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.rocket),
            Text(
              '団体名',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Group extends ConsumerWidget {
  const Group({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF5F3FE),
        child: Padding(
          padding: const EdgeInsets.only(top: 130),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: <Widget>[
                    for (int i = 0; i < 10; i++) const GroupBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xff76548C).withOpacity(0),
              const Color(0xff0F0439).withOpacity(0.3),
              const Color(0xff0F0439).withOpacity(0.4),
              const Color.fromARGB(255, 159, 146, 225).withOpacity(0.7),
            ],
            stops: const [0, 0.5, 0.8, 0.99],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 15,
              child: SizedBox(
                width: 250,
                height: 55,
                child: FloatingActionButton.extended(
                  backgroundColor: const Color(0xFF7B61FF),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute<MaterialPageRoute<dynamic>>(
                          builder: (context) => const GroupCreatePage()),
                    );
                  },
                  label: const Text(
                    '新しい団体を作成',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  icon: Container(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
