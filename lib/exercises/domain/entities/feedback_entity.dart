abstract class FeedbackEntity {}

class ReadingFeedback extends FeedbackEntity {
  final double score;
  final String transcription;
  final List<dynamic> words;

  ReadingFeedback({
    required this.score,
    required this.transcription,
    required this.words,
  });
}

class WritingFeedbackEntity extends FeedbackEntity {
  final double precision;
  final String level;

  WritingFeedbackEntity({
    required this.precision,
    required this.level,
  });
}
