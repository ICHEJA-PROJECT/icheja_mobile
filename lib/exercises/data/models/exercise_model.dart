import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/domain/entities/context_entity.dart';
import 'package:icheja_mobile/exercises/domain/entities/memorama_entity.dart';

class ExerciseModel extends Exercise {
  ExerciseModel({
    required super.id,
    required super.titulo,
    required super.subtitulo,
    required super.contenido,
    required super.instrucciones,
    required super.rutasImagenes,
    required super.type,
    required super.contexto,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    final bool isWriting = json['escritura'] as bool;
    //final bool isReading = json['lectura'] as bool? ?? false;
    final bool isMemory = json['memoria'] as bool;
    
    ExerciseType type;
    if (isMemory) {
      type = ExerciseType.memory;
    } else if (isWriting) {
      type = ExerciseType.writing;
    } else {
      type = ExerciseType.reading;
    }

    return ExerciseModel(
      id: json['id'] as int,
      titulo: json['titulo'] as String,
      subtitulo: json['subtitulo'] as String,
      contenido: json['contenido'] as String,
      instrucciones: json['instrucciones'] as String,
      rutasImagenes: (json['rutas_imagenes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      type: type,
      contexto: _buildContext(json, type),
    );
  }
}

ContextEntity _buildContext(Map<String, dynamic> json, ExerciseType type) {
  switch (type) {
    case ExerciseType.memory:
      return MemoramaContextModel.fromJson(
          json['contexto'] as Map<String, dynamic>);
    case ExerciseType.writing:
      return WritingContextModel.fromJson(
          json['contexto'] as Map<String, dynamic>);
    case ExerciseType.reading:
      return ReadingContextModel.fromJson(
          json['contexto'] as Map<String, dynamic>);
    default:
      return WritingContextModel.fromJson(
          json['contexto'] as Map<String, dynamic>);
  }
}

class MemoramaContextModel extends ContextEntity {
  final List<MemoramaItem> items;

  const MemoramaContextModel({required this.items});

  factory MemoramaContextModel.fromJson(Map<String, dynamic> json) {
    final contenido = json['contenido'] as List<dynamic>;
    final items = contenido.map((item) {
      return MemoramaItem(
        letter: item['vocal'] as String,
        imageUrl: _cleanImageUrl(item['path_image'] as String),
      );
    }).toList();

    return MemoramaContextModel(items: items);
  }

  static String _cleanImageUrl(String url) {
    if (url.contains(':http')) {
      return url.split(':').last;
    }
    return url.trim();
  }
}

class WritingContextModel extends WritingContext {
  const WritingContextModel({required super.imageBase});

  factory WritingContextModel.fromJson(Map<String, dynamic> json) {
    return WritingContextModel(
      imageBase: json['imagen_base'] as String,
    );
  }
}

class ReadingContextModel extends ReadingContext {
  const ReadingContextModel({required super.readingBase});

  factory ReadingContextModel.fromJson(Map<String, dynamic> json) {
    return ReadingContextModel(
      readingBase: json['lectura_base'] as String,
    );
  }
}

class CorrelationContextModel extends CorrelationContext {
  const CorrelationContextModel(
      {required super.typeOptions,
      required super.options,
      required super.correctOptionIndex});

  factory CorrelationContextModel.fromJson(Map<String, dynamic> json) {
    return CorrelationContextModel(
        typeOptions: json["tipo_opciones"] as String,
        options: json["opciones"] as List<String>,
        correctOptionIndex: json["opcion_correcta"] as int);
  }
}
