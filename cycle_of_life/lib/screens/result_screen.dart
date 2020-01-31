import 'dart:io';
import 'package:cycle_of_life/widgets/info_dialog.dart';
import 'package:cycle_of_life/widgets/warning_dialog.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final List result;
  final File image;
  final String message;

  ResultScreen({this.result, this.image, this.message});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
  }

  Color determinePercentageColor(double percentage) {
    if (percentage > 30.0) {
      return Colors.green;
    }
    if (percentage > 15.0) {
      return Colors.black;
    }
    // Else
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Cycle Of Life",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0, left: 64.0, right: 64.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "Material Identified",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 24.0),
              Container(
                height: 150.0,
                child: Image.file(
                  widget.image,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 12.0),
              Tooltip(
                message: widget.message,
                child: Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 12.0),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.result.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: buildMaterialContainer(
                        widget.result[index][0],
                        widget.result[index][1],
                        index == 0,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildMaterialContainer(
      double percentage, String material, bool bolded) {
    return GestureDetector(
      onTap: () {
        if (material != 'trash') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return InfoDialog(material: material);
            },
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.05),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                material,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: bolded ? FontWeight.w700 : FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
              Text(
                percentage.toString() + "%",
                style: TextStyle(
                  color: determinePercentageColor(percentage),
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
