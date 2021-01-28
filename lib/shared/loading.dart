import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.grey[300],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}