// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:project_basic_quiz/profile.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'login.dart';
import 'question_widget.dart';
import 'finish.dart';
import 'dart:math';

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key, required this.items, required this.uid, required this.genre});

  final List items;
  final String? uid;
  final String genre;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title: 'Default-User', items: items, uid: uid, genre: genre),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(
      {super.key,
      required this.title,
      required this.items,
      required this.uid,
      required this.genre});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  final List items;
  final String? uid;
  final String genre;

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int id = 0;
  double myvalue = 0;
  int questionsAnswered = 0;
  // double? _ratingValue;
  List<String> currentItem = ["1", "1", "1", "1"];
  String matrixTableQuestion = "";
  var rating = 0.0;
  String lastId = "";
  var logger = Logger();
  // late PageController _pageController;
  List<String> images = [
    "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
  ];

  Future<void> updateLastQuestion(int id) {
    CollectionReference lastQuestion =
        FirebaseFirestore.instance.collection('last-question-answered');
    return lastQuestion
        .doc(widget.uid)
        .set({
          widget.genre: "$id",
        }, SetOptions(merge: true))
        .then(
          (value) => logger.i("Last question added"),
        )
        .catchError(
          (error) => logger.e("Last question wasn't added successfully."),
        );
  }

  Future<void> updateProgressToProfile(int id) {
    CollectionReference lastQuestion =
        FirebaseFirestore.instance.collection('Profile');
    return lastQuestion
        .doc(widget.uid)
        .set({
          widget.genre: "$questionsAnswered",
        }, SetOptions(merge: true))
        .then((value) => {
              logger.i("Progress added"),
              Alert(context: context, title: "Progress saved ",buttons: [
                DialogButton(
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                  child:  const Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],).show()
            })
        .catchError(
          (error) => logger.e("Progress wasn't added succefully."),
        );
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance
        .signOut()
        .then(

          (value) => {
            Navigator.of(context).pop(),
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyLogin(),
              ),
            ),
            logger.i("logged out successfully"),

          },
        )
        .catchError(
          (error) => logger.w("problem with logging out"),
        );
  }

  void getLastQuestionByUid() async {
    var lastQuestion = FirebaseFirestore.instance
        .collection("last-question-answered")
        .doc("${widget.uid}");
    lastQuestion.get().then((value) => setState(() {
          id = int.parse(value[widget.genre]);
        }));
  }

  @override
  void initState() {
    getLastQuestionByUid();
    super.initState();
    // _pageController = PageController(viewportFraction: 0.8);
  }

  int returnMaxLengthString(List<String> choises, int index) {
    var values = choises.map((choise) => choise.length);
    return (values.reduce(max) - choises[index].length) * 8 + 20;
  }

  List<String> returnListForRankOrder(int index) {
    return [for (var i = 1; i <= index; i++) i.toString()];
  }

  void incrementId(String newId) {
    questionsAnswered++;
    setState(
      () {
        if (newId != "null") {
          id = int.parse(newId) - 1;
          logger.i("String Id is $id");
        } else {
          if (id < widget.items.length - 1) {
            id++;
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Finish(),
                ));
          }
        }
      },
    );
  }

  int getId() {
    return id;
  }

  Widget answers(List items, double value) {
    Widget dicho = Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      height: 100,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              height: 60,
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    incrementId(items[id]["answers"]
                        [items[id]["answers"].keys.toList()[0]]);
                  },
                  child: Text(
                      items[id]["answers"].keys.toList().length > 0
                          ? items[id]["answers"].keys.toList()[0]
                          : '',
                      style: const TextStyle(fontSize: 16))),
            ),
          ),
          Expanded(
            child: Container(
              height: 60,
              padding: const EdgeInsets.only(left: 8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    incrementId(items[id]["answers"]
                        [items[id]["answers"].keys.toList()[1]]);
                  },
                  child: Text(items[id]["answers"].keys.toList()[1],
                      style: const TextStyle(fontSize: 16))),
            ),
          ),
        ],
      ),
    );

    Widget qcm = items[id]["type"] == "qcm"
        ? Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            height: 220,
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      items[id]["answers"].keys.toList().map<Widget>((element) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        minimumSize: const Size.fromHeight(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // <-- Radius
                        ),
                      ),
                      onPressed: () {
                        incrementId(items[id]["answers"][element]);
                      },
                      child: Text(
                        element,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );

                    // const SizedBox(height: 20)
                  }).toList(),
                ),
              ),
            ),
          )
        : Column();

    Widget rankOrder = items[id]["type"] == "RankOrder"
        ? Expanded(
            child: Column(
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (var i = 0;
                      i < items[id]["answers"].keys.toList().length;
                      i++)
                    Expanded(
                        child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              0,
                              returnMaxLengthString(
                                      items[id]["answers"].keys.toList(), i)
                                  .toDouble(),
                              0),
                          child: Text(
                              items[id]["answers"].keys.toList().length > 0
                                  ? items[id]["answers"].keys.toList()[i]
                                  : '',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                        ),
                        Expanded(
                          flex: 2,
                          child: DropdownButton(
                            value: currentItem[i],
                            iconEnabledColor: Colors.black,
                            underline: Container(
                              height: 1.5,
                              color: Colors.grey,
                            ),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            items: returnListForRankOrder(
                                    items[id]["answers"].keys.toList().length)
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (String? value) => setState(
                              () {
                                if (value != null) currentItem[i] = value;
                              },
                            ),
                            isExpanded: true,
                          ),
                        )
                      ],
                    ))
                ],
              )),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle:
                      const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () => {incrementId("null")},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 50.0,
                  ),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: const Text('Next question'),
                ),
              )
            ],
          ))
        : Column();

    Widget matrixTableQuestions = items[id]["type"] == "matrixTableQuestions"
        ? Expanded(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var j = 0;
                      j < items[id]["choises"].keys.toList().length;
                      j++)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      child: Text(
                        items[id]["choises"].keys.toList()[j],
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                ],
              ),
              Expanded(
                  child: ListView(
                children: [
                  for (var i = 0;
                      i < items[id]["answers"].keys.toList().length;
                      i++)
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              0,
                              returnMaxLengthString(
                                      items[id]["answers"].keys.toList(), i)
                                  .toDouble(),
                              0),
                          child: Text(
                              items[id]["answers"].keys.toList().length > 0
                                  ? items[id]["answers"].keys.toList()[i]
                                  : '',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                        ),
                        for (var k = 0;
                            k < items[id]["choises"].keys.toList().length;
                            k++)
                          Expanded(
                              child: ListView(
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                leading: Radio(
                                  value: items[id]["choises"].keys.toList()[k] +
                                      ',' +
                                      items[id]["answers"].keys.toList()[i],
                                  activeColor: const Color(0xFFFFFFFF),
                                  groupValue: matrixTableQuestion,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.white),
                                  onChanged: (value) {
                                    setState(() {
                                      print(value);
                                      matrixTableQuestion = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )),
                      ],
                    )
                ],
              )),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle:
                      const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () => {incrementId("null")},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 50.0,
                  ),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: const Text('Next question'),
                ),
              )
            ],
          ))
        : Column();
    Widget ratingQuestion = items[id]["type"] == "ratingQuestion"
        ? Expanded(
            child: Column(
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0;
                      i < items[id]["answers"].keys.toList().length;
                      i++)
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              0,
                              returnMaxLengthString(
                                          items[id]["answers"].keys.toList(), i)
                                      .toDouble() +
                                  40,
                              0),
                          child: Text(
                              items[id]["answers"].keys.toList().length > 0
                                  ? items[id]["answers"].keys.toList()[i]
                                  : '',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                        ),
                        RatingBar(
                            initialRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                                full: const Icon(Icons.star,
                                    color: Colors.orange),
                                half: const Icon(
                                  Icons.star_half,
                                  color: Colors.white,
                                ),
                                empty: const Icon(
                                  Icons.star_outline,
                                  color: Colors.white,
                                )),
                            onRatingUpdate: (value) {
                              setState(() {
                                // _ratingValue = value;
                              });
                            }),
                      ],
                    )
                ],
              )),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle:
                      const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () => {incrementId("null")},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 50.0,
                  ),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: const Text('Next question'),
                ),
              )
            ],
          ))
        : Column();
    Widget textSlider = items[id]["type"] == "textSlider"
        ? Column(children: <Widget>[
            Slider(
              min: 0.0,
              max: 100.0,
              value: myvalue,
              divisions: items[id]["answers"].keys.toList().length - 1,
              activeColor: Colors.purple,
              inactiveColor: Colors.purple.shade100,
              thumbColor: Colors.pink,
              onChanged: (value) {
                setState(() {
                  myvalue = value;
                });
              },
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                    items[id]["answers"].keys.toList().map<Widget>((element) {
                  return Text(element.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white));
                }).toList()),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () => {incrementId("null")},
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 50.0,
                ),
                child: Text('Next question'),
              ),
            )
          ])
        : Container();
    Widget visualAnalog = Column(
        //padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        //height: 100,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      icon: const Icon(
                        Icons.thumb_up,
                        size: 50.0,
                        color: Colors.blue,
                      ),
                      tooltip: 'Show Snackbar',
                      onPressed: () {
                        incrementId(items[id]["answers"]
                            [items[id]["answers"].keys.toList()[1]]);
                      }),
                ),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IconButton(
                      icon: const Icon(Icons.thumb_down,
                          size: 50.0, color: Colors.redAccent),
                      tooltip: 'Show Snackbar',
                      onPressed: () {
                        incrementId(items[id]["answers"]
                            [items[id]["answers"].keys.toList()[1]]);
                      }),
                  // child: Text(items[id]["answers"].keys.toList()[1],
                  // style: const TextStyle(fontSize: 16))),
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: () => {incrementId("null")},
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 50.0,
              ),
              child: Text('Next question'),
            ),
          ),
        ]);
    /*Widget image = PageView.builder(
       itemCount: images.length,
       pageSnapping: true,
       controller: _pageController,
       onPageChanged: (page) {
         /*setState(() {
           activePage = page;
         });*/
       },
       itemBuilder: (context, pagePosition) {
         return Container(
           margin: EdgeInsets.all(10),
           child: Image.network(images[pagePosition]),
         );
       });


        ]);*/

    Widget answerType = dicho;
    switch (items[id]["type"]) {
      case "qcm":
        answerType = qcm;
        break;
      case "RankOrder":
        answerType = rankOrder;
        break;
      case "textSlider":
        answerType = textSlider;
        break;
      case "matrixTableQuestions":
        answerType = matrixTableQuestions;
        break;
      case "ratingQuestion":
        answerType = ratingQuestion;
        break;

      case "visAnalog":
        answerType = visualAnalog;
        break;
      /* case "image":
        answerType = image;
        break;*/
    }
    return answerType;
  }
  /*

    */

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfile(
                        items: widget.items,
                        uid: widget.uid,
                        genre: widget.genre),
                  ),
                ),
                child: const Icon(Icons.account_circle_rounded),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Show Snackbar',
                onPressed: () => {
                  logOut(),
                },
              ),
            ]),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background_image_2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Questions(items: widget.items, id: id),
              answers(widget.items, myvalue),
              // const SizedBox(height: 50),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //       textStyle:
              //           const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
              //       backgroundColor: Colors.deepPurple),
              //   onPressed: () => {
              //     // updateLastQuestion(id),
              //     // updateProgressToProfile(id),
              //   },
              //   child: const Padding(
              //     padding: EdgeInsets.symmetric(
              //       vertical: 10.0,
              //       horizontal: 50.0,
              //     ),
              //     child: Text('Save progress'),
              //   ),
              // ),
            ],
          ),
        ),
        bottomSheet: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: ElevatedButton(
            onPressed: () => {
              updateLastQuestion(getId()),
              updateProgressToProfile(getId()),
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0)),
            ),
            child: const Text('Save Progress'),
          ),
        ),
      ),
    );
  }
}
