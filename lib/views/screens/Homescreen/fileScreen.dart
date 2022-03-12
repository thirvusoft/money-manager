
// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
       
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({ Key? key }) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//       var result;

//   @override
//   Widget build(BuildContext context) {
//     var file;
//     return Scaffold(
//       body: Center(child:Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(onPressed: (){
//             pickFiles();
//           }, 
//child: Text("Pick a file"),),
//           (file == null)? Container():Image.file(File(file!.path.toString()),
//           width: 150,)
//         ],
//       )),
//     );
//   }
// }

// void pickFiles() async{
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     type: FileType.custom,allowedExtensions: 
//     ['pdf','doc'],
//   );
//   if(result == null)
//   return;

//   var file = result.files.first;
//   viewFile(file);
// }

// void viewFile(PlatformFile file) {

//   var OpenFile;
//   OpenFile.open(file.path);
//   print(OpenFile);
// }

