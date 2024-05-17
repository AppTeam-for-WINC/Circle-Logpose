// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/loading_progress.dart';

import '../../domain/providers/text_field/email_field_provider.dart';
import '../../domain/providers/text_field/password_field_provider.dart';

import '../../domain/usecase/facade/auth_facade.dart';
import '../../views/login/login_page.dart';

class SignUpButton extends ConsumerStatefulWidget {
  const SignUpButton({super.key});

  @override
  ConsumerState<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends ConsumerState<SignUpButton> {
  Future<void> _handleSignUp() async {
    final email = ref.read(emailFieldProvider('')).text;
    final password = ref.read(passwordFieldProvider('')).text;
    final signUpService = _SignUpService(context, ref);
    await signUpService.performSignUp(email, password);
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

class _SignUpService {
  _SignUpService(this.context, this.ref);
  final BuildContext context;
  final WidgetRef ref;

  Future<void> performSignUp(String email, String password) async {
    _loadingProgress(true);
    final authFacade = ref.read(authFacadeProvider);
    final errorMessage = await authFacade.signUp(email, password);
    _loadingProgress(false);

    if (errorMessage != null) {
      _loadingErrorMessage(errorMessage);
      return;
    }

    if (context.mounted) {
      await _NavigationService(context).moveToNextPage(context);
    }
  }

  void _loadingProgress(bool loading) {
    LoadingProgressController(ref).loadingProgress = loading;
  }

  void _loadingErrorMessage(String errorMessage) {
    LoadingProgressController(ref).loadingErrorMessage = errorMessage;
  }
}

class _NavigationService {
  _NavigationService(this.context);
  final BuildContext context;

  Future<void> moveToNextPage(BuildContext context) async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<LoginPage>>(
        builder: (context) => const LoginPage(),
      ),
      (_) => false,
    );
  }
}
