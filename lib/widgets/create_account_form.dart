import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../screens/main_screen.dart';
import 'package:marketplace/screens/app_colors.dart';
import 'package:marketplace/screens/app_icons.dart';
import 'package:marketplace/screens/app_styles.dart';
import '../services/create_user.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({
    Key? key,
    required GlobalKey<FormState> fornKey,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
  })  : _fornKey = fornKey,
        _emailTextController = emailTextController,
        _passwordTextController = passwordTextController,
        super(key: key);

  final GlobalKey<FormState> _fornKey;
  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fornKey,
      child: Column(children: [
        Text('Please enter a valid email and passwortd',
            style: ralewayStyle.copyWith(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            )),

        const SizedBox(
          height: 30,
        ),
        SizedBox(
            height: 40,
            width: 320,
            child: // with custom text
                SignInButton(
              Buttons.Facebook,
              text: "Login with Facebook",
              onPressed: () {},
            )),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 270.0),
          child: Text(
            'Email',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 12.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        const SizedBox(height: 6.0),
        Container(
          height: 50.0,
          width: 325,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: AppColors.whiteColor,
          ),
          child: TextFormField(
            validator: (value) {
              return value!.isEmpty ? 'Enter Email' : null;
            },
            controller: _emailTextController,
            style: ralewayStyle.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.blueDarkColor,
              fontSize: 14.0,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: IconButton(
                  onPressed: () {}, icon: Image.asset(AppIcons.emailIcon)),
              contentPadding: const EdgeInsets.only(top: 16.0),
              hintText: 'Enter Email',
              hintStyle: ralewayStyle.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.blueDarkColor.withOpacity(0.5),
                fontSize: 12.0,
              ),
            ),
          ),
        ),

        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 245.0),
          child: Text(
            'Password',
            style: ralewayStyle.copyWith(
              fontSize: 12.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          height: 50.0,
          width: 325,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: AppColors.whiteColor,
          ),
          child: TextFormField(
            validator: ((value) {
              return value!.isEmpty ? 'Enter Password' : null;
            }),
            controller: _passwordTextController,
            style: ralewayStyle.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.blueDarkColor,
              fontSize: 14.0,
            ),
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: IconButton(
                  onPressed: () {}, icon: Image.asset(AppIcons.eyeIcon)),
              prefixIcon: IconButton(
                  onPressed: () {}, icon: Image.asset(AppIcons.lockIcon)),
              contentPadding: const EdgeInsets.only(top: 16.0),
              hintText: 'Enter Password',
              hintStyle: ralewayStyle.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.blueDarkColor.withOpacity(0.5),
                fontSize: 12.0,
              ),
            ),
          ),
        ),
        // TextButton(
        //     style: TextButton.styleFrom(
        //         primary: Colors.white,
        //         padding: EdgeInsets.all(15),
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(4)),
        //         backgroundColor: Colors.amber,
        //         textStyle: TextStyle(fontSize: 18)),
        //     onPressed: () {
        //       if (_fornKey.currentState!.validate()) {
        //         FirebaseAuth.instance
        //             .createUserWithEmailAndPassword(
        //                 email: _emailTextController.text,
        //                 password: _passwordTextController.text)
        //             .then((value) {
        //           //print(value.user?.email);
        //           FirebaseAuth.instance
        //               .signInWithEmailAndPassword(
        //                   email: _emailTextController.text,
        //                   password: _passwordTextController.text)
        //               .then((value) {
        //             return Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) => MainScreenPage(),
        //                 ));
        //           });
        //         });
        //       }
        //     },
        //     child: Text('Create Account'))
        const SizedBox(
          height: 30,
        ),

        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (_fornKey.currentState!.validate()) {
                String email = _emailTextController.text;
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  if (value.user != null) {
                    String displayName = email.toString().split('@')[0];
                    createUser(displayName, context).then((value) {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreenPage(),
                            ));
                      });
                    });
                  }
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    return Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreenPage(),
                        ));
                  });
                });
              }
            },
            borderRadius: BorderRadius.circular(16.0),
            child: Ink(
                padding: const EdgeInsets.symmetric(
                    horizontal: 70.0, vertical: 18.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: AppColors.blueDarkColor,
                ),
                child: Text(
                  'Create Account',
                  style: ralewayStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.whiteColor,
                    fontSize: 16.0,
                  ),
                )),
          ),
        ),
      ]),
    );
  }
}
