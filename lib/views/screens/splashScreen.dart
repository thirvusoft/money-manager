import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager/views/screens/loginScreen.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);
  @override
  _splash_screenState createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (Context) => landing_screen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 250)),
            Container(
              child: Image.asset(
                'assets/images/thirvulogo.png',
                width: 200,
                height: 200,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 300),
              child: Text(
                "Powered by",
                style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "THIRVUSOFT",
                style: GoogleFonts.lato(
                  fontSize: 20,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
