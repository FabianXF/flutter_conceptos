package com.example.estudianteApi.repository;

import com.example.estudianteApi.Entidad.Curso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CursoRepository extends JpaRepository<Curso, Integer> {
    Optional<Curso> findByCodigoCurso(String codigoCurso);

    List<Curso> findByEstado(String estado);

    List<Curso> findByDocenteId(Integer docenteId);
}
