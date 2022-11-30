import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_basic_quiz/home.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:logger/logger.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _LoadJsonState();
}

class _LoadJsonState extends State<Start> {
  List items = [];
  int selectedItem = -1;
  List categories = ["Culture générale", "Science", "Enseirb-matmeca"];
  final FirebaseAuth auth = FirebaseAuth.instance;

  var logger = Logger();

  String? getUser() {
    final User? user = auth.currentUser;
    final String? uid = user?.uid;
    // here you write the codes to input the data into firestore
    logger.i("User id is : $uid");
    return uid;
  }

  Future<void> readJson(int selectedItem) async {
    String category = 'assets/questions.json';
    switch (selectedItem) {
      case 0:
        category = 'assets/cg.json';
        break;
      case 1:
        category = 'assets/science.json';
        break;
      case 2:
        category = 'assets/enseirb.json';
        break;
      default:
    }
    final String response = await rootBundle.loadString(category);
    logger.i(response);
    final data = await json.decode(response);

    items = await data["Questions"];
/*****************************************************************/
  }

  @override
  Widget build(BuildContext context) {
    String? uid = getUser();

    return Scaffold(
        appBar: AppBar(title: const Text("Charles Consel")),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                color: selectedItem == index
                    ? Colors.blueAccent.withOpacity(0.5)
                    : Colors.transparent,
                child: ListTile(
                  title: Text("${categories[index]}"),
                  onTap: () {
                    setState(() {
                      selectedItem = selectedItem == index ? -1 : index;
                    });
                  },
                ));
          },
        ),
        bottomSheet: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: ElevatedButton(
            child: const Text('Start Quiz'),
            onPressed: () => {
              readJson(selectedItem),
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyApp(items: items, uid: uid)))
            },
          ),
        ));
  }
}
