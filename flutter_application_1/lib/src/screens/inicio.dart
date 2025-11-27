import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/src/providers/auth_provider.dart';
import 'package:flutter_application_1/src/screens/perfil.dart';
import 'package:flutter_application_1/src/screens/formulario.dart';
import 'package:flutter_application_1/src/screens/contactos.dart';
import 'package:flutter_application_1/src/screens/tareas.dart';
import 'package:flutter_application_1/src/screens/estudiantes.dart';
import 'package:flutter_application_1/src/screens/tienda.dart';
import 'package:flutter_application_1/src/screens/configuracion.dart';
import 'package:flutter_application_1/src/screens/login.dart';

class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final usuario = authProvider.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text('EduPlatform'),
        backgroundColor: Color(0xFF09855E),
        actions: [
          // Botón de logout
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Cerrar Sesión'),
                  content: Text('¿Estás seguro que deseas cerrar sesión?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text('Cerrar Sesión'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await authProvider.logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login()),
                );
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF09855E),
                    Color(0xFF0A6B4D),
                  ],
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,

                    backgroundImage: AssetImage('assets/Emogi.jpg'),
                    backgroundColor: Colors.white,
  
                  ),
                  SizedBox(height: 12),
                  Text(
                    usuario?.nombreCompleto ?? 'Usuario',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    usuario?.correo ?? '',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      usuario?.rol ?? 'ESTUDIANTE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Color(0xFF09855E)),
              title: Text('Mi Perfil'),
              subtitle: Text('Ver y editar información'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Perfil()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.assignment_add, color: Color(0xFF09855E)),
              title: Text('Registros de cursos y usuarios'),
              subtitle: Text('Formulario de Registros'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Formulario()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_page, color: Color(0xFF09855E)),
              title: Text('Directorio'),
              subtitle: Text('Compañeros y profesores'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Contactos()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment, color: Color(0xFF09855E)),
              title: Text('Tareas Académicas'),
              subtitle: Text('Gestión de tareas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Tareas()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.storage, color: Color(0xFF09855E)),
              title: Text('Base de Datos'),
              subtitle: Text('Listado de estudiantes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Estudiantes()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag, color: Color(0xFF09855E)),
              title: Text('Tienda Educativa'),
              subtitle: Text('Materiales y recursos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Tienda()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings, color: Color(0xFF09855E)),
              title: Text('Configuración'),
              subtitle: Text('Preferencias de la app'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Configuracion()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFF0F9F6),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icono principal
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Color(0xFF09855E),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF09855E).withOpacity(0.3),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.school,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),

                // Bienvenida
                Text(
                  '¡Bienvenido/a!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF09855E),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  usuario?.nombreCompleto ?? 'Usuario',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),

                // Tarjeta de información
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 50,
                        color: Color(0xFF09855E),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'EduPlatform',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF09855E),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Plataforma Educativa Completa',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      SizedBox(height: 16),
                      Text(
                        'Usa el menú lateral para navegar entre las diferentes secciones del sistema.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildInfoChip(Icons.person, 'Perfil'),
                          SizedBox(width: 10),
                          _buildInfoChip(Icons.assignment, 'Tareas'),
                          SizedBox(width: 10),
                          _buildInfoChip(Icons.shopping_bag, 'Tienda'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF09855E).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Color(0xFF09855E)),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF09855E),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
