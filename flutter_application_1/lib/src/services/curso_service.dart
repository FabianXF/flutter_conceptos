import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/curso.dart';

class CursoService {
  static const String baseUrl = 'http://localhost:8081/api/cursos';

  // Listar todos los cursos
  Future<List<Curso>> getCursos() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Curso.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar cursos');
      }
    } catch (e) {
      print('Error en getCursos: $e');
      return [];
    }
  }

  // Obtener curso por ID
  Future<Curso?> getCurso(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      
      if (response.statusCode == 200) {
        return Curso.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('Error en getCurso: $e');
      return null;
    }
  }

  // Listar cursos activos
  Future<List<Curso>> getCursosActivos() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/activos'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Curso.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error en getCursosActivos: $e');
      return [];
    }
  }

  // Crear curso
  Future<Map<String, dynamic>> crearCurso(Curso curso) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(curso.toJson()),
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': Curso.fromJson(json.decode(response.body)),
          'message': 'Curso creado exitosamente'
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'message': error['error'] ?? 'Error al crear curso'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  // Actualizar curso
  Future<Map<String, dynamic>> actualizarCurso(int id, Curso curso) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(curso.toJson()),
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': Curso.fromJson(json.decode(response.body)),
          'message': 'Curso actualizado exitosamente'
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'message': error['error'] ?? 'Error al actualizar curso'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  // Eliminar curso
  Future<Map<String, dynamic>> eliminarCurso(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Curso eliminado exitosamente'
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'message': error['error'] ?? 'Error al eliminar curso'
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
