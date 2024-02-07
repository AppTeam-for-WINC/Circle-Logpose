import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BehindAndEarlySetting extends ConsumerStatefulWidget {
  const BehindAndEarlySetting({
    super.key,
    required this.responseIcon,
    required this.responseText,
  });

  final Icon responseIcon;
  final Text responseText;
  @override
  ConsumerState<BehindAndEarlySetting> createState() {
    return _BehindAndEarlySettingState();
  }
}

class _BehindAndEarlySettingState extends ConsumerState<BehindAndEarlySetting> {
  @override
  Widget build(BuildContext context) {
    final responseIcon = widget.responseIcon;
    final responseText = widget.responseText;
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: SizedBox(
          width: 360,
          height: 300,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 500,
                decoration: const BoxDecoration(color: Colors.white), //メインの白
              ),
              Container(
                width: double.infinity,
                height: 80,
                decoration:
                    const BoxDecoration(color: Color(0xFFD8EB61)), //上の黄緑
              ),
              Positioned(
                top: 60,
                left: 30,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/group_img.jpeg'),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 110),
                              child: const Text(
                                'Designner23',
                                style: TextStyle(fontSize: 35),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text('2023/9/20 13:00-14:00'),
                            ),
                          ],
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.only(top: 105, left: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            color: const Color(0xFFFBCEFF),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                responseIcon,
                                responseText,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: const Icon(Icons.schedule),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 80, top: 40),
                          child: const Text(
                            '参加時間',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 30, top: 40),
                          child: const Text(
                            '13:30-14:00',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
