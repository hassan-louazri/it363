
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);
  @override
  State<MyRegister> createState() => _MyRegisterState();
}



class _MyRegisterState extends State<MyRegister> {
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
        'Welcome ',
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
                    color: Colors.white,
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
                      backgroundColor: Colors.deepPurple,
                    ),
                    /* onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );
                    }*/
                    onPressed: () => { signUpFunction()},

                    // onPressed: () =>{},
                    child:const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 50.0,
                      ),
                      child: Text('Sign-up'),
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

  Future signUpFunction() async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
    ).then((value) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyLogin()
        )
    )
    );


  }
}



