import 'package:flutter/material.dart';
import '../models/material.dart' as model;
import '../services/material_service.dart';

class Tienda extends StatefulWidget {
  @override
  _stateTienda createState() => _stateTienda();
}

class _stateTienda extends State<Tienda> {
  final MaterialService _materialService = MaterialService();
  List<model.Material> _materiales = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarMateriales();
  }

  Future<void> _cargarMateriales() async {
    setState(() => _isLoading = true);
    final materiales = await _materialService.getMaterialesDisponibles();
    setState(() {
      _materiales = materiales;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tienda de Materiales'),
        backgroundColor: Color(0xFF09855E),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _cargarMateriales,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF09855E)))
          : _materiales.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No hay materiales disponibles', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : Column(
                  children: [
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: _materiales.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1, color: Colors.grey),
                        itemBuilder: (context, index) {
                          var material = _materiales[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Imagen/Icono
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Color(0xFF09855E).withOpacity(0.1),
                                    ),
                                    child: Icon(
                                      _getIconoCategoria(material.categoria),
                                      color: Color(0xFF09855E),
                                      size: 40,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                
                                // Información
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Nombre
                                        Text(
                                          material.nombre,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        
                                        // Precio
                                        Text(
                                          material.precioFormateado,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF09855E),
                                            height: 1.2,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        
                                        // Stock
                                        Text(
                                          'Stock: ${material.stock ?? 0}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        
                                        // Botón Agregar
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: material.estaDisponible
                                                ? () {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          '${material.nombre} agregado al carrito!',
                                                        ),
                                                        backgroundColor: Colors.green,
                                                      ),
                                                    );
                                                  }
                                                : null,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xFF09855E),
                                              foregroundColor: Colors.white,
                                              padding: const EdgeInsets.symmetric(vertical: 8),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              elevation: 0,
                                            ),
                                            child: const Text(
                                              'Agregar al Carrito',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  IconData _getIconoCategoria(String? categoria) {
    switch (categoria?.toLowerCase()) {
      case 'libros':
        return Icons.menu_book;
      case 'equipos':
        return Icons.computer;
      case 'accesorios':
        return Icons.devices_other;
      case 'cursos':
        return Icons.school;
      default:
        return Icons.shopping_bag;
    }
  }
}
