// ignore_for_file: one_member_abstracts

abstract class IUserIdUseCase {
  Future<String> fetchUserDocIdWithAccountId(String accountId);
}
