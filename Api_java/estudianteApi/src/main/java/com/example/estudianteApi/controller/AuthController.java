package com.example.estudianteApi.controller;

import com.example.estudianteApi.Entidad.Estudiante;
import com.example.estudianteApi.dto.AuthResponse;
import com.example.estudianteApi.dto.LoginRequest;
import com.example.estudianteApi.repository.EstudianteRepository;
import com.example.estudianteApi.security.JwtService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")
public class AuthController {

    @Autowired
    private EstudianteRepository estudianteRepository;

    @Autowired
    private JwtService jwtService;

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody Estudiante estudiante) {
        try {
            // Verificar si el correo ya existe
            if (estudianteRepository.findByCorreo(estudiante.getCorreo()).isPresent()) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "El correo ya está registrado");
                return ResponseEntity.badRequest().body(error);
            }

            // Verificar si la identificación ya existe
            if (estudianteRepository.findByIdentificacion(estudiante.getIdentificacion()).isPresent()) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "La identificación ya está registrada");
                return ResponseEntity.badRequest().body(error);
            }

            // Guardar contraseña en texto plano (sin encriptar)
            // estudiante.setPassword ya viene del request body

            // Asignar rol por defecto
            if (estudiante.getRol() == null || estudiante.getRol().isEmpty()) {
                estudiante.setRol("ESTUDIANTE");
            }

            // Guardar el estudiante
            Estudiante nuevoEstudiante = estudianteRepository.save(estudiante);

            // Generar token
            String token = jwtService.generateToken(
                    nuevoEstudiante.getCorreo(),
                    nuevoEstudiante.getCodEstudiante(),
                    nuevoEstudiante.getRol());

            AuthResponse response = new AuthResponse(
                    token,
                    nuevoEstudiante.getCodEstudiante(),
                    nuevoEstudiante.getIdentificacion(),
                    nuevoEstudiante.getNombres(),
                    nuevoEstudiante.getApellidos(),
                    nuevoEstudiante.getTelefono(),
                    nuevoEstudiante.getCorreo(),
                    nuevoEstudiante.getSexo(),
                    nuevoEstudiante.getRol());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Error al registrar: " + e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest loginRequest) {
        try {
            System.out.println("=== LOGIN ATTEMPT ===");
            System.out.println("Correo: " + loginRequest.getCorreo());
            System.out.println("Password: " + loginRequest.getPassword());

            Optional<Estudiante> estudianteOpt = estudianteRepository.findByCorreo(loginRequest.getCorreo());

            if (estudianteOpt.isEmpty()) {
                System.out.println("ERROR: Usuario no encontrado");
                Map<String, String> error = new HashMap<>();
                error.put("error", "Credenciales inválidas");
                return ResponseEntity.badRequest().body(error);
            }

            Estudiante estudiante = estudianteOpt.get();
            System.out.println("Usuario encontrado: " + estudiante.getNombres());
            System.out.println("Password en BD: " + estudiante.getPassword());
            System.out.println("Password recibido: " + loginRequest.getPassword());

            // Verificar la contraseña (comparación directa sin encriptación)
            if (!loginRequest.getPassword().equals(estudiante.getPassword())) {
                System.out.println("ERROR: Password incorrecto");
                Map<String, String> error = new HashMap<>();
                error.put("error", "Credenciales inválidas");
                return ResponseEntity.badRequest().body(error);
            }

            System.out.println("Password correcto, generando token...");

            // Generar token
            String token = jwtService.generateToken(
                    estudiante.getCorreo(),
                    estudiante.getCodEstudiante(),
                    estudiante.getRol());

            System.out.println("Token generado: " + token.substring(0, 20) + "...");

            AuthResponse response = new AuthResponse(
                    token,
                    estudiante.getCodEstudiante(),
                    estudiante.getIdentificacion(),
                    estudiante.getNombres(),
                    estudiante.getApellidos(),
                    estudiante.getTelefono(),
                    estudiante.getCorreo(),
                    estudiante.getSexo(),
                    estudiante.getRol());

            System.out.println("Response creado, enviando...");
            System.out.println("=== LOGIN SUCCESS ===");

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.out.println("=== LOGIN ERROR ===");
            System.out.println("Exception: " + e.getMessage());
            e.printStackTrace();

            Map<String, String> error = new HashMap<>();
            error.put("error", "Error al iniciar sesión: " + e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }
}
