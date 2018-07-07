package com.mopal.view;


import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;

/** User class for form: AsignacionUsuarioAsistenteListingForm */
public class AsignacionUsuarioAsistenteListingForm extends AsignacionUsuarioAsistenteListingFormBase {

    @NotNull
    @Override
    public Action addUsuarioAsistente() {
        return actions().navigate(AsignacionUsuarioAsistenteForm.class);
    }

    public class AsignacionRow extends AsignacionRowBase {
        @NotNull
        @Override
        public Action navigateToAsignacionUsuarioAsistenteForm() {
            return actions().navigate(AsignacionUsuarioAsistenteForm.class, String.valueOf(getId()));
        }
    }
}
