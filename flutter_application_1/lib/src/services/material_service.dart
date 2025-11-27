import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/material.dart';

class MaterialService {
  static const String baseUrl = 'http://localhost:8081/api/materiales';

  // Listar todos los materiales
  Future<List<Material>> getMateriales() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Material.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar materiales');
      }
    } catch (e) {
      print('Error en getMateriales: $e');
      return [];
    }
  }

  // Obtener material por ID
  Future<Material?> getMaterial(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      
      if (response.statusCode == 200) {
        return Material.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('Error en getMaterial: $e');
      return null;
    }
  }

  // Listar materiales disponibles
  Future<List<Material>> getMaterialesDisponibles() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/disponibles'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Material.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error en getMaterialesDisponibles: $e');
      return [];
    }
  }

  // Listar materiales por categoría
  Future<List<Material>> getMaterialesPorCategoria(String categoria) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categoria/$categoria'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Material.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error en getMaterialesPorCategoria: $e');
      return [];
    }
  }

  // Buscar materiales
  Future<List<Material>> buscarMateriales(String nombre) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/buscar?nombre=$nombre'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Material.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error en buscarMateriales: $e');
      return [];
    }
  }

  // Crear material
  Future<Map<String, dynamic>> crearMaterial(Material material) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(material.toJson()),
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': Material.fromJson(json.decode(response.body)),
          'message': 'Material creado exitosamente'
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'message': error['error'] ?? 'Error al crear material'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  // Actualizar material
  Future<Map<String, dynamic>> actualizarMaterial(int id, Material material) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(material.toJson()),
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': Material.fromJson(json.decode(response.body)),
          'message': 'Material actualizado exitosamente'
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'message': error['error'] ?? 'Error al actualizar material'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  // Eliminar material
  Future<Map<String, dynamic>> eliminarMaterial(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Material eliminado exitosamente'
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'message': error['error'] ?? 'Error al eliminar material'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }
}
