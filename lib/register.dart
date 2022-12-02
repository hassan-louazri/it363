import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);
  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  String login = '';
  String password = '';
  bool _obscureText = true;

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

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Widget topBar = Container(
      padding: EdgeInsets.only(left: 20, top: width * 0.4),
      child: const Center(
        child: Text(
          'Create new account',
          style:
              TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Lato'),
        ),
      ),
    );

    Widget loginPage() => Container(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.3, horizontal: width / 20),
          child: SafeArea(
              child: Center(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.white, fontFamily: 'Lato'),
                  icon: Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Icon(Icons.mail_outline, color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.white, width: 3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: emailController,
              ),
              const SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                  filled: false,
                  fillColor: Colors.white,
                  hintText: 'Password',
                  suffixIcon: IconButton(
                      onPressed: _toggle,
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off)),
                  hintStyle:
                      const TextStyle(color: Colors.white, fontFamily: 'Lato'),
                  icon: const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Icon(Icons.lock, color: Colors.white),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.white, width: 3.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: passwordController,
                obscureText: _obscureText,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle:
                      const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 50.0,
                  ),
                  child: Text('Register'),
                ),
                onPressed: () => {signUpFunction()},
              ),
              const SizedBox(height: 100),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  textStyle:
                      const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
                  backgroundColor: Colors.blueAccent,
                ),
                icon: const Icon(
                  Icons.keyboard_return,
                  size: 24,
                ),
                label: const Text("Return"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyLogin()));
                },
              ),
            ],
          ))),
        );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image_2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[topBar, loginPage()],
        ),
      ),
    );
  }

  void success() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MyLogin()));
    Alert(context: context, title: "Register success").show();
  }

  Future signUpFunction() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) => {success()})
        .catchError((error) => {
              Alert(
                      context: context,
                      title: "Password must be 4 characters minimum")
                  .show()
            });
  }
}
