package com.example.estudianteApi.controller;

import com.example.estudianteApi.Entidad.Curso;
import com.example.estudianteApi.repository.CursoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/cursos")
@CrossOrigin(origins = "*")
public class CursoController {

    @Autowired
    private CursoRepository cursoRepository;

    // Listar todos los cursos
    @GetMapping
    public List<Curso> listarCursos() {
        return cursoRepository.findAll();
    }

    // Obtener curso por ID
    @GetMapping("/{id}")
    public ResponseEntity<?> obtenerCurso(@PathVariable Integer id) {
        Optional<Curso> curso = cursoRepository.findById(id);
        if (curso.isEmpty()) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Curso no encontrado");
            return ResponseEntity.badRequest().body(error);
        }
        return ResponseEntity.ok(curso.get());
    }

    // Crear nuevo curso
    @PostMapping
    public ResponseEntity<?> crearCurso(@RequestBody Curso curso) {
        try {
            // Verificar que el código del curso no exista
            if (cursoRepository.findByCodigoCurso(curso.getCodigoCurso()).isPresent()) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "El código del curso ya existe");
                return ResponseEntity.badRequest().body(error);
            }

            // Asegurar que el ID sea null para que JPA lo genere automáticamente
            curso.setIdCurso(null);

            // Si no se especifica cupo disponible, usar el cupo máximo
            if (curso.getCupoDisponible() == null) {
                curso.setCupoDisponible(curso.getCupoMaximo());
            }

            // Asegurar valores por defecto
            if (curso.getEstado() == null || curso.getEstado().isEmpty()) {
                curso.setEstado("ACTIVO");
            }
            if (curso.getCreditos() == null) {
                curso.setCreditos(3);
            }

            Curso nuevoCurso = cursoRepository.save(curso);
            return ResponseEntity.ok(nuevoCurso);
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Error al crear curso: " + e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }

    // Actualizar curso
    @PutMapping("/{id}")
    public ResponseEntity<?> actualizarCurso(@PathVariable Integer id, @RequestBody Curso cursoActualizado) {
        try {
            Optional<Curso> cursoOpt = cursoRepository.findById(id);
            if (cursoOpt.isEmpty()) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "Curso no encontrado");
                return ResponseEntity.badRequest().body(error);
            }

            Curso curso = cursoOpt.get();
            curso.setNombreCurso(cursoActualizado.getNombreCurso());
            curso.setDescripcion(cursoActualizado.getDescripcion());
            curso.setCreditos(cursoActualizado.getCreditos());
            curso.setSemestre(cursoActualizado.getSemestre());
            curso.setCupoMaximo(cursoActualizado.getCupoMaximo());
            curso.setCupoDisponible(cursoActualizado.getCupoDisponible());
            curso.setEstado(cursoActualizado.getEstado());

            Curso cursoGuardado = cursoRepository.save(curso);
            return ResponseEntity.ok(cursoGuardado);
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Error al actualizar curso: " + e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }

    // Eliminar curso
    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminarCurso(@PathVariable Integer id) {
        try {
            if (!cursoRepository.existsById(id)) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "Curso no encontrado");
                return ResponseEntity.badRequest().body(error);
            }

            cursoRepository.deleteById(id);
            Map<String, String> response = new HashMap<>();
            response.put("message", "Curso eliminado exitosamente");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Error al eliminar curso: " + e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }

    // Listar cursos activos
    @GetMapping("/activos")
    public List<Curso> listarCursosActivos() {
        return cursoRepository.findByEstado("ACTIVO");
    }
}
