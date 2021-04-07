import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2.0),
  ),
);

SnackBar customSnackBar(content) {
  return SnackBar(
    backgroundColor: Colors.blue,
    content: Text(
      content,
      style: TextStyle(color: Colors.white, letterSpacing: 0.5),
    ),
  );
}
