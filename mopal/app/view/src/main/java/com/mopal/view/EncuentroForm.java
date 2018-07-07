package com.mopal.view;

import com.mopal.model.DetalleAsistenciaEncuentro;
import com.mopal.model.Encuentro;
import com.mopal.model.g.AsistenteTable;
import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;

import static com.mopal.model.g.AsistenteBase.listWhere;
import static com.mopal.view.DetalleAsistenciaEncuentroListingFormBase.parameters;

/** User class for form: EncuentroForm */
public class EncuentroForm extends EncuentroFormBase {
    @Override
    public void load() {
        super.load();
        if(getId() != null){
            final Encuentro encuentro = Encuentro.find(getId());
            setNivel(encuentro.getComunidad().getNivelComunidad());
        }
    }

    @NotNull
    @Override
    public Action create() {
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
