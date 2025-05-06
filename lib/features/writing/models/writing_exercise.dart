class WritingExercise {
  final String id;
  final String title;
  final String prompt;
  final String language;
  final int difficulty;
  final List<String> keywords;
  final int minWords;
  final int maxWords;
  final String imageUrl;

  WritingExercise({
    required this.id,
    required this.title,
    required this.prompt,
    required this.language,
    required this.difficulty,
    required this.keywords,
    required this.minWords,
    required this.maxWords,
    required this.imageUrl,
  });

  factory WritingExercise.fromJson(Map<String, dynamic> json) {
    return WritingExercise(
      id: json['id'] as String,
      title: json['title'] as String,
      prompt: json['prompt'] as String,
      language: json['language'] as String,
      difficulty: json['difficulty'] as int,
      keywords: List<String>.from(json['keywords'] as List),
      minWords: json['minWords'] as int,
      maxWords: json['maxWords'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'prompt': prompt,
      'language': language,
      'difficulty': difficulty,
      'keywords': keywords,
      'minWords': minWords,
      'maxWords': maxWords,
      'imageUrl': imageUrl,
    };
  }
}