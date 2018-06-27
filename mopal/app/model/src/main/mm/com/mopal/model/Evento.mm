package com.mopal.model schema data;


entity Evento described_by descripcion searchable by {descripcion} {
    descripcion     : String;
    tipoEvento      : TipoEvento;
    activo          : Boolean;
}




