

import 'package:flutter/material.dart';


class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile it363',
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: Colors.blueGrey[900],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 360,
              color: Color.fromARGB(255, 153, 174, 179),
              child: Column(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 75.0,
                        child: CircleAvatar(
                          radius: 70.0,
                          backgroundImage:
                              NetworkImage('https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                          'My Profil',
                          style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                        height: 10.0,
                      ),
                  Card(
                        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Text(
                                "Score : 80",
                                 style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                  ),
                              )
                            ]
                          )
                        )
                  ) 
                ],
              ),
            ),
            SizedBox( height: 50.0),
            Container(
              height: 60,
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                children:[
                  Expanded(
                    child:SizedBox (
                      height:100, //height of button
                      width:300,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), 
                            ),
                          ),
                          onPressed: (){} ,
                          child: const Text("Finish the test", style: TextStyle(fontSize: 16))
                        )
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}