class TopicContentEntity {
  final List<ResourceEntity> resources;
  final List<ExerciseEntity> exercises;

  TopicContentEntity({
    required this.resources,
    required this.exercises,
  });
}

class ResourceEntity {
  final String title;
  final List<Map<String, dynamic>> material;

  ResourceEntity({
    required this.title,
    required this.material,
  });
}

class ExerciseEntity {
  final String titulo;
  final String subtitulo;
  final String contenido;
  final String instrucciones;
  final Map<String, dynamic> mediaInstrucciones;
  final List<String> rutasImagenes;
  final bool escritura;
  final bool lectura;
  final bool seleccion;
  final bool memoria;
  final bool texto;
  final bool deletreo;
  final bool relacionSimple;
  final bool relacionCompleja;
  final Map<String, dynamic> contexto;
  final Map<String, dynamic> retroalimentacion;

  ExerciseEntity({
    required this.titulo,
    required this.subtitulo,
    required this.contenido,
    required this.instrucciones,
    required this.mediaInstrucciones,
    required this.rutasImagenes,
    required this.escritura,
    required this.lectura,
    required this.seleccion,
    required this.memoria,
    required this.texto,
    required this.deletreo,
    required this.relacionSimple,
    required this.relacionCompleja,
    required this.contexto,
    required this.retroalimentacion,
  });
}