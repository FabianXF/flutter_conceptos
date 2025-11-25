package com.example.estudianteApi.controller;

import com.example.estudianteApi.Entidad.Material;
import com.example.estudianteApi.repository.MaterialRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/materiales")
@CrossOrigin(origins = "*")
public class MaterialController {

    @Autowired
    private MaterialRepository materialRepository;

    // Listar todos los materiales
    @GetMapping
    public List<Material> listarMateriales() {
        return materialRepository.findAll();
    }

    // Obtener material por ID
    @GetMapping("/{id}")
    public ResponseEntity<?> obtenerMaterial(@PathVariable Integer id) {
        Optional<Material> material = materialRepository.findById(id);
        if (material.isEmpty()) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Material no encontrado");
            return ResponseEntity.badRequest().body(error);
        }
        return ResponseEntity.ok(material.get());
    }

    // Listar materiales disponibles
    @GetMapping("/disponibles")
    public List<Material> listarMaterialesDisponibles() {
        return materialRepository.findByDisponible(true);
    }

    // Listar materiales por categoría
    @GetMapping("/categoria/{categoria}")
    public List<Material> listarMaterialesPorCategoria(@PathVariable String categoria) {
        return materialRepository.findByCategoria(categoria);
    }

    // Buscar materiales por nombre
    @GetMapping("/buscar")
    public List<Material> buscarMateriales(@RequestParam String nombre) {
        return materialRepository.findByNombreContainingIgnoreCase(nombre);
    }

    // Crear nuevo material
    @PostMapping
    public ResponseEntity<?> crearMaterial(@RequestBody Material material) {
        try {
            Material nuevoMaterial = materialRepository.save(material);
            return ResponseEntity.ok(nuevoMaterial);
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Error al crear material: " + e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }

    // Actualizar material
    @PutMapping("/{id}")
    public ResponseEntity<?> actualizarMaterial(@PathVariable Integer id, @RequestBody Material materialActualizado) {
        try {
            Optional<Material> materialOpt = materialRepository.findById(id);
            if (materialOpt.isEmpty()) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "Material no encontrado");
                return ResponseEntity.badRequest().body(error);
            }

            Material material = materialOpt.get();
            material.setNombre(materialActualizado.getNombre());
            material.setDescripcion(materialActualizado.getDescripcion());
            material.setCategoria(materialActualizado.getCategoria());
            material.setPrecio(materialActualizado.getPrecio());
            material.setStock(materialActualizado.getStock());
            material.setAutor(materialActualizado.getAutor());
            material.setEditorial(materialActualizado.getEditorial());
            material.setDisponible(materialActualizado.getDisponible());

            Material materialGuardado = materialRepository.save(material);
            return ResponseEntity.ok(materialGuardado);
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Error al actualizar material: " + e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }

    // Eliminar material
    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminarMaterial(@PathVariable Integer id) {
        try {
            if (!materialRepository.existsById(id)) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "Material no encontrado");
                return ResponseEntity.badRequest().body(error);
            }

            materialRepository.deleteById(id);
            Map<String, String> response = new HashMap<>();
            response.put("message", "Material eliminado exitosamente");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Error al eliminar material: " + e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }
}
