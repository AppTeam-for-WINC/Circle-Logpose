import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../providers/text_field/schedule_place_controller_provider.dart';
import '../../../../common/custom_text_field/custom_schedule_text_field.dart';

class PlaceTextField extends ConsumerStatefulWidget {
  const PlaceTextField({super.key});
  @override
  ConsumerState createState() => _PlaceTextFieldState();
}

class _PlaceTextFieldState extends ConsumerState<PlaceTextField> {
  @override
  Widget build(BuildContext context) {
    return CustomScheduleTextField(
      textController: ref.watch(schedulePlaceControllerProvider.notifier).state,
      placeholder: '場所を追加',
    );
  }
}
