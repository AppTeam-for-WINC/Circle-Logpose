abstract class IAuthUserIdUseCase {
  Future<String> fetchCurrentUserId();

  Future<String?> fetchCurrentUserIdNullable();
}
