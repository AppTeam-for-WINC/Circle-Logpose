import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/providers/text_field/name_editing_provider.dart';

class NameField extends ConsumerWidget {
  const NameField({super.key, required this.placeholder, this.name});
  final String placeholder;
  final String? name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    TextEditingController nameController;
    if (name == null) {
      nameController = ref.watch(nameEditingProvider(''));
    } else {
      nameController = ref.watch(nameEditingProvider(name!));
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
          controller: nameController,
          prefix: const Icon(CupertinoIcons.pencil),
          style: const TextStyle(fontSize: 18),
          placeholder: placeholder,
          decoration: const BoxDecoration(
            color: Color(0x00000000),
          ),
        ),
      ),
    );
  }
}
