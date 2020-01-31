import 'dart:io';

import 'package:cycle_of_life/screens/edit_screen.dart';
import 'package:cycle_of_life/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = (await ImagePicker.pickImage(source: source));

    if (selected != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditScreen(imageFile: selected)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundWhite,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cycle Of Life",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              child: buildEmptyContainer(),
            ),
          ),
          buildCaptureButton(),
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
        color: kLighterWhite,
        child: Icon(
          Icons.camera_alt,
          size: 30.0,
          color: Colors.black,
        ),
      ),
    );
  }

  Column buildEmptyContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Don\'t know if you can recycle something?',
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        SizedBox(height: 12.0),
        Text(
          'Take a picture of it!',
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
      ],
    );
  }
}
