import 'package:icheja_mobile/exercises/domain/entities/memorama_entity.dart';

class MemoramaExerciseModel extends MemoramaExercise {
  MemoramaExerciseModel({
    required super.titulo,
    required super.subtitulo,
    required super.contenido,
    required super.instrucciones,
    required super.items,
  });

  factory MemoramaExerciseModel.fromJson(Map<String, dynamic> json) {
    final contexto = json['contexto'] as Map<String, dynamic>;
    final contenido = contexto['contenido'] as List<dynamic>;
    
    final items = contenido.map((item) {
      return MemoramaItem(
        letter: item['vocal'] as String,
        imageUrl: _cleanImageUrl(item['path_image'] as String),
      );
    }).toList();

    return MemoramaExerciseModel(
      titulo: json['titulo'] as String,
      subtitulo: json['subtitulo'] as String,
      contenido: json['contenido'] as String,
      instrucciones: json['instrucciones'] as String,
      items: items,
    );
  }

  static String _cleanImageUrl(String url) {
    // Limpiar URLs que tienen prefijos como "E:" 
    if (url.contains(':http')) {
      return url.split(':').last;
    }
    return url.trim();
  }
}