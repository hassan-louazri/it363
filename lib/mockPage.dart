import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart' show MyApp;

class Mock extends StatefulWidget {
  const Mock({Key? key}) : super(key: key);
  @override
  State<Mock> createState() => _Mockk();
}



class _Mockk extends State<Mock> {
  String login = '';
  String password = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    Widget topBar = Container(


      padding: EdgeInsets.only(left: 20, top: width * 0.4),
      child: const Text(
        'Welcome Back',
        style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Lato'),
      ),
    );
    Widget loginPage() =>
        Container(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.3, horizontal: width / 20),
          child: SafeArea(

              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [ TextField(
                      controller: emailController,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        filled: false,

                        hintText: 'Login',
                        hintStyle: TextStyle(
                            color: Colors.white, fontFamily: 'Lato'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      /* onChanged: (value) {
              login = value;
            },*/
                    ),
                      const SizedBox(height: 50),

                      const SizedBox(height: 50),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                              fontSize: 20.0, fontFamily: 'Lato'),
                          backgroundColor: Colors.indigo,
                        ),
                        /* onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );
                    }*/
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 50.0,
                          ),
                          child: Text('Sign-in'),
                        ),

                      ),
                    ],
                  )
              )

          ),

        );


    return Scaffold(


      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/login3.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,


          children: <Widget>[topBar, loginPage()],
        ),
      ),
      /*body: SafeArea(

        child: Center(
          child:  Column(
            children: [
                TextField(
                decoration: InputDecoration(
                 // icon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 100,
                      color: Colors.greenAccent,
                    ),
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  labelText: 'Email',
                ),
              ),

            ],
          )
        )
      ),*/

    );
  }
}




/*class MyLogin extends StatelessWidget {
  const MyLogin ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Login'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
            );
          }
        ),
      ),
    );

  }
}*/

