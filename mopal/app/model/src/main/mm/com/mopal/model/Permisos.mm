package com.mopal.model schema data;

import tekgenesis.authorization.User;

entity ComunidadPastor described_by comunidad auditable deprecable {
	comunidad   : Comunidad;
	pastor		: User;
}