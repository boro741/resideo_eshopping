import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:resideo_eshopping/controller/image_picker_handler.dart';
import 'package:resideo_eshopping/model/User.dart';
import 'package:resideo_eshopping/util/crud_operations.dart';

class SignUp extends StatefulWidget{
  SignUp(this.user,this.profile);
  final FirebaseUser user;
  final VoidCallback profile;
  @override
  State<StatefulWidget> createState() => _SignUpState();

}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin,ImagePickerListener{
  final _formKeyValue = new GlobalKey<FormState>();
  
  File _image;
  //String _uploadFileUrl;
  AnimationController _controler;
  ImagePickerHandler imagePicker;
  FirebaseDatabaseUtil firebaseDatabaseUtil;
  User user;
 // final DatabaseReference database=FirebaseDatabase.instance.reference().child("Users");

  final _nameController =TextEditingController();
  final _phoneController =TextEditingController();
  final _addressController =TextEditingController();
  final _zipcodeController =TextEditingController();

//   _sendData()
//   {
//     database.child(widget.user.uid.toString()).set({
//       'name' : user.name,
//       'phone' : user.phone,
//       'address' : user.address,
//       'Zipcode' : user.zipcode,
//       'imageUrl' : _uploadFileUrl
//     });
//   }

//    Future uploadFile() async {    
//    StorageReference storageReference = FirebaseStorage.instance.ref().child("profile pic"+widget.user.uid.toString());
//    StorageUploadTask uploadTask = storageReference.putFile(_image);   
//    await uploadTask.onComplete;  
//    print('File Uploaded');    
//    storageReference.getDownloadURL().then((fileURL) {    
//      setState(() {    
//        _uploadFileUrl = fileURL;    
//        _sendData();
//       widget.profile();
//      });    
//    });    
//  } 
  
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // Widget continueButton = FlatButton(
    //   child: Text("Yes"),
    //   onPressed: () {}
    //   );
     

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Profile"),
      content: Text("Profile Update Successful"),
      actions: [
        cancelButton,
       // continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  void initState()
  {
    super.initState();
    _controler=AnimationController(vsync: this,
    duration: const Duration(microseconds: 500));
    imagePicker=ImagePickerHandler(this,this._controler);
    imagePicker.init();
    firebaseDatabaseUtil = FirebaseDatabaseUtil();
    firebaseDatabaseUtil.initState();
  }

  @override
  void dispose(){
    _controler.dispose();
    super.dispose();
  }

  @override
  userImage(File _image) {
   setState(() {
     this._image=_image;
   });
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text("Resideo e-Shopping",
              style: TextStyle(
                color: Colors.white,
              )),
        ),
        actions: <Widget>[
           new IconButton(
             icon: new Icon(Icons.close),
            onPressed: () => widget.profile(),
           ),
         ],
        leading: new Container(),
      ),
      body: SafeArea(  
          child:Form(
          key: _formKeyValue,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              GestureDetector(
        onTap: ()=> imagePicker.showDialog(context),
        child:
           _image == null
              ? new Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30,),
                      new CircleAvatar(
    
                        radius: 80.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage("assets/images/user_profile.png"),
                      ),
                  ],
                )
              )
              :
              new Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30,),
                    //Image.file(_image,height: 10,width: 10),
                      new CircleAvatar(
                        radius: 80.0,
                        backgroundColor: const Color(0xFF778899),
                        backgroundImage: FileImage(_image),
                      ),
                  ],
                )
              )
      ),
       SizedBox(height: 30,),
              Flexible(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        icon: const Icon(
                          FontAwesomeIcons.userCircle,
                          color: Colors.blue,
                        ),
                        hintText: 'Enter your Name',
                        labelText: 'Name',
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Name field should not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        icon: const Icon(
                          FontAwesomeIcons.phone,
                          color: Colors.blue,
                        ),
                        hintText: 'Ex: 9700000000',
                        labelText: 'Phone',
                      ),
                      validator: (val) {
                        Pattern pattern = r'^(?:[+0]9)?[0-9]{10}$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(val))
                          return 'Enter Valid Phone Number';
                        else
                          return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _addressController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        icon: const Icon(
                          FontAwesomeIcons.home,
                          color: Colors.blue,
                        ),
                        labelText: 'Address',
                      ),
                      validator: (val) {
                        if (val.isEmpty)
                          return 'Address Field should not be empty';
                        else
                          return null;
                      },
                    ),
                    TextFormField(
                      controller: _zipcodeController,
                      decoration: const InputDecoration(
                        icon: const Icon(
                          FontAwesomeIcons.mapMarker,
                          color: Colors.blue,
                        ),
                        hintText: 'Ex: 500000',
                        labelText: 'Zip Code',
                      ),
                      validator: (val) {
                        Pattern pattern = r'^[1-9][0-9]{5}$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(val))
                          return 'Enter Valid ZipCode';
                        else
                          return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20,),
                     RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Update Profile",
                                    style: TextStyle(fontSize: 24.0)),
                              ],
                            )),
                        onPressed: () {
                          final  form=_formKeyValue.currentState;
                          if (form.validate()) {
                              form.save();
                              user=User(_nameController.text,_phoneController.text,_addressController.text,_zipcodeController.text);
                              if(_image != null)
                              firebaseDatabaseUtil.updateUserProfile(widget.user,_image,user).then((result){showAlertDialog(context);});
                              else
                              firebaseDatabaseUtil.sendData(widget.user, user,null).then((result){showAlertDialog(context);});
                              }
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))
                        ),
                  ],
                ),
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child:
              //     ),
              //   ],
              // ),
            ]
        ),
        ),
      ),
    );
   
  }
}
