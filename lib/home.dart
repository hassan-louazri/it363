import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:project_basic_quiz/profile.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'question_widget.dart';


import 'dart:math';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.items, required this.uid});

  final List items;
  final String? uid;

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
      home: MyHomePage(title: 'Charles Consel', items: items, uid: uid),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key, required this.title, required this.items, required this.uid});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  final List items;
  final String currentItem = "";
  final String? uid;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
   int id = 0;

  double myvalue = 0;

  String currentItem = "";
  var logger = Logger();
  String lastId = "";
   late PageController _pageController;
   List<String> images = [
     "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
     "https://wallpaperaccess.com/full/2637581.jpg",
     "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
   ];


 /* static void  setId(int idToSet)
  {
    id = idToSet;
  }*/

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updateLastQuestion(int id) {
    CollectionReference lastQuestion =
        FirebaseFirestore.instance.collection('last-question-answered');
    return lastQuestion
        .doc(widget.uid)
        .set({
          'uid': "${widget.uid}",
          'id': "$id",
        })
        .then((value) => logger.i("Last question added"))
        .catchError(
            (error) => logger.e("Last question wasn't added successfully."));
  }

  void getLastQuestionByUid() async {
    var lastQuestion = FirebaseFirestore.instance
        .collection("last-question-answered")
        .doc("${widget.uid}");
    lastQuestion.get().then((value) => setState(() {
          id = int.parse(value["id"]);
        }));
  }

  @override
  void initState() {
    List<String> test = ["1", "2", "3"];
    currentItem = test[0];
    getLastQuestionByUid();
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  int returnMaxLengthString(List<String> choises) {
    var values = choises.map((choise) => choise.length);
    return values.reduce(max);
  }

  void incrementId(String newId) {
    logger.i("String newId is $newId");
    setState(() {
      if (newId != "null") {
        id = int.parse(newId) - 1;
        logger.i("String Id is $id");
      } else {
        if (id < widget.items.length - 1) {
          id++;
        } else {
          id = 1;
        }
      }
    });
  }



  Widget answers(List items, double value) {
    List<String> test = ["1", "2", "3"];
    Widget dicho =Container(
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
                            incrementId(items[id]["answers"]
                                [items[id]["answers"].keys.toList()[0]]);
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
                            incrementId(items[id]["answers"]
                                [items[id]["answers"].keys.toList()[1]]);
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
                            incrementId(items[id]["answers"]
                                [items[id]["answers"].keys.toList()[2]]);
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

    Widget rankOrder = items[id]["type"] == "RankOrder"
        ? Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            height: 220,
            child: SafeArea(
              child: Center(
                child: Column(
                  children: <Widget>[
                    for (var i = 0;
                        i < items[id]["answers"].keys.toList().length;
                        i++)
                      Row(children: <Widget>[
                        Column(children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: 40,
                              right: 100,
                            ),
                            child: Text(items[id]["answers"].keys.toList()[i]),
                          ),
                        ]),
                        Column(
                          children: [
                            SizedBox(
                              width: 200,
                              // margin :  EdgeInsets.only(right:100 - items[id]["answers"]!.keys.toList()[i].length +40,),
                              child: DropdownButton(
                                value: currentItem,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                                items: test
                                    .map<DropdownMenuItem<String>>(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        alignment: Alignment.center,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (String? value) => setState(
                                  () {
                                    if (value != null) currentItem = value;
                                  },
                                ),
                                isExpanded: true,
                              ),
                            )
                          ],
                        )
                      ]),
                  ],
                ),
              ),
            ),
          )
        : Column();
    Widget textSlider = items[id]["type"] == "textSlider"
        ? Column(children: <Widget>[
            Slider(
              min: 0.0,
              max: 100.0,
              value: myvalue,
              divisions: 3,
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
                children:  <Widget>[
                  Text(items[id]["answers"].keys.toList()[0],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                  Text(items[id]["answers"].keys.toList()[1],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                  Text(items[id]["answers"].keys.toList()[2],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white))
                ]),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle:
          const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
          backgroundColor: Colors.blueAccent,
        ),
        onPressed:()=> {incrementId("null")},
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
    Widget visualAnalog =
    Column(
      //padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      //height: 100,
      children: [ Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              height: 60,
              padding: const EdgeInsets.only(right: 8.0),

                child:  IconButton(
                    icon: const Icon(Icons.thumb_up,size: 50.0,color: Colors.blue,),
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
              child:  IconButton(
                  icon: const Icon(Icons.thumb_down, size:50.0, color: Colors.redAccent),
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
            textStyle:
            const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
            backgroundColor: Colors.blueAccent,
          ),
          onPressed:()=> {incrementId("null")},
          child: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 50.0,
            ),
            child: Text('Next question'),
          ),

        ),
    ]
    );
   Widget image = PageView.builder(
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
      case "visAnalog":
        answerType = visualAnalog;
        break;
      case "image":
        answerType = image;
        break;
    }
    return answerType;
    //return items[id]["type"] == "dicho" ? dicho : qcm;
    // if (items[id - 1]["type"] == "dicho") {
    //   return dicho;
    // } else if (items[id - 1]["type"] == "qcm") {
    //   return qcm;
    // }
    // return RankOrder;
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
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyProfile(items: widget.items, uid: widget.uid))),
                child: const Icon(Icons.account_circle_rounded),
              ),
            ),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Show Snackbar',
                  onPressed: () => {
                        //logOut()
                      }),
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
              Questions(items: widget.items, id:id),
              answers(widget.items, myvalue),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle:
                        const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
                    backgroundColor: Colors.deepPurple),

                onPressed: () => {updateLastQuestion(id)},

                // onPressed: () =>{},
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 50.0,
                  ),
                  child: Text('Save progress'),
                ),
              ),
            ],
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
  final FirebaseAuth auth = FirebaseAuth.instance;

  var logger = Logger();

  String? getUser() {
    final User? user = auth.currentUser;
    final String? uid = user?.uid;
    // here you write the codes to input the data into firestore
    logger.i("User id is : $uid");
    return uid;
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/questions.json');
    logger.i(response);
    final data = await json.decode(response);

    items = await data["Questions"];
/*****************************************************************/
  }

  @override
  Widget build(BuildContext context) {
    String? uid = getUser();
    CollectionReference students =
        FirebaseFirestore.instance.collection('questions-answered');

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
          backgroundColor: Colors.deepPurple),
      onPressed: () => {
        readJson(),
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyApp(items: items, uid: uid)))
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 50.0,
        ),
        child: Text('Tap to start quiz'),
      ),
    );
  }
}
