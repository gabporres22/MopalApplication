package com.mopal.model schema data;

entity PersonaRelacionada described_by nombre, apellido searchable {
    persona:                Persona;
    nombre:                 String;
    apellido:               String;
    fechaNacimiento:        Date;
    grupoReferencia:        String;
    asistenciaJueves:       Boolean;
    asistenciaViernes:      Boolean;
    asistenciaSabado:       Boolean;
    observaciones:          String, optional;
}