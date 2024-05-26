abstract class IEmailUseCase {
  Future<String?> fetchUserEmail();

  Future<String?> updateUserEmail(String newEmail, String password);

  Future<bool> sendConfirmationEmail();
}
