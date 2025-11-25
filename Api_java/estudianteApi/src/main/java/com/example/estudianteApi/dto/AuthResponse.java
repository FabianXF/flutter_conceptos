package com.example.estudianteApi.dto;

public class AuthResponse {
    private String token;
    private String tipo = "Bearer";
    private Integer codEstudiante;
    private String identificacion;
    private String nombres;
    private String apellidos;
    private String telefono;
    private String correo;
    private String sexo;
    private String rol;

    public AuthResponse(String token, Integer codEstudiante, String identificacion, String nombres,
            String apellidos, String telefono, String correo, String sexo, String rol) {
        this.token = token;
        this.codEstudiante = codEstudiante;
        this.identificacion = identificacion;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.telefono = telefono;
        this.correo = correo;
        this.sexo = sexo;
        this.rol = rol;
    }

    // Getters y Setters
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Integer getCodEstudiante() {
        return codEstudiante;
    }

    public void setCodEstudiante(Integer codEstudiante) {
        this.codEstudiante = codEstudiante;
    }

    public String getIdentificacion() {
        return identificacion;
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }
}
