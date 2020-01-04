import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resideo_eshopping/Screens/home_page.dart';
import 'package:resideo_eshopping/model/user_repository.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(builder: (context) => UserRepository.instance(),), ],
      child: MaterialApp(
        title: 'Resideo e-Shopping',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        home: HomePage(),
      ),

      );
  }
}