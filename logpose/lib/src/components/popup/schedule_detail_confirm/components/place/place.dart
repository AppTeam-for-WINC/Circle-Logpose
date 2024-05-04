import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Place extends ConsumerWidget {
  const Place({super.key, required this.place});
  final String? place;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                CupertinoIcons.placemark,
                size: 25,
                color: CupertinoColors.systemGrey,
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: const Text(
                  '場所',
                  style: TextStyle(color: CupertinoColors.systemGrey),
                ),
              ),
            ],
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
