import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../image/custom_image.dart';

class GroupImage extends ConsumerWidget {
  const GroupImage({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 70,
      left: 30,
      child: CustomImage(imagePath: imagePath, width: 60, height: 60),
    );
  }
}
