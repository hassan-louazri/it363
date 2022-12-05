import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:project_basic_quiz/home.dart';
import 'upload_image.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key, required this.items, required this.uid, required this.genre});
  final List items;
  final String? uid;
  final String genre;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var logger = Logger();

  String profilePictureUrl = 'https://picsum.photos/seed/370/600';
  String userName = "Default-User";
  String? myProgressCg;
  String? myProgressScience;
  String? myProgressEnseirb;

  void getProfilePictureByUid() async {
    var lastQuestion =
        FirebaseFirestore.instance.collection("Profile").doc("${widget.uid}");
    await lastQuestion
        .get()
        .then(
          (value) => setState(() {
            profilePictureUrl = value["profileUrl"];
          }),
        )
        .catchError(
          (error) => setState(() {
            profilePictureUrl = 'https://picsum.photos/seed/370/600';
          }),
        );
  }



  void getProgressCg() async {
    var progress =
    FirebaseFirestore.instance.collection("Profile").doc("${widget.uid}");
    await progress
        .get()
        .then(
          (value) => setState(() {
        myProgressCg = value["cg"];
      }),
    )
        .catchError(
          (error) => setState(() {
        myProgressCg = '0';
      }),
    );
  }

  void getProgressScience() async {
    var progress =
    FirebaseFirestore.instance.collection("Profile").doc("${widget.uid}");
    await progress
        .get()
        .then(
          (value) => setState(() {
        myProgressScience = value["science"];
      }),
    )
        .catchError(
          (error) => setState(() {
        myProgressScience = '0';
      }),
    );
  }

  void getProgressEnseirb() async {
    var progress =
    FirebaseFirestore.instance.collection("Profile").doc("${widget.uid}");
    await progress
        .get()
        .then(
          (value) => setState(() {
        myProgressEnseirb = value["enseirb"];
      }),
    )
        .catchError(
          (error) => setState(() {
        myProgressEnseirb = '0';
      }),
    );
  }

  void getUserNameByUid() async {
    var lastQuestion =
        FirebaseFirestore.instance.collection("Profile").doc("${widget.uid}");
    await lastQuestion
        .get()
        .then(
          (value) => setState(() {
            userName = value["userName"];
          }),
        )
        .catchError(
          (error) => setState(() {
            userName = 'Default-User';
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    getProfilePictureByUid();
    getUserNameByUid();
   getProgressCg();
   getProgressEnseirb();
   getProgressScience();
    double width2 = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF333B3E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF333B3E),
        automaticallyImplyLeading: false,
        title: const Text(
          'Profil',
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(
                    title: userName,
                    items: widget.items,
                    uid: widget.uid,
                    genre: widget.genre,
                  ),
                ),
              );
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        centerTitle: true,
        elevation: 2,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageUploads(uid: widget.uid),
                ),
              ),
              child: const Icon(Icons.menu),
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image_2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: width2,
                height: 165,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      color: Color.fromARGB(255, 190, 92, 90),
                      offset: Offset(0, 4),
                      spreadRadius: 2,
                    )
                  ],
                  color: const Color.fromARGB(255, 190, 92, 90),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: FadeInImage(
                            image: NetworkImage(profilePictureUrl),
                            placeholder: const AssetImage(
                                "assets/profilePlaceholder.png"),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          elevation: 0,
                          child: Container(
                            width: 100,
                            height: 22,
                            decoration: BoxDecoration(
                              color: const Color(0x00249689),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            child: SelectionArea(
                                child: Text(
                              userName,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                                child: Text(
                              'Culture generale',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )),
                            SelectionArea(
                                child: Text(
                              '38',
                            )),
                          ],
                        ),
                        const Divider(
                          height: 15,
                          thickness: 10,
                          indent: 100,
                          endIndent: 100,
                          color: Color(0xA9090909),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                                child: Text(
                              'Science',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )),
                            SelectionArea(
                                child: Text(
                              '10',
                            )),
                          ],
                        ),
                        const Divider(
                          height: 15,
                          thickness: 5,
                          indent: 100,
                          endIndent: 100,
                          color: Color.fromARGB(255, 60, 67, 9),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                                child: Text(
                              'ENSEIRB',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )),
                            SelectionArea(
                                child: Text(
                              '8',
                            )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 400,
                height: 300,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 36, 101, 90),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      color: Color.fromARGB(255, 36, 101, 90),
                      offset: Offset(0, 4),
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Culture generale',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                                child: Text(
                              'Total',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )),
                            SelectionArea(
                                child: Text(
                              '9',
                            )),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SelectionArea(
                                child: Text(
                              'Questions answered',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )),
                            SelectionArea(
                                child: Text(
                              myProgressCg!,
                            )),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                                child: Text(
                              'Correct',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )),
                            SelectionArea(
                                child: Text(
                              '38',
                            )),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      height: 10,
                      thickness: 5,
                      indent: 3,
                      endIndent: 3,
                      //color: Color.fromARGB(255, 60, 67, 9),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Science',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                              child: Text(
                                'Total',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                            SelectionArea(
                                child: Text(
                              '9',
                            )),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children:  [
                            const SelectionArea(
                                child: Text(
                              'questions answered',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )),
                            SelectionArea(
                                child: Text(
                                  myProgressScience!,
                            )),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                                child: Text(
                              'Correct',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )),
                            SelectionArea(
                                child: Text(
                              '38',
                            )),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      height: 10,
                      thickness: 5,
                      indent: 3,
                      endIndent: 3,
                      //color: Color.fromARGB(255, 185, 204, 42),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'ENSEIRB-MATMECA',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                              child: Text(
                                'Total',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                            SelectionArea(
                                child: Text(
                              '12',
                            )),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children:  [
                            const SelectionArea(
                                child: Text(
                              'questions answered',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )),
                            SelectionArea(
                                child: Text(
                                  myProgressEnseirb!,
                            )),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                                child: Text(
                              'Correct',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )),
                            SelectionArea(
                                child: Text(
                              '38',
                            )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
