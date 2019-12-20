import 'package:flutter/material.dart';
import 'package:resideo_eshopping/services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;
  bool _isloading = false;
  String msg ;

  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
    });
    if (_validateAndSave()) {
      _isloading = true;
      msg = '';
      String userId = "";
      try {
        if (_formMode == FormMode.LOGIN) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userId = await widget.auth.signIn(_email, _password);
          prefs.setString('uid', userId);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          print('Signed up user: $userId');
          msg = 'Account Created';
        }
        setState(() {
          _isloading = false;
        });

        if ( userId != null && userId.length > 0 && _formMode == FormMode.LOGIN) {
          widget.onSignedIn();
        }

      } catch (e) {
        print('Error: $e');
        setState(() {
            _isloading = false;
            _errorMessage = e.message;
            _formKey.currentState.reset();
        });
      }
    }
  }


  @override
  void initState() {
    _errorMessage = "";
    _isloading = false;
    super.initState();
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Resideo e-Shopping'),
        ),
        body: Stack(
          children: <Widget>[
            _showBody(),
            _buildWaitingScreen(),
          ],
        ));
  }


  Widget _showBody(){
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showLogo(),
              _showEmailInput(),
              _showPasswordInput(),
              _showPrimaryButton(),
              _showSecondaryButton(),
              _showErrorMessage(),
            ],
          ),
        ));
  }

  Widget _buildWaitingScreen() {
    if(_isloading) {
      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
   }


  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else if(msg!=null && msg.length>0) {
       return new Text(
        msg,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.blue,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    }
     else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.only(right: 50,top: 30),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 80.0,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
      child: new TextFormField(
        autovalidate: true,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
            onSaved: (value) => _email = value.trim(),
            validator: FieldValidator.validateEmail,

      ),
    );
  }
  
  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        autovalidate: true,
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        onSaved: (value) => _password = value.trim(),
        validator: FieldValidator.validatePassword,
      ),
    );
  }

 

  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
          ? new Text('Create an account',
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
          : new Text('Have an account? Sign in',
              style:
                  new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: _formMode == FormMode.LOGIN
                ? new Text('Login',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white))
                : new Text('Create account',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),

            onPressed: _validateAndSubmit,
          ),
        ));
  }
  
}

class FieldValidator{
  static String validateEmail(String value)
  {
    if(value.isEmpty) { return 'Enter Email'; }
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if(!regex.hasMatch(value)){
      return 'Enter valid email';
    }
    return null;
  }

  static String validatePassword(String value)
  {
    if(value.isEmpty) return 'Enter Password';
    return null;
  }
}