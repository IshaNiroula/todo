import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:todo_list_app/Model/userModel.dart';

class AuthServices {
  //creating instance of firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on TheUser
  TheUser _userFromFirebaseUser(User user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<TheUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String emal, String passwrd) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: emal.trim(),
        password: passwrd.trim(),
      );
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'Email Already in use') {
          return '$emal already in use';
        }
      }
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String emal, String passwrd) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: emal.trim(),
        password: passwrd.trim(),
      );
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'Email Already in use') {
          return '$emal already in use';
        }
      }
    }
  }

  //log out user
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
