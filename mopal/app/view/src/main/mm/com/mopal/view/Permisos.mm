package com.mopal.view;

import com.mopal.model.ComunidadPastor;
import com.mopal.model.Nivel;
import com.mopal.model.UsuarioAsistente;

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

form AsignacionUsuarioAsistenteForm "" : UsuarioAsistente {
    header {
        message(entity), col 12;
    };

    "Id"        : id, internal, optional;
    "Usuario"   : usuario;
    "Asistente" : asistente;

    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
        toggle_button(deprecate), style "pull-right";
    };
}

form AsignacionUsuarioAsistenteListingForm "" {
    header {
        message(title), col 12;
    };

    asignacion: UsuarioAsistente, table(10), on_load loadUsuarioAsistente, sortable {
        id              : id, internal, optional ;
        usuario         : usuario, display;
        asistente       : asistente, display;
        btnEditar "btn" : button, on_click navigateToAsignacionUsuarioAsistenteForm;
    };

    footer {
        create "Create" : button, content_style "btn-primary", icon plus, on_click addUsuarioAsistente;
        button(cancel);
    };
}