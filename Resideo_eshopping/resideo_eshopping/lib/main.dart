import 'package:flutter/material.dart';
import 'package:resideo_eshopping/Screens/home_page.dart';
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

      //home: RootPage(auth: Auth()),
       home: HomePage(),
    );
  }
}