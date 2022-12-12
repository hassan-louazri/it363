import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:project_basic_quiz/start.dart';
import 'login.dart';

class Finish extends StatefulWidget {
  const Finish({super.key});

  @override
  State<Finish> createState() => _FinishState();
}

class _FinishState extends State<Finish> {
  Future<void> logOut() async {
    await FirebaseAuth.instance
        .signOut()
        .then(
          (value) => {
            Navigator.of(context).pop(),
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyLogin(),
              ),
            ),
          },
        )
        .catchError(
          (error) {},
        );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finish Line'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Show Snackbar',
            onPressed: () => {
              logOut(),
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image_2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            "You have finished the quiz.",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
        ),
      ),
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: ElevatedButton(
          child: const Text('Return'),
          onPressed: () => {
            Navigator.of(context).pop(),
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Start(),
              ),
            ),
          },
        ),
      ),
    );
  }
}
