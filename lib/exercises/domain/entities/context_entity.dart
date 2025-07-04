abstract class ContextEntity {
  const ContextEntity();
}

class WritingContext extends ContextEntity {
  final String imageBase;

  const WritingContext({required this.imageBase});
}

class ReadingContext extends ContextEntity {
  final String readingBase;

  const ReadingContext({required this.readingBase});
}

class CorrelationContext extends ContextEntity {
  final String typeOptions;
  final List<String> options;
  final num correctOptionIndex;

  const CorrelationContext(
      {required this.typeOptions,
      required this.options,
      required this.correctOptionIndex});
}
