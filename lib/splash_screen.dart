import 'package:flutter/material.dart';
import 'package:seach_option/FadeAnimation.dart';
import 'package:seach_option/search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
    await Future.delayed(Duration(milliseconds: 1750), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (Context) => searchbar()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 100)),
            // FadeAnimation(
            //   2,
            Container(
              // width: 200.0,
              // height: 200.0,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(8.0)),
              //   color: Colors.white,
              // ),

              //   //borderRadius: BorderRadius.circular(20),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Image.asset(
                'assets/images/Icon.webp',
                width: 200,
                height: 300,
              ),

              //   ),
              // )),
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
    );
  }
}
