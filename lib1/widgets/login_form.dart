
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../screens/main_screen.dart';
import 'input_decoration.dart';
class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required GlobalKey<FormState> fornKey,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
  }) : _fornKey = fornKey, _emailTextController = emailTextController, _passwordTextController = passwordTextController, super(key: key);

  final GlobalKey<FormState> _fornKey;
  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;
  static const String _title = "Sample App";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fornKey ,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            validator: (value) {
              return value!.isEmpty ? 'Please add Email' : null;
            },
          controller: _emailTextController,
          decoration: buildInputDecorator(label: 'Enter Email',hintText: 'john@me.com')),
        ),
      
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
             validator: (value) {
              return value!.isEmpty ? 'Enter Password' : null;
            },
          controller: _passwordTextController,
          obscureText: true,
          decoration: buildInputDecorator(label: 'Enter Password', hintText: '')),

          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)
              ),
              backgroundColor: Colors.amber,
              textStyle:TextStyle(fontSize:18)
            ),
            onPressed: () {
              if(_fornKey.currentState!.validate()){
                FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text, password: _passwordTextController.text).then((value) {
                  //print(value.user?.uid);
             Navigator.push(context,
                     MaterialPageRoute(builder: (context) => MainScreenPage(),
                     ));
                });
              }
            } ,
           child: Text('Sign In'))
      ]),
    );
  }
}
