package com.mopal.model schema data;

entity Localidad described_by descripcion searchable {
    descripcion: String;
    barrios: Barrio*;
}
