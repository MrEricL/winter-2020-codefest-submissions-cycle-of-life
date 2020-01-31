import 'dart:io';

import 'package:cycle_of_life/styles/colors.dart';
import 'package:cycle_of_life/widgets/option_button.dart';
import 'package:cycle_of_life/widgets/uploading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class EditScreen extends StatefulWidget {
  final File imageFile;

  EditScreen({this.imageFile});

  @override
  _EditScreenState createState() => _EditScreenState(imageFile: imageFile);
}

class _EditScreenState extends State<EditScreen> {
  File imageFile;

  _EditScreenState({this.imageFile});

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
    );

    setState(() {
      imageFile = cropped ?? imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundWhite,
      appBar: AppBar(
        title: Text(
          'Cycle Of Life',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: imageFile != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: buildPhotoContainer(),
                  ),
                ),
                buildOptionsBar(),
              ],
            )
          : buildErrorContainer(),
    );
  }

  Center buildErrorContainer() {
    return Center(
      child: Text('Error: No image found'),
    );
  }

  Container buildOptionsBar() {
    return Container(
      height: 75.0,
      width: double.infinity,
      color: kLighterWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: OptionButton(
              onTap: _cropImage,
              icon: Icons.crop,
            ),
          ),
          buildDivider(),
          Expanded(
            child: OptionButton(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return UploadingDialog(image: imageFile);
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

  Container buildDivider() {
    return Container(
      width: 2.0,
      height: 40.0,
      color: Color.fromRGBO(0, 0, 0, 0.25),
    );
  }

  Image buildPhotoContainer() {
    return Image.file(
      imageFile,
      fit: BoxFit.contain,
    );
  }
}
