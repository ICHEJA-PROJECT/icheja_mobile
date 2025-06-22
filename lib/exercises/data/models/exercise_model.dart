import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/domain/entities/context_entity.dart';

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
    final ExerciseType type =
        isWriting ? ExerciseType.writing : ExerciseType.reading;

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
      contexto: isWriting
          ? WritingContextModel.fromJson(
              json['contexto'] as Map<String, dynamic>)
          : ReadingContextModel.fromJson(
              json['contexto'] as Map<String, dynamic>),
    );
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
