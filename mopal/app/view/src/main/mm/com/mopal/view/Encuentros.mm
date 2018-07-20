package com.mopal.view;

import com.mopal.model.DetalleAsistenciaEncuentro;
import com.mopal.model.Encuentro;
import com.mopal.model.Nivel;
import com.mopal.model.Comunidad;
import com.mopal.model.ComunidadPastor;

form EncuentroForm "Encuentro Form" : Encuentro {
    header {
        message(entity), col 12;
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

    filtros "Filtros": vertical, collapsible {
        nivelFiltro         : Nivel, combo_box, hint "Nivel", optional, col 2;
        comunidadFiltro     : Comunidad, combo_box, hint "Comunidad", filter (nivelComunidad = nivelFiltro), disable when nivelFiltro == null, optional, col 2;
        fechaDesdeFiltro    : Date, optional, col 2;
        fechaHastaFiltro    : Date, optional, col 2;
    };

    horizontal, col 12{
        buscar   "Buscar"   : button, icon search, on_click buscar, shortcut "ctrl+b";
        resetear "Resetear" : button, icon eraser, on_click resetearFiltros;
    };

    encuentros: Encuentro, table(10), on_change saveEncuentro, sortable {
        id               : id, internal;
        nivel "Nivel"    : Nivel, display, width 15;
        comunidad ""     : comunidad, display, width 15;
        fecha ""         : fechaEncuentro, display, width 10;
        asistencias "A"  : String, display, width 10;
        observaciones "" : observaciones, optional, width 50;
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
        asistentes  : DetalleAsistenciaEncuentro, table, on_change saveAsistencia, sortable {
            id                          : id, internal;
            nombre      "Nombre"        : String, display, width 20;
            apellido    "Apellido"      : String, display, width 20;
            presente    "Asistió"       : Boolean, width 10;
            observacion "Observaciones" : String, optional, width 50;
        };
    };

    footer {
        button(cancel);
    };
}