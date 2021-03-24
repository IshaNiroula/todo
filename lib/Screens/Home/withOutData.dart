import 'package:flutter/material.dart';

class WithoutData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Image.asset(
          "images/todo.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
