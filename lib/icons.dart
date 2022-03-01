import 'package:flutter/material.dart';
import 'package:seach_option/user.dart';

import 'package:flutter/material.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({Key? key}) : super(key: key);

  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage>
    with TickerProviderStateMixin {
  List<User> _selectedUsers = [];

  List<User> _users = [
    User('Setiment', ' Icons.home'),
    User('Home', 'Icons.home'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
          padding: EdgeInsets.only(right: 20, left: 20),
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
            itemCount: _users.length,
            itemBuilder: (context, index) {
              return userComponent(user: _users[index]);
            },
          )),
    );
  }

  userComponent({required User user}) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            
            Container(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  
                  //child: Image.network(user.image),
                  //child: Icon(Icons),
                )),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(user.iconname,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500)),
            ])
          ]),
        ],
      ),
    );
  }
}
