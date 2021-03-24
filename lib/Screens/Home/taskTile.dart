import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/Services/database.dart';

class TaskTile extends StatefulWidget {
  final String title;
  final String details;
  final String date;
  final String id;
  final String time;
  final DocumentSnapshot snapshot;

  TaskTile({
    this.title,
    this.details,
    this.id,
    this.time,
    this.date,
    this.snapshot,
  });

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  int selectedRadioTile;
  final _color = TextStyle(
    color: Colors.white,
  );
  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int value) {
    setState(() {
      selectedRadioTile = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _size() {
      return SizedBox(
        height: 10,
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: SingleChildScrollView(
        child: RadioListTile(
          value: 1,
          //toggleable: true,
          selected: true,
          groupValue: selectedRadioTile,
          title: Text(widget.title, style: _color),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _size(),
              Text(widget.details, style: _color),
              _size(),
              Text(
                '${widget.date},${widget.time}',
                style: _color,
              ),
              _size(),
            ],
          ),
          onChanged: (val) {
            setSelectedRadioTile(val);
            deleteTask(widget.snapshot);
          },
          activeColor: Colors.white,
        ),
      ),
    );
  }
}
