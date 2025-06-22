import 'package:icheja_mobile/exercises/domain/entities/context_entity.dart';

enum ExerciseType {
  writing,
  reading,
}

class Exercise {
  final int id;
  final String titulo;
  final String subtitulo;
  final String contenido;
  final String instrucciones;
  final List<String> rutasImagenes;
  final ExerciseType type;
  final ContextEntity contexto;
  // final FeedbackEntity retroalimentacion;

  const Exercise({
    required this.id,
    required this.titulo,
    required this.subtitulo,
    required this.contenido,
    required this.instrucciones,
    required this.rutasImagenes,
    required this.type,
    required this.contexto,
    // required this.retroalimentacion,
  });
}
