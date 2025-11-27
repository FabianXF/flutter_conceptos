class Curso {
  final int idCurso;
  final String codigoCurso;
  final String nombreCurso;
  final String? descripcion;
  final int? creditos;
  final int? semestre;
  final int? docenteId;
  final int? cupoMaximo;
  final int? cupoDisponible;
  final String? estado;
  final String? fechaCreacion;

  Curso({
    required this.idCurso,
    required this.codigoCurso,
    required this.nombreCurso,
    this.descripcion,
    this.creditos,
    this.semestre,
    this.docenteId,
    this.cupoMaximo,
    this.cupoDisponible,
    this.estado,
    this.fechaCreacion,
  });

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      idCurso: json['idCurso'] ?? 0,
      codigoCurso: json['codigoCurso'] ?? '',
      nombreCurso: json['nombreCurso'] ?? '',
      descripcion: json['descripcion'],
      creditos: json['creditos'],
      semestre: json['semestre'],
      docenteId: json['docenteId'],
      cupoMaximo: json['cupoMaximo'],
      cupoDisponible: json['cupoDisponible'],
      estado: json['estado'],
      fechaCreacion: json['fechaCreacion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCurso': idCurso,
      'codigoCurso': codigoCurso,
      'nombreCurso': nombreCurso,
      'descripcion': descripcion,
      'creditos': creditos,
      'semestre': semestre,
      'docenteId': docenteId,
      'cupoMaximo': cupoMaximo,
      'cupoDisponible': cupoDisponible,
      'estado': estado,
      'fechaCreacion': fechaCreacion,
    };
  }
}
