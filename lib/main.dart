import 'package:flutter/material.dart';
import 'package:project_basic_quiz/profile.dart';
import 'login.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MaterialApp(
    home: MyLogin(),
  ));
}
