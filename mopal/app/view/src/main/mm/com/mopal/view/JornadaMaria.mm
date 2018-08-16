package com.mopal.view;

import com.mopal.model.AsistenteJornadaMaria;
import com.mopal.model.Asistente;
import com.mopal.model.Localidad;
import com.mopal.model.Nivel;
import com.mopal.model.Comunidad;

form AsistenteJornadaMariaForm : AsistenteJornadaMaria {
    header {
        message(entity), col 12;
    };

    forCreation: Boolean, internal, default false;

    vertical, col 5 {
        "Evento"                        : evento, display, label_col 4;
        "Persona"                       : persona, on_new_form AsistenteForm, on_change validarAsistenciaPersona, required, label_col 4;
        personaMatrimonio "Esposa/o"    : Asistente, on_new_form AsistenteForm, on_change validarAsistenciaEsposo, optional, label_col 4;
        montoSugerido  "Monto a Pagar"  : Decimal(10, 2), display, mask currency, label_col 4;
        "Monto Contribucion"            : montoContribucion, mask currency, default 0, check montoContribucion >= 0 : "El monto debe ser mayor o igual a 0", label_col 4;
        "Observaciones"                 : observaciones, optional, label_col 4;
    };

    vertical, col 7, hide when persona == null{
        "Personas a cargo asignadas": vertical {
            personasAsignadas: table, sortable{
                nombre          "Nombre"            : String, required;
                apellido        "Apellido"          : String, required;
                fechaNacimiento "Fecha Nacimiento"  : Date, on_change updateEdad, to today(), required;
                edad            "Edad"              : display;
                grupoReferencia "Grupo"             : String, optional;
                observacionesPersona "Observaciones": String, optional;
            };
			horizontal {
				button(add_row), label_expression "Agregar", on_click updateMontoSugerido, content_style "btn-warning", icon user;
				button(remove_row), label_expression "Borrar", on_click updateMontoSugeridoAfterRemove, content_style "btn-danger", icon remove;
			};
        };
    };

    footer, col 12 {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}

form AsistenteJornadaMariaListingForm {
    header {
        message(title), col 12;
        descripcionEvento: String, display;
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

    asistentesJornadaMaria : AsistenteJornadaMaria, table(10), on_load loadAsistentes, sortable {
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
        exportar "Descargar": button(export), export_type csv;
        create "Create"     : button, content_style "btn-primary", icon plus, on_click addAsistencia;
        back "Back"         : button(cancel);
    };
}