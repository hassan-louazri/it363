import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart' show MyApp;
import 'mockPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'register.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);
  @override
  State<MyLogin> createState() => _MyLoginState();
}



class _MyLoginState extends State<MyLogin> {
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
    double width = MediaQuery.of(context).size.width;
    Widget topBar =   Container(


      padding:  EdgeInsets.only(left: 20, top: width*0.4),
      child: const Text(
        'Welcome Back',
        style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Lato'),
      ),
    );
    Widget loginPage () => Container(
      padding:  EdgeInsets.symmetric(
          vertical: width*0.3, horizontal: width/20),
      child: SafeArea(

          child: Center(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [  TextField(
                  controller: emailController,
              style:  const TextStyle(
                color: Colors.black,
              ),
            decoration:  const InputDecoration(
              filled: false,

              hintText: 'Login',
              hintStyle: TextStyle(color: Colors.white,fontFamily: 'Lato'),
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
                   TextField(
                     controller: passwordController,
                    style:  const TextStyle(

                      color: Colors.black,
                    ),
                    decoration:  const InputDecoration(
                      filled: false,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white,fontFamily:'Lato'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        //borderSide: BorderSide.,
                      ),
                    ),
                     /* onChanged: (value) {
                         password = value;
                     },*/
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20.0,fontFamily: 'Lato'),
                        backgroundColor: Colors.indigo,
                      ),
                   /* onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );
                    }*/
                    onPressed: () => { signInFunction()},

                  // onPressed: () =>{},
                    child:const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 50.0,
                    ),
                    child: Text('Sign-in'),
                  ),

                  ),
                  ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20.0,fontFamily: 'Lato'),
                      backgroundColor: Colors.indigo,
                    ),
                    /* onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );
                    }*/
                    onPressed: () => { (value) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyRegister())
                    )},


                    // onPressed: () =>{},
                    child:const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 50.0,
                      ),
                      child: Text('Create account'),
                    ),

                  ),

                ],
              )
          )

      ),

    );


    return  Scaffold(


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


          children: <Widget>[topBar,loginPage()],
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

  Future signInFunction() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text
    ).then((value) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Mock()
        )
    )
    ).catchError((error) => Alert(context: context, title: "Wrong email or password").show());
    

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

