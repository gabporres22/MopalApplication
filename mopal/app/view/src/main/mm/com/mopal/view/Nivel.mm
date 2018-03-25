package com.mopal.view;

import com.mopal.model.Nivel;

form NivelForm "Nivel Form" : Nivel {
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };
    "Id"          : id, internal, optional;
    "Descripcion" : descripcion;
    "Orden"       : orden;
    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}

form NivelFormListing {
    header {
        message(title), col 12;
    };

    niveles: Nivel, table(10), on_load loadNiveles, sortable{
        id              : id, internal;
        descripcion     : descripcion, display;
        orden           : orden, display;
        editar "Editar" : label, on_click editar, icon pencil_square_o;
    };

    footer {
        create "Create" :button, on_click crearNivel;
        back "Back"     :button(cancel);
    };
}