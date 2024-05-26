import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/text_field/schedule_detail_controller_provider.dart';
import '../../custom_text_field/custom_schedule_text_field.dart';

class DetailTextField extends ConsumerStatefulWidget {
  const DetailTextField({super.key});
  @override
  ConsumerState createState() => _DetailTextFieldState();
}

class _DetailTextFieldState extends ConsumerState<DetailTextField> {
  @override
  Widget build(BuildContext context) {
    return CustomScheduleTextField(
      textController:
          ref.watch(scheduleDetailControllerProvider.notifier).state,
      placeholder: '詳細を追加',
    );
  }
}
