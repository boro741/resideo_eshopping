import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:resideo_eshopping/services/authentication.dart';


class MockFirebaseAuth extends Mock implements FirebaseAuth{}
class MockFirebaseUser extends Mock implements FirebaseUser{}
class MockAuthResult extends Mock implements AuthResult {}

//class MockAuth extends Mock implements Auth{
//  FirebaseAuth _auth = FirebaseAuth.instance;
//  @override
//  Future<String> signIn(String email, String password) {
//    // TODO: implement signIn
//
//    return null;
//  }
//}

void main() {
//  MockFirebaseAuth _auth = MockFirebaseAuth();
//  BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();
//  when(_auth.onAuthStateChanged).thenAnswer((_){
//    return _user;
//  });
  //UserRepository _repo = UserRepository.instance(auth: _auth);
  FirebaseAuth _repo = FirebaseAuth.instance;
//  group('user repository test', (){
//    when(_auth.signInWithEmailAndPassword(email: "email",password: "password")).thenAnswer((_)async{
//      _user.add(MockFirebaseUser());
//      return MockAuthResult();
//    });
//    when(_auth.signInWithEmailAndPassword(email: "mail",password: "pass")).thenThrow((){
//      return null;
//    });

    test("sign in with email and password", () async {
      AuthResult signedIn = await _repo.signInWithEmailAndPassword(email: "email",password: "password");
      expect(signedIn, true);
    });

    test("sing in fails with incorrect email and password",() async {
      AuthResult signedIn = await _repo.signInWithEmailAndPassword(email: "mail",password: "pass");
      expect(signedIn, false);
    });

//    test('sign out', ()async{
//      await _repo.signOut();
//      expect(_repo.status, Status.Unauthenticated);
//    });
  //});
}

