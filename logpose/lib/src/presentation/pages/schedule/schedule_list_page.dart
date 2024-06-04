import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/responsive_util.dart';

import '../../components/common/bottom_gradation.dart';

import '../../components/components/schedule_list/schedule_card_list.dart';
import '../../components/components/schedule_list/schedule_creation_button.dart';
import '../../components/components/schedule_list/schedule_sort_button.dart';

import '../../providers/group/group/listen_is_joined_group_exist_provider.dart';

class ScheduleListPage extends ConsumerStatefulWidget {
  const ScheduleListPage({super.key});

  @override
  ConsumerState createState() => _ScheduleListState();
}

class _ScheduleListState extends ConsumerState<ScheduleListPage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFF5F3FE),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (ResponsiveUtil.isMobile(context)) {
            return _buildMobileLayout(deviceWidth, deviceHeight);
          } else if (ResponsiveUtil.isTablet(context)) {
            return _buildTabletLayout(deviceWidth, deviceHeight);
          } else {
            return _buildDesktopLayout(deviceWidth, deviceHeight);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      deviceWidth: deviceWidth,
      sortButtonPositionTop: deviceHeight * 0.14,
      sortButtonPositionRight: deviceWidth * 0.1,
      scheduleCradPositionTop: deviceHeight * 0.19,
      creationButtonPositionTop: deviceHeight * 0.875,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      deviceWidth: deviceWidth,
      sortButtonPositionTop: deviceHeight * 0.15,
      sortButtonPositionRight: deviceWidth * 0.1,
      scheduleCradPositionTop: deviceHeight * 0.2,
      creationButtonPositionTop: deviceHeight * 0.875,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      deviceWidth: deviceWidth,
      sortButtonPositionTop: deviceHeight * 0.16,
      sortButtonPositionRight: deviceWidth * 0.1,
      scheduleCradPositionTop: deviceHeight * 0.22,
      creationButtonPositionTop: deviceHeight * 0.875,
    );
  }

  Widget _buildLayout({
    required double deviceWidth,
    required double sortButtonPositionTop,
    required double sortButtonPositionRight,
    required double scheduleCradPositionTop,
    required double creationButtonPositionTop,
  }) {
    final isJoinedGroupExist = ref.watch(listenIsJoinedGroupExistProvider);
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          top: sortButtonPositionTop,
          right: sortButtonPositionRight,
          child: ScheduleSortButton(deviceWidth: deviceWidth),
        ),
        Positioned(
          top: scheduleCradPositionTop,
          child: const ScheduleCardList(),
        ),
        const Positioned(
          bottom: 0,
          child: BottomGradation(),
        ),
        if (isJoinedGroupExist is AsyncLoading)
          const Center(child: CupertinoActivityIndicator()),
        if (isJoinedGroupExist is AsyncError)
          Center(child: Text('Error: ${isJoinedGroupExist.error}')),
        if (isJoinedGroupExist is AsyncData && isJoinedGroupExist.value == true)
          Positioned(
            top: creationButtonPositionTop,
            child: const ScheduleCreationButton(),
          ),
      ],
    );
  }
}
