import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:playground/services/auth.dart';
import 'package:playground/shared/constants.dart';
import 'package:playground/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    return _loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(screenWidth / 12, screenHeight / 9,
                    screenWidth / 12, screenHeight / 12),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'SIGN UP',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: screenHeight / 9),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Enter your Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: screenHeight / 36),
                      TextFormField(
                        obscureText: true,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 54.0),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => _loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  _loading = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    customSnackBar(
                                      'Error signing Up. Try again.',
                                    ),
                                  );
                                });
                              }
                            }
                          },
                          child: Text('Register')),
                      SizedBox(height: 40.0),
                      Text.rich(
                        TextSpan(children: <TextSpan>[
                          TextSpan(text: 'Do have an account? '),
                          TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  widget.toggleView();
                                }),
                        ]),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
