package com.mopal.view;

import com.mopal.model.*;
import com.mopal.model.g.ComunidadPastorBase;
import com.mopal.model.g.ComunidadTable;
import org.jetbrains.annotations.NotNull;
import tekgenesis.authorization.User;
import tekgenesis.common.collections.ImmutableList;
import tekgenesis.common.core.DateOnly;
import tekgenesis.common.core.Option;
import tekgenesis.form.Action;
import tekgenesis.form.MappingCallback;
import tekgenesis.model.KeyMap;
import tekgenesis.persistence.Select;

import static com.mopal.model.Encuentro.listAllByUser;
import static com.mopal.model.g.ComunidadPastorTable.COMUNIDAD_PASTOR;
import static com.mopal.model.g.ComunidadTable.COMUNIDAD;
import static com.mopal.model.g.DetalleAsistenciaEncuentroBase.listWhere;
import static com.mopal.model.g.DetalleAsistenciaEncuentroTable.DETALLE_ASISTENCIA_ENCUENTRO;
import static com.mopal.view.DetalleAsistenciaEncuentroListingFormBase.parameters;
import static tekgenesis.authorization.shiro.AuthorizationUtils.getCurrentUser;
import static tekgenesis.common.core.Option.none;
import static tekgenesis.common.core.Option.option;

/** User class for form: EncuentroListingForm */
public class EncuentroListingForm extends EncuentroListingFormBase {
    final User currentUser = getCurrentUser();

    @Override
    public void load() {
        super.load();
        buscarEncuentros(none(), none(), none(), none());
        loadComboOptions();
    }

    private void loadComboOptions() {
        if(currentUser.getId().equals("admin")) {
            setNivelFiltroOptions(Nivel.listAll());
        } else {
            final ImmutableList<ComunidadPastor> comunidades = ComunidadPastorBase.listWhere(COMUNIDAD_PASTOR.PASTOR_ID.eq(currentUser.getId())).toList();

            setNivelFiltroOptions(comunidades.map(comunidad -> comunidad.getComunidad().getNivelComunidad()));
        }
    }

    @NotNull
    @Override
    public Action loadComunidadOptions() {
        if(currentUser.getId().equals("admin")) {
            final ImmutableList<Comunidad> comunidades = Comunidad.listWhere(COMUNIDAD.NIVEL_COMUNIDAD_ID.eq(getNivelFiltro().getId())).toList();

            setComunidadFiltro(null);
            setComunidadFiltroOptions(comunidades);
        } else {
            final ImmutableList<ComunidadPastor> comunidades = ComunidadPastorBase.listWhere(COMUNIDAD_PASTOR.PASTOR_ID.eq(currentUser.getId()).and(COMUNIDAD.NIVEL_COMUNIDAD_ID.eq(getNivelFiltro().getId()))).join(COMUNIDAD, COMUNIDAD.ID.eq(COMUNIDAD_PASTOR.COMUNIDAD_ID)).toList();

            setComunidadFiltro(null);
            setComunidadFiltroOptions(comunidades.map(comunidad -> comunidad.getComunidad()));
        }

        return actions().getDefault();
    }

    public Action buscarEncuentros(final Option<Nivel> nivel, final Option<Comunidad> comunidad, final Option<DateOnly> fechaDesde, final Option<DateOnly> fechaHasta) {
        getEncuentros().clear();
        listAllByUser(currentUser, nivel, comunidad, fechaDesde, fechaHasta).forEach(encuentro -> getEncuentros().add().populate(encuentro));

        return actions().getDefault();
    }

    @NotNull
    @Override
    public Action buscar() {
        if(option(getFechaDesdeFiltro()).isPresent() && option(getFechaHastaFiltro()).isPresent() && getFechaHastaFiltro().isLessThan(getFechaDesdeFiltro()))
            return actions().getError().withMessage("Las fechas de búsqueda deben tener un criterio válido.");

        return buscarEncuentros(option(getNivelFiltro()), option(getComunidadFiltro()), option(getFechaDesdeFiltro()), option(getFechaHastaFiltro()));
    }

    @NotNull
    @Override
    public Action resetearFiltros() {
        buscarEncuentros(none(), none(), none(), none());
        loadComboOptions();

        return actions().getStay();
    }

    @NotNull
    @Override
    public Action addEncuentro() {
        return actions().navigate(EncuentroForm.class).callback(EncuentroCallback.class);
    }

    public static class EncuentroCallback implements MappingCallback<EncuentroForm, EncuentroListingForm> {
        @Override
        public void onSave(@NotNull EncuentroForm base, @NotNull EncuentroListingForm out) {
            out.resetearFiltros();
        }
    }

    public class EncuentrosRow extends EncuentrosRowBase {
        @Override
        public void populate(@NotNull Encuentro encuentro) {
            super.populate(encuentro);
            setNivel(encuentro.getComunidad().getNivelComunidad());
            final ImmutableList<DetalleAsistenciaEncuentro> detalleAsistencia = listWhere(DETALLE_ASISTENCIA_ENCUENTRO.ENCUENTRO_ID.eq(encuentro.getId())).toList();
            setAsistencias(detalleAsistencia.filter(asistencia -> asistencia.isPresente()).size() + " / " + detalleAsistencia.size());
        }

        @NotNull
        @Override
        public Action navigateToDetalleAsistencias() {
            return actions().navigate(DetalleAsistenciaEncuentroListingForm.class).withParameters(parameters().withIdEncuentro(getId()));
        }
    }
}
