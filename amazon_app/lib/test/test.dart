import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';




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
