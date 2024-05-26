// ignore_for_file: one_member_abstracts

abstract class ILogInUseCase {
  Future<String?> logIn(String email, String password);
}
