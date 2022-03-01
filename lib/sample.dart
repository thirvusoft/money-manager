import 'package:flutter/material.dart';

final List vi = [
  Icons.sentiment_very_dissatisfied,
  Icons.home,
  Icons.drafts,
  Icons.backspace
];

// class sample extends StatelessWidget {
//   const sample({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListView(
//         children: icons.map((icon) => Icon(icon)).toList(),
//       ),
//     );
//   }
// }
class sample extends StatelessWidget {
  const sample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 3,
        children: vi.map((icon) => Icon(icon)).toList(),
      ),
    );
  }
}
