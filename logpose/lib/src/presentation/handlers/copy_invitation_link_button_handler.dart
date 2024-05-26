import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/clipboard/copy_to_clipboard.dart';

import '../controllers/copy_invitation_link_controller.dart';

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
    final invitationController = ref.read(copyInvitationLinkControllerProvider);
    return invitationController.createAndFetchGroupInvitationLink(groupId);
  }

  void _copyToClipboard(String invitationLink) {
    copyToClipboard(invitationLink);
  }
}
