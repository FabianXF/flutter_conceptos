package com.example.estudianteApi.repository;

import com.example.estudianteApi.Entidad.Material;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MaterialRepository extends JpaRepository<Material, Integer> {
    List<Material> findByCategoria(String categoria);

    List<Material> findByDisponible(Boolean disponible);

    List<Material> findByNombreContainingIgnoreCase(String nombre);
}
