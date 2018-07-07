package com.mopal.model schema data;

import tekgenesis.authorization.User;

entity ComunidadPastor described_by comunidad auditable deprecable {
	comunidad   : Comunidad;
	pastor		: Asistente;
}

entity UsuarioAsistente described_by usuario, asistente auditable deprecable {
	usuario 	: User;
	asistente 	: Asistente;
}