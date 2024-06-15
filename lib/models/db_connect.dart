import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/question_model.dart';

class FirebaseDataAdder {
  final url = Uri.parse('https://simplequizapp-4cf6f-default-rtdb.firebaseio.com/question.json');
Future<void> addQuestion(Question question)async{
  http.post(url, body: json.encode({
    'title': question.title,
    'options': question.options,
  }));

}
  Future<List<Question>> fetchQuestions() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        try {
          final response = await http.get(url);

          if (response.statusCode == 200) {
            Map<String, dynamic> data = json.decode(response.body);

            List<Question> questions = [];

            data.forEach((key, value) {
              Question question = Question.fromJson(key, value);
              questions.add(question);
            });

            return questions;
          } else {
            throw Exception('Failed to load questions (HTTP ${response.statusCode})');
          }
        } catch (e) {
          throw Exception('Error: $e');
        }
      } else {
        throw Exception('Failed to load questions (HTTP ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
