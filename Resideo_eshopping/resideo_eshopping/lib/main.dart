import 'package:flutter/material.dart';
import 'package:resideo_eshopping/controller/root_page.dart';
import 'package:resideo_eshopping/services/authentication.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resideo e-Shopping',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Resideo e-Shopping'),

      home: RootPage(auth: Auth()),
    );
  }
}