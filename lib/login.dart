import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'register.dart';
import 'start.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);
  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
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
      padding: EdgeInsets.only(left: 20, top: width * 0.4, right: 20),
      child: const Center(
        child: Text(
          'Login',
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
                controller: emailController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  filled: false,
                  hintText: 'Email or username',
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
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle:
                      const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () => {signInFunction(context)},
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 50.0,
                  ),
                  child: Text('Login'),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle:
                        const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
                    backgroundColor: Colors.blueAccent),
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyRegister()))
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 50.0,
                  ),
                  child: Text('Create account'),
                ),
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

  Future signInFunction(BuildContext context) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) => {
              Navigator.of(context).pop(),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Start())),
            })
        .catchError((error) =>
            {Alert(context: context, title: "Wrong email or password").show()});
  }
}
