import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:resideo_eshopping/model/user_repository.dart';


class MockFirebaseAuth extends Mock implements FirebaseAuth{}
class MockFirebaseUser extends Mock implements FirebaseUser{}
class MockAuthResult extends Mock implements AuthResult {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MockFirebaseAuth _auth = MockFirebaseAuth();
  BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();
  when(_auth.onAuthStateChanged).thenAnswer((_){
    return _user;
  });
  UserRepository _repo = UserRepository.instance();
  group('user repository test', (){
    when(_auth.signInWithEmailAndPassword(email: "email",password: "password")).thenAnswer((_)async{
      _user.add(MockFirebaseUser());
      return MockAuthResult();
    });
    when(_auth.signInWithEmailAndPassword(email: "mail",password: "pass")).thenThrow((){
      return null;
    });
    test("sign in with email and password", () async {
      String signedIn = await _repo.signIn("email", "password");
      expect(_repo.status, Status.Authenticated);
    });
//
//    test("sing in fails with incorrect email and password",() async {
//      String signedIn = await _repo.signIn("mail", "pass");
//      expect(_repo.status, Status.Unauthenticated);
//    });
//
//    test('sign out', ()async{
//      await _repo.signOut();
//      expect(_repo.status, Status.Unauthenticated);
//    });
  });
}

