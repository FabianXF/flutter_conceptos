# 📚 GUÍA DE ESTUDIO - TEMAS FLUTTER IMPLEMENTADOS

## EduPlatform - Proyecto Final Móviles

---

## 1️⃣ **WIDGETS BÁSICOS**

### **StatelessWidget**
**Concepto**: Widget que no cambia su estado interno.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/screens/contactos.dart`
- **Líneas**: 5-7
```dart
class Contactos extends StatefulWidget {
  @override
  _ContactosState createState() => _ContactosState();
}
```

**Nota**: Aunque la mayoría de pantallas usan StatefulWidget, los widgets personalizados como `_buildInfoTile` en perfil.dart son ejemplos de widgets sin estado.

---

### **Container**
**Concepto**: Widget de caja que puede contener decoración, padding, constraints.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/screens/tareas.dart`
- **Líneas**: 48-66
```dart
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
  child: Row(...)
)
```

**Otros ejemplos**:
- `lib/src/screens/perfil.dart` (línea 89) - Container para badge de rol
- `lib/src/screens/tienda.dart` (línea 95) - Container para imagen de producto

---

### **Row**
**Concepto**: Widget que organiza sus hijos horizontalmente.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/screens/tareas.dart`
- **Líneas**: 53-75
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    _buildEstadistica('Total', '${_tareas.length}', Icons.task_alt, verdeOscuro),
    _buildEstadistica('Activas', '...', Icons.check_circle, Colors.green),
    _buildEstadistica('Vencidas', '...', Icons.error, Colors.red),
  ],
)
```

**Otros ejemplos**:
- `lib/src/screens/formulario.dart` (línea 132) - Row para Créditos y Semestre
- `lib/src/screens/contactos.dart` (línea 73) - Row para icono + teléfono

---

### **Column**
**Concepto**: Widget que organiza sus hijos verticalmente.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/screens/perfil.dart`
- **Líneas**: 42-130
```dart
Column(
  children: [
    CircleAvatar(...),
    SizedBox(height: 20),
    Text(usuario?.nombreCompleto ?? 'Usuario', ...),
    Container(...), // Badge de rol
    Card(...), // Información del usuario
  ],
)
```

**Otros ejemplos**:
- `lib/src/screens/formulario.dart` (línea 82) - Column para campos del formulario
- `lib/src/screens/tareas.dart` (línea 44) - Column principal de la pantalla

---

### **Image**
**Concepto**: Widget para mostrar imágenes.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/screens/inicio.dart`
- **Líneas**: 65-72
```dart
CircleAvatar(
  radius: 40,
  backgroundImage: AssetImage('assets/Emogi.jpg'),
  backgroundColor: Colors.white,
)
```

**Nota**: Se usa `AssetImage` para cargar imágenes locales del proyecto.

---

### **Text**
**Concepto**: Widget para mostrar texto.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/screens/login.dart`
- **Líneas**: 48-54
```dart
Text(
  'Bienvenido',
  style: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Color(0xFF09855E),
  ),
)
```

**Otros ejemplos con estilos**:
- `lib/src/screens/perfil.dart` (línea 79) - Text con estilo de título
- `lib/src/screens/tareas.dart` (línea 38) - Text en AppBar

---

## 2️⃣ **NAVEGACIÓN EN PANTALLAS**

### **Scaffold**
**Concepto**: Estructura básica de una pantalla Material Design.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/screens/inicio.dart`
- **Líneas**: 30-250
```dart
Scaffold(
  backgroundColor: Color(0xFFF8FAFC),
  appBar: AppBar(...),
  drawer: Drawer(...),
  body: SingleChildScrollView(...),
)
```

**Componentes del Scaffold**:
- `appBar`: Barra superior
- `drawer`: Menú lateral
- `body`: Contenido principal
- `backgroundColor`: Color de fondo

---

