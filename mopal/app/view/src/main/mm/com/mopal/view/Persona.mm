package com.mopal.view;

import com.mopal.model.Persona;
import com.mopal.model.PersonaRelacionada;
import com.mopal.model.Barrio;
import com.mopal.model.Localidad;
import com.mopal.model.Comunidad;
import com.mopal.model.Nivel;
import com.mopal.model.Asistente;

widget AsistenteWidget "Asistente Widget" : Asistente {
    "": vertical, col 6 {
        "Nombre"               : nombre, required, label_col 4;
        "Apellido"             : apellido, required, label_col 4;
        "Telefono"             : telefonoDeContacto, optional, custom_mask "####################", label_col 4;
        "Email"                : email, optional, label_col 4;
        "Localidad"            : localidad, required, on_new_form LocalidadForm, label_col 4;
        "Barrio"               : barrio, required, filter(localidad = localidad), on_new_form BarrioForm, label_col 4;
    };

    "": vertical, col 6 {
        "Fecha Nacimiento"     : fechaNacimiento, required, label_col 4, on_ui_change updateEdad;
        edadValue "Edad"       : String, display, label_col 4;
        "Estado Civil"         : tipoEstadoCivil, required, default SOLTERO, optional, label_col 4;
        "Cantidad Hijos"       : cantidadHijos, default 0, mask decimal, optional, label_col 4;
        "Nivel"                : nivel, required, on_new_form NivelForm, label_col 4;
        "Comunidad"            : comunidad, required, filter (nivelComunidad = nivel), on_new_form ComunidadForm, optional, label_col 4;
    };
}

form AsistenteForm "Asistente Form" : Asistente {
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };

    "Id"        : id, internal, optional;
    asistente "": Asistente, widget(AsistenteWidget);

    footer, col 12 {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}

form AsistenteFormListing {
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

    asistentes: Asistente, table(10),on_load loadAsistentes, sortable {
        id                  : id, internal;
        nombre              : nombre, display;
        apellido            : apellido, display;
        email               : email, display;
        localidad           : localidad, display;
        barrio              : barrio, display;
        fechaNacimiento     : fechaNacimiento, display;
        edad ""             : String, display;
        nivel               : nivel, display;
        comunidad           : comunidad, display;
        telefonoDeContacto  : telefonoDeContacto, display;
        tipoEstadoCivil     : tipoEstadoCivil, display;
        editarPersona "" : label, on_click editarPersona, label_expression "Editar", icon pencil_square_o;
    };

    totalRows "Registros": String, display;

    footer {
        create "Create" : button, content_style "btn-primary", icon plus, on_click addAsistente;
        back "Back"     : button(cancel);
    };
}

form PersonaRelacionadaForm "Persona Relacionada Form"  {
    header {
        message(title), col 12;
    };

    mainDiv: vertical, col 12 {
        cargaPersona "": vertical, col 6 {
            personaResponsable "Responsable"    : Persona, display, content_style "font-weight: bold;", label_col 4;
            id                                  : Int, internal, optional;
            nombre "Nombre"                     : String, required, label_col 4;
            apellido "Apellido"                 : String, required, label_col 4;
            fechaNacimiento "Fecha Nacimiento"  : Date, required, on_ui_change updateEdad, label_col 4;
            edadValue "Edad"                    : String, display, label_col 4;
            grupoReferencia "Grupo Referencia"  : String, required, label_col 4;

            "Asistencias": horizontal, col 12 {
                asistenciaJueves    : Boolean, no_label, placeholder "Jueves";
                asistenciaViernes   : Boolean, no_label, placeholder "Viernes";
                asistenciaSabado    : Boolean, no_label, placeholder "Sabado";
            };

            observaciones "Observaciones"       : String, text_area, optional, label_col 4;
        };

        "Personas a cargo asignadas": vertical, col 6 {
            personasAsignadas: table, sortable {
                idPersonaRelacionada    : Int, internal, optional;
                nombrePersona           : String, display;
                apellidoPersona         : String, display;
                edad "Edad"             : String, display;
                grupoReferenciaPersona  : String, display;
                colAsistenciaJueves "J" : Boolean, display;
                colAsistenciaViernes "V": Boolean, display;
                colAsistenciaSabado "S" : Boolean, display;
                rowActions ""           : dropdown, icon cog, style "open-left"{
                    editarPersona "Editar"  : label, on_click editarPersona, icon pencil_square_o;
                    quitarPersona "Borrar"  : label, on_click quitarPersona, icon remove;
                };
            };
        };
    };

    footer {
        saveButton "Guardar": button, content_style "btn-primary", icon save, on_click saveData;
        button(cancel);
    };
}

