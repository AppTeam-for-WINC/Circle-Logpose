import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/providers/group/text/group_name_editing_provider.dart';

class GroupNameField extends ConsumerWidget {
  const GroupNameField({super.key, this.groupName});
  final String? groupName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    TextEditingController groupNameController;
    if (groupName == null) {
      groupNameController = ref.watch(groupNameEditingProvider(''));
    } else {
      groupNameController = ref.watch(groupNameEditingProvider(groupName!));
    }

    return Container(
      width: deviceWidth * 0.65,
      height: deviceHeight * 0.05,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 244, 219, 251),
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2.5,
            spreadRadius: 2.5,
            offset: Offset(0, 2),
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 13),
        child: CupertinoTextField(
          controller: groupNameController,
          prefix: const Icon(CupertinoIcons.pencil),
          style: const TextStyle(fontSize: 18),
          placeholder: '団体名',
          decoration: const BoxDecoration(
            color: Color(0x00000000),
          ),
        ),
      ),
    );
  }
}
