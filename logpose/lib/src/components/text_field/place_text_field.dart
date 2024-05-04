import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/providers/text_field/schedule/schedule_place_controller_provider.dart';

class PlaceTextField extends ConsumerStatefulWidget {
  const PlaceTextField({super.key});
  @override
  ConsumerState createState() => _PlaceTextFieldState();
}

class _PlaceTextFieldState extends ConsumerState<PlaceTextField> {
  @override
  Widget build(BuildContext context) {
    void onChanged(String text) {
      ref.read(schedulePlaceControllerProvider.notifier).state.text = text;
    }

    return CupertinoTextField(
      controller: ref.watch(schedulePlaceControllerProvider.notifier).state,
      placeholder: '場所を追加',
      placeholderStyle: const TextStyle(
        color: CupertinoColors.systemGrey,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(style: BorderStyle.none),
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: CupertinoColors.black,
      ),
      onChanged: onChanged,
    );
  }
}
