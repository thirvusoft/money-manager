import 'package:flutter/material.dart';

void main() {
  runApp(const task());
}

class task extends StatefulWidget {
  const task({Key? key}) : super(key: key);
  @override
  _taskState createState() => _taskState();
}

class _taskState extends State<task> {
  List userSearchItems = [];
  final List<Map> data = List.generate(
      10,
      (index) => {
            'id': index,
            'name': 'Name: qwerr \nTask: Designing \nstatus:open ',
            'isSelected': false
          });

  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("AppBar Title");

  set customSearchBar(Text customSearchBar) {}

  set customIcon(Icon customIcon) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                } else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("AppBar Title");
                }
              });
            },
          ),
        ]),
        body: SafeArea(
            child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext ctx, index) {
            return Card(
                key: ValueKey(data[index]['name']),
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: data[index]['isSelected'] == true
                    ? Colors.blue[900]
                    : Colors.grey,
                child: ListTile(
                  onTap: () {
                    setState(() {
                      data[index]['isSelected'] = !data[index]['isSelected'];
                      userSearchItems.add(index);
                      print(userSearchItems);
                    });
                  },
                  leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(data[index]['id'].toString())),
                  title: Text(data[index]['name']),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ));
          },
        )));
  }
}
