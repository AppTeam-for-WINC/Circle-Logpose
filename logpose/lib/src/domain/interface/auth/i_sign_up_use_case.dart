// ignore_for_file: one_member_abstracts

abstract class ISignUpUseCase {
  Future<String?> signUp(String email, String password);
}
