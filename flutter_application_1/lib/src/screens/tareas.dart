import 'package:flutter/material.dart';
import '../models/curso.dart';
import '../services/curso_service.dart';

class Tareas extends StatefulWidget {
  @override
  _TareasState createState() => _TareasState();
}

class _TareasState extends State<Tareas> {
  final CursoService _cursoService = CursoService();
  List<Curso> _cursos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarCursos();
  }

  Future<void> _cargarCursos() async {
    setState(() => _isLoading = true);
    final cursos = await _cursoService.getCursos();
    setState(() {
      _cursos = cursos;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color verdeOscuro = Color(0xFF09855E);
    final Color fondoClaro = Color(0xFFF8FAFC);

    return Scaffold(
      backgroundColor: fondoClaro,
      appBar: AppBar(
        title: Text(
          "Lista de Cursos",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: verdeOscuro,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _cargarCursos,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Estadísticas
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildEstadistica(
                    'Total',
                    '${_cursos.length}',
                    Icons.school,
                    verdeOscuro,
                  ),
                  _buildEstadistica(
                    'Activos',
                    '${_cursos.where((c) => c.estado == 'ACTIVO').length}',
                    Icons.check_circle,
                    Colors.green,
                  ),
                  _buildEstadistica(
                    'Con Cupos',
                    '${_cursos.where((c) => (c.cupoDisponible ?? 0) > 0).length}',
                    Icons.event_seat,
                    Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            
            // Lista de cursos (ListView.builder)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: _isLoading
                    ? Center(child: CircularProgressIndicator(color: verdeOscuro))
                    : _cursos.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.school_outlined,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "¡No hay cursos disponibles!",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Los cursos aparecerán aquí",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.all(8),
                            itemCount: _cursos.length,
                            itemBuilder: (context, index) {
                              final curso = _cursos[index];
                              final cupoDisponible = curso.cupoDisponible ?? 0;
                              final cupoMaximo = curso.cupoMaximo ?? 30;
                              final tieneCupos = cupoDisponible > 0;

                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(16),
                                  leading: CircleAvatar(
                                    backgroundColor: verdeOscuro.withOpacity(0.1),
                                    child: Text(
                                      '${curso.creditos ?? 3}',
                                      style: TextStyle(
                                        color: verdeOscuro,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    curso.nombreCurso,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: verdeOscuro,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 4),
                                      Text(
                                        'Código: ${curso.codigoCurso}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.event_seat, size: 12, color: Colors.grey),
                                          SizedBox(width: 4),
                                          Text(
                                            'Cupos: $cupoDisponible/$cupoMaximo',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: tieneCupos ? Colors.green : Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                                          SizedBox(width: 4),
                                          Text(
                                            'Sem. ${curso.semestre ?? 'N/A'}',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: curso.estado == 'ACTIVO' 
                                          ? Colors.green.withOpacity(0.1)
                                          : Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      curso.estado ?? 'ACTIVO',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: curso.estado == 'ACTIVO' ? Colors.green : Colors.grey,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    _mostrarDetallesCurso(curso);
                                  },
                                ),
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstadistica(String label, String valor, IconData icono, Color color) {
    return Column(
      children: [
        Icon(icono, color: color, size: 28),
        SizedBox(height: 4),
        Text(
          valor,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  void _mostrarDetallesCurso(Curso curso) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(curso.nombreCurso),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Código: ${curso.codigoCurso}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            if (curso.descripcion != null && curso.descripcion!.isNotEmpty)
              Text(curso.descripcion!),
            SizedBox(height: 8),
            Text('Créditos: ${curso.creditos ?? 3}'),
            Text('Semestre: ${curso.semestre ?? 'N/A'}'),
            Text('Cupos: ${curso.cupoDisponible}/${curso.cupoMaximo}'),
            Text('Estado: ${curso.estado ?? 'ACTIVO'}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
