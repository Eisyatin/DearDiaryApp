import 'package:diaryapp/homepage2.dart';
import 'package:diaryapp/loginPage.dart';
import 'package:diaryapp/util/authpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_emoji/animated_emoji.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => AuthPage()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.blue[900],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           AnimatedEmoji(
            AnimatedEmojis.loveLetter,
            size: 128,
            repeat: true,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Dear Diary",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white, fontStyle:FontStyle.italic ),
          )
        ],
      ),
    ));
  }
}