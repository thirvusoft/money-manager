import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  late String title;
  late IconData icon;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late TextEditingController _editingController;

  get kDefaultPadding => null;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: size,
      child: Container(
        margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
        height: size.height * 0.2,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.2 - 27,
              width: size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  )),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        widget.icon,
                        size: 40,
                        color: Colors.white,
                      )
                    ],
                  )),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 54,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Theme.of(context).primaryColor.withOpacity(0.23),
                      )
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _editingController,
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5)),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    _editingController.text.trim().isEmpty
                        ? IconButton(
                            icon: Icon(Icons.search,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5)),
                            onPressed: null)
                        : IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(Icons.clear,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5)),
                            onPressed: () => setState(() {
                                  _editingController.clear();
                                })),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }
}