### **AppBar**
**Concepto**: Barra de aplicación superior.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/screens/tareas.dart`
- **Líneas**: 36-48
```dart
AppBar(
  title: Text(
    "Lista de Cursos",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  backgroundColor: Color(0xFF09855E),
  elevation: 0,
  centerTitle: true,
  actions: [
    IconButton(
      icon: Icon(Icons.refresh),
      onPressed: _cargarCursos,
    ),
  ],
)
```

**Propiedades importantes**:
- `title`: Título de la pantalla
- `backgroundColor`: Color de fondo
- `actions`: Botones de acción a la derecha
- `elevation`: Sombra
- `centerTitle`: Centrar el título

---

### **Drawer**
**Concepto**: Menú lateral deslizable.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/screens/inicio.dart`
- **Líneas**: 58-230
```dart
Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(...), // Encabezado con usuario
      ListTile(...), // Opción de menú 1
      ListTile(...), // Opción de menú 2
      Divider(),
      ListTile(...), // Más opciones
    ],
  ),
)
```

**Navegación desde el Drawer**:
```dart
ListTile(
  leading: Icon(Icons.school, color: Color(0xFF09855E)),
  title: Text('Lista de Cursos'),
  onTap: () {
    Navigator.pop(context); // Cierra el drawer
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Tareas()),
    );
  },
)
```

---

## 3️⃣ **FORMULARIOS**

### **Form + TextFormField**
**Concepto**: Widgets para crear formularios con validación.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/screens/formulario.dart`
- **Líneas**: 77-175

**Estructura completa**:
```dart
Form(
  key: _formKeyCurso, // GlobalKey para validación
  child: Column(
    children: [
      // Campo de texto con validación
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
      
      // Más campos...
      
      // Botón de submit
      ElevatedButton(
        onPressed: _registrarCurso,
        child: Text('Registrar Curso'),
      ),
    ],
  ),
)
```

**Validación del formulario**:
```dart
Future<void> _registrarCurso() async {
  if (!_formKeyCurso.currentState!.validate()) return;
  // Procesar datos...
}
```

**Tipos de campos implementados**:
1. **TextFormField básico** (línea 94) - Código del curso
2. **TextFormField multilinea** (línea 112) - Descripción
3. **TextFormField numérico** (línea 125) - Créditos
4. **TextFormField con toggle** (línea 263) - Contraseña con mostrar/ocultar
5. **DropdownButtonFormField** (línea 278) - Selector de sexo

---

## 4️⃣ **LISTAS EN FLUTTER**

### **ListView.builder**
**Concepto**: Lista eficiente que construye items bajo demanda.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/screens/tareas.dart`
- **Líneas**: 120-210

**Código completo**:
```dart
ListView.builder(
  padding: EdgeInsets.all(8),
  itemCount: _cursos.length, // Número de items
  itemBuilder: (context, index) {
    final curso = _cursos[index]; // Obtener item
    
    return Card(
      child: ListTile(
        leading: CircleAvatar(...),
        title: Text(curso.nombreCurso),
        subtitle: Column(...),
        trailing: Container(...),
        onTap: () => _mostrarDetallesCurso(curso),
      ),
    );
  },
)
```

**Otros ejemplos**:
- `lib/src/screens/contactos.dart` (línea 59) - Lista de contactos
- `lib/src/screens/tienda.dart` (línea 95) - Lista de materiales

---

### **ListView.separated**
**Concepto**: ListView con separadores entre items.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/screens/tienda.dart`
- **Líneas**: 95-180
```dart
ListView.separated(
  padding: const EdgeInsets.all(8.0),
  itemCount: _materiales.length,
  separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.grey),
  itemBuilder: (context, index) {
    var material = _materiales[index];
    return Container(...);
  },
)
```

---

## 5️⃣ **MANEJO DE ESTADOS**

### **StatefulWidget + setState**
**Concepto**: Widget que puede cambiar su estado y reconstruirse.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/screens/tareas.dart`
- **Líneas**: 5-28

**Estructura**:
```dart
class Tareas extends StatefulWidget {
  @override
  _TareasState createState() => _TareasState();
}

class _TareasState extends State<Tareas> {
  // Variables de estado
  List<Curso> _cursos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarCursos(); // Cargar datos al iniciar
  }

  Future<void> _cargarCursos() async {
    setState(() => _isLoading = true); // Actualizar UI
    final cursos = await _cursoService.getCursos();
    setState(() {
      _cursos = cursos; // Actualizar datos
      _isLoading = false; // Actualizar UI
    });
  }
}
```

**Cuándo usar setState**:
- Después de cargar datos de API
- Al cambiar valores de formularios
- Al actualizar listas
- Al cambiar estados visuales (loading, errores)

---

### **Provider (Manejo de estado global)**
**Concepto**: Patrón para compartir estado entre widgets.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/providers/auth_provider.dart`
- **Líneas**: 1-76

**Definición del Provider**:
```dart
class AuthProvider with ChangeNotifier {
  Usuario? _usuario;
  bool _isAuthenticated = false;

  Usuario? get usuario => _usuario;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String correo, String password) async {
    final result = await _authService.login(correo, password);
    if (result['success']) {
      _usuario = Usuario.fromJson(result['data']);
      _isAuthenticated = true;
      notifyListeners(); // Notificar cambios
    }
  }
}
```

**Uso en widgets**:
- **Archivo**: `lib/src/screens/perfil.dart`
- **Líneas**: 32-33
```dart
final authProvider = Provider.of<AuthProvider>(context);
final usuario = authProvider.usuario;
```

**Configuración en main.dart**:
```dart
ChangeNotifierProvider(
  create: (_) => AuthProvider(),
  child: MyApp(),
)
```

---

## 6️⃣ **CONFIGURACIÓN CON BASES DE DATOS**

### **Llamadas a APIs (HTTP)**
**Concepto**: Comunicación con backend REST.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/services/curso_service.dart`
- **Líneas**: 1-135

