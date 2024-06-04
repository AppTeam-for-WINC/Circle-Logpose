import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/responsive_util.dart';
import '../../handlers/photo_button_handler.dart';

class PhotoButton extends ConsumerStatefulWidget {
  const PhotoButton({super.key});
  @override
  ConsumerState<PhotoButton> createState() => _PhotoButtonState();
}

class _PhotoButtonState extends ConsumerState<PhotoButton> {
  Future<void> _handlePhoto() async {
    final handler = PhotoButtonHandler(context: context, ref: ref);
    await handler.handlePhoto();
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
    return _buildLayout(deviceWidth * 0.12);
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.1);
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.08);
  }

  Widget _buildLayout(double photoIconSize) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: _handlePhoto,
      child: SizedBox(
        child: Icon(
          CupertinoIcons.photo,
          size: photoIconSize,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }
}
