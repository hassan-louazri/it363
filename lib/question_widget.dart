import 'package:flutter/material.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key, required this.items, required this.id}) : super(key: key);

  final List items;
  final int id;

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8.0),
          margin: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 40, bottom: 30),
          alignment: Alignment.centerLeft,
          child: Text(
            "Question ${widget.items[widget.id]["id"]}",
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 12.0, bottom: 80),
          child: Text(
            widget.items[widget.id]["description"],
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 22, color: Colors.white),
          ),
        )
      ],
    );
  }
}
