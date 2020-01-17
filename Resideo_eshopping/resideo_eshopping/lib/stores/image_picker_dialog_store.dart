//import 'package:resideo_eshopping/Screens/image_picker_dialog.dart';
//import 'package:resideo_eshopping/controller/image_picker_handler.dart';
//import 'package:resideo_eshopping/stores/error_store.dart';
//import 'dart:async';
//import 'package:flutter/material.dart';
//part 'image_picker_dialog_store.g.dart';
//
//class imagePickerDialogStore = _imagePickerDialogStore with _$imagePickerDialogStore;
//abstract class _imagePickerDialogStore with Store {
//  // store for handling form errors
//
//
//  // store for handling error messages
//  final ErrorStore errorStore = ErrorStore();
//  BuildContext context;
//  Animation<double> _drawerContentsOpacity;
//  Animation<Offset> _drawerDetailsPosition;
//
//void initState() {
//    _drawerContentsOpacity = new CurvedAnimation(
//      parent: new ReverseAnimation(_controller),
//      curve: Curves.fastOutSlowIn,
//    );
//    _drawerDetailsPosition = new Tween<Offset>(
//      begin: const Offset(0.0, 1.0),
//      end: Offset.zero,
//    ).animate(new CurvedAnimation(
//      parent: _controller,
//      curve: Curves.fastOutSlowIn,
//    ));
//  }
//  startTime() async {
//    var _duration = new Duration(milliseconds: 200);
//    return new Timer(_duration, navigationPage);
//  }
//  void navigationPage() {
//    Navigator.pop(context);
//  }
//getImage(BuildContext context) {
//    if (_controller == null ||
//        _drawerDetailsPosition == null ||
//        _drawerContentsOpacity == null) {
//      return;
//    }
//    _controller.forward();
//    showDialog(
//      context: context,
//      builder: (BuildContext context) => new SlideTransition(
//        position: _drawerDetailsPosition,
//        child: new FadeTransition(
//          opacity: new ReverseAnimation(_drawerContentsOpacity),
//          child: this,
//        ),
//      ),
//    );
//  }
//}