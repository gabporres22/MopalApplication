package com.mopal.view;

import com.mopal.model.Persona;
import com.mopal.model.PersonaRelacionada;
import com.mopal.model.Barrio;
import com.mopal.model.Localidad;
import com.mopal.model.Comunidad;
import com.mopal.model.Nivel;


form PersonaRelacionadaForm "Persona Relacionada Form" : PersonaRelacionada {
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };
    "Id"                 : id, internal, optional;
    "Persona"            : persona;
    "Nombre"             : nombre;
    "Apellido"           : apellido;
    "Fecha Nacimiento"   : fechaNacimiento;
    "Grupo Referencia"   : grupoReferencia;
    "Asistencia Jueves"  : asistenciaJueves;
    "Asistencia Viernes" : asistenciaViernes;
    "Asistencia Sabado"  : asistenciaSabado;
    "Observaciones"      : observaciones;
    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}


form PersonaForm "Persona Form" : Persona {
    header {
        message(entity), col 12;
        search_box, col 4, style "pull-right";
    };

    nivelNinguno    : Nivel, internal;

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
        button(save);
        button(cancel);
        addPersonasRelacionadas "Agregar personas a cargo"  : button, on_click addPersonaRelacionada, hide when id == null;
        button(delete), style "pull-right";
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
        localidad "Localidad"       : String, display;
        edad      "Edad"            : Int, display;
        nivel     "Nivel"           : nivel, display;
        comunidad "Comunidad"       : String, display;
        asistenciaJueves "J"        : asistenciaJueves, display;
        asistenciaViernes "V"       : asistenciaViernes, display;
        asistenciaSabado "S"        : asistenciaSabado, display;
        hijos     "Hijos"           : cantidadHijos, display;
        telefono  "Telefono"        : telefonoDeContacto, display;
        contribucion "Contribuyo"   : Boolean, display;
        editarPersona "Editar" : label, on_click editarPersona, icon pencil_square_o;
    };

    footer {
        create "Create" :button, on_click addPersona;
        back "Back"     :button(cancel);
    };
}