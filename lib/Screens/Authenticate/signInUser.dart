import 'package:flutter/material.dart';
import 'package:todo_list_app/Services/authServices.dart';
import 'package:todo_list_app/Shared/textFormFieldDecoration.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Services for authentication and global form key
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //for text form field
  String email = "".trim();
  String password = "".trim();
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(70),
                  bottomEnd: Radius.circular(70),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "WELCOME \nBACK",
                        style: TextStyle(
                          fontSize: 35,
                          letterSpacing: 1.5,
                          fontFamily: 'Arial',
                          color: Color(0xFF2D2F41),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration:
                                    textDecoration.copyWith(hintText: "Email"),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter an email' : null,
                                onChanged: (val) {
                                  setState(() {
                                    email = val.trim();
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: textDecoration.copyWith(
                                    hintText: "Password"),
                                validator: (val) => val.length < 8
                                    ? "Password should be more than 8 chars long"
                                    : null,
                                obscureText: true,
                                onChanged: (val) {
                                  setState(() {
                                    password = val.trim();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                          10.0,
                        ),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Color(0xFF2D2F41),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  right: 10,
                                ),
                                child: FloatingActionButton(
                                  backgroundColor: Color(0xFF2D2F41),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result = await _auth
                                          .signInWithEmailAndPassword(
                                              email.trim(), password.trim());
                                      if (result == null) {
                                        setState(() {
                                          error =
                                              "Please supply a valid email address";
                                          loading = true;
                                        });
                                      }
                                    }
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () {
                                widget.toggleView();
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Color(0xFF2D2F41),
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () {
                                print("forgot password pressed");
                              },
                              child: Text("Forgot Password?",
                                  style: TextStyle(
                                      color: Color(0xFF2D2F41),
                                      decoration: TextDecoration.underline)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
