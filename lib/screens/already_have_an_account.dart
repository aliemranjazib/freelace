import 'package:flutter/material.dart';
import 'package:marketplace/constant.dart';
import 'package:marketplace/screens/app_colors.dart';
import '../constant.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          //
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: TextStyle(
              color: Color.fromARGB(255, 3, 0, 151),
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
