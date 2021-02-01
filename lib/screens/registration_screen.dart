import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  colorButton: Colors.blueAccent,
                  labelText: "Register",
                  onPress: () async {
                    await registerFirebase();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future registerFirebase() async {
    setSpinner(true);
    if (email.isNotEmpty || password.isNotEmpty) {
      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (newUser != null) {
          setSpinner(false);

          print(newUser);
          Navigator.pushNamed(context, ChatScreen.id);
        }

      } on FirebaseAuthException catch (e) {
        setSpinner(false);
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      }
    }
  }
}
