import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/group_image_view.dart';
import '../../../common/photo_button.dart';
import '../../../common/red_error_message.dart';
import '../../../common/text_field/name_field.dart';

class GroupNameAndImageSection extends ConsumerStatefulWidget {
  const GroupNameAndImageSection({
    super.key,
    required this.loadingErrorMessage,
  });

  final String? loadingErrorMessage;
  @override
  ConsumerState createState() => _GroupNameAndImageSectionState();
}

class _GroupNameAndImageSectionState
    extends ConsumerState<GroupNameAndImageSection> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final loadingErrorMessage = widget.loadingErrorMessage;

    return Container(
      width: deviceWidth * 0.85,
      height: deviceHeight * 0.215,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: CupertinoColors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(0, 2),
            color: Color.fromRGBO(0, 0, 0, 0.15),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 60,
              right: 60,
              bottom: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GroupImageView(),
                Icon(
                  CupertinoIcons.arrow_right_arrow_left,
                  size: 30,
                  color: CupertinoColors.systemGrey,
                ),
                PhotoButton(),
              ],
            ),
          ),
          if (loadingErrorMessage != null)
            RedErrorMessage(
              errorMessage: loadingErrorMessage,
              fontSize: 14,
            ),
          const NameField(placeholder: '団体名'),
        ],
      ),
    );
  }
}
