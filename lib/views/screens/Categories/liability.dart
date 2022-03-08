import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class customLiability extends StatefulWidget {
  const customLiability({Key? key}) : super(key: key);

  @override
  _customLiabilityState createState() => _customLiabilityState();
}

class _customLiabilityState extends State<customLiability> {
  TextEditingController _textEditingController = TextEditingController();
  var typecontroller = TextEditingController();
  var namecontroller = TextEditingController();
  List icon_nameOnSearch = [];
  List icon_name = [
    ['', 58759],
    ['', 61190],
    [' ', 987215],
    [' ', 62507],
    ['', 98633],
  ];

  var data;
  get index => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 93, 99, 216),
        title: Text('Liability Customise Icons'),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 3, crossAxisSpacing: 12),
          itemCount: _textEditingController.text.isNotEmpty
              ? icon_nameOnSearch.length
              : icon_name.length,
          itemBuilder: (context, index) {
            print(icon_name[index][1]);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 58,
                    backgroundColor: Color.fromARGB(255, 93, 99, 216),
                    child: IconButton(
                        iconSize: 30.0,
                        onPressed: () {
                          _show(context);
                        },
                        icon: Icon(
                            IconData(icon_name[index][1],
                                fontFamily: 'MaterialIcons'),
                            color: Color.fromARGB(255, 255, 255, 255))),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                ],
              ),
            );
          }),
    );
  }

  void _show(BuildContext ctx) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text(
                "Liability",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: namecontroller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Name:'),
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                  color: Color.fromARGB(255, 93, 99, 216),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    cussubmit(
                      typecontroller.text,
                      namecontroller.text,
                    );
                  })
            ]),
      ),
    );
  }

  Future cussubmit(type, name) async {
    if (typecontroller.text.isNotEmpty || namecontroller.text.isNotEmpty) {
      var response = await http.post(Uri.parse(
          "http://192.168.24.34:8000/api/method/money_management_backend.custom.py.api.custom?Type=Liability&Subtype=${name}&IconBineryCode=654654"));
      if (response.statusCode == 200) {
        print(response.statusCode);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Submitted Successfully"),
          backgroundColor: Colors.green,
        ));
      } else {
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Try again"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
