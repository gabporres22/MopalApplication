package com.mopal.view;

import com.mopal.model.DetalleAsistenciaEncuentro;
import com.mopal.model.Encuentro;
import com.mopal.model.Nivel;
import com.mopal.model.Comunidad;
import com.mopal.model.ComunidadPastor;

form EncuentroForm "Encuentro Form" : Encuentro {
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };

    "Id"              : id, internal, optional;
    nivel "Nivel"     : Nivel, required, disable when id != null;
    "Comunidad"       : comunidad, filter (nivelComunidad = nivel), disable when nivel == null || id != null, required;
    "Fecha Encuentro" : fechaEncuentro, default now(), required;
    "Observaciones"   : observaciones;

    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}

form EncuentroListingForm "" {
    header {
        message(title), col 12;
    };

    encuentros: Encuentro, table(10), sortable {
        id               : id, internal;
        nivel "Nivel"    : Nivel, display;
        comunidad ""     : comunidad, display;
        fecha ""         : fechaEncuentro, display;
        observaciones  "": observaciones, display;
        btnEditar      "btn": button, on_click navigateToEncuentroForm;
        btnAsistencias "btn": button, on_click navigateToDetalleAsistencias;
    };

    footer {
        exportar "Descargar": button(export), export_type csv;
        create "Create"     : button, content_style "btn-primary", icon plus, on_click addEncuentro;
        back "Back"         : button(cancel);
    };
}

form DetalleAsistenciaEncuentroForm "Detalle Asistencia Encuentro Form" : DetalleAsistenciaEncuentro {
    header {
        message(entity), col 12;
    };
    "Id"            : id, internal, optional;
    "Encuentro"     : encuentro, disable when id != null;
    "Persona"       : persona, disable when id != null;
    "Presente"      : presente, default false;
    "Observaciones" : observaciones;
    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}

form DetalleAsistenciaEncuentroListingForm "Detalle Asistencia Encuentro Listing" parameters idEncuentro {
    header {
        message(title), col 12;
    };
    idEncuentro : Int, internal;
    encuentro   : Encuentro, internal, optional;
    vertical {
        nivel          "Nivel"         : Nivel, display;
        comunidad      "Comunidad"     : Comunidad, display;
        fechaEncuentro "Encuentro"     : Date, display;
        observaciones  "Observaciones" : String, display, optional;
    };

    vertical {
        asistentes  : DetalleAsistenciaEncuentro, table(10), on_change saveAsistencia, sortable {
            id                          : id, internal;
            nombre      "Nombre"        : String, display;
            apellido    "Apellido"      : String, display;
            presente    "Asistió"       : Boolean;
            observacion "Observaciones" : String, optional;
            btnEditar   "btn"           : button, on_click navigateToDetalleAsistenciaEncuentro;
        };
    };

    footer {
        button(cancel);
    };
}