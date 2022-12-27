import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:marketplace/screens/get_started_page.dart';
  import 'package:firebase_auth/firebase_auth.dart';
import 'package:marketplace/screens/login_page.dart';
import 'package:marketplace/screens/main_screen.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: 'AIzaSyB5kxQBd5lKLHsl3u87SU0NKmrrIR5YL-g', appId: '1:990123833536:web:31fa4707c3f525391a1525', messagingSenderId: '990123833536', projectId: 'eagreeapp')
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    Widget widget;
    if(firebaseUser != null) {
      print(firebaseUser.email);
      widget = MainScreenPage();
    }
    else{
      widget = LoginPage();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home:  widget
    );
  }
}

