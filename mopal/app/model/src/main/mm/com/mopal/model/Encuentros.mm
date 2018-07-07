package com.mopal.model  schema data;

entity Encuentro described_by fechaEncuentro, comunidad searchable by {id} auditable deprecable {
	comunidad		: Comunidad;
	fechaEncuentro	: Date;
	observaciones	: String, optional;
}

entity DetalleAsistenciaEncuentro auditable deprecable described_by encuentro, persona{
	encuentro       : Encuentro;
	persona		    : Asistente;
	presente	    : Boolean, default false;
	observaciones   : String, optional;
}