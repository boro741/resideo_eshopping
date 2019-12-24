
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resideo_eshopping/Screens/login_signup_page.dart';
import 'package:resideo_eshopping/Screens/product_list_page.dart';
import 'package:resideo_eshopping/services/authentication.dart';
import 'package:after_layout/after_layout.dart';
import 'package:resideo_eshopping/util/logger.dart' as logger;
import 'package:shared_preferences/shared_preferences.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _RootPageState extends State<RootPage>with AfterLayoutMixin<RootPage> {
  static const String TAG ="RootPage";
  AuthStatus authStatus = AuthStatus.NOT_LOGGED_IN;
  String _userId = "";
  bool _logInButtonPress=false;
  FirebaseUser _user;

  @override
  void afterFirstLayout(BuildContext context) {
//    super.initState();
    _function();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _user=user;
          _userId = user?.uid;
        }
        //authStatus =
          //  user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    }).catchError((error) {
      logger.error(TAG, " Error while rendering the Layout : "+ error);
//      print(error);
    });
  }

  Future _function() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('uid') == null) {
      authStatus = AuthStatus.NOT_LOGGED_IN;
    }
    else {
      authStatus = AuthStatus.LOGGED_IN;
    }
  }
  
  void _onlogInButtonPress(){
    setState(() {
      _logInButtonPress=true;
    });
  }

  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user){
      setState(() {
        _user=user;
        _userId = user.uid.toString();
        authStatus = AuthStatus.LOGGED_IN;
      });
    }).catchError((error){
      logger.error(TAG, " Error while checking in Logged in or not  : "+ error);
//      print(error);
    });
  }

  void _onSignedOut() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      prefs.clear();
      _logInButtonPress=false;
      _userId = "";
      _user=null;
    });
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_LOGGED_IN:
      {
        if(_logInButtonPress)
        {
          return new LoginSignUpPage(
          auth: widget.auth,
          onSignedIn: _onLoggedIn);
        
        }else
        {
         return new ProductsListPage(_user,_onlogInButtonPress,_onSignedOut,widget.auth);

        }    
      }   
      break;
      case AuthStatus.LOGGED_IN:
        if (_userId != null && _userId.length > 0) {
          return new ProductsListPage(_user,_onlogInButtonPress,_onSignedOut,widget.auth);
        } else return _buildWaitingScreen();
        break;
      default:
        return _buildWaitingScreen();
    }
  }
}


