package com.example.estudianteApi.controller;

import com.example.estudianteApi.Entidad.Tarea;
import com.example.estudianteApi.repository.TareaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/tareas")
@CrossOrigin(origins = "*")
public class TareaController {

    @Autowired
    private TareaRepository tareaRepository;

    // Listar todas las tareas
    @GetMapping
    public List<Tarea> listarTareas() {
        return tareaRepository.findAll();
    }

    // Obtener tarea por ID
    @GetMapping("/{id}")
    public ResponseEntity<?> obtenerTarea(@PathVariable Integer id) {
        Optional<Tarea> tarea = tareaRepository.findById(id);
        if (tarea.isEmpty()) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Tarea no encontrada");
            return ResponseEntity.badRequest().body(error);
        }
        return ResponseEntity.ok(tarea.get());
    }

    // Listar tareas por curso
    @GetMapping("/curso/{cursoId}")
    public List<Tarea> listarTareasPorCurso(@PathVariable Integer cursoId) {
        return tareaRepository.findByCursoId(cursoId);
    }

    // Listar tareas activas
    @GetMapping("/activas")
    public List<Tarea> listarTareasActivas() {
        return tareaRepository.findByEstado("ACTIVA");
    }

    // Crear nueva tarea
    @PostMapping
    public ResponseEntity<?> crearTarea(@RequestBody Tarea tarea) {
        try {
            Tarea nuevaTarea = tareaRepository.save(tarea);
            return ResponseEntity.ok(nuevaTarea);
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Error al crear tarea: " + e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }

    // Actualizar tarea
    @PutMapping("/{id}")
    public ResponseEntity<?> actualizarTarea(@PathVariable Integer id, @RequestBody Tarea tareaActualizada) {
        try {
            Optional<Tarea> tareaOpt = tareaRepository.findById(id);
            if (tareaOpt.isEmpty()) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "Tarea no encontrada");
                return ResponseEntity.badRequest().body(error);
            }

            Tarea tarea = tareaOpt.get();
            tarea.setTitulo(tareaActualizada.getTitulo());
            tarea.setDescripcion(tareaActualizada.getDescripcion());
            tarea.setFechaEntrega(tareaActualizada.getFechaEntrega());
            tarea.setPuntajeMaximo(tareaActualizada.getPuntajeMaximo());
            tarea.setEstado(tareaActualizada.getEstado());

            Tarea tareaGuardada = tareaRepository.save(tarea);
            return ResponseEntity.ok(tareaGuardada);
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Error al actualizar tarea: " + e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }

    // Eliminar tarea
    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminarTarea(@PathVariable Integer id) {
        try {
            if (!tareaRepository.existsById(id)) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "Tarea no encontrada");
                return ResponseEntity.badRequest().body(error);
            }

            tareaRepository.deleteById(id);
            Map<String, String> response = new HashMap<>();
            response.put("message", "Tarea eliminada exitosamente");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Error al eliminar tarea: " + e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }
}
