package com.mopal.view;

import com.mopal.model.Persona;
import com.mopal.model.PersonaRelacionada;
import com.mopal.model.Localidad;
import com.mopal.model.Comunidad;
import com.mopal.model.Nivel;

form LocalidadForm "Localidad Form" : com.mopal.model.Localidad {
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };
    "Id"          : id, internal, optional;
    "Descripcion" : descripcion;
    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}

form ComunidadForm "Comunidad Form" : com.mopal.model.Comunidad {
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };
    "Id"              : id, internal, optional;
    "Nivel Comunidad" : nivelComunidad;
    "Localidad"       : localidad, on_new_form LocalidadForm;
    "Descripcion"     : descripcion;
    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}

form PersonaForm "Persona Form" : com.mopal.model.Persona {
    header {
        message(entity), col 12;
        search_box, col 4, style "pull-right";
    };
    "Id"                   : id, internal, optional;
    "Nombre"               : nombre, required;
    "Apellido"             : apellido, required;
    "Localidad"            : localidad, required, on_new_form LocalidadForm;
    "Fecha Nacimiento"     : fechaNacimiento, required;
    "Tipo Camino"          : tipoCamino, required, default INGRESANTE;
    "Nivel"                : nivel, required, disable when tipoCamino == INGRESANTE;
    "Comunidad"            : comunidad, filter (nivelComunidad = nivel), disable when nivel == NINGUNA, on_new_form ComunidadForm, optional;
    "Cantidad Pascuas"     : cantidadPascuas, required, default 0, mask decimal;
    "Cantidad Hijos"       : cantidadHijos, default 0, mask decimal, optional;
    "Telefono De Contacto" : telefonoDeContacto, required, custom_mask "####################";
    "Tipo Estado Civil"    : tipoEstadoCivil, required, default SOLTERO, optional;
    "Asistencia Jueves"    : asistenciaJueves;
    "Asistencia Viernes"   : asistenciaViernes;
    "Asistencia Sabado"    : asistenciaSabado;
    "Contribucion Pascua"  : contribucionPascua, internal, is montoContribucionValue > 0 ;
    montoContribucionValue "Monto Contribucion"    : montoContribucion, required, default 0, mask currency;
    "Observaciones"        : observaciones, optional;
    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}

form ComunidadFormListing {
    header {
        message(title), col 12;
    };

    comunidades: Comunidad, table, on_load loadComunidades, sortable {
        nivelComunidad:     nivelComunidad, display;
        localidad:          localidad, display;
        descripcion:        descripcion, display;
    };

    footer {
        create "Create" :button, on_click addComunidad;
        back "Back"     :button(cancel);
    };
}

form PersonaFormListing {
    header {
        message(title), col 12;
    };

    filtros "Filtros": vertical, collapsible {
        nombreFiltro: String, hint "Nombre", optional, col 2;
        apellidoFiltro: String, hint "Apellido", optional, col 2;
        localidadFiltro:    Localidad, hint "Localidad", on_new_form LocalidadForm, optional, col 2;
        nivelFiltro:        Nivel, hint "Nivel", optional, col 2, on_ui_change updateComunidadFiltro;
        comunidadFiltro:    Comunidad, hint "Comunidad", filter (nivelComunidad = nivelFiltro), disable when nivelFiltro == NINGUNA || nivelFiltro == null, on_new_form ComunidadForm, optional, col 2;
    };

    horizontal, col 12{
        buscar  "Buscar"    : button, icon search, on_click buscar, shortcut "ctrl+b";
        resetear "Resetear" : button, icon eraser, on_click resetearFiltros;
    };

    personas:   Persona, table(10), on_load loadPersonas, sortable {
        id        "Id"              : id, internal, optional;
        nombre    "Nombre"          : nombre, display;
        apellido  "Apellido"        : apellido, display;
        localidad "Localidad"       : localidad, display;
        edad      "Edad"            : Int, display;
        nivel     "Nivel"           : nivel, display;
        comunidad "Comunidad"       : String, display;
        asistenciaJueves "J"        : asistenciaJueves, display;
        asistenciaViernes "V"       : asistenciaViernes, display;
        asistenciaSabado "S"        : asistenciaSabado, display;
        hijos     "Hijos"           : cantidadHijos, display;
        telefono  "Telefono"        : telefonoDeContacto, display;
        contribucion "Contribuyo"   : contribucionPascua, display;
        editarPersona "Editar" : label, on_click editarPersona, icon pencil_square_o;
    };

    footer {
        create "Create" :button, on_click addPersona;
        back "Back"     :button(cancel);
    };
}

menu MopalMenu {
	PersonaForm;
	LocalidadForm;
	ComunidadFormListing;
	PersonaFormListing;
}
