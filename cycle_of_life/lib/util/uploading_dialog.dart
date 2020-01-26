import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadingDialog extends StatefulWidget {
  final File image;

  UploadingDialog({this.image});

  @override
  _UploadingDialogState createState() => _UploadingDialogState();
}

class _UploadingDialogState extends State<UploadingDialog> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://cycle-of-life.appspot.com');

  StorageUploadTask _uploadTask;
  String downloadUrl;

  @override
  void initState() {
    super.initState();
    uploadToFirebaseStorage();
  }

  void _startUpload() {
    /// Unique file name for the file
    String filePath = 'images/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.image);
    });
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
    print(downloadUrl);
    if (downloadUrl != null) {
      // TODO: make http request
      Navigator.pop(context);
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
                value: progressPercent,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3.0,
              ),
              // Center(
              //   child: Text(
              //     '${(progressPercent * 100).round()} % ',
              //     style: TextStyle(
              //       fontSize: 24.0,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Text(
          "Determining recyclability",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromRGBO(50, 50, 50, 1.0),
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
