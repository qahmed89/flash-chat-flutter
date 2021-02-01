import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/round_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  void setSpinner(bool isShow) {
    setState(() {
      showSpinner = isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            height: double.infinity,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Hero(
                        tag: kLogoTageAnimation,
                        child: Container(
                          height: 200.0,
                          child: Image.asset('images/logo.png'),
                        ),
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        style: kTextFieldTextStyle,
                        onChanged: (value) {
                          //Do something with the user input.
                          email = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Enter the Email",
                            hintStyle: kTextFieldHintStyle),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: kTextFieldTextStyle,
                        onChanged: (value) {
                          //Do something with the user input.
                          password = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Enter the Password",
                            hintStyle: kTextFieldHintStyle),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      RoundedButton(
                        colorButton: Colors.lightBlueAccent,
                        labelText: 'Log In',
                        onPress: () async {
                          await logInFireBase();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future logInFireBase() async {
    setSpinner(true);
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        final newUser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (newUser != null) {
          print(newUser);
          setSpinner(false);
          Navigator.pushNamed(context, ChatScreen.id);
        }
      }
    } on FirebaseAuthException catch (e) {
      setSpinner(false);

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
