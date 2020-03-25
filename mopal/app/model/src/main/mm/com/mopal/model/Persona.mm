package com.mopal.model schema data;

entity Asistente described_by nombre, apellido searchable by {nombre; apellido;}{
    nombre:                 String;
    apellido:               String;
    fechaNacimiento:        Date;
    dni:                    String;
    tipoEstadoCivil:        EstadoCivil, optional, default SOLTERO;
    imagen:                 Resource, optional;
    email:                  String, optional;
    celularDeContacto:      String, optional;
    telefonoDeContacto:     String, optional;
    calle:                  String;
    altura:                 Int;
    localidad:              Localidad;
    trabajaActualmente:     Boolean;
    oficioTrabajo:          String, optional;
    estudioMaximo:          String;
    estudioTerminado:       Boolean;
    anoIngresoObra:         Int;
    anoPrimeraPascua:       Int;
    nivel:                  Nivel;
    comunidad:              Comunidad;
}