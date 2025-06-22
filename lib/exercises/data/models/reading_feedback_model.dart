import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';

class ReadingFeedbackModel extends ReadingFeedback {
  ReadingFeedbackModel({
    required super.score,
    required super.transcription,
    required super.words,
  });

  factory ReadingFeedbackModel.fromJson(Map<String, dynamic> json) {
    return ReadingFeedbackModel(
      score: (json['precision'] as num).toDouble(),
      transcription: json['transcription'] as String,
      words: json['wrong_words'] != null
          ? List<dynamic>.from(json['wrong_words'] as List)
          : [],
    );
  }
}
