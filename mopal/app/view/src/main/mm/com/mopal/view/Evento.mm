package com.mopal.view;

import com.mopal.model.Evento;


form EventoForm : com.mopal.model.Evento {
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };

    "Id"                 : id, internal, optional;
    "Descripcion"        : descripcion;
    "Tipo Evento"        : tipoEvento;
    "Activo"             : activo;

    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}


form AbstractABMForm on_display redirect;
form AbstractListingForm on_display redirect;