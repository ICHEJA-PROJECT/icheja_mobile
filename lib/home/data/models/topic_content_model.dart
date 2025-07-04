import 'package:icheja_mobile/home/domain/entities/topic_content_entity.dart';

class TopicContentModel extends TopicContentEntity {
  TopicContentModel({
    required super.resources,
    required super.exercises,
  });

  factory TopicContentModel.fromJson(Map<String, dynamic> json) {
    final resourcesList = json['Recursos'] as List<dynamic>? ?? [];
    final exercisesList = json['Ejercicios'] as List<dynamic>? ?? [];

    return TopicContentModel(
      resources: resourcesList
          .map((resource) => ResourceModel.fromJson(resource as Map<String, dynamic>))
          .toList(),
      exercises: exercisesList
          .map((exercise) => ExerciseModel.fromJson(exercise as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ResourceModel extends ResourceEntity {
  ResourceModel({
    required super.title,
    required super.material,
  });

  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return ResourceModel(
      title: json['titulo'] as String,
      material: List<Map<String, dynamic>>.from(json['material'] as List),
    );
  }
}

class ExerciseModel extends ExerciseEntity {
  ExerciseModel({
    required super.titulo,
    required super.subtitulo,
    required super.contenido,
    required super.instrucciones,
    required super.mediaInstrucciones,
    required super.rutasImagenes,
    required super.escritura,
    required super.lectura,
    required super.seleccion,
    required super.memoria,
    required super.texto,
    required super.deletreo,
    required super.relacionSimple,
    required super.relacionCompleja,
    required super.contexto,
    required super.retroalimentacion,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      titulo: json['titulo'] as String,
      subtitulo: json['subtitulo'] as String,
      contenido: json['contenido'] as String,
      instrucciones: json['instrucciones'] as String,
      mediaInstrucciones: Map<String, dynamic>.from(json['media_instrucciones'] as Map),
      rutasImagenes: List<String>.from(json['rutas_imagenes'] as List),
      escritura: json['escritura'] as bool,
      lectura: json['lectura'] as bool? ?? false,
      seleccion: json['seleccion'] as bool,
      memoria: json['memoria'] as bool,
      texto: json['texto'] as bool,
      deletreo: json['deletreo'] as bool,
      relacionSimple: json['relacion_simple'] as bool,
      relacionCompleja: json['relacion_compleja'] as bool,
      contexto: Map<String, dynamic>.from(json['contexto'] as Map),
      retroalimentacion: Map<String, dynamic>.from(json['retroalimentacion'] as Map),
    );
  }
}