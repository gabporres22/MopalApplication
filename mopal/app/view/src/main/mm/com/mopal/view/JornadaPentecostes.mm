package com.mopal.view;

import com.mopal.model.AsistenteJornadaPentecostes;
import com.mopal.model.Asistente;
import com.mopal.model.Nivel;
import com.mopal.model.Localidad;
import com.mopal.model.Comunidad;
import com.mopal.model.Evento;

form AsistenteJornadaPentecostesForm : AsistenteJornadaPentecostes {
    header {
        message(entity), col 12;
    };

    "Evento"                : evento, display;
    "Persona"               : persona, on_new_form AsistenteForm;
    "Monto Contribucion"    : montoContribucion, mask decimal;
    "Observaciones"         : observaciones, optional;
    hidePersonasReleacionadas "": Boolean, internal, default true;
    forCreation           : Boolean, internal, default false;

    footer, col 12 {
        button(save);
        button(cancel);
        addPersonasRelacionadas "Personas a cargo": button, on_click addPersonaRelacionada, content_style "btn-warning", icon user, hide when persona == null || hidePersonasReleacionadas;
        button(delete), style "pull-right";
    };
}

form AsistenteJornadaPentecostesFormListing {
    header {
        message(title), col 12;
    };

    filtros "Filtros": vertical, collapsible {
        nombreFiltro    : String, hint "Nombre", optional, col 2;
        apellidoFiltro  : String, hint "Apellido", optional, col 2;
        localidadFiltro : Localidad, hint "Localidad", on_new_form LocalidadForm, optional, col 2;
        nivelFiltro     : Nivel, hint "Nivel", optional, col 2;
        comunidadFiltro : Comunidad, hint "Comunidad", filter (nivelComunidad = nivelFiltro), disable when nivelFiltro == null, on_new_form ComunidadForm, optional, col 2;
    };

    horizontal, col 12{
        buscar   "Buscar"   : button, icon search, on_click buscar, shortcut "ctrl+b";
        resetear "Resetear" : button, icon eraser, on_click resetearFiltros;
    };

    asistentesJornadaPentecostes : AsistenteJornadaPentecostes, table(10), on_load loadAsistentes, sortable {
        montoContribucion                   : montoContribucion, internal;
        idEvento                            : Int, internal;
        idPersona                           : Int, internal;
        nombre    "Nombre"                  : String, display;
        apellido  "Apellido"                : String, display;
        edad      "Edad"                    : String, display;
        nivel     "Nivel"                   : Nivel, display;
        comunidad "Comunidad"               : Comunidad, display;
        telefono  "Telefono"                : String, display;
        contribucion "Contribuyo"           : Boolean, display;
        personasACargo "Personas a cargo"   : Int, display;
        editarPersona "Persona"             : label, on_click editarPersona, label_expression "Editar", icon pencil_square_o;
        editarAsistencia "Asistencia"       : label, on_click editarAsistencia, label_expression "Editar", icon pencil_square_o;
    };

    totalRows "Registros": String, display;

    footer {
        create "Create" : button, content_style "btn-primary", icon plus, on_click addAsistencia;
        back "Back"     : button(cancel);
    };
}

form PersonaRelacionadaJornadaPentecostesForm {
    header {
        message(title), col 12;
    };

    mainDiv: vertical, col 12 {
        cargaPersona "": vertical, col 6 {
            asistenteResponsable "Responsable"  : Asistente, display, content_style "font-weight: bold;", label_col 4;
            id                                  : Int, internal, optional;
            idEvento                            : Int, internal, optional;
            nombre "Nombre"                     : String, required, label_col 4;
            apellido "Apellido"                 : String, required, label_col 4;
            fechaNacimiento "Fecha Nacimiento"  : Date, required, on_ui_change updateEdad, label_col 4;
            edadValue "Edad"                    : String, display, label_col 4;
            grupoReferencia "Grupo Referencia"  : String, required, label_col 4;
            observaciones "Observaciones"       : String, text_area, optional, label_col 4;
        };

        "Personas a cargo asignadas": vertical, col 6 {
            personasAsignadas: table, sortable {
                idPersonaRelacionada    : Int, internal, optional;
                nombrePersona           : String, display;
                apellidoPersona         : String, display;
                edad "Edad"             : String, display;
                grupoReferenciaPersona  : String, display;
                editarPersona ""        : label, on_click editarPersona, label_expression "Editar", icon pencil_square_o;
                quitarPersona ""        : label, on_click quitarPersona, label_expression "Borrar", icon remove;
            };
        };
    };

    footer {
        saveButton "Guardar": button, content_style "btn-primary", icon save, on_click saveData;
        button(cancel);
    };
}