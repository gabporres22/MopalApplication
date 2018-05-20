package com.mopal.model schema data;

entity Asistente described_by nombre, apellido searchable by {nombre; apellido;}{
    nombre:                 String;
    apellido:               String;
    email:                  String, optional;
    localidad:              Localidad;
    barrio:                 Barrio, optional;
    fechaNacimiento:        Date;
    nivel:                  Nivel;
    comunidad:              Comunidad, optional;
    cantidadHijos:          Int, optional, default 0;
    telefonoDeContacto:     String, optional;
    tipoEstadoCivil:        EstadoCivil, optional, default SOLTERO;
}

entity Evento described_by descripcion searchable by {descripcion} {
    descripcion     : String;
    tipoEvento      : TipoEvento;
    activo          : Boolean;
}

entity AsistenteJornadaPentecostes primary_key evento, persona {
    evento              : Evento;
    persona             : Asistente;
    montoContribucion   : Decimal(10, 2);
    observaciones       : String, optional;
    personasRelacionadas: PRJornadaPentecostes*;
}

entity AsistenteRetiroPascua primary_key evento, persona {
    evento              : Evento;
    tipoCamino          : TipoCamino, default INGRESANTE;
    persona             : Asistente;
    cantidadDePascuas   : Int;
    asistenciaJueves    : Boolean;
    asistenciaViernes   : Boolean;
    asistenciaSabado    : Boolean;
    montoContribucion   : Decimal(10, 2);
    observaciones       : String, optional;
    personasRelacionadas: PRRetiroPascua*;
}

entity PRJornadaPentecostes{
    personaRelacionada  : AsistenteJornadaPentecostes;
    nombre              : String;
    apellido            : String;
    fechaNacimiento     : Date;
    grupoReferencia     : String;
    observaciones       : String, optional;
}

entity PRRetiroPascua {
    personaRelacionada: AsistenteRetiroPascua;
    nombre              : String;
    apellido            : String;
    fechaNacimiento     : Date;
    grupoReferencia     : String;
    asistenciaJueves    : Boolean;
    asistenciaViernes   : Boolean;
    asistenciaSabado    : Boolean;
    observaciones       : String, optional;
}