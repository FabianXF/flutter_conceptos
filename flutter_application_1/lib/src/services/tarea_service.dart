import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tarea.dart';

class TareaService {
  static const String baseUrl = 'http://localhost:8081/api/tareas';

  // Listar todas las tareas
  Future<List<Tarea>> getTareas() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Tarea.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar tareas');
      }
    } catch (e) {
      print('Error en getTareas: $e');
      return [];
    }
  }

  // Obtener tarea por ID
  Future<Tarea?> getTarea(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      
      if (response.statusCode == 200) {
        return Tarea.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('Error en getTarea: $e');
      return null;
    }
  }

  // Listar tareas por curso
  Future<List<Tarea>> getTareasPorCurso(int cursoId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/curso/$cursoId'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Tarea.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error en getTareasPorCurso: $e');
      return [];
    }
  }

  // Listar tareas activas
  Future<List<Tarea>> getTareasActivas() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/activas'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Tarea.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error en getTareasActivas: $e');
      return [];
    }
  }

  // Crear tarea
  Future<Map<String, dynamic>> crearTarea(Tarea tarea) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tarea.toJson()),
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': Tarea.fromJson(json.decode(response.body)),
          'message': 'Tarea creada exitosamente'
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'message': error['error'] ?? 'Error al crear tarea'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  // Actualizar tarea
  Future<Map<String, dynamic>> actualizarTarea(int id, Tarea tarea) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tarea.toJson()),
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': Tarea.fromJson(json.decode(response.body)),
          'message': 'Tarea actualizada exitosamente'
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'message': error['error'] ?? 'Error al actualizar tarea'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  // Eliminar tarea
  Future<Map<String, dynamic>> eliminarTarea(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Tarea eliminada exitosamente'
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'message': error['error'] ?? 'Error al eliminar tarea'
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
