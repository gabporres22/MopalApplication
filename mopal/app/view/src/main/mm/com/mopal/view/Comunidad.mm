package com.mopal.view;

import com.mopal.model.Comunidad;

form ComunidadForm "Comunidad Form" : Comunidad {
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };
    disableNivel        : Boolean, internal, default false;
    "Id"                : id, internal, optional;
    "Nivel Comunidad"   : nivelComunidad, disable when disableNivel;
    "Descripcion"       : descripcion;
    "Cantidad Personas" : cantidadPersonas;
    footer {
        button(save), icon save;
        button(cancel);
        button(delete), icon remove, style "pull-right";
    };
}

form ComunidadFormListing {
    header {
        message(title), col 12;
    };

    comunidades: Comunidad, table, on_load loadComunidades, sortable {
        id              : id, internal;
        nivelComunidad  : nivelComunidad, display;
        descripcion     : descripcion, display;
        cantidad        : cantidadPersonas, display;
        editar "Editar" : label, on_click editarComunidad, icon pencil_square_o;
    };

    footer {
        create "Create" :button, content_style "btn-primary", icon plus, on_click addComunidad;
        back "Back"     :button(cancel);
    };
}