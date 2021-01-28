import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.red,
        child: Center(
          child: Icon(
            CupertinoIcons.clear_thick_circled,
            color: Colors.white,
            size: 100,
          ),
        ),
      ),
    );
  }
}
