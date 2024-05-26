abstract class IAuthRepository {
  Future<bool> createAccount(String email, String password);

  Future<bool> logInAccount(String email, String password);

  Stream<bool> userLoginState(String docId);

  Future<String?> fetchUserEmail();

  Future<bool> updateUserEmail(String oldEmail, String email, String password);

  Future<bool> sendConfirmationEmail();

  Future<bool> sendPasswordResetEmail(String email);

  Future<String?> updateUserPassword(
    String email,
    String password,
    String newPassword,
  );

  Future<String?> fetchCurrentUserId();

  Future<String?> getUserIdToken();
  
  Future<void> logOut();
}
