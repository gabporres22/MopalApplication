package com.mopal.view;

import com.mopal.model.ComunidadPastor;
import com.mopal.model.Nivel;

form AsignacionComunidadPastorForm "" : ComunidadPastor {
    header {
        message(entity), col 12;
    };

    "Id"            : id, internal, optional;
    nivel "Nivel"   : Nivel, disable when id != null;
    "Comunidad"     : comunidad, filter (nivelComunidad = nivel), disable when nivel == null || id != null, required;
    "Pastor"        : pastor, disable when id != null;

    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
        toggle_button(deprecate), style "pull-right";
    };
}

form AsignacionComunidadPastorListingForm "" {
    header {
        message(title), col 12;
    };

    asignacion : ComunidadPastor, table(10), on_load loadComunidadPastor, sortable {
        id          : id, internal, optional ;
        nivel "Niv" : Nivel, display;
        comunidad   : comunidad, display;
        pastor      : pastor, display;
        btnEditar "btn"  : button, on_click navigateToAsignacionComunidadPastorForm;
    };

    footer {
        create "Create" : button, content_style "btn-primary", icon plus, on_click addComunidadPastor;
        button(cancel);
    };
}
