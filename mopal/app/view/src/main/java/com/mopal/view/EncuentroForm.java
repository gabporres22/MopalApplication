package com.mopal.view;

import com.mopal.model.Comunidad;
import com.mopal.model.ComunidadPastor;
import com.mopal.model.DetalleAsistenciaEncuentro;
import com.mopal.model.Encuentro;
import com.mopal.model.Nivel;
import com.mopal.model.g.AsistenteTable;
import com.mopal.model.g.ComunidadPastorBase;
import com.mopal.model.g.ComunidadTable;
import org.jetbrains.annotations.NotNull;
import tekgenesis.authorization.User;
import tekgenesis.common.collections.ImmutableList;
import tekgenesis.form.Action;

import static com.mopal.model.g.AsistenteBase.listWhere;
import static com.mopal.model.g.ComunidadPastorTable.COMUNIDAD_PASTOR;
import static com.mopal.model.g.ComunidadTable.COMUNIDAD;
import static com.mopal.view.DetalleAsistenciaEncuentroListingFormBase.parameters;
import static tekgenesis.authorization.shiro.AuthorizationUtils.getCurrentUser;

/** User class for form: EncuentroForm */
public class EncuentroForm extends EncuentroFormBase {
    final User currentUser = getCurrentUser();

    @Override
    public void load() {
        super.load();
        loadComboOptions();

        if(getId() != null){
            final Encuentro encuentro = Encuentro.find(getId());
            setNivel(encuentro.getComunidad().getNivelComunidad());
        }
    }

    private void loadComboOptions() {
        if(currentUser.getId().equals("admin")) {
            setNivelOptions(Nivel.listAll());
        } else {
            final ImmutableList<ComunidadPastor> comunidades = ComunidadPastorBase.listWhere(COMUNIDAD_PASTOR.PASTOR_ID.eq(currentUser.getId())).toList();

            setNivelOptions(comunidades.map(comunidad -> comunidad.getComunidad().getNivelComunidad()));
        }
    }

    @NotNull
    @Override
    public Action loadComunidadOptions() {
        if(currentUser.getId().equals("admin")) {
            final ImmutableList<Comunidad> comunidades = Comunidad.listWhere(ComunidadTable.COMUNIDAD.NIVEL_COMUNIDAD_ID.eq(getNivel().getId())).toList();

            setComunidad(null);
            setComunidadOptions(comunidades);
        } else {
            final ImmutableList<ComunidadPastor> comunidades = ComunidadPastorBase.listWhere(COMUNIDAD_PASTOR.PASTOR_ID.eq(currentUser.getId()).and(COMUNIDAD.NIVEL_COMUNIDAD_ID.eq(getNivel().getId()))).join(COMUNIDAD, COMUNIDAD.ID.eq(COMUNIDAD_PASTOR.COMUNIDAD_ID)).toList();

            setComunidad(null);
            setComunidadOptions(comunidades.map(comunidad -> comunidad.getComunidad()));
        }

        return actions().getDefault();
    }

    @NotNull
    @Override
    public Action create() {
        if(getNivel() == null || getComunidad() == null) {
            return actions().getError().withMessage("Se debe indicar el Nivel y la Comunidad.");
        }

        super.create();
        final Encuentro encuentro = Encuentro.find(getId());

        if(encuentro == null) {
            return actions().getError().withMessage("No se pudo obtener el encuentro generado.");
        }

        populateDetalleAsistencia(encuentro);

        return actions().navigate(DetalleAsistenciaEncuentroListingForm.class).withParameters(
                parameters().withIdEncuentro(encuentro.getId()));
    }

    private void populateDetalleAsistencia(final Encuentro encuentro) {
        listWhere(AsistenteTable.ASISTENTE.COMUNIDAD_ID.eq(encuentro.getComunidad().getId())).toList()
                .forEach(asistente -> {
                    final DetalleAsistenciaEncuentro detalleAsistenciaEncuentro = DetalleAsistenciaEncuentro.create();
                    detalleAsistenciaEncuentro.setEncuentro(encuentro);
                    detalleAsistenciaEncuentro.setPersona(asistente);
                    detalleAsistenciaEncuentro.persist();
                });
    }
}
