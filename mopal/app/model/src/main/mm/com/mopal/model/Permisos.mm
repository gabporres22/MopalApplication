package com.mopal.model schema data;

import tekgenesis.authorization.User;

entity ComunidadPastor deprecable {
	comunidad   : Comunidad;
	pastor		: Asistente;
}

entity UsuarioAsistente deprecable {
	usuario 	: User;
	asistente 	: Asistente;
}