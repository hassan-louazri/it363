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
  List imgs = ["culture_generale.png", "science.jpeg", "enseirb_matmeca.jpg"];
  final FirebaseAuth auth = FirebaseAuth.instance;

  var logger = Logger();

  String genre = "";

  String? getUser() {
    final User? user = auth.currentUser;
    final String? uid = user?.uid;
    // here you write the codes to input the data into firestore
    // logger.i("User id is : $uid");
    return uid;
  }

  Future<void> readJson(int selectedItem) async {
    String category = 'assets/questions.json';
    switch (selectedItem) {
      case 0:
        category = 'assets/cg.json';
        genre = "cg";
        break;
      case 1:
        category = 'assets/science.json';
        genre = "science";
        break;
      case 2:
        category = 'assets/enseirb.json';
        genre = "enseirb";
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
        appBar: AppBar(title: const Text("Welcome to Trivia Star")),
        body: Column(
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
              child: Text(
                "Please choose a category before proceeding",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedItem = selectedItem == index ? -1 : index;
                          });
                        },
                        child: Card(
                          margin: const EdgeInsets.all(10.0),
                          elevation: 8,
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: index == selectedItem
                                    ? Colors.blue
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/${imgs[index]}',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${categories[index]}"),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [Text("10/10")],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
            ),
          ],
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
                  builder: (context) => MyApp(items: items, uid: uid, genre:genre),
                ),
              ),
            },
          ),
        ));
  }
}
