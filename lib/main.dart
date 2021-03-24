import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:todo_list_app/Model/userModel.dart';
import 'package:todo_list_app/Screens/wrapper.dart';
import 'package:todo_list_app/Services/authServices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser>.value(
      value: AuthServices().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}
