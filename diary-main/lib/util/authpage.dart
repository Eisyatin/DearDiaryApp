import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diaryapp/loginpage.dart';
import 'package:diaryapp/homepage2.dart';
import 'loginorregisterpage.dart';

//check the user has sign in or not
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),//if the user is logged in or not
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData){
            return HomePage();
          }

          //user is not logged in
          else {
            return LoginOrRegsterPage();
          }
        },
),
    );
  }
}