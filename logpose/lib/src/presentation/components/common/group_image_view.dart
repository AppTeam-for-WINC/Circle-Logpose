import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/responsive_util.dart';

import '../../notifiers/image_provider.dart';

import 'custom_image/custom_image.dart';

class GroupImageView extends ConsumerStatefulWidget {
  const GroupImageView({super.key, this.imagePath});
  final String? imagePath;

  @override
  ConsumerState<GroupImageView> createState() => _GroupImageViewState();
}

class _GroupImageViewState extends ConsumerState<GroupImageView> {
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
    return _buildLayout(
      groupIconSize: deviceWidth * 0.17,
      imageSize: deviceWidth * 0.14,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      groupIconSize: deviceWidth * 0.14,
      imageSize: deviceWidth * 0.11,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      groupIconSize: deviceWidth * 0.1,
      imageSize: deviceWidth * 0.08,
    );
  }

  Widget _buildLayout({
    required double groupIconSize,
    required double imageSize,
  }) {
    final imageNotifier = ref.watch(imageControllerProvider);

    final imagePath = imageNotifier.path == '' && widget.imagePath != null
        ? widget.imagePath!
        : imageNotifier.path;

    return imagePath == ''
        ? Icon(
            CupertinoIcons.group_solid,
            size: groupIconSize,
            color: CupertinoColors.systemGrey,
          )
        : CustomImage(
            imagePath: imagePath,
            width: imageSize,
            height: imageSize,
          );
  }
}
