import 'package:flutter/cupertino.dart';

import 'schedule_field/detail_text_field.dart';

class DetailSection extends StatelessWidget {
  const DetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                CupertinoIcons.text_justify,
                size: 25,
                color: CupertinoColors.systemGrey,
              ),
              Container(
                padding: const EdgeInsets.only(left: 8),
                width: deviceWidth * 0.6,
                child: const DetailTextField(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
