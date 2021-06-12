import 'package:dicoding_submission_flutter/mainMenu.dart';
import 'package:flutter/material.dart';

void main() {
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

