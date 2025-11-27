import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login.dart';

class Configuracion extends StatefulWidget {
  @override
  _ConfiguracionState createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  bool _notificaciones = true;
  bool _modoOscuro = false;
  double _tamanoTexto = 14.0;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
        backgroundColor: Color(0xFF09855E),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Sección: Notificaciones
          Text(
            'Notificaciones',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF09855E),
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: SwitchListTile(
              title: Text('Activar notificaciones'),
              subtitle: Text('Recibir alertas de tareas y cursos'),
              value: _notificaciones,
              activeColor: Color(0xFF09855E),
              onChanged: (value) {
                setState(() => _notificaciones = value);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value ? 'Notificaciones activadas' : 'Notificaciones desactivadas',
                    ),
                  ),
                );
              },
              secondary: Icon(Icons.notifications, color: Color(0xFF09855E)),
            ),
          ),
          
          SizedBox(height: 20),
          
          // Sección: Apariencia
          Text(
            'Apariencia',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF09855E),
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('Modo oscuro'),
                  subtitle: Text('Cambiar tema de la aplicación'),
                  value: _modoOscuro,
                  activeColor: Color(0xFF09855E),
                  onChanged: (value) {
                    setState(() => _modoOscuro = value);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Función próximamente disponible'),
                      ),
                    );
                  },
                  secondary: Icon(Icons.dark_mode, color: Color(0xFF09855E)),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.text_fields, color: Color(0xFF09855E)),
                  title: Text('Tamaño de texto'),
                  subtitle: Slider(
                    value: _tamanoTexto,
                    min: 12.0,
                    max: 20.0,
                    divisions: 4,
                    activeColor: Color(0xFF09855E),
                    label: _tamanoTexto.round().toString(),
                    onChanged: (value) {
                      setState(() => _tamanoTexto = value);
                    },
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 20),
          
          // Sección: Cuenta
          Text(
            'Cuenta',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF09855E),
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.lock, color: Color(0xFF09855E)),
                  title: Text('Cambiar contraseña'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Función próximamente disponible'),
                      ),
                    );
                  },
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.language, color: Color(0xFF09855E)),
                  title: Text('Idioma'),
                  subtitle: Text('Español'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Función próximamente disponible'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          
          SizedBox(height: 20),
          
          // Sección: Acerca de
          Text(
            'Acerca de',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF09855E),
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.info, color: Color(0xFF09855E)),
                  title: Text('Versión'),
                  subtitle: Text('4.0.0'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.help, color: Color(0xFF09855E)),
                  title: Text('Ayuda y soporte'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Contactar a soporte@eduplatform.com'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          
          SizedBox(height: 30),
          
          // Botón Cerrar Sesión
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
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
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false,
                  );
                }
              },
              icon: Icon(Icons.logout),
              label: Text('Cerrar Sesión'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
