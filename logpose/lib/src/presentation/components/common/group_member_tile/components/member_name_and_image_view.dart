import 'package:flutter/cupertino.dart';

import '../../../../../domain/entity/user_profile.dart';
import '../../custom_image/custom_cached_network_image.dart';
import '../../custom_text.dart';

class MemberNameAndImageView extends StatelessWidget {
  const MemberNameAndImageView({super.key, required this.memberProfile});

  final UserProfile memberProfile;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 0.5,
            spreadRadius: 0.1,
            offset: Offset(1, 1),
            color: CupertinoColors.systemGrey,
          ),
        ],
        borderRadius: BorderRadius.circular(40),
        color: const Color.fromARGB(255, 248, 233, 255),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 10),
              child: CustomCachedNetworkImage(
                imagePath: memberProfile.image,
                width: 37,
                height: 37,
              ),
            ),
            CustomText(text: memberProfile.name),
          ],
        ),
      ),
    );
  }
}
