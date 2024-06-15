import 'package:flutter/material.dart';
import 'package:quiz_app/models/db_connect.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/screen/home_page.dart';



void main(){


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: const MyHomepage(),
    );
  }
}


