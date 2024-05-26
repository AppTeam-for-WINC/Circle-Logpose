import 'package:flutter/cupertino.dart';

import 'schedule_field/place_text_field.dart';

class PlaceSection extends StatelessWidget {
  const PlaceSection({super.key});

  @override
  Widget build(BuildContext context) {
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
