import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../database/user_controller.dart';
// import 'package:cloud_functions/cloud_functions.dart';

///How to manage email.
///https://www.notion.so/Email-c2a0c4f50a064bd09df0ce93b5b5ae61?pvs=4

class AuthController {
  AuthController._internal();
  static final AuthController _instance = AuthController._internal();
  static AuthController get instance => _instance;
  static final auth = FirebaseAuth.instance;

  /// Create user's account.
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

      return await _createUserDatabase(docId, 'New user');
    } on FirebaseAuthException catch (error) {
      debugPrint('Error: Failed to create account. $error');
      return false;
    }
  }

  static Future<bool> _createUserDatabase(String docId, String name) async {
    try {
      await UserController.create(
        docId: docId,
        name: 'New user',
        image: '',
      );
      return true;
    } on FirebaseFirestore catch (e) {
      debugPrint('Error: Failed to create user Database. $e');
      return false;
    }
  }

  /// Login user's account.
  static Future<bool> loginToAccount(String email, String password) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user?.uid == null) {
        debugPrint('Error: Failed to create account.');
        return false;
      }

      debugPrint('Success: Login to account.');
      return true;
    } on FirebaseAuthException catch (error) {
      debugPrint('Error: Failed to login. $error');
      return false;
    }
  }

  /// Watching whether users remain logged in.
  /// True is signed in. False is signed out.
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

  static Future<String?> readEmail() async {
    try {
      if (auth.currentUser == null) {
        throw Exception('User not found.');
      }
      return auth.currentUser?.email;
    } on FirebaseAuthException catch (error) {
      debugPrint('Error: email not found.  $error');
      throw Exception('Email not found.');
    }
  }

  /// Update email.
  static Future<bool> updateUserEmail(
    String oldEmail,
    String email,
    // String password,
  ) async {
    try {
      final user = auth.currentUser;
      // final credential = await _checkSignInWithCredential(
      //   email,
      //   password,
      // );
      // await user.reauthenticateWithCredential(credential);
      if (user == null) {
        debugPrint('Email not found.');
        return false;
      } else if (user.email == oldEmail && user.email != email) {
        await user.verifyBeforeUpdateEmail(email);
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

  /// Send Confirmation email.
  static Future<bool> sendConfirmationEmail() async {
    try {
      /// Set auth code of language to japanese.
      await _setLanguageCode();

      if (auth.currentUser == null) {
        debugPrint('User is not currently signed in.');
        return false;
      } else {
        return await _sendEmailVerification();
      }
    } on FirebaseAuthException catch (error) {
      debugPrint('Error sending confirmation email: $error');
      return false;
    }
  }

  static Future<void> _setLanguageCode() async {
    await auth.setLanguageCode('ja');
  }

  static Future<bool> _sendEmailVerification() async {
    try {
      await auth.currentUser?.sendEmailVerification();
      debugPrint('Confirmation email sent.');
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint('Error: failed to send email. $e');
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
  static Future<String?> updateUserPassword(
    String email,
    String password,
    String newPassword,
  ) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return 'User is not currently signed in.';
      }

      final credential = await _checkSignInWithCredential(email, password);
      await _reAuthenticateWithCredential(user, credential);
      await _updatePassword(user, newPassword);

      return null;
    } on FirebaseAuthException catch (error) {
      debugPrint('Error updating password: $error');
      return 'Password is not correctly.';
    }
  }

  static Future<AuthCredential> _checkSignInWithCredential(
    String email,
    String password,
  ) async {
    try {
      return EmailAuthProvider.credential(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<void> _reAuthenticateWithCredential(
    User user,
    AuthCredential credential,
  ) async {
    await user.reauthenticateWithCredential(credential);
  }

  static Future<void> _updatePassword(User user, String newPassword) async {
    await user.updatePassword(newPassword);
  }

  static Future<String?> getCurrentUserId() async {
    try {
      return FirebaseAuth.instance.currentUser?.uid;
    } on FirebaseAuthException catch (e) {
      throw Exception('Error: failed to get current user ID. $e');
    }
  }

  static Future<String?> getUserIdToken() async {
    try {
      return await auth.currentUser?.getIdToken();
    } on FirebaseAuthException catch (e) {
      throw Exception('Error: failed to get ID token. $e');
    }
  }

  /// Logout.
  static Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseException catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  // static Future<String>getUpHello() async {
  //   //引数は、 call()の中に書く。
  //   final happy_result = await FirebaseFunctions
  // .instance.httpsCallable('on_call_happy').call<String>();
  //   return happy_result.data;
  // }
}
