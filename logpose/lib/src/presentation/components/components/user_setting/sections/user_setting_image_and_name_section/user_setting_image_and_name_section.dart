import 'package:flutter/cupertino.dart';

import '../../../../common/name_field.dart';
import '../../../../common/red_error_message.dart';

import 'components/user_photo_section.dart';

class UserSettingImageAndNameSection extends StatefulWidget {
  const UserSettingImageAndNameSection({
    super.key,
    required this.imagePath,
    required this.name,
    required this.errorMessage,
  });

  final String imagePath;
  final String name;
  final String? errorMessage;

  @override
  State createState() => _UserSettingImageAndNameSectionState();
}

class _UserSettingImageAndNameSectionState
    extends State<UserSettingImageAndNameSection> {
  @override
  Widget build(BuildContext context) {
    final imagePath = widget.imagePath;
    final name = widget.name;
    final errorMessage = widget.errorMessage;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UsePhotoSection(imagePath: imagePath),
        if (errorMessage != null)
          RedErrorMessage(errorMessage: errorMessage, fontSize: 14),
        NameField(placeholder: 'username', name: name),
      ],
    );
  }
}
