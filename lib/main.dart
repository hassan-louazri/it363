import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

// import 'package:project_basic_quiz/profile.dart';

import 'login.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // var logger = Logger();
  // if (FirebaseAuth.instance.currentUser != null) {
  //   // wrong call in wrong place!

  //   logger.w("User not logged in");
  // } else {
  //   logger.w("there is already a user");
  // }
  runApp(const MaterialApp(
    home: MyLogin(),
  ));
}
