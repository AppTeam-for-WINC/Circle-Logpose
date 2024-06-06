abstract class IAccountDeletionUseCase {
  Future<String?> deleteAccount(String email, String password);
}
