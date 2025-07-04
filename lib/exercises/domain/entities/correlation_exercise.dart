class CorrelationExercise {
  final int id;
  final String instrucciones;
  final List<String> rutasImagenes;
  final List<String> opciones;
  final int opcionCorrecta;

  const CorrelationExercise({
    required this.id,
    required this.instrucciones,
    required this.rutasImagenes,
    required this.opciones,
    required this.opcionCorrecta,
  });

  // Factory constructor para crear desde un Map (útil para mocks y API)
  factory CorrelationExercise.fromMap(Map<String, dynamic> map) {
    return CorrelationExercise(
      id: map['id'] as int,
      instrucciones: map['instrucciones'] as String,
      rutasImagenes: List<String>.from(map['rutasImagenes']),
      opciones: List<String>.from(map['opciones']),
      opcionCorrecta: map['opcionCorrecta'] as int,
    );
  }

  // Método para convertir a Map (útil para almacenamiento y API)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'instrucciones': instrucciones,
      'rutasImagenes': rutasImagenes,
      'opciones': opciones,
      'opcionCorrecta': opcionCorrecta,
    };
  }
} 