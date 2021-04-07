import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:playground/services/auth.dart';
import 'package:playground/shared/constants.dart';
import 'package:playground/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                        'SIGN IN',
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
                      SizedBox(height: screenHeight / 36),
                      GestureDetector(
                        onTap: () {},
                        child: Text('Forgot your Password?'),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => _loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  _loading = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    customSnackBar(
                                      'Error signing In. Try again.',
                                    ),
                                  );
                                });
                              }
                            }
                          },
                          child: Text('Sign In')),
                      // OutlinedButton(
                      //   style: ButtonStyle(
                      //     backgroundColor:
                      //         MaterialStateProperty.all(Colors.blue),
                      //     shape: MaterialStateProperty.all(
                      //       RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(40),
                      //       ),
                      //     ),
                      //   ),
                      //   onPressed: () async {
                      //     if (_formKey.currentState.validate()) {
                      //       setState(() => _loading = true);
                      //       dynamic result = await _auth
                      //           .signInWithEmailAndPassword(email, password);
                      //       if (result == null) {
                      //         setState(() {
                      //           _loading = false;
                      //           ScaffoldMessenger.of(context).showSnackBar(
                      //             customSnackBar(
                      //               'Error signing In. Try again.',
                      //             ),
                      //           );
                      //         });
                      //       }
                      //     }
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.min,
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: <Widget>[
                      //         Image(
                      //           image: AssetImage("assets/google_logo.png"),
                      //           height: 35.0,
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 10),
                      //           child: Text(
                      //             'Sign in with Google',
                      //             style: TextStyle(
                      //               fontSize: 20,
                      //               color: Colors.black54,
                      //               fontWeight: FontWeight.w600,
                      //             ),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // GestureDetector(
                      //   onTap: () async {
                      //     if (_formKey.currentState.validate()) {
                      //       setState(() => _loading = true);
                      //       dynamic result = await _auth
                      //           .signInWithEmailAndPassword(email, password);
                      //       if (result == null) {
                      //         setState(() {
                      //           _loading = false;
                      //           ScaffoldMessenger.of(context).showSnackBar(
                      //             customSnackBar(
                      //               'Error signing out. Try again.',
                      //             ),
                      //           );
                      //         });
                      //       }
                      //     }
                      //   },
                      //   child: Container(
                      //     height: 48,
                      //     width: double.maxFinite,
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //         color: Colors.blue,
                      //         borderRadius: BorderRadius.circular(24)),
                      //     child: Text(
                      //       'Submit',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 40.0),
                      Text.rich(
                        TextSpan(children: <TextSpan>[
                          TextSpan(text: 'Don\'t have an account? '),
                          TextSpan(
                              text: 'Sign Up',
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
                      SizedBox(
                        height: 20,
                      ),
                      OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          setState(() => _loading = true);
                          dynamic result = await _auth
                              .signInWithGoogle();
                          if (result == null) {
                            setState(() {
                              _loading = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(
                                  'Error signing In. Try again.',
                                ),
                              );
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage("assets/google_logo.png"),
                                height: 35.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Sign in with Google',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //     onPressed: () async {
                      //       dynamic result = await _auth.signInWithGoogle();
                      //       if (result == null) {
                      //         setState(() {
                      //           _loading = false;
                      //           error =
                      //               'Could not sign in with those credentials';
                      //         });
                      //       }
                      //     },
                      //     child: Text('Google Sign In')),
                      // ElevatedButton(
                      //     onPressed: () async {
                      //       dynamic result = await _auth.signOut();
                      //       if (result == null) {
                      //         setState(() {
                      //           _loading = false;
                      //           error =
                      //               'Could not sign in with those credentials';
                      //         });
                      //       }
                      //     },
                      //     child: Text('Google Sign Out')),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
