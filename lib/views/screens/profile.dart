import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class ProfilePageDesign extends StatefulWidget {
  @override
  _ProfilePageDesignState createState() => _ProfilePageDesignState();
}

class _ProfilePageDesignState extends State<ProfilePageDesign> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile",
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfilePage extends StatelessWidget {
  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Vadivelu",
            ),
            Divider(),
            SizedBox(
              height: 16,
            ),
            Text("glenmargon@gmail.com"),
            SizedBox(
              height: 16,
            ),
            Divider(),
            SizedBox(
              height: 16,
            ),
            FlatButton(
              padding: EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 20.0),
              ),
              color: Color.fromARGB(255, 93, 99, 216),
              textColor: Colors.white,
              onPressed: () {},
            ),
            SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size(double.infinity, 320);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(top: 4),
        decoration:
            BoxDecoration(color: Color.fromARGB(255, 93, 99, 216), boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 233, 231, 230),
              blurRadius: 20,
              offset: Offset(0, 0))
        ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 200,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/profile.jpg"))),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Milan Short",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);
    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
