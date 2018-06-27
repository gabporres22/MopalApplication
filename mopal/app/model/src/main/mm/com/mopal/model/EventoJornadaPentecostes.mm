package com.mopal.model schema data;

entity AsistenteJornadaPentecostes primary_key evento, persona {
    evento              : Evento;
    persona             : Asistente;
    montoContribucion   : Decimal(10, 2), default 0;
    observaciones       : String, optional;
    personasRelacionadas: PRJornadaPentecostes*;
}

entity PRJornadaPentecostes{
    personaRelacionada  : AsistenteJornadaPentecostes;
    nombre              : String;
    apellido            : String;
    fechaNacimiento     : Date;
    grupoReferencia     : String;
    observaciones       : String, optional;
}