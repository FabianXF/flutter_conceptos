import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Contactos extends StatefulWidget {
  @override
  _ContactosState createState() => _ContactosState();
}

class _ContactosState extends State<Contactos> {
  List<dynamic> estudiantes = [];
  bool loading = false;

  Future<void> obtenerEstudiantes() async {
    setState(() => loading = true);
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8081/api/estudiantes'),
      );
      if (response.statusCode == 200) {
        setState(() {
          estudiantes = json.decode(response.body);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cargar contactos: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    obtenerEstudiantes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Directorio de Contactos',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF09855E),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: obtenerEstudiantes,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF09855E)))
          : estudiantes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.contacts_outlined, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No hay contactos disponibles', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: estudiantes.length,
                  itemBuilder: (context, index) {
                    final estudiante = estudiantes[index];
                    final nombre = '${estudiante['nombres'] ?? ''} ${estudiante['apellidos'] ?? ''}'.trim();
                    final telefono = estudiante['telefono'] ?? 'Sin teléfono';
                    final correo = estudiante['correo'] ?? '';
                    final sexo = estudiante['sexo'] ?? 'M';

                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0xFF09855E),
                          child: Icon(
                            sexo == 'M' ? Icons.person : Icons.person_outline,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        title: Text(
                          nombre.isNotEmpty ? nombre : 'Sin nombre',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 16, color: Color(0xFF09855E)),
                                SizedBox(width: 4),
                                Text(
                                  telefono,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            if (correo.isNotEmpty) ...[
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Icon(Icons.email, size: 14, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      correo,
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.phone_in_talk, color: Color(0xFF09855E)),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Llamar a $telefono'),
                                backgroundColor: Color(0xFF09855E),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
