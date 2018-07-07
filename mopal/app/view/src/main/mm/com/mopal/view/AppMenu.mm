package com.mopal.view;

menu MopalMenu {
    ConfiguracionMenu;
    AsistenteFormListing;
    EventosMenu;
    EncuentrosMenu;
}

menu ConfiguracionMenu {
    LocalidadFormListing;
    NivelFormListing;
	ComunidadFormListing;
	PermisosMenu;
}

menu EventosMenu {
    EventoListing;
    EventoActivo;
}

menu EventoActivo {
	AbstractABMForm;
	AbstractListingForm;
}

menu EncuentrosMenu {
    EncuentroListingForm;
}

menu PermisosMenu {
    AsignacionComunidadPastorListingForm;
    AsignacionUsuarioAsistenteListingForm;
}