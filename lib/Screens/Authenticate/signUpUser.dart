import 'package:flutter/material.dart';
import 'package:todo_list_app/Services/authServices.dart';
import 'package:todo_list_app/Shared/textFormFieldDecoration.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //Services for authentication and global form key
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //for textformfield
  String name = "";
  String email = "";
  String password = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(70),
                bottomStart: Radius.circular(70),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "CREATE \nACCOUNT",
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
                          TextFormField(
                            decoration:
                                textDecoration.copyWith(hintText: "Name"),
                            validator: (val) =>
                                val.isEmpty ? 'Enter your name' : null,
                            onSaved: (val) {
                              setState(() {
                                name = val;
                              });
                            },
                            onChanged: (val) {
                              setState(() {
                                name = val.trim();
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration:
                                textDecoration.copyWith(hintText: "eg@eg.com"),
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
                            decoration:
                                textDecoration.copyWith(hintText: "Password"),
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
                              "Sign Up",
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
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email.trim(), password.trim());
                                  if (result is String) {
                                    setState(() {
                                      error =
                                          "Couldn't be SignIn with those credentials.";
                                      loading = false;
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
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          color: Color(0xFF2D2F41),
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
