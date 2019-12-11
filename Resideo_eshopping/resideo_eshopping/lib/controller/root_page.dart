import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resideo_eshopping/Screens/login_signup_page.dart';
import 'package:resideo_eshopping/Screens/product_list_page.dart';
import 'package:resideo_eshopping/services/authentication.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;
 // final CheckIn checkIn;
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  bool logIn=true;
  FirebaseUser _user;
  //User userInfo;
 // FirebaseDatabaseUtil firebaseDatabaseUtil;
  //VoidCallback userCheckin;

  @override
  void initState() {
    super.initState();
    //ProductsListPage(userLogin: this);
    //firebaseDatabaseUtil =new FirebaseDatabaseUtil();
    //firebaseDatabaseUtil.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _user=user;
          _userId = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }
  
  void _logIn(){
    setState(() {
      logIn=false;
    });
  }

  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user){
      setState(() {
        _user=user;
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
     
    });
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      logIn=true;
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
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
      {
        if(logIn)
        {
          return new ProductsListPage(_user,_logIn,_onSignedOut,widget.auth);
          
        }else
        {
        return new LoginSignUpPage(
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );
        }    
      }   
      break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new ProductsListPage(_user,_logIn,_onSignedOut,widget.auth);
         
          
       //  widget.checkIn.userCheckIn(_user);
        } else return _buildWaitingScreen();
        break;
      default:
        return _buildWaitingScreen();
    }
  }
}

// abstract class CheckIn{
//   void userCheckIn(FirebaseUser user);
// }