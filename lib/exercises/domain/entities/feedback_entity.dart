import 'package:equatable/equatable.dart';

abstract class FeedbackEntity extends Equatable {
  final double? precision;
  final List<String>? palabrasIncorrectas;
  final String? retroalimentacion;

  const FeedbackEntity({
    this.precision,
    this.palabrasIncorrectas,
    this.retroalimentacion,
  });

  @override
  List<Object?> get props =>
      [precision, palabrasIncorrectas, retroalimentacion];
}

abstract class WritingFeedback extends FeedbackEntity {
  final String level;
  final double structuralSimilarity;

  const WritingFeedback({
    required this.level,
    required this.structuralSimilarity,
  });

  @override
  List<Object?> get props => [level, structuralSimilarity];
}

abstract class ReadingFeedback extends FeedbackEntity {
  final String objectiveSentence;
  final String transcription;
  final int distance;
  final double precision;
  final List<String>? palabrasIncorrectas;

  const ReadingFeedback({
    required this.objectiveSentence,
    required this.transcription,
    required this.distance,
    required this.precision,
    this.palabrasIncorrectas,
  }) : super(precision: precision, palabrasIncorrectas: palabrasIncorrectas);

  @override
  List<Object?> get props => [
        objectiveSentence,
        transcription,
        distance,
        precision,
        palabrasIncorrectas,
      ];
}
