package com.example.estudianteApi.repository;

import com.example.estudianteApi.Entidad.Estudiante;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface EstudianteRepository extends JpaRepository<Estudiante, Integer> {
    Optional<Estudiante> findByCorreo(String correo);

    Optional<Estudiante> findByIdentificacion(String identificacion);
}