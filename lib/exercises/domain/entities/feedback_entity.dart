abstract class FeedbackEntity {
  const FeedbackEntity();
}

class WritingFeedback extends FeedbackEntity {
  final String level;
  final double structuralSimilarity;

  const WritingFeedback({
    required this.level,
    required this.structuralSimilarity,
  });
}

class ReadingFeedback extends FeedbackEntity {
  final String objectiveSentence;
  final String transcription;
  final int distance;
  final double precision;

  const ReadingFeedback({
    required this.objectiveSentence,
    required this.transcription,
    required this.distance,
    required this.precision,
  });
}
