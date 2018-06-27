package com.mopal.model schema data;

entity AsistenteJornadaMaria primary_key evento, persona auditable {
    evento              : Evento;
    persona             : Asistente;
    montoContribucion   : Decimal(10, 2), default 0;
    observaciones       : String, optional;
    personasRelacionadas: PRJornadaMaria*;
}

entity PRJornadaMaria auditable {
    personaRelacionada  : AsistenteJornadaMaria;
    nombre              : String;
    apellido            : String;
    fechaNacimiento     : Date;
    grupoReferencia     : String;
    observaciones       : String, optional;
}