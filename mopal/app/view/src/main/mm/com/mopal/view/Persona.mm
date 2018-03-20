package com.mopal.view;

import com.mopal.model.Persona;
import com.mopal.model.PersonaRelacionada;
import com.mopal.model.Localidad;
import com.mopal.model.Comunidad;

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
    "Nombre"               : nombre;
    "Apellido"             : apellido;
    "Localidad"            : localidad, on_new_form LocalidadForm;
    "Fecha Nacimiento"     : fechaNacimiento;
    "Tipo Camino"          : tipoCamino, default INGRESANTE;
    "Nivel"                : nivel, disable when tipoCamino == INGRESANTE;
    "Comunidad"            : comunidad, filter (nivelComunidad = nivel), disable when nivel == NINGUNA, on_new_form ComunidadForm, optional;
    "Cantidad Pascuas"     : cantidadPascuas, default 0, mask decimal;
    "Cantidad Hijos"       : cantidadHijos, default 0, mask decimal, optional;
    "Telefono De Contacto" : telefonoDeContacto;
    "Tipo Estado Civil"    : tipoEstadoCivil, default SOLTERO, optional;
    "Asistencia Jueves"    : asistenciaJueves;
    "Asistencia Viernes"   : asistenciaViernes;
    "Asistencia Sabado"    : asistenciaSabado;
    contribucionPascua "Contribucion Pascua"  : Boolean, display, is montoContribucion > 0 ;
    montoContribucion "Monto Contribucion"    : Decimal, default 0, mask decimal;
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

    personas:   Persona, table(10), on_load loadPersonas, sortable {
        id        "Id"              : id, internal, optional;
        nombre    "Nombre"          : nombre, display;
        apellido  "Apellido"        : apellido, display;
        localidad "Localidad"       : localidad, display;
        edad      "Edad"            : Int, display;
        nivel     "Nivel"           : nivel, display;
        comunidad "Comunidad"       : String, display;
        hijos     "Hijos"           : cantidadHijos, display;
        telefono  "Telefono"        : telefonoDeContacto, display;
        contribucion "Contribuyo"   : contribucionPascua, display;
    };

    footer {
        create "Create" :button, on_click addPersona;
        back "Back"     :button(cancel);
    };
}

menu MopalMenu {
	PersonaForm;
	ComunidadFormListing;
	PersonaFormListing;
}
