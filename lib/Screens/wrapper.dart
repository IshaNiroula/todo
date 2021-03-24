import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/Model/userModel.dart';
import 'package:todo_list_app/Screens/Home/HomePage.dart';

import 'Authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);

    //return either Home Screen or Authenticate Screen
    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
