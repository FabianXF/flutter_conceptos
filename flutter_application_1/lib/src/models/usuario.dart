class Usuario {
  final int codEstudiante;
  final String? identificacion;
  final String nombres;
  final String apellidos;
  final String? telefono;
  final String correo;
  final String? sexo;
  final String? fechaNacimiento;
  final String rol;

  Usuario({
    required this.codEstudiante,
    this.identificacion,
    required this.nombres,
    required this.apellidos,
    this.telefono,
    required this.correo,
    this.sexo,
    this.fechaNacimiento,
    required this.rol,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      codEstudiante: json['codEstudiante'] ?? 0,
      identificacion: json['identificacion'] ?? '',
      nombres: json['nombres'] ?? '',
      apellidos: json['apellidos'] ?? '',
      telefono: json['telefono'] ?? '',
      correo: json['correo'] ?? '',
      sexo: json['sexo'] ?? 'M',
      fechaNacimiento: json['fechaNacimiento'],
      rol: json['rol'] ?? 'ESTUDIANTE',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codEstudiante': codEstudiante,
      'identificacion': identificacion ?? '',
      'nombres': nombres,
      'apellidos': apellidos,
      'telefono': telefono ?? '',
      'correo': correo,
      'sexo': sexo ?? 'M',
      'fechaNacimiento': fechaNacimiento,
      'rol': rol,
    };
  }

  String get nombreCompleto => '$nombres $apellidos';
}