**Estructura del servicio**:
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class CursoService {
  static const String baseUrl = 'http://localhost:8081/api/cursos';

  // GET - Obtener lista
  Future<List<Curso>> getCursos() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Curso.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  // POST - Crear nuevo
  Future<Map<String, dynamic>> crearCurso(Curso curso) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(curso.toJson()),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'data': json.decode(response.body)};
      }
      return {'success': false, 'message': 'Error al crear'};
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // PUT - Actualizar
  Future<Map<String, dynamic>> actualizarCurso(int id, Curso curso) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(curso.toJson()),
    );
    // Procesar respuesta...
  }

  // DELETE - Eliminar
  Future<Map<String, dynamic>> eliminarCurso(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    // Procesar respuesta...
  }
}
```

**Otros servicios implementados**:
- `lib/src/services/auth_service.dart` - Autenticación
- `lib/src/services/tarea_service.dart` - Tareas
- `lib/src/services/material_service.dart` - Materiales
- `lib/src/services/estudiante_service.dart` - Estudiantes

---

### **Modelos de datos**
**Concepto**: Clases que representan datos de la BD.

**Implementación en el proyecto**:
- **Archivo**: `lib/src/models/curso.dart`
- **Líneas**: 1-57

**Estructura del modelo**:
```dart
class Curso {
  final int idCurso;
  final String codigoCurso;
  final String nombreCurso;
  final String? descripcion;
  final int? creditos;
  final int? semestre;
  final int? cupoMaximo;
  final int? cupoDisponible;
  final String? estado;

  Curso({
    required this.idCurso,
    required this.codigoCurso,
    required this.nombreCurso,
    this.descripcion,
    this.creditos,
    this.semestre,
    this.cupoMaximo,
    this.cupoDisponible,
    this.estado,
  });

  // Convertir JSON a objeto
  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      idCurso: json['idCurso'] ?? 0,
      codigoCurso: json['codigoCurso'] ?? '',
      nombreCurso: json['nombreCurso'] ?? '',
      descripcion: json['descripcion'],
      creditos: json['creditos'],
      semestre: json['semestre'],
      cupoMaximo: json['cupoMaximo'],
      cupoDisponible: json['cupoDisponible'],
      estado: json['estado'],
    );
  }

  // Convertir objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'idCurso': idCurso,
      'codigoCurso': codigoCurso,
      'nombreCurso': nombreCurso,
      'descripcion': descripcion,
      'creditos': creditos,
      'semestre': semestre,
      'cupoMaximo': cupoMaximo,
      'cupoDisponible': cupoDisponible,
      'estado': estado,
    };
  }
}
```

---

## 📋 **RESUMEN DE ARCHIVOS CLAVE**

### **Widgets Básicos**:
- `lib/src/screens/tareas.dart` - Container, Row, Column
- `lib/src/screens/perfil.dart` - Text con estilos
- `lib/src/screens/inicio.dart` - Image (CircleAvatar)

### **Navegación**:
- `lib/src/screens/inicio.dart` - Scaffold, AppBar, Drawer completo
- Todas las pantallas usan Navigator.push

### **Formularios**:
- `lib/src/screens/formulario.dart` - Form completo con validación
- `lib/src/screens/registro.dart` - Formulario de registro
- `lib/src/screens/perfil.dart` - Formulario de edición

### **Listas**:
- `lib/src/screens/tareas.dart` - ListView.builder
- `lib/src/screens/tienda.dart` - ListView.separated
- `lib/src/screens/contactos.dart` - ListView.builder con RefreshIndicator

### **Estados**:
- `lib/src/providers/auth_provider.dart` - Provider (estado global)
- Todas las pantallas - StatefulWidget + setState

### **APIs**:
- `lib/src/services/curso_service.dart` - Ejemplo completo de CRUD
- `lib/src/models/curso.dart` - Modelo con fromJson/toJson

---

## 🎯 **TIPS PARA LA EXPOSICIÓN**

1. **Widgets Básicos**: Mostrar `tareas.dart` líneas 48-75 (Container con Row)
2. **Navegación**: Mostrar `inicio.dart` el Drawer completo
3. **Formularios**: Mostrar `formulario.dart` el Form con validación
4. **Listas**: Mostrar `tareas.dart` el ListView.builder
5. **Estados**: Explicar Provider en `auth_provider.dart`
6. **APIs**: Mostrar `curso_service.dart` método getCursos() y crearCurso()

---

**Fecha**: 25 de Noviembre, 2025  
**Proyecto**: EduPlatform - Aplicación Educativa  
**Tecnologías**: Flutter + Spring Boot + MySQL
