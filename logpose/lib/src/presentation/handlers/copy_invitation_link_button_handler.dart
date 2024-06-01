import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/copy_to_clipboard.dart';

import '../controllers/group_invitation/group_invitation_management_controller.dart';

class CopyInvitationLinkButtonHandler {
  CopyInvitationLinkButtonHandler({
    required this.context,
    required this.ref,
    required this.groupId,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String groupId;

  Future<void> handleToCopyInvitationLink() async {
    final invitationLink = await _getInvitationLink();
    _copyToClipboard(invitationLink);
  }

  Future<String> _getInvitationLink() async {
    final invitationController =
        ref.read(groupInvitationManagementControllerProvider);
    return invitationController.createAndFetchGroupInvitationLink(groupId);
  }

  void _copyToClipboard(String invitationLink) {
    copyToClipboard(invitationLink);
  }
}
