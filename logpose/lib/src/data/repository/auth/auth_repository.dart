import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../database/user_repository.dart';

///How to manage email.
///https://www.notion.so/Email-c2a0c4f50a064bd09df0ce93b5b5ae61?pvs=4

class AuthRepository {
  AuthRepository._internal();
  static final AuthRepository _instance = AuthRepository._internal();
  static AuthRepository get instance => _instance;
  
  static final auth = FirebaseAuth.instance;

  /// Create user's account.
  Future<bool> createAccount(String email, String password) async {
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
      await UserRepository.create(
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
  Future<bool> loginToAccount(String email, String password) async {
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
      await auth.currentUser!.reload();
      return auth.currentUser?.email;
    } on FirebaseAuthException catch (error) {
      debugPrint('Error reloading user: $error');
      if (error.code == 'user-token-expired') {
        throw Exception(
          "User's credential is no longer valid. Please sign in again.",
        );
      } else {
        throw Exception('Email not found.');
      }
    }
  }

  /// to-do modifled.
  /// Update email.
  static Future<bool> updateUserEmail(
    String oldEmail,
    String email,
    String password,
  ) async {
    try {
      final user = auth.currentUser;
      final credential = await _checkSignInWithCredential(oldEmail, password);
      if (user == null) {
        debugPrint('User not log in.');
        return false;
      } else if (!user.emailVerified) {
        debugPrint('メールアドレスが未確認です。');
        await user.sendEmailVerification();
        debugPrint('確認メールを再送しました。');
        return false;
      } else if (user.email == oldEmail && user.email != email) {
        await user.reauthenticateWithCredential(credential);
        await user.verifyBeforeUpdateEmail(email);
        await user.updateEmail(email);
        return true;
      } else {
        debugPrint('Error updating email');
        return false;
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'operation-not-allowed') {
        debugPrint('Please check your email for verification link.');
        return true;
      } else {
        debugPrint('Error: failed to update email.  $error ${error.message}');
        return false;
      }
    }
  }

  /// Send Confirmation email.
  static Future<bool> sendConfirmationEmail() async {
    try {
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

  /// Set auth code of language to japanese.
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
      return EmailAuthProvider.credential(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception('Error: failed to check credential data. ${e.message}');
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

  Future<String?> fetchCurrentUserId() async {
    try {
      return FirebaseAuth.instance.currentUser?.uid;
    } on FirebaseAuthException catch (e) {
      throw Exception('Error: failed to fetch current user ID. ${e.message}');
    }
  }

  static Future<String?> getUserIdToken() async {
    try {
      return await auth.currentUser?.getIdToken();
    } on FirebaseAuthException catch (e) {
      throw Exception('Error: failed to get ID token. ${e.message}');
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
