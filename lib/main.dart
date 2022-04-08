import 'package:PrivateNotes/Pages/Home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.nunitoSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: SplashScreen(
          image: Image.asset(
            "images/img_1.png",
            width: 500,
            height: 500,
          ),
          photoSize: 100.0,
          seconds: 1,
          navigateAfterSeconds: Homepage(),
          loadingText: Text("Private Notes",
              style: GoogleFonts.balooBhai(
                  color: Colors.grey.shade900, fontSize: 50)),
          loaderColor: Colors.transparent,
          backgroundColor: Colors.white,
          // loaderColor: Colors.white
        ));
  }
}
