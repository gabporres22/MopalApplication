package com.mopal.view;


import com.mopal.model.Encuentro;
import com.mopal.model.g.EncuentroBase;
import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;

import static com.mopal.view.DetalleAsistenciaEncuentroListingFormBase.parameters;

/** User class for form: EncuentroListingForm */
public class EncuentroListingForm extends EncuentroListingFormBase {
    @Override
    public void load() {
        super.load();
        loadEncuentros();
    }

    public void loadEncuentros(){
        getEncuentros().clear();
        EncuentroBase.listAll().toList().forEach(encuentro -> getEncuentros().add().populate(encuentro));
    }

    @NotNull
    @Override
    public Action addEncuentro() {
        return actions().navigate(EncuentroForm.class);
    }

    public class EncuentrosRow extends EncuentrosRowBase {
        @Override
        public void populate(@NotNull Encuentro encuentro) {
            super.populate(encuentro);
            setNivel(encuentro.getComunidad().getNivelComunidad());
        }

        @NotNull
        @Override
        public Action navigateToEncuentroForm() {
            return actions().navigate(EncuentroForm.class, String.valueOf(getId()));
        }

        @NotNull
        @Override
        public Action navigateToDetalleAsistencias() {
            return actions().navigate(DetalleAsistenciaEncuentroListingForm.class).withParameters(parameters().withIdEncuentro(getId()));
        }
    }
}
