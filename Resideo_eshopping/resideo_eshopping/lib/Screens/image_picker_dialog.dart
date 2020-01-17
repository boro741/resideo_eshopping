import 'dart:async';
import 'package:flare_flutter/flare.dart';
import 'package:flutter/material.dart';
import 'package:resideo_eshopping/controller/image_picker_handler.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';

enum AnimationToPlay {
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped
}

class ImagePickerDialog extends StatelessWidget {
  final ImagePickerHandler _listener;
  final AnimationController _controller;

  BuildContext context;
  final bool _deletePhotoButtonEnable;
  ImagePickerDialog(
      this._listener, this._controller, this._deletePhotoButtonEnable);
  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;
  AnimationToPlay _animationToPlay = AnimationToPlay.Deactivate;
  AnimationToPlay _lastPlayedAnimation;
  final FlareControls animationControls = FlareControls();
  bool isOpen = false;
  static const double AnimationWidth = 295.0;
  static const double AnimationHeight = 251.0;

  void initState() {
    _drawerContentsOpacity = new CurvedAnimation(
      parent: new ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = new Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  getImage(BuildContext context) {
    if (_controller == null ||
        _drawerDetailsPosition == null ||
        _drawerContentsOpacity == null) {
      return;
    }
    _controller.forward();
    showDialog(
      context: context,
      builder: (BuildContext context) => new SlideTransition(
        position: _drawerDetailsPosition,
        child: new FadeTransition(
          opacity: new ReverseAnimation(_drawerContentsOpacity),
          child: this,
        ),
      ),
    );
  }

  void dispose() {
    _controller.dispose();
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 200);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }

  dismissDialog() {
    _controller.reverse();
    startTime();
  }

  dynamic _enableDisableDeletePhotoButton() {
    if (_deletePhotoButtonEnable) {
      return new Column(children: <Widget>[
        GestureDetector(
          onTap: () => _listener.removePicture(),
          child: Image(image: AssetImage("assets/images/delete.png")),
        ),
        const SizedBox(
          height: 5,
        ),
        Text("Remove Photo", style: TextStyle(color: Colors.white)),
      ]);
    } else {
      return SizedBox(height: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Material(
        type: MaterialType.transparency,
        child: new Opacity(
          opacity: 1.0,
          child: new Container(
            width: AnimationWidth,
            height: AnimationHeight,
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new GestureDetector(
        //             onTapUp: (tapInfo) {
        //               var localTouchPosition =
        //                   (context.findRenderObject() as RenderBox)
        //                       .globalToLocal(tapInfo.globalPosition);

        //               var topHalfTouched =
        //                   localTouchPosition.dy < AnimationHeight / 2;

        //               var leftSideTouched =
        //                   localTouchPosition.dx < AnimationWidth / 3;

        //               var rightSideTouched =
        //                   localTouchPosition.dx > (AnimationWidth / 3) * 2;

        //               var middleTouched = !leftSideTouched && !rightSideTouched;
        //               if (leftSideTouched && topHalfTouched) {
        //                  _listener.openCamera();
        //                 _setAnimationToPlay(AnimationToPlay.CameraTapped);
                        
        //               } else if (middleTouched && topHalfTouched) {
        //                 _listener.removePicture();
        //                 _setAnimationToPlay(AnimationToPlay.PulseTapped);
        //               } else if (rightSideTouched && topHalfTouched) {
        //                 _listener.openGallery();
        //                 _setAnimationToPlay(AnimationToPlay.ImageTapped);
        //               } else {
        //                 if (isOpen) {
        //                   _setAnimationToPlay(AnimationToPlay.Deactivate);
        //                 } else {
        //                   _setAnimationToPlay(AnimationToPlay.Activate);
        //                 }

        //                 isOpen = !isOpen;
                        
        //               }
        //             },
        //             child: FlareActor('assets/button-animation.flr',
        //                 controller: animationControls,
        //                 animation: 'deactivate')),
        //       ],
        //     ),
        //   ),
        // ));

            onTap: () => _listener.openCamera(),
            child: new CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage("assets/images/camera.png"),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text("Camera", style: TextStyle(color: Colors.white)),
          const SizedBox(
            height: 20,
          ),
          new GestureDetector(
            onTap: () => _listener.openGallery(),
            child: new CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage("assets/images/gallery.png"),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text("GAllery", style: TextStyle(color: Colors.white)),
          const SizedBox(
            height: 20,
          ),
          _enableDisableDeletePhotoButton(),
          const SizedBox(
            height: 20,
          ),
          new GestureDetector(
            onTap: () => dismissDialog(),
            child: new Padding(
              padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              child: Icon(Icons.cancel),
            ),
          ),
        ],
      ),
    ),
    ));
  }

  // String _getAnimationName(AnimationToPlay animationToPlay) {
  //   switch (animationToPlay) {
  //     case AnimationToPlay.Activate:
  //       return 'activate';
  //     case AnimationToPlay.Deactivate:
  //       return 'deactivate';
  //     case AnimationToPlay.CameraTapped:
  //       return 'camera_tapped';
  //     case AnimationToPlay.PulseTapped:
  //       return 'pulse_tapped';
  //     case AnimationToPlay.ImageTapped:
  //       return 'image_tapped';
  //     default:
  //       return 'deactivate';
  //   }
  // }

  // void _setAnimationToPlay(AnimationToPlay animation) {
  //   var isTappedAnimation = _getAnimationName(animation).contains("_tapped");
  //   if (isTappedAnimation &&
  //       _lastPlayedAnimation == AnimationToPlay.Deactivate) {
  //     return;
  //   }

  //   animationControls.play(_getAnimationName(animation));

  //   _lastPlayedAnimation = animation;
  // }
}
