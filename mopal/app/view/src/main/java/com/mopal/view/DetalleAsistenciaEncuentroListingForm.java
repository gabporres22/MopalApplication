package com.mopal.view;


import com.mopal.model.DetalleAsistenciaEncuentro;
import com.mopal.model.Encuentro;
import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;

import static com.mopal.model.g.DetalleAsistenciaEncuentroBase.find;
import static com.mopal.model.g.DetalleAsistenciaEncuentroBase.listWhere;
import static com.mopal.model.g.DetalleAsistenciaEncuentroTable.DETALLE_ASISTENCIA_ENCUENTRO;

/** User class for form: DetalleAsistenciaEncuentroListingForm */
public class DetalleAsistenciaEncuentroListingForm extends DetalleAsistenciaEncuentroListingFormBase {
    @Override
    public void load() {
        super.load();
        final Encuentro encuentro = Encuentro.find(getIdEncuentro());
        setEncuentro(encuentro);
        setNivel(getEncuentro().getComunidad().getNivelComunidad());
        setComunidad(getEncuentro().getComunidad());
        setFechaEncuentro(getEncuentro().getFechaEncuentro());
        setObservaciones(getEncuentro().getObservaciones());

        loadAsistentes();
    }

    public void loadAsistentes() {
        getAsistentes().clear();

        listWhere(DETALLE_ASISTENCIA_ENCUENTRO.ENCUENTRO_ID.eq(getEncuentro().getId())).toList()
                .forEach(detalleAsistencia -> {
                            getAsistentes().add().populate(detalleAsistencia);
                        }
                );
    }

    @NotNull
    @Override
    public Action saveAsistencia() {
        super.saveAsistencia();
        final AsistentesRow currentRow = getAsistentes().getCurrent();
        final DetalleAsistenciaEncuentro detalleAsistenciaEncuentro = find(currentRow.getId());
        detalleAsistenciaEncuentro.setPresente(currentRow.isPresente());
        detalleAsistenciaEncuentro.setObservaciones(currentRow.getObservacion());
        detalleAsistenciaEncuentro.update();
        return actions().getDefault();
    }

    public class AsistentesRow extends AsistentesRowBase {
        @NotNull
        @Override
        public Action navigateToDetalleAsistenciaEncuentro() {
            return actions().navigate(DetalleAsistenciaEncuentroForm.class, String.valueOf(getId()));
        }

        @Override
        public void populate(@NotNull DetalleAsistenciaEncuentro detalleAsistenciaEncuentro) {
            super.populate(detalleAsistenciaEncuentro);
            setNombre(detalleAsistenciaEncuentro.getPersona().getNombre());
            setApellido(detalleAsistenciaEncuentro.getPersona().getApellido());
            setPresente(detalleAsistenciaEncuentro.isPresente());
            setObservacion(detalleAsistenciaEncuentro.getObservaciones());
        }


    }
}
