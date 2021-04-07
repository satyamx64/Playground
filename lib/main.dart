import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/auth.dart';
import 'shared/loading.dart';
import 'models/myUser.dart';
import 'screens/wrapper.dart';
import 'shared/error.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Error();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider<MyUser>.value(
              initialData: null,
              value: AuthService().myUser,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light(),
                home: Wrapper(),
              ),
            );
          }
          return Loading();
        });
  }
}
