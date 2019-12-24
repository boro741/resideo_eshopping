import 'package:after_layout/after_layout.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:resideo_eshopping/model/user_repository.dart';
import 'package:resideo_eshopping/routes.dart';
import 'package:resideo_eshopping/services/shared_preferences/preferences.dart';
import 'package:resideo_eshopping/widgets/progress_indicator.dart';
import 'package:resideo_eshopping/widgets/strings.dart';
import 'package:resideo_eshopping/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resideo_eshopping/stores/login_page_store.dart';

enum FormMode {LOGIN, SIGNUP}

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AfterLayoutMixin<LoginPage>{
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  FocusNode _passwordFocusNode;

  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  final _store = LoginPageStore();

  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;

  @override
  void afterFirstLayout(BuildContext context){
    _passwordFocusNode = FocusNode();

//    _email = TextEditingController(text: "");
//    _password = TextEditingController(text: "");
    _email.addListener(() {
      //this will be called whenever user types in some value
      _store.setEmail(_email.text);
    });
    _password.addListener(() {
      //this will be called whenever user types in some value
      _store.setPassword(_password.text);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Resideo E-Shopping"),
      ),
      body: _buildBody(),
    );
  }

  Material _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[
          OrientationBuilder(
            builder: (context, orientation) {
              //variable to hold widget
              var child;

              //check to see whether device is in landscape or portrait
              //load widgets based on device orientation
              orientation == Orientation.landscape
                  ? child = Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: _buildLeftSide(),
                  ),
                  Expanded(
                    flex: 1,
                    child: _buildRightSide(),
                  ),
                ],
              )
                  : child = Center(child: _buildRightSide());

              return child;
            },
          ),
          Observer(
            builder: (context) {
              return _store.success
                  ? navigate(context)
                  : showErrorMessage(context, _store.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _store.loading,
                child: ProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildLeftSide() {
    return SizedBox.expand(
      child: Image.asset(
        'assets/images/img_login.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildRightSide() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 24.0),
              _showLogo(),
              _buildEmailField(),
              _buildPasswordField(),
              _buildSignInButton(),
              _showSecondaryButton()
            ],
          ),
        ),
      ),
    );
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

  Widget _buildEmailField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: Strings.login_et_user_email,
          inputType: TextInputType.emailAddress,
          icon: Icons.person,
          iconColor: Colors.black54,
          textController: _email,
          inputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _store.formErrorStore.email,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: Strings.login_et_user_password,
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: Colors.black54,
          textController: _password,
          focusNode: _passwordFocusNode,
          errorText: _store.formErrorStore.password,
        );
      },
    );
  }


  Widget _buildSignInButton() {
    final user = Provider.of<UserRepository>(context);
        return Padding(
          padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
          child: SizedBox(
              height: 40.0,
              child: new RaisedButton(
                elevation: 5.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                color: Colors.blue,

                onPressed: () async {
//                  if (_store.canLogin) {
//                    _store.login();
//                  } else {
//                    showErrorMessage(context, 'Please fill in all fields');
//                  }
                  if (_formKey.currentState.validate()) {
                    if (!await user.signIn(
                        _email.text, _password.text))
                      _key.currentState.showSnackBar(SnackBar(
                        content: Text("Something is wrong"),
                      ));
                  }
                },
                child: _formMode == FormMode.LOGIN
                    ? new Text('Login',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white))
                    : new Text('Create account',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              )),
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

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  showErrorMessage(BuildContext context, String message) {
    if(message != null) {
      FlushbarHelper.createError(
        message: message,
        title: 'Error',
        duration: Duration(seconds: 3),
      )
        ..show(context);
    }

    return Container();
  }

  Widget navigate(BuildContext context){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    Future.delayed(Duration(milliseconds: 0), (){
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (Route<dynamic> route) => false);
    });
    return Container();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}

