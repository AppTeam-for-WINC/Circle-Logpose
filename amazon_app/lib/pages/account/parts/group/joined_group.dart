import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinedGroup extends ConsumerWidget {
  const JoinedGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(
            216,
            235,
            97,
            0.29,
          ),
          borderRadius: BorderRadius.circular(80),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Icon(CupertinoIcons.group_solid, size: 25),
              Text(
                '団体名',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9A9A9A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
