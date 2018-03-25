package com.mopal.model schema data;

entity Comunidad described_by descripcion, localidad searchable by{nivelComunidad; descripcion;}{
    nivelComunidad:     Nivel;
    localidad:          Localidad;
    barrio:             Barrio, optional;
    descripcion:        String;
    cantidadPersonas:   Int;
}