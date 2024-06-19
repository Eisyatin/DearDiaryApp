import 'package:flutter/material.dart';
import 'favorite_page.dart';
import 'homepage2.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:diaryapp/util/theme_provider.dart';
import './sql_helper.dart';
import 'splashScreen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:diaryapp/util/ClickFavorite.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp( ChangeNotifierProvider(
      create: (context) => FavoritesManager(),
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  


  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
       themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: Splash(),
        // Add the FavoritePage to the app's routes
      routes: {
        '/homepage': (context) => HomePage(),
        '/diary_favorite': (context) => FavoritePage(),
      },
        );
  },
  );
}