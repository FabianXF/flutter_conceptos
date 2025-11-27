class Tarea {
  final int idTarea;
  final int cursoId;
  final String titulo;
  final String? descripcion;
  final String? fechaCreacion;
  final String fechaEntrega;
  final double? puntajeMaximo;
  final String? estado;
  final int? creadaPor;

  Tarea({
    required this.idTarea,
    required this.cursoId,
    required this.titulo,
    this.descripcion,
    this.fechaCreacion,
    required this.fechaEntrega,
    this.puntajeMaximo,
    this.estado,
    this.creadaPor,
  });

  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      idTarea: json['idTarea'] ?? 0,
      cursoId: json['cursoId'] ?? 0,
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'],
      fechaCreacion: json['fechaCreacion'],
      fechaEntrega: json['fechaEntrega'] ?? '',
      puntajeMaximo: json['puntajeMaximo']?.toDouble(),
      estado: json['estado'],
      creadaPor: json['creadaPor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idTarea': idTarea,
      'cursoId': cursoId,
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaCreacion': fechaCreacion,
      'fechaEntrega': fechaEntrega,
      'puntajeMaximo': puntajeMaximo,
      'estado': estado,
      'creadaPor': creadaPor,
    };
  }

  // Helper para saber si está vencida
  bool get estaVencida {
    try {
      final fecha = DateTime.parse(fechaEntrega);
      return fecha.isBefore(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  // Helper para obtener días restantes
  int get diasRestantes {
    try {
      final fecha = DateTime.parse(fechaEntrega);
      final diferencia = fecha.difference(DateTime.now());
      return diferencia.inDays;
    } catch (e) {
      return 0;
    }
  }
}
