
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../widgets/create_account_form.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isCreatedAccountClicked = false;
  final _fornKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
   final TextEditingController _passwordTextController = TextEditingController();
   
  @override
  Widget build(BuildContext context) {
    return Material(
      child:Container(child:Column(children: [
        Expanded(flex:2,child: Container(color:HexColor('#b9c2d1') ,)),
        Text('Sign In',
        style: Theme.of(context).textTheme.headline5,),
        SizedBox(
          height: 10,
        ),
        Column(
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: isCreatedAccountClicked!=true ? LoginForm(fornKey: _fornKey, emailTextController: _emailTextController, passwordTextController: _passwordTextController) 
              :CreateAccountForm(fornKey: _fornKey, emailTextController: _emailTextController, passwordTextController: _passwordTextController),

            ),
            TextButton.icon(
            icon: Icon(Icons.portrait_rounded),
            style: TextButton.styleFrom(
              primary: HexColor('#fd5b28'),
              textStyle: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic
              )
            ),
            onPressed: () {
              setState(() {
                if(!isCreatedAccountClicked){
                  isCreatedAccountClicked = true;
                }
                else
                isCreatedAccountClicked = false;
              });
            }, 
            label: Text(isCreatedAccountClicked ? 'Already have an account' : 'Create Account'),)
          ],
        ),
        Expanded(flex:2,child: Container(color:HexColor('#b9c2d1') ,))
        
      ],)) ,
    );
  }


}
