import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class customAsset extends StatefulWidget {
  const customAsset({Key? key}) : super(key: key);

  @override
  _customAssetState createState() => _customAssetState();
}

class _customAssetState extends State<customAsset> {
  TextEditingController _textEditingController = TextEditingController();
  List icon_nameOnSearch = [];
  List icon_name = [
    ['', 58759],
    ['', 61190],
    ['', 987215],
    ['', 62507],
    ['', 98633],
    ['', 97633],
  ];

  var data;
  get index => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 93, 99, 216),
        title: Text('Asset Customise Icons'),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 3, crossAxisSpacing: 12),
          itemCount: _textEditingController!.text.isNotEmpty
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
                            IconData(
                              icon_name[index][1],
                              fontFamily: 'MaterialIcons',
                            ),
                            color: Color.fromARGB(255, 255, 255, 255))),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  // Text(
                  //     _textEditingController!.text.isNotEmpty
                  //         ? icon_nameOnSearch[index][0]
                  //         : icon_name[index][0],
                  //     style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 15,
                  //         letterSpacing: .7)),
                ],
              ),
            );
          }),
    );
  }
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
            TextField(
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
                  //submit();
                })
          ]),
    ),
  );
}
