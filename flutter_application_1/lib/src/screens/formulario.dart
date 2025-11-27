import 'package:flutter/material.dart';
import '../models/curso.dart';
import '../services/curso_service.dart';
import '../services/auth_service.dart';

class Formulario extends StatefulWidget {
  const Formulario({super.key});
  
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Variables para registro de cursos
  final _formKeyCurso = GlobalKey<FormState>();
  final _codigoCursoController = TextEditingController();
  final _nombreCursoController = TextEditingController();
  final _descripcionCursoController = TextEditingController();
  final _creditosController = TextEditingController(text: '3');
  final _semestreController = TextEditingController();
  final _cupoMaximoController = TextEditingController(text: '30');
  
  // Variables para inscripción de usuarios
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _correoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _identificacionController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _mostrarPassword = false;
  String _sexoSeleccionado = 'M';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text('Inscripciones'),
        backgroundColor: Color(0xFF09855E),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Registrar Curso'),
            Tab(icon: Icon(Icons.person_add), text: 'Registrar Usuario'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRegistroCurso(),
          _buildInscripcionUsuarios(),
        ],
      ),
    );
  }

  // TAB 1: Registro de Curso
  Widget _buildRegistroCurso() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKeyCurso,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Registro de Nuevo Curso',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF09855E),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                
                TextFormField(
                  controller: _codigoCursoController,
                  decoration: InputDecoration(
                    labelText: "Código del Curso",
                    hintText: "Ej: MAT101",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.tag, color: Color(0xFF09855E)),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? "Ingrese el código" : null,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  controller: _nombreCursoController,
                  decoration: InputDecoration(
                    labelText: "Nombre del Curso",
                    hintText: "Ej: Matemáticas Básicas",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.book, color: Color(0xFF09855E)),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? "Ingrese el nombre" : null,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  controller: _descripcionCursoController,
                  decoration: InputDecoration(
                    labelText: "Descripción",
                    hintText: "Descripción del curso",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description, color: Color(0xFF09855E)),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _creditosController,
                        decoration: InputDecoration(
                          labelText: "Créditos",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.credit_card, color: Color(0xFF09855E)),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) => value?.isEmpty ?? true ? "Ingrese créditos" : null,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _semestreController,
                        decoration: InputDecoration(
                          labelText: "Semestre",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF09855E)),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) => value?.isEmpty ?? true ? "Ingrese semestre" : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  controller: _cupoMaximoController,
                  decoration: InputDecoration(
                    labelText: "Cupo Máximo",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.people, color: Color(0xFF09855E)),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value?.isEmpty ?? true ? "Ingrese cupo máximo" : null,
                ),
                SizedBox(height: 24),
                
                ElevatedButton.icon(
                  onPressed: _registrarCurso,
                  icon: Icon(Icons.save),
                  label: Text('Registrar Curso', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF09855E),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TAB 2: Inscripción de Usuarios (igual que antes)
  Widget _buildInscripcionUsuarios() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Registro de Nuevo Usuario',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF09855E),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                
                TextFormField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                    labelText: "Nombres",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: Color(0xFF09855E)),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? "Ingrese el nombre" : null,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  controller: _apellidoController,
                  decoration: InputDecoration(
                    labelText: "Apellidos",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline, color: Color(0xFF09855E)),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? "Ingrese los apellidos" : null,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  controller: _identificacionController,
                  decoration: InputDecoration(
                    labelText: "Identificación",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.badge, color: Color(0xFF09855E)),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? "Ingrese la identificación" : null,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  controller: _correoController,
                  decoration: InputDecoration(
                    labelText: "Correo electrónico",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email, color: Color(0xFF09855E)),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) return "Ingrese el correo";
                    if (!value!.contains("@")) return "Correo inválido";
                    return null;
                  },
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  controller: _telefonoController,
                  decoration: InputDecoration(
                    labelText: "Teléfono",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone, color: Color(0xFF09855E)),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value?.isEmpty ?? true ? "Ingrese el teléfono" : null,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF09855E)),
                    suffixIcon: IconButton(
                      icon: Icon(_mostrarPassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _mostrarPassword = !_mostrarPassword),
                    ),
                  ),
                  obscureText: !_mostrarPassword,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return "Ingrese la contraseña";
                    if (value!.length < 6) return "Mínimo 6 caracteres";
                    return null;
                  },
                ),
                SizedBox(height: 16),
                
                DropdownButtonFormField<String>(
                  value: _sexoSeleccionado,
                  decoration: InputDecoration(
                    labelText: "Sexo",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.wc, color: Color(0xFF09855E)),
                  ),
                  items: [
                    DropdownMenuItem(value: 'M', child: Text('Masculino')),
                    DropdownMenuItem(value: 'F', child: Text('Femenino')),
                  ],
                  onChanged: (value) => setState(() => _sexoSeleccionado = value!),
                ),
                SizedBox(height: 24),
                
                ElevatedButton.icon(
                  onPressed: _registrarUsuario,
                  icon: Icon(Icons.person_add),
                  label: Text('Registrar Usuario', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF09855E),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _registrarCurso() async {
    if (!_formKeyCurso.currentState!.validate()) return;

    final cursoService = CursoService();
    
    // Mostrar loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(color: Color(0xFF09855E)),
      ),
    );

    final cupoMaximo = int.tryParse(_cupoMaximoController.text) ?? 30;
    
    final nuevoCurso = Curso(
      idCurso: 0, // Se genera automáticamente
      codigoCurso: _codigoCursoController.text,
      nombreCurso: _nombreCursoController.text,
      descripcion: _descripcionCursoController.text,
      creditos: int.tryParse(_creditosController.text) ?? 3,
      semestre: int.tryParse(_semestreController.text),
      cupoMaximo: cupoMaximo,
      cupoDisponible: cupoMaximo, // Inicialmente igual al máximo
      estado: 'ACTIVO',
    );

    final result = await cursoService.crearCurso(nuevoCurso);

    // Cerrar loading
    Navigator.pop(context);

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Curso registrado exitosamente!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Limpiar formulario
      _formKeyCurso.currentState!.reset();
      _codigoCursoController.clear();
      _nombreCursoController.clear();
      _descripcionCursoController.clear();
      _creditosController.text = '3';
      _semestreController.clear();
      _cupoMaximoController.text = '30';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Error al registrar curso'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _registrarUsuario() async {
    if (!_formKey.currentState!.validate()) return;

    final authService = AuthService();
    
    // Mostrar loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(color: Color(0xFF09855E)),
      ),
    );
    
    final result = await authService.register({
      'identificacion': _identificacionController.text,
      'nombres': _nombreController.text,
      'apellidos': _apellidoController.text,
      'telefono': _telefonoController.text,
      'correo': _correoController.text,
      'password': _passwordController.text,
      'sexo': _sexoSeleccionado,
    });

    // Cerrar loading
    Navigator.pop(context);

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario registrado exitosamente'), backgroundColor: Colors.green),
      );
      _formKey.currentState!.reset();
      _nombreController.clear();
      _apellidoController.clear();
      _identificacionController.clear();
      _correoController.clear();
      _telefonoController.clear();
      _passwordController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message']), backgroundColor: Colors.red),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _codigoCursoController.dispose();
    _nombreCursoController.dispose();
    _descripcionCursoController.dispose();
    _creditosController.dispose();
    _semestreController.dispose();
    _cupoMaximoController.dispose();
    _nombreController.dispose();
    _apellidoController.dispose();
    _correoController.dispose();
    _telefonoController.dispose();
    _identificacionController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
