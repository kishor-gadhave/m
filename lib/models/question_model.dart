class Question {
  final String id;
  final String title;
  final Map<String, bool> options;

  Question({
    required this.id,
    required this.title,
    required this.options,
  });

  factory Question.fromJson(String id, Map<String, dynamic> json) {
    var optionsMap = json['option'] as Map<String, dynamic>?;

    Map<String, bool> parsedOptions = {};
    if (optionsMap != null) {
      optionsMap.forEach((key, value) {
        // Remove single quotes from the key to get the actual option name
        var optionName = key.replaceAll("'", "");
        if (value is bool) {
          parsedOptions[optionName] = value;
        }
      });
    }

    return Question(
      id: id,
      title: json['title'] ?? '',
      options: parsedOptions,
    );
  }

  @override
  String toString() {
    return 'Question(id: $id, title: $title, options: $options)';
  }
}
