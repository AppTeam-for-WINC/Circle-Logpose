import 'package:amazon_app/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceTab extends ConsumerStatefulWidget {
  const AttendanceTab({super.key});

  @override
  ConsumerState createState() => AttendanceTabState();
}

class AttendanceTabState extends ConsumerState<AttendanceTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
            builder: (context) => const HomePage(),
          ),
          (_) => false,
        );
      },
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 33,
              height: 33,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.20),
                borderRadius: BorderRadius.circular(33),
              ),
              child: const Center(
                child: Text(
                  'all',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(255, 255, 255, 0.80),
                  ),
                ),
              ),
            ),
            const Text(
              '出席簿',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const Icon(
              Icons.expand_more,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
