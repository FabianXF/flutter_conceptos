import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/usuario.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:8081/api';
  final storage = const FlutterSecureStorage();

  // Login
  Future<Map<String, dynamic>> login(String correo, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'correo': correo,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Guardar token
        await storage.write(key: 'token', value: data['token']);
        await storage.write(key: 'usuario', value: json.encode(data));

        return {
          'success': true,
          'data': data,
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'message': error['error'] ?? 'Error al iniciar sesión',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e',
      };
    }
  }

  // Registro
  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Guardar token
        await storage.write(key: 'token', value: data['token']);
        await storage.write(key: 'usuario', value: json.encode(data));

        return {
          'success': true,
          'data': data,
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'message': error['error'] ?? 'Error al registrarse',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e',
      };
    }
  }

  // Obtener token
  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  // Obtener usuario actual
  Future<Usuario?> getCurrentUser() async {
    final usuarioJson = await storage.read(key: 'usuario');
    if (usuarioJson != null) {
      final data = json.decode(usuarioJson);
      return Usuario.fromJson(data);
    }
    return null;
  }

  // Verificar si está autenticado
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null;
  }

  // Logout
  Future<void> logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'usuario');
  }
}
