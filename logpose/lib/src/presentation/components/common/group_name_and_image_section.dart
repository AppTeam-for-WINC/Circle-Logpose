import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/responsive_util.dart';

import 'group_image_view.dart';
import 'name_field.dart';
import 'photo_button.dart';
import 'red_error_message.dart';

class GroupNameAndImageSection extends ConsumerStatefulWidget {
  const GroupNameAndImageSection({
    super.key,
    required this.loadingErrorMessage,
    this.imagePath,
    this.groupName,
  });

  final String? loadingErrorMessage;
  final String? imagePath;
  final String? groupName;
  @override
  ConsumerState createState() => _GroupNameAndImageSectionState();
}

class _GroupNameAndImageSectionState
    extends ConsumerState<GroupNameAndImageSection> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout(deviceWidth, deviceHeight);
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout(deviceWidth, deviceHeight);
        } else {
          return _buildDesktopLayout(deviceWidth, deviceHeight);
        }
      },
    );
  }

  Widget _buildMobileLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.85,
      containerHeight: deviceHeight * 0.215,
      arrowIconSize: deviceHeight * 0.026,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.85,
      containerHeight: deviceHeight * 0.215,
      arrowIconSize: deviceHeight * 0.03,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.85,
      containerHeight: deviceHeight * 0.215,
      arrowIconSize: deviceHeight * 0.03,
    );
  }

  Widget _buildLayout({
    required double containerWidth,
    required double containerHeight,
    required double arrowIconSize,
  }) {
    final loadingErrorMessage = widget.loadingErrorMessage;
    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: CupertinoColors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(0, 2),
            color: Color.fromRGBO(0, 0, 0, 0.15),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 20),
                  GroupImageView(imagePath: widget.imagePath),
                  Icon(
                    CupertinoIcons.arrow_right_arrow_left,
                    size: arrowIconSize,
                    color: CupertinoColors.systemGrey,
                  ),
                  const PhotoButton(),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ),
          if (loadingErrorMessage != null)
            RedErrorMessage(errorMessage: loadingErrorMessage, fontSize: 14),
          NameField(placeholder: '団体名', name: widget.groupName),
        ],
      ),
    );
  }
}
