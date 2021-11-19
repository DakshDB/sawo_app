import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sawo/sawo.dart';
import 'package:sawo_app/model/user_model.dart';
import 'package:sawo_app/widget/button.dart';

import '../keys.dart';
import '../theme.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Sawo sawo = new Sawo(apiKey: sawoAPIKey, secretKey: sawoSecretKey);

  UserModel user = UserModel(id: "", identifier: "", identifierType: "");

  void payloadCallback(context, payload) {
    if (payload == null || (payload is String && payload.length == 0)) {
      payload = "Login Failed :(";
      String snackBarText = "Login Failed ! Unable to login";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(snackBarText),
        ),
      );
    } else {
      var parsedPayload = jsonDecode(payload);
      user = UserModel.fromJson(parsedPayload);
      String snackBarText = "Successful Login";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(snackBarText),
        ),
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Text(
              'Sawo : IP Tracker App',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      buttonText: "Email Login",
                      onPressed: () async {
                        sawo.signIn(
                          context: context,
                          identifierType: 'email',
                          callback: payloadCallback,
                        );
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    ButtonWidget(
                      buttonText: "Phone Login",
                      onPressed: () async {
                        sawo.signIn(
                          context: context,
                          identifierType: 'phone_number_sms',
                          callback: payloadCallback,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
