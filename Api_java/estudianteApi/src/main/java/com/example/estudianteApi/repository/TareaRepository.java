package com.example.estudianteApi.repository;

import com.example.estudianteApi.Entidad.Tarea;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TareaRepository extends JpaRepository<Tarea, Integer> {
    List<Tarea> findByCursoId(Integer cursoId);

    List<Tarea> findByEstado(String estado);

    List<Tarea> findByCreadaPor(Integer creadaPor);
}
