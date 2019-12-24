import 'package:flutter/widgets.dart';
import 'package:resideo_eshopping/Screens/home_page.dart';

class Routes{
  Routes._();

  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomePage(),
  };
}