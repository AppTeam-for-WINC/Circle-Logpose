import 'package:flutter/cupertino.dart';

import '../../../../utils/responsive_util.dart';
import '../../../navigations/dialogs/to_palette_dialog_navigator.dart';

class ColorButton extends StatefulWidget {
  const ColorButton({super.key, this.groupScheduleId, required this.color});

  final String? groupScheduleId;
  final Color? color;

  @override
  State<ColorButton> createState() => _ColorButtonState();
}

class _ColorButtonState extends State<ColorButton> {
  Future<void> _handleToTap() async {
    final navigator = ToPaletteDialogNavigator(context);
    await navigator.showDialog(widget.groupScheduleId, widget.color!);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    if (widget.color == null) {
      return const SizedBox.shrink();
    }

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
    return _buildLayout(
      paddingLeft: deviceWidth * 0.065,
      iconSize: deviceWidth * 0.11,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      paddingLeft: deviceWidth * 0.08,
      iconSize: deviceWidth * 0.06,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      paddingLeft: deviceWidth * 0.05,
      iconSize: deviceWidth * 0.05,
    );
  }

  Widget _buildLayout({
    required double paddingLeft,
    required double iconSize,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.only(left: paddingLeft),
      onPressed: _handleToTap,
      child: Icon(
        CupertinoIcons.circle_fill,
        size: iconSize,
        color: widget.color,
      ),
    );
  }
}
