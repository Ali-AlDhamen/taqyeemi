import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static String? userId;
  static void showsnackbar(BuildContext context, String text) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Sorry error ocurred!',
        message: text,
        contentType: ContentType.failure,
      ),
      duration: const Duration(seconds: 1, milliseconds: 500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<void> loginIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      userId = authResult.user!.uid;
    } on PlatformException catch (e) {
      if (e.code == 'user-not-found') {
        showsnackbar(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showsnackbar(context, "Wrong password provided for that user.");
      } else {
        showsnackbar(context, e.code);
      }
    }
  }

  static Future<void> signUp(
      String email, String password, String name, String phoneNo ,BuildContext context) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      userId = authResult.user!.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set({
        'name': name,
        'email': email,
        'phoneNo': phoneNo,
      });
    } on PlatformException catch (e) {
      if (e.code == 'weak-password') {
        showsnackbar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showsnackbar(context, "The account already exists for that email.");
      } else {
        showsnackbar(context, e.code);
      }
    }
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }

  static Future getUserData() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
  }

  static Future updateInformation(String update, String newValue) async {
    User? user = _auth.currentUser;
    userId = user!.uid;
    final userDocument =
        FirebaseFirestore.instance.collection('users').doc(userId);

    userDocument.update({update: newValue});
  }
}
