package com.mopal.view;


import com.mopal.model.ComunidadPastor;
import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;

/** User class for form: AsignacionComunidadPastorListingForm */
public class AsignacionComunidadPastorListingForm extends AsignacionComunidadPastorListingFormBase {

    @NotNull
    @Override
    public Action addComunidadPastor() {
        return actions().navigate(AsignacionComunidadPastorForm.class);
    }

    public class AsignacionRow extends AsignacionRowBase {
        @NotNull
        @Override
        public Action navigateToAsignacionComunidadPastorForm() {
            return actions().navigate(AsignacionComunidadPastorForm.class, String.valueOf(getId()));
        }

        @Override
        public void populate(@NotNull ComunidadPastor comunidadPastor) {
            super.populate(comunidadPastor);
            setNivel(comunidadPastor.getComunidad().getNivelComunidad());
        }
    }
}
