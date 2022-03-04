import 'package:flutter/material.dart';
import 'Animation/FadeAnimation.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'loginScreen.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  _splash_screenState createState() => _splash_screenState();
}

const colorizeColors = [
  Colors.white,
  Colors.pinkAccent,
  Colors.orangeAccent,
  Colors.black26,
];
const colorizeTextStyle = TextStyle(
    fontSize: 30.0,
    fontFamily: 'Fredoka_Condensed',
    fontWeight: FontWeight.bold,
    letterSpacing: 5);

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 2250), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (Context) => login_page()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 93, 99, 216),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 100)),
              // FadeAnimation(
              //   2,
              Container(
                child: Image.asset(
                  'assets/images/Icon.webp',
                  width: 200,
                  height: 300,
                ),
              ),
              FadeAnimation(
                .5,
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "Money  Manager",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: 5,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 250,
              ),
              FadeAnimation(
                1.5,
                Container(
                  child: Text(
                    "Powered By",
                    style: GoogleFonts.mcLaren(
                      textStyle: TextStyle(
                          color: Colors.white, letterSpacing: .5, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'THIRVUSOFT',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
