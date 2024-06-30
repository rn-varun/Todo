import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppBar(
        // appBar decoration

        elevation: 5.0,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,

        // appBar title

        title: Text(
          'DoDo',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(Icons.login),
          )
        ],

      ),
    );
  }
}