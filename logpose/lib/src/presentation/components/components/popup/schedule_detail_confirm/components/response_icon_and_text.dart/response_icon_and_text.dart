import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponseIconAndText extends ConsumerWidget {
  const ResponseIconAndText({
    super.key,
    this.responseIcon,
    this.responseText,
  });
  final Icon? responseIcon;
  final Text? responseText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    if (responseIcon == null || responseText == null) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 20,
      right: 20,
      child: Container(
        width: deviceWidth * 0.2,
        height: deviceHeight * 0.093,
        margin: const EdgeInsets.only(top: 105, left: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          color: const Color(0xFFFBCEFF),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              responseIcon!,
              responseText!,
            ],
          ),
        ),
      ),
    );
  }
}
