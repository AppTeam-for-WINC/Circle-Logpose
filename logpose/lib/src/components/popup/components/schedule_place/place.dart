import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'place_text_field.dart';

class Place extends ConsumerWidget {
  const Place({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.placemark,
            size: 25,
            color: CupertinoColors.systemGrey,
          ),
          Container(
            padding: const EdgeInsets.only(left: 8),
            width: deviceWidth * 0.6,
            child: const PlaceTextField(),
          ),
        ],
      ),
    );
  }
}
