import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Estudiantes extends StatefulWidget {
  @override
  _EstudiantesState createState() => _EstudiantesState();
}

class _EstudiantesState extends State<Estudiantes> {
  List<dynamic> estudiantes = [];
  bool loading = false;

  Future<void> obtenerEstudiantes() async {
    setState(() {
      loading = true;
    });
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8081/api/estudiantes'),
      );
      if (response.statusCode == 200) {
        setState(() {
          estudiantes = json.decode(response.body);
        });
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cargar estudiantes: $e'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Lista de Estudiantes',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 9, 133, 94),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: loading ? null : obtenerEstudiantes,
              icon: loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.school, size: 20),
              label: Text(
                'Cargar Estudiantes',
                style: const TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 9, 133, 94),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
              ),
            ),
          ),
          Expanded(
            child: estudiantes.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No hay estudiantes cargados',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Presiona el botón para cargar la lista',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: estudiantes.length,
                    itemBuilder: (context, index) {
                      var est = estudiantes[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          leading: CircleAvatar(
                            backgroundColor: est['sexo'] == 'M'
                                ? Colors.blue[300]
                                : Colors.pink[300],
                            child: Icon(
                              est['sexo'] == 'M' ? Icons.male : Icons.female,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            '${est['nombres'] ?? ''} ${est['apellidos'] ?? ''}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                'Cédula: ${est['identificacion'] ?? 'N/A'}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text(
                                'Teléfono: ${est['telefono'] ?? 'N/A'}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          trailing: Chip(
                            label: Text(
                              est['sexo'] ?? '',
                              style: const TextStyle(fontSize: 12),
                            ),
                            backgroundColor: est['sexo'] == 'M'
                                ? Colors.blue[100]
                                : Colors.pink[100],
                            labelStyle: TextStyle(
                              color: est['sexo'] == 'M'
                                  ? Colors.blue[800]
                                  : Colors.pink[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
