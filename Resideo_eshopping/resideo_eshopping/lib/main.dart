import 'package:flutter/material.dart';
import 'package:resideo_eshopping/Screens/screen3.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resideo eshopping',
      theme: ThemeData(
        primaryColor: Color(0xffDB4437),
      ),
      home: Screen3(0.0),
    );
  }
}
