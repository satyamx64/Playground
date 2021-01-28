import 'package:flutter/material.dart';
import 'package:playground/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playground'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.exit_to_app,color: Colors.white,),
            label: Text('Logout',style: TextStyle(color: Colors.white),),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
