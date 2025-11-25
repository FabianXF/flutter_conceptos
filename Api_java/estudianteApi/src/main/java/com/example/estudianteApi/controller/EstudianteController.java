package com.example.estudianteApi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.estudianteApi.Entidad.Estudiante;
import com.example.estudianteApi.repository.EstudianteRepository;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*", methods = { RequestMethod.GET, RequestMethod.PUT, RequestMethod.OPTIONS })
public class EstudianteController {

    @Autowired
    private EstudianteRepository estudianteRepository;

    @GetMapping("/estudiantes")
    public ResponseEntity<List<Estudiante>> getAllEstudiantes() {
        try {
            List<Estudiante> estudiantes = estudianteRepository.findAll();
            return ResponseEntity.ok(estudiantes);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    // Obtener estudiante por ID
    @GetMapping("/estudiantes/{id}")
    public ResponseEntity<?> getEstudianteById(@PathVariable Integer id) {
        try {
            Optional<Estudiante> estudiante = estudianteRepository.findById(id);
            if (estudiante.isEmpty()) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "Estudiante no encontrado");
                return ResponseEntity.badRequest().body(error);
            }
            return ResponseEntity.ok(estudiante.get());
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Error al obtener estudiante: " + e.getMessage());
            return ResponseEntity.internalServerError().body(error);
        }
    }

    // Actualizar estudiante
    @PutMapping("/estudiantes/{id}")
    public ResponseEntity<?> actualizarEstudiante(@PathVariable Integer id,
            @RequestBody Estudiante estudianteActualizado) {
        try {
            Optional<Estudiante> estudianteOpt = estudianteRepository.findById(id);
            if (estudianteOpt.isEmpty()) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "Estudiante no encontrado");
                return ResponseEntity.badRequest().body(error);
            }

            Estudiante estudiante = estudianteOpt.get();

            // Actualizar solo los campos permitidos
            if (estudianteActualizado.getNombres() != null) {
                estudiante.setNombres(estudianteActualizado.getNombres());
            }
            if (estudianteActualizado.getApellidos() != null) {
                estudiante.setApellidos(estudianteActualizado.getApellidos());
            }
            if (estudianteActualizado.getIdentificacion() != null) {
                estudiante.setIdentificacion(estudianteActualizado.getIdentificacion());
            }
            if (estudianteActualizado.getTelefono() != null) {
                estudiante.setTelefono(estudianteActualizado.getTelefono());
            }

            Estudiante estudianteGuardado = estudianteRepository.save(estudiante);
            return ResponseEntity.ok(estudianteGuardado);
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Error al actualizar estudiante: " + e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }
}