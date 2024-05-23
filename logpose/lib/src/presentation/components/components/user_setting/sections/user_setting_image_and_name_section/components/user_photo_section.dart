import 'package:flutter/cupertino.dart';

import '../../../../../common/photo_button.dart';
import 'user_image_view.dart';

class UsePhotoSection extends StatelessWidget {
  const UsePhotoSection({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 0, 60, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          UserImageView(imagePath: imagePath),
          const Icon(
            CupertinoIcons.arrow_right_arrow_left,
            size: 30,
            color: CupertinoColors.systemGrey,
          ),
          const PhotoButton(),
        ],
      ),
    );
  }
}
