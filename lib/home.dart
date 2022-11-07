// ignore_for_file: avoid_print

import 'dart:convert';  

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart' show MyLogin;

/*void main() {
  runApp(const MyApp());
}*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MyHomePage(title: 'Charles Consel'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // void _incrementCounter() {
  //   setState(() {});
  // }

   var  items = [];



  /********** Function to read Json file **************************/
  @override
  void initState() {
    super.initState();
    readJson();


  }
  Future<void> readJson() async
  {

    final String response = await rootBundle.loadString('assets/questions.json');
    final data = await json.decode(response);

    setState(() {
      items = data["Questions"];

    });

    print(items);
    print(items[0]);
/*****************************************************************/


  }

  Widget question () => Column(
    
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        margin:
            const EdgeInsets.only(left: 20.0, right: 20.0, top: 40, bottom: 30),
        alignment: Alignment.centerLeft,
        child: const Text(
          "Question 1:",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
      ),
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 80),
        child:   Text(
          items[0]["description"],
         style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 30, color: Colors.white),
        ),
      )
    ],
  );

  Widget answers() => Container(
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
                  print('Test no');
                },
                child: const Text("Yes", style: TextStyle(fontSize: 16))),
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
                onPressed: () /*{Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Question2(title: 'Charles Consel')),
                );},*/
                  {},
                child: const Text("No", style: TextStyle(fontSize: 16))),
          ),
        ),
      ],
    ),
  );
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
     child:  Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        /*leading: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            print('going to profile');
          },
        ),*/
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
            image: AssetImage(
                "assets/background_image.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[question(), answers()],
        ),
      ),
    ),
    );
  }
}

/*class Question2 extends StatefulWidget {
  const Question2({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Question2> createState() => _Question2State();
}

class _Question2State extends State<Question2> {
  Widget question = Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        margin:
        const EdgeInsets.only(left: 20.0, right: 20.0, top: 40, bottom: 30),
        alignment: Alignment.centerLeft,
        child: const Text(
          "Question 1:",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
      ),
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 80),
        child: const Text(
          "Test page navigation?",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 30, color: Colors.white),
        ),
      )
    ],
  );

  Widget answers = Container(
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
                  print('Test no');
                },
                child: const Text("Yes", style: TextStyle(fontSize: 16))),
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
                  print('Test yes');
                },
                child: const Text("No", style: TextStyle(fontSize: 16))),
          ),
        ),
      ],
    ),
  );
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
        leading: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            print('going to profile');
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/background_image.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[question, answers],
        ),
      ),
    ),
    );
  }
}*/


