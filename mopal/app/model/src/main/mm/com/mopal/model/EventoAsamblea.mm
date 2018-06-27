package com.mopal.model schema data;

entity AsistenteAsamblea primary_key evento, persona {
    evento              : Evento;
    persona             : Asistente;
    observaciones       : String, optional;
    personasRelacionadas: PRAsamblea*;
}

entity PRAsamblea{
    personaRelacionada  : AsistenteAsamblea;
    nombre              : String;
    apellido            : String;
    fechaNacimiento     : Date;
    grupoReferencia     : String;
    observaciones       : String, optional;
}
