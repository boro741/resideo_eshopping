import 'package:flutter_test/flutter_test.dart';
import 'package:resideo_eshopping/Screens/login_signup_page.dart';

void main() {
  test('Empty Email Test', () {
    var result = FieldValidator.validateEmail('');
      expect(result, 'Enter Email');
  });
test('Invalid Email Test', () {
    var result = FieldValidator.validateEmail('Ajay');
      expect(result, 'Enter valid email');
  });
test('Valid Email Test', () {
    var result = FieldValidator.validateEmail('Ajay@gmail.com');
      expect(result, null);
  });  
test('Empty Password Test', () {
    var result = FieldValidator.validatePassword('');
      expect(result, 'Enter Password');
  });
}
