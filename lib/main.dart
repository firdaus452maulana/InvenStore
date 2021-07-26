import 'package:dicoding_submission_flutter/Auth.dart';
import 'package:dicoding_submission_flutter/mainMenu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final AuthService _authService = AuthService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  dynamic result = await _authService.signInAnon();
  if (result == null)
    print("null");
  else
    print(result);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Invenstore',
      home: mainMenu(),
    );
  }

}

