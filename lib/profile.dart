//import '../flutter_flow/flutter_flow_icon_button.dart';
//import '../flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key, required this.items, required this.uid});
  final List items;
  final String? uid;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF333B3E),
      appBar: AppBar(
        backgroundColor: Color(0xFF333B3E),
        automaticallyImplyLeading: false,
        title: const Text(
          'Profil',
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
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
                width: 355,
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
                    color: Color.fromARGB(255, 190, 92, 90)),
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
                          child: Image.network(
                            'https://picsum.photos/seed/370/600',
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          elevation: 0,
                          child: Container(
                            width: 100,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Color(0x00249689),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            child: const SelectionArea(
                                child: Text(
                              'Soufyane',
                              style: TextStyle(
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
                  color: Color.fromARGB(255, 36, 101, 90),
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
                    Row(
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
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                                child: Text(
                              'Sience',
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
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                                child: Text(
                              'Enseirb-Matmeca',
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
                    Row(
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
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                                child: Text(
                              'Sience',
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
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                                child: Text(
                              'Enseirb-Matmeca',
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
                    Row(
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
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                                child: Text(
                              'Sience',
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
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            SelectionArea(
                                child: Text(
                              'Enseirb-Matmeca',
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
