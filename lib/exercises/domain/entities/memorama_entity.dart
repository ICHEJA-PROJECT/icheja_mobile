class MemoramaItem {
  final String letter;
  final String imageUrl;

  const MemoramaItem({
    required this.letter,
    required this.imageUrl,
  });
}

class MemoramaCard {
  final int id;
  final String content; // Letra o URL de imagen
  final MemoramaCardType type;
  final String pairId; // ID para identificar la pareja
  bool isFlipped;
  bool isMatched;

  MemoramaCard({
    required this.id,
    required this.content,
    required this.type,
    required this.pairId,
    this.isFlipped = false,
    this.isMatched = false,
  });

  MemoramaCard copyWith({
    bool? isFlipped,
    bool? isMatched,
  }) {
    return MemoramaCard(
      id: id,
      content: content,
      type: type,
      pairId: pairId,
      isFlipped: isFlipped ?? this.isFlipped,
      isMatched: isMatched ?? this.isMatched,
    );
  }
}

enum MemoramaCardType { letter, image }
