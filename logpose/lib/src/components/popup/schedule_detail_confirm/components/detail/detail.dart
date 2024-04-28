import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Detail extends ConsumerWidget {
  const Detail({super.key, required this.detail});
  final String? detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.only(top: 15),
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
                margin: const EdgeInsets.only(left: 8),
                child: const Text(
                  '詳細',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: deviceHeight * 0.08,
            ),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(right: 30),
                child: detail != null
                    ? Text(
                        detail!,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
