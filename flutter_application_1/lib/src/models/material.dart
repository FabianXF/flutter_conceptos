class Material {
  final int idMaterial;
  final String nombre;
  final String? descripcion;
  final String? categoria;
  final double? precio;
  final int? stock;
  final String? imagenUrl;
  final String? autor;
  final String? editorial;
  final bool? disponible;
  final String? fechaCreacion;

  Material({
    required this.idMaterial,
    required this.nombre,
    this.descripcion,
    this.categoria,
    this.precio,
    this.stock,
    this.imagenUrl,
    this.autor,
    this.editorial,
    this.disponible,
    this.fechaCreacion,
  });

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(
      idMaterial: json['idMaterial'] ?? 0,
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'],
      categoria: json['categoria'],
      precio: json['precio']?.toDouble(),
      stock: json['stock'],
      imagenUrl: json['imagenUrl'],
      autor: json['autor'],
      editorial: json['editorial'],
      disponible: json['disponible'],
      fechaCreacion: json['fechaCreacion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMaterial': idMaterial,
      'nombre': nombre,
      'descripcion': descripcion,
      'categoria': categoria,
      'precio': precio,
      'stock': stock,
      'imagenUrl': imagenUrl,
      'autor': autor,
      'editorial': editorial,
      'disponible': disponible,
      'fechaCreacion': fechaCreacion,
    };
  }

  // Helper para verificar disponibilidad
  bool get estaDisponible => (disponible ?? false) && (stock ?? 0) > 0;

  // Helper para obtener precio formateado
  String get precioFormateado => '\$${precio?.toStringAsFixed(2) ?? '0.00'}';
}
