import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'detail_text_field.dart';

class Detail extends ConsumerWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
