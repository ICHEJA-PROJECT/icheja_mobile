class MemoramaExercise {
  final String titulo;
  final String subtitulo;
  final String contenido;
  final String instrucciones;
  final List<MemoramaItem> items;

  const MemoramaExercise({
    required this.titulo,
    required this.subtitulo,
    required this.contenido,
    required this.instrucciones,
    required this.items,
  });
}

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
  final String content; // Letra o imagen
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
}

enum MemoramaCardType { letter, image }