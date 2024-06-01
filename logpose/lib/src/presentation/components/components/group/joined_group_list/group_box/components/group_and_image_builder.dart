import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../domain/model/group_and_id_model.dart';
import '../../../../../../../utils/responsive_util.dart';
import '../../../../../../providers/group/group/listen_group_and_id_provider.dart';

import '../../../../../common/custom_image/custom_image.dart';

class GroupAndImageBuilder extends ConsumerWidget {
  const GroupAndImageBuilder({super.key, required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncGroupAndId = ref.watch(listenGroupAndIdProvider(groupId));

    return asyncGroupAndId.when(
      data: _GroupAndImage.new,
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => Text('$error'),
    );
  }
}

class _GroupAndImage extends StatelessWidget {
  const _GroupAndImage(this.data);

  final GroupAndId? data;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    if (data == null) {
      return const Text('No group data.');
    }

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildLayout(),
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildLayout(),
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildLayout(),
    );
  }

  List<Widget> _buildLayout() {
    return [
      CustomImage(
        imagePath: data!.groupProfile.image,
        height: 45,
        width: 45,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          data!.groupProfile.name,
          style: const TextStyle(
            fontSize: 16,
            overflow: TextOverflow.clip,
          ),
        ),
      ),
    ];
  }
}
