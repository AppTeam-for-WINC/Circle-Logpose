// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/loading_progress.dart';

import '../../domain/providers/text_field/email_field_provider.dart';
import '../../domain/providers/text_field/password_field_provider.dart';

import '../../domain/usecase/facade/auth_facade.dart';
import '../slide/slider/schedule_list_and_joined_group_tab_slider.dart';

class LoginButton extends ConsumerStatefulWidget {
  const LoginButton({super.key});

  @override
  ConsumerState<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends ConsumerState<LoginButton> {
  Future<void> _handleLogin() async {
    final email = ref.read(emailFieldProvider('')).text;
    final password = ref.read(passwordFieldProvider('')).text;

    final loginService = _LoginService(context, ref);
    await loginService.performLogin(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 195,
      margin: const EdgeInsets.all(23),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        color: const Color.fromRGBO(80, 49, 238, 0.9),
        borderRadius: BorderRadius.circular(30),
        onPressed: _handleLogin,
        child: const Text(
          'Login',
          style: TextStyle(
            fontFamily: 'Shippori_Mincho_B1',
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}

class _LoginService {
  _LoginService(this.context, this.ref);
  final BuildContext context;
  final WidgetRef ref;

  Future<void> performLogin(String email, String password) async {
    _updateLoadingStatus(true);
    final authfacade = ref.read(authFacadeProvider);
    final errorMessage = await authfacade.login(email, password);
    _updateLoadingStatus(false);

    if (errorMessage != null) {
      _displayErrorMessage(errorMessage);
      return;
    }

    if (context.mounted) {
      await _NavigationService(context).moveToNextPage();
    }
  }

  void _updateLoadingStatus(bool loading) {
    LoadingProgressController(ref).loadingProgress = loading;
  }

  void _displayErrorMessage(String errorMessage) {
    LoadingProgressController(ref).loadingErrorMessage = errorMessage;
  }
}

class _NavigationService {
  _NavigationService(this.context);
  final BuildContext context;

  Future<void> moveToNextPage() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<
          CupertinoPageRoute<ScheduleListAndJoinedGroupTabSlider>>(
        builder: (context) => const ScheduleListAndJoinedGroupTabSlider(),
      ),
      (_) => false,
    );
  }
}
