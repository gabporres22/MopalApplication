package com.mopal.view;

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

    "": horizontal, col 12 {
        "Foto": imagen, optional;
    };

    footer, col 12 {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}

form AsistenteFormListing on_load load{
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
        exportar "Descargar": button(export), export_type csv;
        create "Create" : button, content_style "btn-primary", icon plus, on_click addAsistente;
        back "Back"     : button(cancel);
    };
}