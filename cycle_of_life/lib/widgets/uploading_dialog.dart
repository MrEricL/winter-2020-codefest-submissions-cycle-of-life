import 'dart:io';

import 'package:cycle_of_life/http/http_provider.dart';
import 'package:cycle_of_life/screens/result_screen.dart';
import 'package:cycle_of_life/styles/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadingDialog extends StatefulWidget {
  final File image;

  UploadingDialog({this.image});

  @override
  _UploadingDialogState createState() => _UploadingDialogState();
}

class _UploadingDialogState extends State<UploadingDialog> {
  StorageUploadTask _uploadTask;
  String downloadUrl;

  @override
  void initState() {
    super.initState();
    uploadToFirebaseStorage();
  }

  Future<void> uploadToFirebaseStorage() async {
    String filePath = 'images/${DateTime.now()}.png';
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(filePath);
    setState(() {
      _uploadTask = firebaseStorageRef.putFile(widget.image);
    });
    StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
    
    downloadUrl = await taskSnapshot.ref.getDownloadURL();
    if (downloadUrl != null) {
      HttpProvider httpProvider = HttpProvider();
      List result = await httpProvider.getResponse(downloadUrl);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            result: result,
            image: widget.image,
          ),
        ),
        (route) => route.isFirst,
      );
    }
  }

  Column buildProgressIndicatorColumn(double progressPercent) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 150.0,
          width: 150.0,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 2.0,
              ),
            ],
          ),
        ),
        Text(
          "Determining material",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kLighterWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: StreamBuilder<StorageTaskEvent>(
            stream: _uploadTask.events,
            builder: (_, snapshot) {
              var event = snapshot?.data?.snapshot;

              double progressPercent = event != null
                  ? event.bytesTransferred / event.totalByteCount
                  : 0;

              return buildProgressIndicatorColumn(progressPercent);
            },
          ),
        ),
      ),
    );
  }
}
