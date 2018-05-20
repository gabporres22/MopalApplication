package com.mopal.view;

import com.mopal.model.AsistenteRetiroPascua;
import com.mopal.model.Asistente;

form AsistenteRetiroPascuaForm "Asistente Retiro Pascua Form" : AsistenteRetiroPascua {
    header {
        message(entity), col 12;
    };

    "Evento"                : evento;
    "Tipo Camino"           : tipoCamino, default INGRESANTE;
    "Persona"               : persona, on_new_form AsistenteForm;
    "Cantidad De Pascuas"   : cantidadDePascuas, mask decimal;
    "Asistencia Jueves"     : asistenciaJueves;
    "Asistencia Viernes"    : asistenciaViernes;
    "Asistencia Sabado"     : asistenciaSabado;
    "Monto Contribucion"    : montoContribucion, mask decimal;
    "Observaciones"         : observaciones, optional;

    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}