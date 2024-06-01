import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/responsive_util.dart';
import '../../providers/text_field/name_field_provider.dart';

class NameField extends ConsumerStatefulWidget {
  const NameField({super.key, required this.placeholder, this.name});

  final String placeholder;
  final String? name;

  @override
  ConsumerState<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends ConsumerState<NameField> {
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
      containerWidth: deviceWidth * 0.65,
      containerHeight: deviceHeight * 0.05,
      iconSize: deviceWidth * 0.06,
      textSize: deviceWidth * 0.04,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.65,
      containerHeight: deviceHeight * 0.05,
      iconSize: deviceWidth * 0.04,
      textSize: deviceWidth * 0.03,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.65,
      containerHeight: deviceHeight * 0.05,
      iconSize: deviceWidth * 0.03,
      textSize: deviceWidth * 0.02,
    );
  }

  Widget _buildLayout({
    required double containerWidth,
    required double containerHeight,
    required double iconSize,
    required double textSize,
  }) {
    final nameController = widget.name == null
        ? ref.watch(nameFieldProvider(''))
        : ref.watch(nameFieldProvider(widget.name!));

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 244, 219, 251),
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2.5,
            spreadRadius: 2.5,
            offset: Offset(0, 2),
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 13),
        child: CupertinoTextField(
          controller: nameController,
          prefix: Icon(CupertinoIcons.pencil, size: iconSize),
          style: TextStyle(fontSize: textSize),
          placeholder: widget.placeholder,
          decoration: const BoxDecoration(color: Color(0x00000000)),
        ),
      ),
    );
  }
}
