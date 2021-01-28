import 'package:flutter/material.dart';
import 'package:playground/models/myUser.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final myUser = Provider.of<MyUser>(context);
    
    // return either the Home or Authenticate widget
    if (myUser == null){
      return Authenticate();
    } else {
      return Home();
    }
    
  }
}