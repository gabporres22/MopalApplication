package com.mopal.model schema data;

entity AsistenteJornadaMaria described_by persona auditable {
    evento              : Evento;
    persona             : Asistente;
    montoContribucion   : Decimal(10, 2), default 0;
    observaciones       : String, optional;
}

entity PRJornadaMaria auditable {
    personaRelacionada  : AsistenteJornadaMaria;
    personaRelacionada2 : AsistenteJornadaMaria, optional;
    nombre              : String;
    apellido            : String;
    fechaNacimiento     : Date;
    grupoReferencia     : String;
    observaciones       : String, optional;
}