form PersonaForm "Persona Form" : Persona {
    header {
        message(entity), col 12;
        search_box, col 4, style "pull-right";
    };

    nivelNinguno        : Nivel, internal;

    "": vertical, col 6 {
        "Id"                   : id, internal, optional;
        "Nombre"               : nombre, required, label_col 4;
        "Apellido"             : apellido, required, label_col 4;
        "Telefono"             : telefonoDeContacto, optional, custom_mask "####################", label_col 4;
        "Localidad"            : localidad, required, on_new_form LocalidadForm, label_col 4;
        "Barrio"               : barrio, filter(localidad = localidad), on_new createBarrio, label_col 4;
        "Fecha Nacimiento"     : fechaNacimiento, required, label_col 4, on_ui_change updateEdad;
        edadValue "Edad"       : String, display, label_col 4;
        "Email"                : email, optional, label_col 4;
        "Estado Civil"         : tipoEstadoCivil, required, default SOLTERO, optional, label_col 4;
        "Cantidad Hijos"       : cantidadHijos, default 0, mask decimal, optional, label_col 4;
    };

    "": vertical, col 6 {
        "Tipo Camino"          : tipoCamino, required, default INGRESANTE, label_col 4;
        "Nivel"                : nivel, required, disable when tipoCamino == INGRESANTE, default nivelNinguno, on_new_form NivelForm, label_col 4;
        "Comunidad"            : comunidad, filter (nivelComunidad = nivel), disable when nivel == nivelNinguno, on_new createComunidad, optional, label_col 4;
        "Cantidad Pascuas"     : cantidadPascuas, required, default 0, mask decimal, label_col 4;

        "Asistencias": horizontal, col 12 {
            colAsistenciaJueves    : asistenciaJueves, no_label, placeholder "Jueves";
            colAsistenciaViernes   : asistenciaViernes, no_label, placeholder "Viernes";
            colAsistenciaSabado    : asistenciaSabado, no_label, placeholder "Sabado";
        };
        "Monto Contribucion"   : montoContribucion, required, default 0, mask currency, label_col 4;
        "Observaciones"        : observaciones, text_area, optional, label_col 4;
    };

    footer, col 12 {
        button(save), icon save;
        button(cancel);
        addPersonasRelacionadas "Personas a cargo"  : button, on_click addPersonaRelacionada, content_style "btn-warning", icon user, hide when id == null;
        button(delete), icon remove, style "pull-right";
    };
}

form PersonaFormListing {
    header {
        message(title), col 12;
    };

    nivelNinguno:           Nivel, internal;

    filtros "Filtros": vertical, collapsible {
        nombreFiltro: String, hint "Nombre", optional, col 2;
        apellidoFiltro: String, hint "Apellido", optional, col 2;
        localidadFiltro:    Localidad, hint "Localidad", on_new_form LocalidadForm, optional, col 2;
        nivelFiltro:        Nivel, hint "Nivel", optional, col 2, on_ui_change updateComunidadFiltro;
        comunidadFiltro:    Comunidad, hint "Comunidad", filter (nivelComunidad = nivelFiltro), disable when nivelFiltro == nivelNinguno || nivelFiltro == null, on_new_form ComunidadForm, optional, col 2;
    };

    horizontal, col 12{
        buscar  "Buscar"    : button, icon search, on_click buscar, shortcut "ctrl+b";
        resetear "Resetear" : button, icon eraser, on_click resetearFiltros;
    };

    personas:   Persona, table(10), on_load loadPersonas, sortable {
        montoContribucion           : montoContribucion, internal;
        id        "Id"              : id, internal;
        nombre    "Nombre"          : nombre, display;
        apellido  "Apellido"        : apellido, display;
        edad      "Edad"            : String, display;
        nivel     "Nivel"           : nivel, display;
        comunidad "Comunidad"       : String, display;
        asistenciaJueves "J"        : asistenciaJueves, display;
        asistenciaViernes "V"       : asistenciaViernes, display;
        asistenciaSabado "S"        : asistenciaSabado, display;
        telefono  "Telefono"        : telefonoDeContacto, display;
        contribucion "Contribuyo"   : Boolean, display;
        personasACargo "Personas a cargo": Int, display;
        editarPersona "Editar" : label, on_click editarPersona, icon pencil_square_o;
    };

    footer {
        create "Create" :button, content_style "btn-primary", icon plus, on_click addPersona;
        back "Back"     :button(cancel);
    };
}

form PersonaAsistenciaRapidaForm : Persona{
    header {
        message(title), col 12;
    };

    buscarPersonaSearchBox "Buscar persona": search_box;

    descripcion: message(title), disable, hide when id == null, col 12;

    "Asistencias": horizontal, col 12 {
        id                     : id, internal, optional;
        colAsistenciaJueves    : asistenciaJueves, no_label, placeholder "Jueves";
        colAsistenciaViernes   : asistenciaViernes, no_label, placeholder "Viernes";
        colAsistenciaSabado    : asistenciaSabado, no_label, placeholder "Sabado";
    };

    "Acciones": horizontal, col 6 {
        button(save), icon save, disable when id == null;
        button(cancel);
        editarPersona "Editar": button, content_style "btn-warning", icon pencil_square_o, on_click editarPersona, disable when id == null;
    };

}