import 'package:flutter/material.dart';
import 'package:quiz_app/models/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({Key? key,
  required this.result,
    required this.questionLength,
    required this.onPressed,
  }): super(key: key);



  final int result;
  final int questionLength;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: background,
    content: Padding(
      padding: EdgeInsets.all(60.0),
  child: Column(
  mainAxisSize: MainAxisSize.min,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text('Result',
      style: TextStyle(
          color: neutral,
          fontSize: 22.0),),
  const SizedBox(height: 20.0,),
  CircleAvatar(radius:60,
    child: Text('$result/$questionLength',style: TextStyle(
    fontWeight: FontWeight.bold,
      fontSize: 30.0,),
           ),
    backgroundColor: result == questionLength/2?
    Colors.yellow:
    result<questionLength/2?
    incorrect:correct),
    const SizedBox(height: 20.0,),
    Text(result == questionLength/2? 'Almost there':
      result<questionLength/2? 'Try again': 'Great',style: TextStyle(fontWeight: FontWeight.bold,
    color: neutral,fontSize: 20),),
    const SizedBox(height: 20.0,),
    GestureDetector(
      onTap: onPressed,
      child: const Text('Star over',style:
      TextStyle(
          fontWeight: FontWeight.bold,
        fontSize: 20.0,color:Colors.blue,letterSpacing: 1.0
      ),),
          )
         ],
      ),
   ));
  }
}
