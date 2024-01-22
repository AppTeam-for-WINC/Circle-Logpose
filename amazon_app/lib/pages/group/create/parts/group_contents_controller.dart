import 'package:amazon_app/validation/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> groupContentController(
  BuildContext context,
  WidgetRef ref,
  TextEditingController groupNameController,
) async {
  final groupName = groupNameController.text;
  const requiredValidation = RequiredValidation();
  const maxLength32Validation = MaxLength32Validation();

  final groupNameRequiredValidation = requiredValidation.validate(
    groupName,
    'groupName',
  );
  final groupNameMaxLength32Validation = maxLength32Validation.validate(
    groupName,
    'groupName',
  );

  //途中なので、後で追加する。
}
