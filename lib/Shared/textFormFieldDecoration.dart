import 'package:flutter/material.dart';

final textDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 2.0,
    ),
  ),
);

final addTaskDecoration = InputDecoration(
  border: InputBorder.none,
  focusColor: Colors.cyanAccent,
  hintStyle: TextStyle(
    color: Colors.white,
    fontSize: 14,
  ),
);
