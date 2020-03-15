package com.mopal.model schema data;

entity Asistente described_by nombre, apellido searchable by {nombre; apellido;}{
    nombre:                 String;
    apellido:               String;
    email:                  String, optional;
    localidad:              Localidad;
    barrio:                 Barrio, optional;
    fechaNacimiento:        Date;
    nivel:                  Nivel;
    comunidad:              Comunidad, optional;
    cantidadHijos:          Int, optional, default 0;
    telefonoDeContacto:     String, optional;
    tipoEstadoCivil:        EstadoCivil, optional, default SOLTERO;
    imagen:                 Resource, optional;
}
