package com.mopal.view;

import com.mopal.model.Localidad;

form LocalidadForm "Localidad Form" : Localidad {
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

form LocalidadFormListing {
    header {
        message(title), col 12;
    };

    localidades: Localidad, table(10), on_load loadLocalidades, sortable {
        id              : id, internal;
        descripcion     : descripcion, display;
        editar "Editar" : button, on_click editar, icon pencil_square_o;
    };

    footer {
        create "Create" :button, on_click crearLocalidad;
        back "Back"     :button(cancel);
    };
}