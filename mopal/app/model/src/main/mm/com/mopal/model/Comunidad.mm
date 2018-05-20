package com.mopal.model schema data;

entity Comunidad described_by descripcion, barrio searchable by{nivelComunidad; descripcion;}{
    nivelComunidad:     Nivel;
    localidad:          Localidad;
    barrio:             Barrio, optional;
    descripcion:        String;
    cantidadPersonas:   Int;
}