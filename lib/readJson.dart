import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

Future<List> readjsx() async {
  WidgetsFlutterBinding.ensureInitialized();
  List items = [];

  final String response = await rootBundle.loadString('assets/questions.json');
  final data = await json.decode(response);

  items = await data["Questions"];
  return items;


}