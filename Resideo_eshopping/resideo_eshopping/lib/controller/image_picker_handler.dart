import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:resideo_eshopping/Screens/image_picker_dialog.dart';
import 'package:resideo_eshopping/util/firebase_database_helper.dart';

class ImagePickerHandler{

  AnimationController _controler;
  ImagePickerListener _listener;
  ImagePickerDialog imagePicker;
  FirebaseUser _user;
  FirebaseDatabaseUtil _firebaseDatabaseUtil;
  ImagePickerHandler(this._listener,this._controler,this._user);
  
   openCamera() async {
    imagePicker.dismissDialog();
    await ImagePicker.pickImage(source: ImageSource.camera).then((image){
      cropImage(image);
    }).catchError((error){
      print(error);
    });

  }

  openGallery() async {
    imagePicker.dismissDialog();
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image){
      cropImage(image);
    }).catchError((error){
      print(error);
    });
  }

  removePicture() async{
    imagePicker.dismissDialog();
    await _firebaseDatabaseUtil.deleteProfilePicture(_user).then((result){
      if(result)
      _listener.userImage(null);
    }).catchError((error){
      print(error);
    });
  }

   Future cropImage(File image) async {
    await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    ).then((croppedFile){
      _listener.userImage(croppedFile);
    }).then((error){
      print(error);
    });

  }

  void init(){
   _firebaseDatabaseUtil = FirebaseDatabaseUtil();
   imagePicker= ImagePickerDialog(this,this._controler);
   imagePicker.initState();
  }

  void showDialog(BuildContext context){
   imagePicker.getImage(context);
  }

  
}
abstract class ImagePickerListener{
  userImage(File _image);
}