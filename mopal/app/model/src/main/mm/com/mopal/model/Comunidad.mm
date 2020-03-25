package com.mopal.model schema data;

entity Comunidad described_by descripcion searchable by{nivelComunidad; descripcion;}{
    nivelComunidad:     Nivel;
    descripcion:        String;
    cantidadPersonas:   Int;
}