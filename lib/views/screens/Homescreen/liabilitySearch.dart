import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:money_manager/views/screens/Categories/liability.dart';

import '../Categories/Asset.dart';
import 'package:http/http.dart' as http;

import '../profile.dart';

class liabilitySearch extends StatefulWidget {
  const liabilitySearch({Key? key}) : super(key: key);

  @override
  _liabilitySearchState createState() => _liabilitySearchState();
}

class _liabilitySearchState extends State<liabilitySearch> {
  TextEditingController _textEditingController = TextEditingController();

  var typecontroller = TextEditingController();
  var subtypecontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var notescontroller = TextEditingController();
  var amountcontroller = TextEditingController();
  var datecontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  bool _loading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Color.fromARGB(255, 93, 99, 216);
      setState(() {
        _loading = false;
      });
    });
  }

  List icon_nameOnSearch = [];
  List icon_name = [
    ['Debt', 0xeea2],
    ['EMI', 0xf2d1],
  ];
  var data;
  var subtypes;
  get index => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profiles()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                ),
              ),
            ),
          ],
          backgroundColor: Color.fromARGB(255, 93, 99, 216),
          automaticallyImplyLeading: false,
          title: Container(
            width: 330,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  value.trimLeft();
                  icon_nameOnSearch.clear();
                  for (var i = 0; i < icon_name.length; i++) {
                    data = icon_name[i][0];
                    if (data
                        .toLowerCase()
                        .contains(value.trim().toLowerCase())) {
                      icon_nameOnSearch.add(icon_name[i]);
                      print(icon_nameOnSearch);
                    }
                  }
                });
              },
              controller: _textEditingController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  hintText: "Search",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 93, 99, 216),
                  )),
            ),
          ),
        ),
        body: Center(
            child: _loading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 93, 99, 216)),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        crossAxisSpacing: 20),
                    itemCount: _textEditingController.text.isNotEmpty
                        ? icon_nameOnSearch.length
                        : icon_name.length,
                    itemBuilder: (context, index) {
                      print(icon_name[index][1]);
                      return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Center(
                                  child: TextButton.icon(
                                      onPressed: () {
                                        subtypes = icon_name[index][0];
                                        _show(context, subtypes);
                                        print(icon_name[index][0]);
                                      },
                                      label: Text(
                                        _textEditingController.text.isNotEmpty
                                            ? icon_nameOnSearch[index][0]
                                            : icon_name[index][0],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            letterSpacing: .7),
                                      ),
                                      icon: Icon(
                                          IconData(icon_name[index][1],
                                              fontFamily: 'MaterialIcons'),
                                          color: Color.fromARGB(
                                              255, 93, 99, 216)))),
                            ],
                          ));
                    })),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            // isExtended: true,
            child: Icon(Icons.add, semanticLabel: 'Customise icon'),
            backgroundColor: Color.fromARGB(255, 93, 99, 216),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => customLiability()),
              );
            }));
  }

  void _show(BuildContext ctx, subtypes) {
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
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text("Liability",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25)),
                      ),
                      Text(subtypes, style: TextStyle(fontSize: 20)),
                      TextFormField(
                          controller: namecontroller,
                          decoration: InputDecoration(labelText: 'Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter the name";
                            } else {
                              return null;
                            }
                          }),
                      TextField(
                        controller: notescontroller,
                        decoration: InputDecoration(labelText: 'Notes'),
                      ),
                      TextField(
                        controller: amountcontroller,
                        decoration: InputDecoration(labelText: 'Amount'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        readOnly: true,
                        controller: dateController,
                        decoration: InputDecoration(labelText: 'Reminder Date'),
                        style: TextStyle(),
                        onTap: () async {
                          var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100),
                          );
                          builder:
                          (BuildContext context, Widget child) {
                            return Theme(
                              data: ThemeData().copyWith(
                                  colorScheme: ColorScheme.dark(
                                      primary: Colors.red,
                                      surface: Colors.red)),
                              child: child,
                            );
                          };
                          dateController.text =
                              date.toString().substring(0, 10);
                        },
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
                            if (formKey.currentState!.validate()) {
                              dataentry(
                                typecontroller.text,
                                subtypes,
                                namecontroller.text,
                                notescontroller.text,
                                amountcontroller.text,
                                datecontroller.text,
                              );
                              namecontroller.clear();
                              notescontroller.clear();
                              amountcontroller.clear();
                              datecontroller.clear();
                            }
                          })
                    ]),
              ),
            ));
  }

  Future dataentry(
    type,
    subtypes,
    name,
    notes,
    amount,
    date,
  ) async {
    if (typecontroller.text.isNotEmpty ||
        namecontroller.text.isNotEmpty ||
        notescontroller.text.isNotEmpty ||
        amountcontroller.text.isNotEmpty ||
        datecontroller.text.isNotEmpty) {
      print("check");
      var response = await http.post(Uri.parse(
          "http://192.168.24.34:8000/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=Liability&Subtype=${subtypes}&Name=${name}&Notes=${notes}&Amount=${amount}&Remainder_date=${date}"));
      print(response.statusCode);
      print("response");
      if (response.statusCode == 200) {
        print(response.statusCode);
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Submited Sucessfully"),
          backgroundColor: Colors.green,
        ));
      } else {
        print(response.statusCode);
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
