package com.mopal.model;

enum TipoCamino{
    INGRESANTE;
    CAMINANTE;
}

enum EstadoCivil{
    SOLTERO;
    CASADO;
    SEPARADO;
    VIUDO;
}

enum Nivel{
    NINGUNA;
    CAMINO;
    EVANGELIO;
    INICIACION;
    PROFUNDIZACION;
    PERFECCIONAMIENTO;
    PREPARACION_COMUNIDAD_DE_VIDA;
    COMUNIDAD_DE_VIDA;
}

entity Localidad described_by descripcion searchable {
    descripcion: String;
}

entity Comunidad described_by descripcion, localidad searchable by{nivelComunidad; descripcion;} {
    nivelComunidad:     Nivel;
    localidad:          Localidad;
    descripcion:        String;
    cantidadPersonas:   Int;
}

entity Persona described_by nombre, apellido searchable by {nombre; apellido;}{
    nombre:                 String;
    apellido:               String;
    localidad:              Localidad;
    fechaNacimiento:        Date;
    tipoCamino:             TipoCamino, default INGRESANTE;
    nivel:                  Nivel, default NINGUNA;
    comunidad:              Comunidad, optional;
    cantidadPascuas:        Int, default 0;
    cantidadHijos:          Int, optional, default 0;
    personaRelacionada:     entity PersonaRelacionada* {
        nombre:                 String;
        apellido:               String;
        fechaNacimiento:        Date;
        telefonoDeContacto:     String;
        asistenciaJueves:       Boolean;
        asistenciaViernes:      Boolean;
        asistenciaSabado:       Boolean;
        observaciones:          String;
    };
    telefonoDeContacto:     String;
    tipoEstadoCivil:        EstadoCivil, optional, default SOLTERO;
    asistenciaJueves:       Boolean;
    asistenciaViernes:      Boolean;
    asistenciaSabado:       Boolean;
    contribucionPascua:     Boolean;
    montoContribucion:      Decimal(10, 2);
    observaciones:          String, optional;
}
