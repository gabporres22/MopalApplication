package com.mopal.view;

import com.mopal.model.Evento;


form EventoForm : com.mopal.model.Evento {
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };

    "Id"              : id, internal, optional;
    "Descripcion"     : descripcion;
    "Tipo Evento"     : tipoEvento;
    "Monto Soltero"   : montoSoltero, mask currency;
    "Monto Matrimonio": montoMatrimonio, mask currency;
    "Monto Niño"      : montoNiño, mask currency;
    "Monto Niños Dto.": montoNiñosDescuento, mask currency;
    "Activo"          : activo;

    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}


form EventoListing "Evento Listing" {
    header {
        message(title), col 12;
    };
    eventos    : com.mopal.model.Evento, table, on_change saveEvento, on_load loadEventos, sortable {
        "Id"              : id, display;
        "Descripcion"     : descripcion, display;
        "Tipo Evento"     : tipoEvento, display;
        "Monto Soltero"   : montoSoltero, display;
        "Monto Matrimonio": montoMatrimonio, display;
        "Monto Niño"      : montoNiño, display;
        "Monto Niños Dto.": montoNiñosDescuento, display;
        "Activo"          : activo;
        "Editar"          : button, on_click editarEvento;
    };
    horizontal, style "margin-top-20" {
        addButton "Agregar": button, disable when forbidden(create), on_click createEvento, style "margin-right-5";
        button(remove_row, eventos), disable when forbidden(delete), on_click removeEvento;
    };
}

form AbstractABMForm on_display redirect;
form AbstractListingForm on_display redirect;