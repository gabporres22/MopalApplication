package com.mopal.model schema data;

entity AsistenteRetiroPascua primary_key evento, persona auditable {
    evento              : Evento;
    persona             : Asistente;
    tipoCamino          : TipoCamino, default INGRESANTE;
    cantidadDePascuas   : Int;
    asistenciaJueves    : Boolean;
    asistenciaViernes   : Boolean;
    asistenciaSabado    : Boolean;
    montoContribucion   : Decimal(10, 2), default 0;
    observaciones       : String, optional;
    personasRelacionadas: PRRetiroPascua*;
}

entity PRRetiroPascua {
    personaRelacionada  : AsistenteRetiroPascua;
    nombre              : String;
    apellido            : String;
    fechaNacimiento     : Date;
    grupoReferencia     : String;
    asistenciaJueves    : Boolean;
    asistenciaViernes   : Boolean;
    asistenciaSabado    : Boolean;
    observaciones       : String, optional;
}