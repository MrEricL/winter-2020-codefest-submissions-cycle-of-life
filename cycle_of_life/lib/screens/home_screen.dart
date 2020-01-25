import 'dart:io';

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
      // ratioX: 1.0,
      // ratioY: 1.0,
      // maxWidth: 512,
      // maxHeight: 512,
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cycle Of Life"),
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
        height: 125.0,
        width: double.infinity,
        color: Colors.black87,
        child: Icon(
          Icons.camera_alt,
          size: 40.0,
          color: Colors.white,
        ),
      ),
    );
  }

  Container buildOptionsBar() {
    return Container(
      height: 125.0,
      width: double.infinity,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _cropImage();
            },
            child: Icon(
              Icons.crop,
              size: 40.0,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              _clear();
            },
            child: Icon(
              Icons.clear,
              size: 40.0,
              color: Colors.white,
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
          "Don't know if you can recycle?",
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        Text(
          "Take a picture!",
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ],
    );
  }

  Image buildPhoto() {
    return Image.file(
      _imageFile,
      fit: BoxFit.cover,
    );
  }
}
