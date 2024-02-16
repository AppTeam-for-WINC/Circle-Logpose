// エラーメッセージの一元管理
class DBErrorMessages {
  static const userNotFound = 'User document not found for ID: ';
  static const userAccountNotFound =
      'Error: No document found for the user account ID.';
  static const noDocumentData = 'Error: No found document data.';
  // その他のエラーメッセージ...
}

class ControllerException implements Exception {
  ControllerException(this.message);
  final String message;

  @override
  String toString() => message;
}
