import 'package:flutter/material.dart';
import 'package:student_project/pages/login.page.dart';
import "package:firebase_core/firebase_core.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(
                  child: Container(
            child: Text("Fuck offf"),
          )));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }
        return MaterialApp(
            home: Scaffold(body: Center(child: Text("Loading"))));
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  // _AppState createState() => _AppState();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khawarizmi',
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
