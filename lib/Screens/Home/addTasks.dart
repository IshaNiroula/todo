import 'package:flutter/material.dart';
import 'package:todo_list_app/Services/database.dart';
import 'package:todo_list_app/Shared/textFormFieldDecoration.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  GlobalKey _key = GlobalKey();
  String title = "";
  String details = "";
  String date = "";
  String time = "";
  DateTime showDate;
  TimeOfDay showTime;
  TextEditingController _title = TextEditingController();
  TextEditingController _details = TextEditingController();

  @override
  void initState() {
    super.initState();
    date = showDate.toString();
    time = showTime.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (String text) {
                          title = text;
                        },
                        decoration:
                            addTaskDecoration.copyWith(hintText: "Add Task"),
                        autofocus: true,
                        controller: _title,
                      ),
                      TextField(
                        onChanged: (String text) {
                          details = text;
                        },
                        decoration:
                            addTaskDecoration.copyWith(hintText: "Add Details"),
                        autofocus: true,
                        controller: _details,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      child: Text(showDate == null
                          ? ""
                          : showDate.toString().substring(0, 10)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      child: Text(showTime == null
                          ? ""
                          : showTime.toString().substring(10, 15)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.cyanAccent,
                        size: 30,
                      ),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate:
                              showDate == null ? DateTime.now() : showDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050),
                        ).then((date) {
                          setState(() {
                            showDate = date;
                          });
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.access_time,
                        color: Colors.cyanAccent,
                        size: 30,
                      ),
                      onPressed: () {
                        DateTime now = DateTime.now();
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: now.hour,
                            minute: now.minute,
                          ),
                        ).then((time) {
                          setState(() {
                            showTime = time;
                          });
                        });
                      },
                    ),
                    Spacer(flex: 1),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () async {
                        await updateUserData(
                          title,
                          details,
                          showDate.toString().substring(0, 10),
                          showTime.toString().substring(10, 15),
                        );
                        print('Data Added');
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
