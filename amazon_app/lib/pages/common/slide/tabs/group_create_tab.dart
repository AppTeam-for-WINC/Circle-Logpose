import 'package:amazon_app/pages/src/group/create/group_create_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupCreateTab extends ConsumerStatefulWidget {
  const GroupCreateTab({super.key});

  @override
  ConsumerState createState() => GroupCreateTabState();
}

class GroupCreateTabState extends ConsumerState<GroupCreateTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        await Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
            builder: (context) => const GroupCreatePage(),
          ),
          (_) => false,
        );
      },
      child: Container(
        width: 180,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: Row(
          children: [
            Container(
              width: 33,
              height: 33,
              decoration: BoxDecoration(
                color: const Color.fromARGB(210, 194, 136, 223),
                borderRadius: BorderRadius.circular(33),
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                ),
              ),
            ),
            const Text(
              '団体作成',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF7B61FF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
