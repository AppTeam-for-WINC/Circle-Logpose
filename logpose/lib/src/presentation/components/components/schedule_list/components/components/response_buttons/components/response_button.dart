import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../utils/schedule/schedule_response.dart';

class ResponseButton extends ConsumerWidget {
  const ResponseButton({
    super.key,
    required this.isResponse,
    required this.responseType,
    required this.groupScheduleId,
    required this.handleResponse,
  });
  
  final bool isResponse;
  final ResponseType responseType;
  final String groupScheduleId;
  final Future<void> Function() handleResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: handleResponse,
      child: Container(
        width: deviceWidth * 0.185,
        height: deviceHeight * 0.085,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          color: isResponse ? const Color(0xFFFBCEFF) : CupertinoColors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScheduleResponse.getIcon(responseType),
              ScheduleResponse.getText(responseType),
            ],
          ),
        ),
      ),
    );
  }
}
