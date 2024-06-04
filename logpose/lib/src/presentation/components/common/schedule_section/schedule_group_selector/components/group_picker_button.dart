import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../utils/responsive_util.dart';
import '../../../../../navigations/modals/to_group_picker_navigator.dart';

import '../../../../../providers/group/group/selected_group_name_provider.dart';

class GroupPickerButton extends ConsumerStatefulWidget {
  const GroupPickerButton({super.key, required this.groupIdList});

  final List<String> groupIdList;

  @override
  ConsumerState<GroupPickerButton> createState() => _GroupPickerButtonState();
}

class _GroupPickerButtonState extends ConsumerState<GroupPickerButton> {
  Future<void> _handleToTap() async {
    final navigator = ToGroupPickerNavigator(context);
    await navigator.showModal(widget.groupIdList);
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
    return _buildLayout(deviceWidth * 0.04);
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.025);
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.018);
  }

  Widget _buildLayout(double nameTextSize) {
    return CupertinoButton(
      padding: const EdgeInsets.only(left: 10),
      onPressed: _handleToTap,
      child: Text(
        ref.watch(selectedGroupNameProvider),
        style: TextStyle(
          fontSize: nameTextSize,
          color: const Color(0xFF7B61FF),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
