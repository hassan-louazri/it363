
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login.dart';
import 'register.dart';

import 'package:firebase_core/firebase_core.dart';





Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  List items = [];

  final String response = await rootBundle.loadString('assets/questions.json');
  final data = await json.decode(response);

  items = await data["Questions"];


  
  runApp( const MaterialApp(
    home: MyLogin(),
  ));
}

// ignore_for_file: avoid_print
/*
import 'dart:convert';
import 'home.dart' show MyApp;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List items = [];

  final String response = await rootBundle.loadString('assets/questions.json');
  final data = await json.decode(response);

  items = await data["Questions"];

  print(items);

  runApp(MyApp(items: items));
}

 */

