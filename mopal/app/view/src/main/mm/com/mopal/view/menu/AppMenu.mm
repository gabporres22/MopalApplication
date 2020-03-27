package com.mopal.view.menu;

import com.mopal.view.AsistenteFormListing;
import com.mopal.view.AsistenteForm;
import com.mopal.view.LocalidadFormListing;
import com.mopal.view.NivelFormListing;
import com.mopal.view.ComunidadFormListing;
import com.mopal.view.EventoListing;
import com.mopal.view.AbstractABMForm;
import com.mopal.view.AbstractListingForm;
import com.mopal.view.EncuentroListingForm;
import com.mopal.view.AsignacionComunidadPastorListingForm;

menu Asistentes {
    AsistenteFormListing;
}

menu Configuracion {
    LocalidadFormListing;
    NivelFormListing;
	ComunidadFormListing;
	Permisos;
}

menu Eventos {
    EventoListing;
    EventoActivo;
}

menu EventoActivo {
	AbstractABMForm;
	AbstractListingForm;
}

menu Encuentros {
    EncuentroListingForm;
}

menu Permisos {
    AsignacionComunidadPastorListingForm;
}