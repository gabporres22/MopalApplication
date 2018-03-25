package com.mopal.model schema data;

entity Barrio described_by descripcion searchable by {localidad; descripcion;}{
    localidad: Localidad;
    descripcion: String;
}