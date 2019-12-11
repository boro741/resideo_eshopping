import 'package:firebase_database/firebase_database.dart';

class User
{
  String _id;
  String _name;
  String _address;
  String _zipcode;
  String _imageUrl;
  String _phone;

  User(this._name,this._phone,this._address,this._zipcode);

  String get id => _id;
  String get name => _name;
  String get address => _address;
  String get zipcode => _zipcode;
  String get imageUrl => _imageUrl;
  String get phone => _phone;

  User.fromSnapshot(DataSnapshot snapshot){
    _id=snapshot.key;
    _name=snapshot.value['name'];
    _address=snapshot.value['address'];
    _zipcode=snapshot.value['zipcode'];
    _imageUrl=snapshot.value['imageUrl'];
    _phone=snapshot.value['phone'];
  }
}
