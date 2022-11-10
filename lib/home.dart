import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import  "package:firebase_auth/firebase_auth.dart";
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.items});

  final List items;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Quiz',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Charles Consel', items: items),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.items});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  final List items;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int id = 0;

  double myvalue= 0;


  void incrementId(String newId) {
    setState(() {
      if (newId != "null") {
        id = int.parse(newId);
      } else {
        if (id < widget.items.length - 1) {
          id++;
        } else {
          id = 0;
        }
      }
    });
  }

  Widget question(List items) {
    Widget dicho = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8.0),
          margin: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 40, bottom: 30),
          alignment: Alignment.centerLeft,
          child: Text(
            "Question ${1 + id}:",
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 12.0, bottom: 80),
          child: Text(
            items[id]["description"],
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 22, color: Colors.white),
          ),
        )
      ],
    );
    return dicho;
  }

  Widget answers(List items,double value) {
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
                  child: Text(items[id]["answers"].keys.toList()[0],
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
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(20),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // <-- Radius
                            ),
                          ),
                          onPressed: () {
                            incrementId("null");
                          },
                          child: Text(items[id]["answers"].keys.toList()[0],
                              style: const TextStyle(fontSize: 16))),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(20),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // <-- Radius
                            ),
                          ),
                          onPressed: () {
                            incrementId("null");
                          },
                          child: Text(items[id]["answers"].keys.toList()[1],
                              style: const TextStyle(fontSize: 16))),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(20), // NEW
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // <-- Radius
                            ),
                          ),
                          onPressed: () {
                            incrementId("null");
                          },
                          child: Text(items[id]["answers"].keys.toList()[2],
                              style: const TextStyle(fontSize: 16))),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Column();
    Widget textSlider = items[id]["type"] == "textSlider"
    ? Column(
    children: <Widget> [Slider(
      min: 0.0,
      max: 100.0,
      value: myvalue,
      divisions: 9,
      activeColor: Colors.green,
      inactiveColor: Colors.orange,

      onChanged: (value) {
        setState(() {
          myvalue = value;
        });

      },
    ),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: const <Widget>[
        Text('6'),
    ]
    ),
        ]
    )
        :Container();
    switch (items[id]["type"])
    {
      case "textSlider":
        return textSlider;
      case "qcm":
        return qcm;
    }
    return dicho;
    //return items[id]["type"] == "dicho" ? dicho : qcm;
  }

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
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.account_circle_sharp),
              ),
              Tab(
                icon: Icon(Icons.account_tree_outlined),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background_image.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[question(widget.items), answers(widget.items,myvalue)],
          ),
        ),
      ),
    );
  }
}

class LoadJson extends StatefulWidget {
  const LoadJson({Key? key}) : super(key: key);

  @override
  State<LoadJson> createState() => _LoadJsonState();
}


class _LoadJsonState extends State<LoadJson> {
  List items = [];
  Future<void> readJson() async
  {

    final String response = await rootBundle.loadString('assets/questions.json');
    final data = await json.decode(response);

    items = await data["Questions"];
/*****************************************************************/


  }
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    /*void inputData() {
      final User? user = auth.currentUser;
      final uid = user?.uid;
      // here you write the codes to input the data into firestore
    }

    inputData();*/
    var logger = Logger();
    logger.i("Debug message");

    CollectionReference students = FirebaseFirestore.instance.collection('questions-aswered');

   /* Future<void> addAnswer() {
      // Calling the collection to add a new user
      return students
      //adding to firebase collection
          .add({
        //Data added in the form of a dictionary into the document.
        'full_name': "test",
        'grade': "tes",
        'age': [
          {
            'id': "1",
            'answers':{'yes':"yes"}
          }
        ]
      })
          .then((value) => print("Student data Added"))
          .catchError((error) => print("Student couldn't be added."));
    }*/

    //addAnswer();

    return ElevatedButton(
      style:ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20.0,fontFamily: 'Lato'),
          backgroundColor: Colors.deepPurple

      ),

      onPressed: () => {
        readJson(),
        Navigator.push( context, MaterialPageRoute(builder: (context) =>  MyApp(items:items))
      )
      },


      // onPressed: () =>{},
      child:const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 50.0,
        ),
        child: Text('Start quizz'),
      ),

    );
  }
}

