// ignore_for_file: one_member_abstracts

abstract class IPasswordUseCase {
  Future<String?> updateUserPassword(
    String password,
    String newPassword,
  );
}
