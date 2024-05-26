import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/schedule_view_label.dart';

class SchedulePlaceView extends ConsumerWidget {
  const SchedulePlaceView({super.key, required this.place});

  final String? place;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScheduleViewLabel(
            icon: CupertinoIcons.placemark,
            label: '場所',
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(right: 30),
            child: place != null
                ? Text(
                    place!,
                    style: const TextStyle(fontSize: 18),
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
