# 🎓 EduPlatform - Plataforma Educativa Móvil

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-6DB33F?style=for-the-badge&logo=spring-boot&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

**Aplicación móvil educativa completa con gestión de cursos, tareas y materiales**

[Características](#características) • [Instalación](#instalación) • [Uso](#uso) • [Documentación](#documentación)

</div>

---

## 📋 Tabla de Contenidos

- [Descripción](#descripción)
- [Características](#características)
- [Tecnologías](#tecnologías)
- [Arquitectura](#arquitectura)
- [Instalación](#instalación)
- [Configuración](#configuración)
- [Uso](#uso)
- [API Endpoints](#api-endpoints)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Temas Implementados](#temas-implementados)
- [Capturas de Pantalla](#capturas-de-pantalla)
- [Contribuir](#contribuir)
- [Licencia](#licencia)

---

## 📖 Descripción

**EduPlatform** es una aplicación móvil educativa desarrollada con Flutter y Spring Boot que permite la gestión integral de cursos, tareas académicas y materiales educativos. El proyecto implementa una arquitectura cliente-servidor con autenticación JWT y operaciones CRUD completas.

### 🎯 Objetivo del Proyecto

Demostrar el dominio de conceptos fundamentales de desarrollo móvil con Flutter, incluyendo:
- Widgets básicos y avanzados
- Navegación entre pantallas
- Formularios con validación
- Listas dinámicas
- Manejo de estados (StatefulWidget y Provider)
- Consumo de APIs REST
- Integración con bases de datos

---

## ✨ Características

### 👤 **Gestión de Usuarios**
- ✅ Registro de nuevos usuarios
- ✅ Autenticación con JWT
- ✅ Perfiles de usuario editables
- ✅ Roles (Estudiante, Docente, Admin)
- ✅ Directorio de contactos

### 📚 **Gestión de Cursos**
- ✅ Registro de nuevos cursos
- ✅ Listado de cursos disponibles
- ✅ Información detallada (créditos, cupos, semestre)
- ✅ Control de cupos disponibles
- ✅ Filtrado por estado

### 📝 **Gestión de Tareas**
- ✅ Visualización de tareas académicas
- ✅ Filtros (Todas, Activas, Vencidas)
- ✅ Indicadores de urgencia
- ✅ Contador de días restantes
- ✅ Detalles de entregas

### 🛒 **Tienda de Materiales**
- ✅ Catálogo de materiales educativos
- ✅ Búsqueda en tiempo real
- ✅ Filtros por categoría
- ✅ Control de stock
- ✅ Carrito de compras (simulado)

### 🎨 **Interfaz de Usuario**
- ✅ Diseño moderno y consistente
- ✅ Tema de colores personalizado (#09855E)
- ✅ Navegación fluida con Drawer
- ✅ Animaciones y transiciones
- ✅ Responsive design

---

## 🛠️ Tecnologías

### **Frontend**
- **Flutter** 3.x - Framework de desarrollo móvil
- **Dart** - Lenguaje de programación
- **Provider** - Manejo de estado
- **HTTP** - Consumo de APIs
- **Flutter Secure Storage** - Almacenamiento seguro

### **Backend**
- **Spring Boot** 3.x - Framework Java
- **Spring Security** - Autenticación y autorización
- **JWT** - Tokens de autenticación
- **JPA/Hibernate** - ORM
- **MySQL** - Base de datos relacional

### **Herramientas**
- **Maven** - Gestión de dependencias (Backend)
- **Git** - Control de versiones
- **XAMPP** - Servidor MySQL local
- **Postman** - Testing de APIs

---

## 🏗️ Arquitectura

```
┌─────────────────────────────────────────────────────────┐
│                    FLUTTER APP                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │
│  │   Screens    │  │   Widgets    │  │   Models     │ │
│  └──────────────┘  └──────────────┘  └──────────────┘ │
│  ┌──────────────┐  ┌──────────────┐                   │
│  │   Services   │  │   Providers  │                   │
│  └──────────────┘  └──────────────┘                   │
└─────────────────────────────────────────────────────────┘
                          │
                          │ HTTP/REST
                          ▼
┌─────────────────────────────────────────────────────────┐
│                  SPRING BOOT API                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │
│  │ Controllers  │  │  Services    │  │ Repositories │ │
│  └──────────────┘  └──────────────┘  └──────────────┘ │
│  ┌──────────────┐  ┌──────────────┐                   │
│  │   Security   │  │     DTOs     │                   │
│  └──────────────┘  └──────────────┘                   │
└─────────────────────────────────────────────────────────┘
                          │
                          │ JPA/Hibernate
                          ▼
┌─────────────────────────────────────────────────────────┐
│                    MySQL DATABASE                       │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │
│  │ estudiantes  │  │    cursos    │  │    tareas    │ │
│  └──────────────┘  └──────────────┘  └──────────────┘ │
│  ┌──────────────┐                                      │
│  │  materiales  │                                      │
│  └──────────────┘                                      │
└─────────────────────────────────────────────────────────┘
```

---

## 📦 Instalación

### **Prerrequisitos**

- **Flutter SDK** >= 3.0.0
- **Java JDK** >= 17
- **Maven** >= 3.8
- **MySQL** >= 8.0
- **Git**

### **1. Clonar el Repositorio**

```bash
git clone https://github.com/FabianXF/flutter_conceptos.git
cd flutter_conceptos
```

### **2. Configurar Base de Datos**

```bash
# Iniciar MySQL (XAMPP o servicio)
# Crear base de datos
mysql -u root -p

CREATE DATABASE estudiante_db;
USE estudiante_db;

# Importar schema
source prueba.sql;
```

### **3. Configurar Backend**

```bash
cd Api_java/estudianteApi

# Editar application.properties si es necesario
# src/main/resources/application.properties

# Compilar y ejecutar
./mvnw spring-boot:run
```

El backend estará disponible en `http://localhost:8081`

### **4. Configurar Frontend**

```bash
cd flutter_application_1

# Instalar dependencias
flutter pub get

# Ejecutar en Windows
flutter run -d windows

# O en Android/iOS
flutter run
```

---

## ⚙️ Configuración

### **Backend (application.properties)**

```properties
spring.application.name=estudianteApi
server.port=8081

# MySQL Configuration
spring.datasource.url=jdbc:mysql://localhost:3306/estudiante_db
spring.datasource.username=root
spring.datasource.password=

# JPA Configuration
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

# JWT Configuration
jwt.secret=tu_clave_secreta_muy_segura_aqui
jwt.expiration=86400000
```

### **Frontend (Services)**

Los servicios están configurados para conectarse a `http://localhost:8081/api`

Si necesitas cambiar la URL, edita:
- `lib/src/services/auth_service.dart`
- `lib/src/services/curso_service.dart`
- `lib/src/services/tarea_service.dart`
- `lib/src/services/material_service.dart`
- `lib/src/services/estudiante_service.dart`

---

## 🚀 Uso

### **Credenciales de Prueba**

#### **Estudiantes** (password: `12345`)
- `carlos.garcia@example.com`
- `laura.gomez@example.com`
- `felipe.sanchez@example.com`

#### **Docentes** (password: `12345`)
- `maria.gonzalez@universidad.edu`
- `carlos.rodriguez@universidad.edu`

#### **Admin** (password: `admin123`)
- `admin@universidad.edu`

### **Flujo de Uso**

1. **Login**: Inicia sesión con cualquier credencial
2. **Explorar**: Navega por el menú lateral (Drawer)
3. **Cursos**: Registra nuevos cursos o visualiza existentes
4. **Tareas**: Consulta tareas académicas con filtros
5. **Tienda**: Busca y agrega materiales al carrito
6. **Perfil**: Edita tu información personal
7. **Configuración**: Ajusta preferencias de la app

---

## 🔌 API Endpoints

### **Autenticación**
```
POST   /api/auth/register    - Registrar nuevo usuario
POST   /api/auth/login       - Iniciar sesión
```

### **Estudiantes**
```
GET    /api/estudiantes      - Listar todos
GET    /api/estudiantes/{id} - Obtener por ID
PUT    /api/estudiantes/{id} - Actualizar estudiante
```

### **Cursos**
```
GET    /api/cursos           - Listar todos
GET    /api/cursos/{id}      - Obtener por ID
GET    /api/cursos/activos   - Listar activos
POST   /api/cursos           - Crear curso
PUT    /api/cursos/{id}      - Actualizar curso
DELETE /api/cursos/{id}      - Eliminar curso
```

### **Tareas**
```
GET    /api/tareas           - Listar todas
GET    /api/tareas/{id}      - Obtener por ID
GET    /api/tareas/activas   - Listar activas
GET    /api/tareas/curso/{id}- Por curso
POST   /api/tareas           - Crear tarea
PUT    /api/tareas/{id}      - Actualizar tarea
DELETE /api/tareas/{id}      - Eliminar tarea
```

### **Materiales**
```
GET    /api/materiales                - Listar todos
GET    /api/materiales/{id}           - Obtener por ID
GET    /api/materiales/disponibles    - Disponibles
GET    /api/materiales/categoria/{cat}- Por categoría
GET    /api/materiales/buscar?nombre= - Buscar
POST   /api/materiales                - Crear material
PUT    /api/materiales/{id}           - Actualizar material
DELETE /api/materiales/{id}           - Eliminar material
```

---

## 📁 Estructura del Proyecto

```
Proyecto_final_mobiles/
├── Api_java/
│   └── estudianteApi/
│       ├── src/main/java/com/example/estudianteApi/
│       │   ├── controller/      # Controladores REST
│       │   ├── Entidad/         # Entidades JPA
│       │   ├── repository/      # Repositorios
│       │   ├── security/        # Configuración JWT
│       │   └── dto/             # Data Transfer Objects
│       └── src/main/resources/
│           └── application.properties
│
├── flutter_application_1/
│   └── lib/
│       └── src/
│           ├── models/          # Modelos de datos
│           ├── providers/       # Providers (estado)
│           ├── screens/         # Pantallas de la app
│           ├── services/        # Servicios HTTP
│           └── main.dart        # Punto de entrada
│
├── prueba.sql                   # Schema de base de datos
├── README.md                    # Este archivo
├── GUIA_ESTUDIO_TEMAS.md       # Guía de temas implementados
└── ANALISIS_BASE_DATOS.md      # Análisis de BD
```

---

## 📚 Temas Implementados

### **1. Widgets Básicos**
- ✅ StatelessWidget / StatefulWidget
- ✅ Container, Row, Column
- ✅ Image, Text
- ✅ Card, ListTile

### **2. Navegación**
- ✅ Scaffold
- ✅ AppBar
- ✅ Drawer
- ✅ Navigator.push/pop

### **3. Formularios**
- ✅ Form + GlobalKey
- ✅ TextFormField
- ✅ Validación
- ✅ DropdownButtonFormField

### **4. Listas**
- ✅ ListView.builder
- ✅ ListView.separated
- ✅ RefreshIndicator

### **5. Manejo de Estados**
- ✅ StatefulWidget + setState
- ✅ Provider (estado global)
- ✅ ChangeNotifier

### **6. APIs y Base de Datos**
- ✅ HTTP requests (GET, POST, PUT, DELETE)
- ✅ JSON serialization (fromJson/toJson)
- ✅ Modelos de datos
- ✅ Servicios REST

**Ver documentación completa**: [GUIA_ESTUDIO_TEMAS.md](GUIA_ESTUDIO_TEMAS.md)

---

## 📸 Capturas de Pantalla

### Login
Pantalla de autenticación con validación de formularios.

### Inicio
Dashboard principal con navegación por Drawer.

### Cursos
Registro y visualización de cursos con información detallada.

### Tareas
Lista de tareas con filtros y contador de días restantes.

### Tienda
Catálogo de materiales con búsqueda y filtros.

### Perfil
Información del usuario con edición funcional.

---

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📄 Licencia

Este proyecto es de código abierto y está disponible bajo la [MIT License](LICENSE).

---

## 👥 Autores

- **Tu Nombre** - *Desarrollo completo* - [GitHub](https://github.com/tu-usuario)

---

## 🙏 Agradecimientos

- Universidad por el apoyo académico
- Comunidad Flutter por la documentación
- Spring Boot por el framework robusto


---

