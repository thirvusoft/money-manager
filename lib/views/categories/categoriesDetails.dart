import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

// void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AllFieldsForm(),
    );
  }
}

class AllFieldsFormBloc extends FormBloc<String, String> {
  final text1 = TextFieldBloc();

  final boolean1 = BooleanFieldBloc();

  final boolean2 = BooleanFieldBloc();

  final select1 = SelectFieldBloc(
    items: ['Gold', ' Sliver', 'Plantinum', 'Diamond'],
  );

  final select2 = SelectFieldBloc(
    items: ['Option 1', 'Option 2'],
  );

  final multiSelect1 = MultiSelectFieldBloc<String, dynamic>(
    items: [
      'Option 1',
      'Option 2',
    ],
  );
  final select3 = SelectFieldBloc(
    items: ['Gram', ' Kilogram', 'Pavan'],
  );
  final select4 = SelectFieldBloc(
    items: ['Bangle', ' Ring', 'Chain'],
  );

  final date1 = InputFieldBloc<DateTime?, dynamic>(initialValue: null);

  final dateAndTime1 = InputFieldBloc<DateTime?, dynamic>(initialValue: null);

  final time1 = InputFieldBloc<TimeOfDay?, Object>(initialValue: null);

  get context => null;

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.success();
    });
  }

  get controller => null;

  AllFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
      text1,
      boolean1,
      boolean2,
      select1,
      select2,
      multiSelect1,
      select3,
      select4,
      date1,
      dateAndTime1,
      time1,
    ]);
  }

  @override
  void onSubmitting() async {
    try {
      await Future<void>.delayed(Duration(milliseconds: 500));

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}

class AllFieldsForm extends StatelessWidget {
  @override
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.success();
    });
  }

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return Theme(
            data: Theme.of(context).copyWith(
              scaffoldBackgroundColor: Colors.indigo,
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              body: FormBlocListener<AllFieldsFormBloc, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => SuccessScreen()));
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.failureResponse!)));
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.select1,
                          decoration: InputDecoration(
                            labelText: 'Metal Type',
                            prefixIcon: Icon(Icons.toys),
                          ),
                          itemBuilder: (context, value) => FieldItem(
                            child: Text(value),
                          ),
                        ),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.select3,
                          decoration: InputDecoration(
                            labelText: 'Quantity Type',
                            prefixIcon: Icon(Icons.shop),
                          ),
                          itemBuilder: (context, value) => FieldItem(
                            child: Text(value),
                          ),
                        ),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.select4,
                          decoration: InputDecoration(
                            labelText: 'Metal Model',
                            prefixIcon: Icon(Icons.shop),
                          ),
                          itemBuilder: (context, value) => FieldItem(
                            child: Text(value),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.text1,
                          decoration: InputDecoration(
                            labelText: 'Purchase Rate',
                            prefixIcon: Icon(Icons.atm),
                          ),
                        ),
                        DateTimeFieldBlocBuilder(
                          dateTimeFieldBloc: formBloc.date1,
                          format: DateFormat('dd-MM-yyyy'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          decoration: InputDecoration(
                            labelText: 'DateTimeFieldBlocBuilder',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.text1,
                          decoration: InputDecoration(
                            labelText: 'Purchase Shop Name',
                            prefixIcon: Icon(Icons.text_fields),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.text1,
                          decoration: InputDecoration(
                            labelText: 'Purchase Shop Place',
                            prefixIcon: Icon(Icons.text_fields),
                          ),
                        ),

                        RoundedLoadingButton(
                          child: Text('Submit',
                              style: TextStyle(color: Colors.white)),
                          controller: _btnController,
                          onPressed: _doSomething,
                        )
                        // RoundedLoadingButton(
                        //   color: Colors.black,
                        //   onPressed: _doSomething(),
                        // AwesomeDialog(
                        //   context: context,
                        //   dialogType: DialogType.INFO_REVERSED,
                        //   borderSide:
                        //       BorderSide(color: Colors.green, width: 2),
                        //   width: 280,
                        //   buttonsBorderRadius:
                        //       BorderRadius.all(Radius.circular(2)),
                        //   headerAnimationLoop: false,
                        //   animType: AnimType.BOTTOMSLIDE,
                        //   title: 'INFO',
                        //   desc: 'Submitted Successfully',
                        //   showCloseIcon: true,
                        //   btnCancelOnPress: () {},
                        //   btnOkOnPress: () {
                        //     // autoHide:
                        //     // Duration(seconds: 2);
                        //   },
                        // )..show();
                        //   controller: _btnController(),
                        //   child: const Text('Enabled Button'),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void _doSomething(Type btnController) async {
  Timer(const Duration(seconds: 3), () {
    _btnController.success();
  });
}

class _btnController {
  static void success() {}
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.tag_faces, size: 100),
            SizedBox(height: 10),
            Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => AllFieldsForm())),
              icon: Icon(Icons.replay),
              label: Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}
