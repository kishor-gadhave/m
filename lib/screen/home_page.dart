import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/constants.dart';
import 'package:quiz_app/models/db_connect.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/widget/question_widget.dart';
import '../widget/result_box.dart';
import '../widget/option_card.dart';
import '../widget/next_button.dart';
class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  var db = FirebaseDataAdder();
  late Future _questions;

   Future<List<Question>> getData()async{
     return db.fetchQuestions();
   }

   @override
  void initState() {
     _questions = getData();
    super.initState();
  }


  int index = 0;
  int score = 0;

  bool isPressed = false;
  bool isAlreadySelected = false;
  
  void checkAnswerAndUpdate(bool value){
    if(isAlreadySelected){
      return;
    }else{if(value == true){
      score++;
    }
    setState(() {
      isPressed=true;
      isAlreadySelected=true;});
    }
  }

  void nextQuestion(int questionLength){
    if(index== questionLength - 1) {
      showDialog(context: context, barrierDismissible: false,
          builder:(ctx) => ResultBox(result: score, questionLength:questionLength,
          onPressed: startOver,));
    } else {
      if(isPressed){
      setState(() {
        index++;
        isPressed = false;
        isAlreadySelected=false;
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('please select any option'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(vertical: 20.0),
      ));
    }
      }
  }

  void startOver(){
    setState(() {
      index=0;
      score=0;
      isPressed=false;
      isAlreadySelected= false;});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _questions as Future<List<Question>>,
        builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if(snapshot.hasError){
          return Center(child: Text('${snapshot.error}',
            style: const TextStyle(fontSize: 10.0),
             ),
          );
        }else if(snapshot.hasData){
          var extractedData = snapshot.data as List<Question>;
          return Scaffold(
            backgroundColor: background,
            appBar: AppBar(
              title: const Text('Quiz app'),
              backgroundColor: background,
              shadowColor: Colors.transparent,
              actions: [
                Padding(padding: const EdgeInsets.all(18.0),
                child: Text('score:$score'),
                )
              ],
            ),
            body: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              child:  Column(
                children: [
                QuestionWidget(
                    question: extractedData[index].title,
                    totalQuestions: extractedData.length,
                    indexActions: index
                ),
                  Divider(color: neutral,),
                  const SizedBox(height: 25,),
                  for(int i = 0; i < extractedData[index].options.length; i++)
                    GestureDetector(onTap: () => checkAnswerAndUpdate(
                      extractedData[index].options.values.toList()[i]
                    ),
                      child: OptionCard(
                        option: extractedData[index].options.keys.toList()[i],
                        color: isPressed?
                        extractedData[index].options.values.toList()[i] == true?
                        correct:
                        incorrect:neutral
                             ,)
                           ),
                         ],
                       ),
                     ),
            floatingActionButton:  GestureDetector(
              onTap: ()=>nextQuestion(extractedData.length),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: NextButton(),),
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
                 );
               }
          }else
          {return
       const Center(child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           CircularProgressIndicator(),
         SizedBox(height: 20,),
         Text('Please wait data is loading....',
           style:TextStyle(
             color:Colors.blue,
             fontSize: 14.0,
             fontWeight: FontWeight.bold
               ) ,
             )
           ],
         )
       );
      }
      return const Center(child: Text('No Data'));
          }
        );
      }
}





