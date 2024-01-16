import 'dart:convert';
import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;



Future<void> postChatGPT(String question) async {
  final url = Uri.https('chat-gpt-qgddwv763a-uc.a.run.app');
  final body = json.encode({'question': question});
  final response = await http.post(url, body: body, headers: {'Content-Type': 'application/json'});

  if (response.statusCode == 200) {
    try {
      // レスポンスの処理
      final data = json.decode(response.body);
      print('Response from Cloud Function: $data');
    } catch (e) {
      print('Error parsing JSON: $e');
    }
  } else {
    // エラーの処理
    print('Failed to call Cloud Function: ${response.body}');
  }
}


Future<void> testSignInAndGetUserIdToken() async {
  // "Authorization: Bearer $(gcloud auth print-identity-token)"
  await FirebaseAuth.instance.signInAnonymously();
  final idToken = await AuthController.getUserIdToken();

  print('idToken: $idToken');
  // -qgddwv763a-uc.a.run.app/
  var url = Uri.https('on-request-example-qgddwv763a-uc.a.run.app');
  // var url = Uri.parse('https://on-request-example-qgddwv763a-uc.a.run.app/');
  var response = await http.get(url, headers: {'Authorization': 'Bearer $idToken'},);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');


  print('HELLO WORLD');
  final data = await AuthController.getUpHello();
  print(data);

}





// void main() async{

//   // "Authorization: Bearer $(gcloud auth print-identity-token)"

//   final idToken = await AuthController.getUserIdToken();

//   // -qgddwv763a-uc.a.run.app/
//   var url = Uri.https('on-request-example-qgddwv763a-uc.a.run.app/');
//   // var url = Uri.parse('https://on-request-example-qgddwv763a-uc.a.run.app/');
//   var response = await http.get(url, headers: {'Authorization': 'Bearer $idToken'},);
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');

// }
