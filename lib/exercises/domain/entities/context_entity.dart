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
