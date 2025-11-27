import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  Usuario? _usuario;
  bool _isAuthenticated = false;
  bool _isLoading = true;

  Usuario? get usuario => _usuario;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    _isLoading = true;
    notifyListeners();

    _isAuthenticated = await _authService.isAuthenticated();
    if (_isAuthenticated) {
      _usuario = await _authService.getCurrentUser();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String correo, String password) async {
    final result = await _authService.login(correo, password);
    
    if (result['success']) {
      _usuario = Usuario.fromJson(result['data']);
      _isAuthenticated = true;
      notifyListeners();
    }

    return result;
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    final result = await _authService.register(userData);
    
    if (result['success']) {
      _usuario = Usuario.fromJson(result['data']);
      _isAuthenticated = true;
      notifyListeners();
    }

    return result;
  }

  Future<void> logout() async {
    await _authService.logout();
    _usuario = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  // Actualizar usuario en memoria
  Future<void> updateUsuario(Usuario usuarioActualizado) async {
    _usuario = usuarioActualizado;
    
    // Actualizar también en storage
    await _authService.storage.write(
      key: 'usuario',
      value: usuarioActualizado.toJson().toString(),
    );
    
    notifyListeners();
  }
}
