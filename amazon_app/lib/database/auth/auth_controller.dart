import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../user/user_controller.dart';
// import 'package:cloud_functions/cloud_functions.dart';

///How to manage email.
///https://www.notion.so/Email-c2a0c4f50a064bd09df0ce93b5b5ae61?pvs=4

class AuthController {
  const AuthController();
  static final auth = FirebaseAuth.instance;

  ///Create user's account.
  static Future<bool> createAccount(String email, String password) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final docId = userCredential.user?.uid ?? '';
      if (docId == '') {
        debugPrint('Error: Failed to create account.');
        return false;
      }

      await UserController.create(docId: docId);
      debugPrint('Success: Created new account. doc_id: $docId');
      return true;
    } on FirebaseAuthException catch (error) {
      debugPrint('Error: Failed to create account. $error');
      return false;
    }
  }

  ///Login user's account.
  static Future<bool> loginToAccount(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint('Success: Login to account.');
      return true;
    } on FirebaseAuthException catch (error) {
      debugPrint('Error: Failed to login. $error');
      return false;
    }
  }

  ///Watching whether users remain logged in.
  ///True is signed in. False is signed out.
  static Stream<bool> userLoginState(String docId) async* {
    await for (final doc in auth.authStateChanges()) {
      if (doc == null) {
        debugPrint('User is currently signed out!');
        yield false;
      } else if (doc.uid == docId) {
        debugPrint('User is signed in!');
        yield true;
      } else {
        debugPrint('Error, or a different user is signed in.');
      }
    }
  }

  ///Update email.
  static Future<bool> updateUserEmail(String oldEmail, String email) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        debugPrint('Email not found.');
        return false;
      } else if (user.email == oldEmail && user.email != email) {
        await user.updateEmail(email);
        debugPrint('Email updated successfully to $email');
        return true;
      } else {
        debugPrint('Error updating email');
        return false;
      }
    } on FirebaseAuthException catch (error) {
      debugPrint('Error: email not found.  $error');
      return false;
    }
  }

  ///Send Confirmation email.
  static Future<bool> sendConfirmationEmail() async {
    try {
      ///Set auth code of language to japanese.
      await auth.setLanguageCode('ja');

      final user = auth.currentUser;

      if (user == null) {
        debugPrint('User is not currently signed in.');
        return false;
      } else {
        await user.sendEmailVerification();
        debugPrint('Confirmation email sent.');
        return true;
      }
    } on FirebaseAuthException catch (error) {
      debugPrint('Error sending confirmation email: $error');
      return false;
    }
  }

  /// Send a password reset email to the user 
  /// registered with Firebase Authentication.
  static Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      debugPrint('Password reset email sent successfully.');
      return true;
    } on FirebaseAuthException catch (error) {
      debugPrint('Error sending password reset email: $error');
      return false;
    }
  }

  /// Update user's new password.
  static Future<bool> updateUserPassword(String newPassword) async {
    try {
      final user = auth.currentUser;

      if (user == null) {
        debugPrint('User is not currently signed in.');
        return false;
      } else {
        await user.updatePassword(newPassword);
        debugPrint('Password updated successfully.');
        return true;
      }
    } on FirebaseAuthException catch (error) {
      debugPrint('Error updating password: $error');
      return false;
    }
  }

  static Future<String?>getCurrentUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  static Future<String?>getUserIdToken() async{
    final user = auth.currentUser;
    return await user?.getIdToken();
  }

  // static Future<String>getUpHello() async {
  //   //引数は、 call()の中に書く。
  //   final happy_result = await FirebaseFunctions.instance.httpsCallable('on_call_happy').call<String>();
  //   return happy_result.data;
  // }
}
