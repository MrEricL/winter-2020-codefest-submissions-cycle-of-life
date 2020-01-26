import 'dart:io';

import 'package:cycle_of_life/util/option_button.dart';
import 'package:cycle_of_life/util/uploading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File _imageFile;

  Future<void> _cropImage() async {
    File cropped = (await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    ));

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = (await ImagePicker.pickImage(source: source));

    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(50, 50, 50, 1.0),
      appBar: AppBar(
        title: Text("Cycle Of Life"),
        actions: <Widget>[
          _imageFile != null
              ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _clear();
                  },
                )
              : Container(),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              child: _imageFile == null ? buildEmptyContainer() : buildPhoto(),
            ),
          ),
          _imageFile == null ? buildCaptureButton() : buildOptionsBar(),
        ],
      ),
    );
  }

  GestureDetector buildCaptureButton() {
    return GestureDetector(
      onTap: () {
        _pickImage(ImageSource.gallery);
      },
      child: Container(
        height: 75.0,
        width: double.infinity,
        color: Color.fromRGBO(25, 25, 25, 1.0),
        child: Icon(
          Icons.camera_alt,
          size: 30.0,
          color: Colors.white,
        ),
      ),
    );
  }

  Container buildOptionsBar() {
    return Container(
      height: 75.0,
      width: double.infinity,
      color: Color.fromRGBO(25, 25, 25, 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: OptionButton(
              onTap: _cropImage,
              icon: Icons.crop,
            ),
          ),
          Container(
            width: 2.0,
            height: 50.0,
            color: Color.fromRGBO(255, 255, 255, 0.25),
          ),
          Expanded(
            child: OptionButton(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return UploadingDialog(image: _imageFile);
                  },
                );
              },
              icon: Icons.check,
            ),
          ),
        ],
      ),
    );
  }

  Column buildEmptyContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don't know if you can recycle something?",
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        Text(
          "Take a picture of it!",
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ],
    );
  }

  Image buildPhoto() {
    return Image.file(
      _imageFile,
      fit: BoxFit.contain,
    );
  }
}
