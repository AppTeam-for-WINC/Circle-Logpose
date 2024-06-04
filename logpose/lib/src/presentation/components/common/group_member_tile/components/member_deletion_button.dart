import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/responsive_util.dart';

import '../../../../handlers/member_delete_handler.dart';

class MemberDeletionButton extends ConsumerStatefulWidget {
  const MemberDeletionButton({
    super.key,
    required this.accountId,
    this.groupId,
  });

  final String accountId;
  final String? groupId;

  @override
  ConsumerState<MemberDeletionButton> createState() =>
      _MemberDeletionButtonState();
}

class _MemberDeletionButtonState extends ConsumerState<MemberDeletionButton> {
  Future<void> handleToTap() async {
    final handler = MemberDeleteHandler(
      ref: ref,
      groupId: widget.groupId,
      accountId: widget.accountId,
    );
    await handler.handleToDeleteMember();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout(deviceWidth);
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout(deviceWidth);
        } else {
          return _buildDesktopLayout(deviceWidth);
        }
      },
    );
  }

  Widget _buildMobileLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.06);
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.04);
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.035);
  }

  Widget _buildLayout(double deleteIconSize) {
    return CupertinoButton(
      onPressed: handleToTap,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 231, 231, 231),
          borderRadius: BorderRadius.all(Radius.circular(999)),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(0, 2),
              color: Color.fromRGBO(0, 0, 0, 0.25),
            ),
          ],
        ),
        child: Icon(
          CupertinoIcons.delete,
          color: CupertinoColors.black,
          size: deleteIconSize,
        ),
      ),
    );
  }
}
