import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/usuario.dart';
import '../services/estudiante_service.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool _editando = false;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _identificacionController;
  late TextEditingController _telefonoController;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final usuario = authProvider.usuario;
    
    _nombreController = TextEditingController(text: usuario?.nombres ?? '');
    _apellidoController = TextEditingController(text: usuario?.apellidos ?? '');
    _identificacionController = TextEditingController(text: usuario?.identificacion ?? '');
    _telefonoController = TextEditingController(text: usuario?.telefono ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final usuario = authProvider.usuario;

    // Valores con fallback
    final telefono = (usuario?.telefono?.isEmpty ?? true) ? 'No disponible' : usuario!.telefono!;
    final identificacion = (usuario?.identificacion?.isEmpty ?? true) ? 'No disponible' : usuario!.identificacion!;

    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text('Mi Perfil'),
        backgroundColor: Color(0xFF09855E),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_editando ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() {
                if (_editando) {
                  // Cancelar edición
                  _nombreController.text = usuario?.nombres ?? '';
                  _apellidoController.text = usuario?.apellidos ?? '';
                  _identificacionController.text = usuario?.identificacion ?? '';
                  _telefonoController.text = usuario?.telefono ?? '';
                }
                _editando = !_editando;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar y nombre
            CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFF09855E),
              child: Icon(
                usuario?.sexo == 'M' ? Icons.person : Icons.person_outline,
                size: 60,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            
            if (!_editando) ...[
              Text(
                usuario?.nombreCompleto ?? 'Usuario',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF09855E),
                ),
              ),
              SizedBox(height: 8),
              
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF09855E).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  usuario?.rol ?? 'ESTUDIANTE',
                  style: TextStyle(
                    color: Color(0xFF09855E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              SizedBox(height: 30),
              
              // Información del usuario (modo lectura)
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    _buildInfoTile(
                      Icons.email,
                      'Correo',
                      usuario?.correo ?? 'No disponible',
                    ),
                    Divider(height: 1),
                    _buildInfoTile(
                      Icons.badge,
                      'Identificación',
                      identificacion,
                    ),
                    Divider(height: 1),
                    _buildInfoTile(
                      Icons.phone,
                      'Teléfono',
                      telefono,
                    ),
                    Divider(height: 1),
                    _buildInfoTile(
                      Icons.wc,
                      'Sexo',
                      usuario?.sexo == 'M' ? 'Masculino' : usuario?.sexo == 'F' ? 'Femenino' : 'No especificado',
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Formulario de edición
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Editar Perfil',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF09855E),
                          ),
                        ),
                        SizedBox(height: 20),
                        
                        TextFormField(
                          controller: _nombreController,
                          decoration: InputDecoration(
                            labelText: 'Nombres',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person, color: Color(0xFF09855E)),
                          ),
                          validator: (value) => value?.isEmpty ?? true ? 'Ingrese el nombre' : null,
                        ),
                        SizedBox(height: 16),
                        
                        TextFormField(
                          controller: _apellidoController,
                          decoration: InputDecoration(
                            labelText: 'Apellidos',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person_outline, color: Color(0xFF09855E)),
                          ),
                          validator: (value) => value?.isEmpty ?? true ? 'Ingrese los apellidos' : null,
                        ),
                        SizedBox(height: 16),
                        
                        TextFormField(
                          controller: _identificacionController,
                          decoration: InputDecoration(
                            labelText: 'Identificación',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.badge, color: Color(0xFF09855E)),
                          ),
                          validator: (value) => value?.isEmpty ?? true ? 'Ingrese la identificación' : null,
                        ),
                        SizedBox(height: 16),
                        
                        TextFormField(
                          controller: _telefonoController,
                          decoration: InputDecoration(
                            labelText: 'Teléfono',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone, color: Color(0xFF09855E)),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) => value?.isEmpty ?? true ? 'Ingrese el teléfono' : null,
                        ),
                        SizedBox(height: 20),
                        
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _guardarCambios,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF09855E),
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text('Guardar Cambios', style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF09855E)),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  void _guardarCambios() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final usuario = authProvider.usuario;
    
    if (usuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Usuario no encontrado'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Mostrar loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(color: Color(0xFF09855E)),
      ),
    );

    // Importar el servicio
    final estudianteService = EstudianteService();
    
    // Llamar al backend
    final result = await estudianteService.actualizarEstudiante(
      usuario.codEstudiante,
      {
        'nombres': _nombreController.text,
        'apellidos': _apellidoController.text,
        'identificacion': _identificacionController.text,
        'telefono': _telefonoController.text,
      },
    );

    // Cerrar loading
    Navigator.pop(context);

    if (result['success']) {
      // Actualizar el usuario en el provider
      final usuarioActualizado = Usuario.fromJson(result['data']);
      await authProvider.updateUsuario(usuarioActualizado);
      
      setState(() => _editando = false);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Perfil actualizado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Error al actualizar perfil'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _identificacionController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }
}
