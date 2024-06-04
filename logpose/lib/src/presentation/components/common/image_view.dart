import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/responsive_util.dart';

import '../../notifiers/image_path_set_notifier.dart';

import 'custom_image/custom_image.dart';

enum ImageViewType { user, group }

class ImageView extends ConsumerStatefulWidget {
  const ImageView({super.key, this.imagePath, required this.imageViewType});

  final String? imagePath;
  final ImageViewType imageViewType;

  @override
  ConsumerState<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends ConsumerState<ImageView> {
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
      iconSize: deviceWidth * 0.17,
      imageSize: deviceWidth * 0.14,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      iconSize: deviceWidth * 0.14,
      imageSize: deviceWidth * 0.11,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      iconSize: deviceWidth * 0.1,
      imageSize: deviceWidth * 0.08,
    );
  }

  Widget _buildLayout({
    required double iconSize,
    required double imageSize,
  }) {
    final imageNotifier = ref.watch(imagePathSetNotifierProvider);

    final imagePath = imageNotifier.path == '' && widget.imagePath != null
        ? widget.imagePath!
        : imageNotifier.path;

    if (imagePath != '') {
      return CustomImage(
        imagePath: imagePath,
        width: imageSize,
        height: imageSize,
      );
    } else if (widget.imageViewType == ImageViewType.user) {
      return Icon(
        CupertinoIcons.person,
        size: iconSize,
        color: CupertinoColors.systemGrey,
      );
    } else if (widget.imageViewType == ImageViewType.group) {
      return Icon(
        CupertinoIcons.group_solid,
        size: iconSize,
        color: CupertinoColors.systemGrey,
      );
    } else {
      throw Exception('Error: unexpected error occoured.');
    }
  }
}
