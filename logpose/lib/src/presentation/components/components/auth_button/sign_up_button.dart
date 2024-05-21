// ignore_for_file: use_setters_to_change_properties, unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/providers/text_field/email_field_provider.dart';
import '../../../../domain/providers/text_field/password_field_provider.dart';

import '../../../controllers/sign_up_controller.dart';

import '../../../navigations/sign_up_navigator.dart';
import '../../common/loading_progress.dart';

class SignUpButton extends ConsumerStatefulWidget {
  const SignUpButton({super.key});

  @override
  ConsumerState<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends ConsumerState<SignUpButton> {
  Future<void> _handleSignUp() async {
    final signUphandler = SignUpHandler(context, ref);
    await signUphandler.handleSignUp();
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
        onPressed: _handleSignUp,
        child: const Text(
          'Sign Up',
          style: TextStyle(
            fontFamily: 'Shippori_Mincho_B1',
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}

class SignUpHandler {
  const SignUpHandler(this.context, this.ref);

  final BuildContext context;
  final WidgetRef ref;

  Future<void> handleSignUp() async {
    final email = ref.read(emailFieldProvider('')).text;
    final password = ref.read(passwordFieldProvider('')).text;
    final signUpController = ref.read(signUpControllerProvider);

    _loadingProgress(true);
    final errorMessage = await signUpController.performSignUp(email, password);
    _loadingProgress(false);

    if (errorMessage != null) {
      _loadingErrorMessage(errorMessage);
      return;
    }

    if (context.mounted) {
      await SignUpNavigator(context).moveToNextPage(context);
    }
  }

  void _loadingProgress(bool loading) {
    ref.read(loadingProgressControllerProvider).loadingProgress = loading;
  }

  void _loadingErrorMessage(String errorMessage) {
    ref.read(loadingProgressControllerProvider).loadingErrorMessage =
        errorMessage;
  }
}
