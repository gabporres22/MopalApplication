package com.mopal.view;

form BarrioForm "Barrio Form" : com.mopal.model.Barrio {
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };
    disableLocalidad : Boolean, internal, default false;

    "Id"          : id, internal, optional;
    "Localidad"   : localidad, disable when disableLocalidad;
    "Descripcion" : descripcion;
    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}