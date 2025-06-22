import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';

class WritingFeedbackModel extends WritingFeedbackEntity {
  WritingFeedbackModel({
    required super.precision,
    required super.level,
  });

  factory WritingFeedbackModel.fromJson(Map<String, dynamic> json) {
    return WritingFeedbackModel(
      precision: (json['precision'] as num).toDouble() * 100,
      level: json['educational_feedback']['level'] as String,
    );
  }
}
