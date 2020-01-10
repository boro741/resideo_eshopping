//import 'dart:html';

import 'package:flutter_test/flutter_test.dart';
import 'package:resideo_eshopping/stores/login_page_store.dart';

void main() {

  LoginPageStore loginPageStore = LoginPageStore();
  test("empty email", (){
    loginPageStore.validateEmail("");
    expect("Email can't be empty", loginPageStore.formErrorStore.email);
  });

  test("Invalid email address", (){
    loginPageStore.validateEmail("abc#gmail.com");
    expect("Please enter a valid email address", loginPageStore.formErrorStore.email);
  });

  test("Valid email address", (){
    loginPageStore.validateEmail("abc@gmail.com");
    expect(null, loginPageStore.formErrorStore.email);
  });

  test("Empty Password", (){
    loginPageStore.validatePassword("");
    expect("Password can't be empty", loginPageStore.formErrorStore.password);
  });

  test("Non - Empty Password", (){
    loginPageStore.validatePassword("12345678");
    expect(null, loginPageStore.formErrorStore.password);
  });

}