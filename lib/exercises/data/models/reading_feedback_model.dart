import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';

class ReadingFeedbackModel extends ReadingFeedback {
  const ReadingFeedbackModel({
    required super.objectiveSentence,
    required super.transcription,
    required super.distance,
    required super.precision,
    super.palabrasIncorrectas,
  });

  factory ReadingFeedbackModel.fromJson(Map<String, dynamic> json) {
    return ReadingFeedbackModel(
      objectiveSentence: json['objective_sentence'] as String,
      transcription: json['transcription'] as String,
      distance: (json['distance'] as num).toInt(),
      precision: (json['precision'] as num).toDouble(),
      palabrasIncorrectas: json['wrong_words'] != null
          ? List<String>.from(json['wrong_words'] as List)
          : null,
    );
  }
}
