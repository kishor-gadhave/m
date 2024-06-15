import 'package:flutter/material.dart';
import 'package:quiz_app/models/constants.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({Key?key,
    required this.question,
    required this.totalQuestions,
    required this.indexActions}) : super(key: key);

  final String question;
  final int indexActions;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
          'Question ${indexActions + 1}/$totalQuestions: $question',
      style: TextStyle(
        fontSize: 24.0,
        color: neutral,
      ),),
    );
  }
}
