package com.mopal.model  schema data;

entity Encuentro {
	comunidad		: Comunidad;
	fechaEncuentro	: DateTime;
	observaciones	: String;
}

entity DetalleAsistenciaEncuentro {
	encuentro       : Encuentro;
	persona		    : Asistente;
	presente	    : Boolean, default false;
	observaciones   : String;
}