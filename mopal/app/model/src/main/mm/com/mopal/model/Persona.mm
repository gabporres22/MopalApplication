package com.mopal.model schema data;

entity Persona described_by nombre, apellido searchable by {nombre; apellido;}{
    nombre:                 String;
    apellido:               String;
    email:                  String, optional;
    localidad:              Localidad;
    barrio:                 Barrio, optional;
    fechaNacimiento:        Date;
    tipoCamino:             TipoCamino, default INGRESANTE;
    nivel:                  Nivel;
    comunidad:              Comunidad, optional;
    cantidadPascuas:        Int, default 0;
    cantidadHijos:          Int, optional, default 0;
    telefonoDeContacto:     String, optional;
    tipoEstadoCivil:        EstadoCivil, optional, default SOLTERO;
    asistenciaJueves:       Boolean;
    asistenciaViernes:      Boolean;
    asistenciaSabado:       Boolean;
    montoContribucion:      Decimal(10, 2);
    observaciones:          String, optional;
    personasRelacionadas:   PersonaRelacionada*;
}