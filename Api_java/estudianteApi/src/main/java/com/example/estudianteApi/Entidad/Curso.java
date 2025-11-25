package com.example.estudianteApi.Entidad;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "cursos")
public class Curso {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_curso")
    private Integer idCurso;

    @Column(name = "codigo_curso", unique = true, nullable = false, length = 20)
    private String codigoCurso;

    @Column(name = "nombre_curso", nullable = false, length = 200)
    private String nombreCurso;

    @Column(name = "descripcion", columnDefinition = "TEXT")
    private String descripcion;

    @Column(name = "creditos")
    private Integer creditos = 3;

    @Column(name = "semestre")
    private Integer semestre;

    @Column(name = "docente_id")
    private Integer docenteId;

    @Column(name = "cupo_maximo")
    private Integer cupoMaximo = 30;

    @Column(name = "cupo_disponible")
    private Integer cupoDisponible = 30;

    @Column(name = "estado", length = 20)
    private String estado = "ACTIVO";

    @Column(name = "fecha_creacion")
    private LocalDateTime fechaCreacion;

    // Constructores
    public Curso() {
    }

    public Curso(String codigoCurso, String nombreCurso, String descripcion, Integer creditos,
            Integer semestre, Integer docenteId, Integer cupoMaximo) {
        this.codigoCurso = codigoCurso;
        this.nombreCurso = nombreCurso;
        this.descripcion = descripcion;
        this.creditos = creditos;
        this.semestre = semestre;
        this.docenteId = docenteId;
        this.cupoMaximo = cupoMaximo;
        this.cupoDisponible = cupoMaximo;
    }

    @PrePersist
    protected void onCreate() {
        if (fechaCreacion == null) {
            fechaCreacion = LocalDateTime.now();
        }
        if (estado == null || estado.isEmpty()) {
            estado = "ACTIVO";
        }
        if (creditos == null) {
            creditos = 3;
        }
        if (cupoMaximo == null) {
            cupoMaximo = 30;
        }
        if (cupoDisponible == null) {
            cupoDisponible = cupoMaximo;
        }
    }

    // Getters y Setters
    public Integer getIdCurso() {
        return idCurso;
    }

    public void setIdCurso(Integer idCurso) {
        this.idCurso = idCurso;
    }

    public String getCodigoCurso() {
        return codigoCurso;
    }

    public void setCodigoCurso(String codigoCurso) {
        this.codigoCurso = codigoCurso;
    }

    public String getNombreCurso() {
        return nombreCurso;
    }

    public void setNombreCurso(String nombreCurso) {
        this.nombreCurso = nombreCurso;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Integer getCreditos() {
        return creditos;
    }

    public void setCreditos(Integer creditos) {
        this.creditos = creditos;
    }

    public Integer getSemestre() {
        return semestre;
    }

    public void setSemestre(Integer semestre) {
        this.semestre = semestre;
    }

    public Integer getDocenteId() {
        return docenteId;
    }

    public void setDocenteId(Integer docenteId) {
        this.docenteId = docenteId;
    }

    public Integer getCupoMaximo() {
        return cupoMaximo;
    }

    public void setCupoMaximo(Integer cupoMaximo) {
        this.cupoMaximo = cupoMaximo;
    }

    public Integer getCupoDisponible() {
        return cupoDisponible;
    }

    public void setCupoDisponible(Integer cupoDisponible) {
        this.cupoDisponible = cupoDisponible;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public LocalDateTime getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(LocalDateTime fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
}
