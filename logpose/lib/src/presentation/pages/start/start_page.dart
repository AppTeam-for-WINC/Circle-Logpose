import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/responsive_util.dart';

import '../../components/common/app_logo_and_title.dart';
import '../../components/components/start/move_to_log_in_button.dart';
import '../../components/components/start/move_to_sign_up_button.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Color.fromRGBO(80, 49, 238, 1),
                Color.fromRGBO(123, 97, 255, 1),
                Color.fromRGBO(123, 97, 255, 0.29),
              ],
              stops: [0, 0.2, 1],
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (ResponsiveUtil.isMobile(context)) {
                return _buildMobileLayout();
              } else if (ResponsiveUtil.isTablet(context)) {
                return _buildTabletLayout();
              } else {
                return _buildDesktopLayout();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppLogoAndTitle(),
        SizedBox(height: 40),
        MoveToSignUpButton(),
        SizedBox(height: 20),
        MoveToLogInButton(),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppLogoAndTitle(),
        SizedBox(height: 60),
        MoveToSignUpButton(),
        SizedBox(height: 30),
        MoveToLogInButton(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: const AppLogoAndTitle(),
          ),
        ),
        const SizedBox(width: 200),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MoveToSignUpButton(),
                SizedBox(height: 20),
                MoveToLogInButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
