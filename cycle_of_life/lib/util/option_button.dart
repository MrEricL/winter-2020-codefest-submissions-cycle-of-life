import 'package:flutter/material.dart';

class OptionButton extends StatefulWidget {
  final VoidCallback onTap;
  final IconData icon;

  OptionButton({this.onTap, this.icon});

  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: Colors.transparent,
        height: 75.0,
        child: Icon(
          widget.icon,
          size: 30.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
