//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/Screens/Home/addTasks.dart';
import 'package:todo_list_app/Screens/Home/taskTile.dart';
import 'package:todo_list_app/Screens/Home/withOutData.dart';
import 'package:todo_list_app/Services/authServices.dart';
import 'package:todo_list_app/Services/database.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    void _addTask() {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          backgroundColor: Colors.grey,
          context: context,
          isScrollControlled: true,
          builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Form(child: AddTask())));
    }

    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      appBar: AppBar(
        backgroundColor: Color(0xFF2D2F41),
        elevation: 0,
        title: Text("TO-DO",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            )),
        actions: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            child: InkWell(
              onTap: () async {
                print("CircleAvatar pressed");
                await _auth.signOut();
              },
              child: Icon(Icons.person),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask();
          print("Create New TO-DO");
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.add, size: 30, color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: taskCollection.snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    return TaskTile(
                      snapshot: data,
                      title: data.data()['title'],
                      details: data.data()['details'],
                      date: data.data()['date'],
                      time: data.data()['time'],
                    );
                  },
                )
              : WithoutData();
        },
      ),
    );
  }
}
