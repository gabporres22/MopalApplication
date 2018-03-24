package com.mopal.view;


import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;
import tekgenesis.form.MappingCallback;

/** User class for form: LocalidadFormListing */
public class LocalidadFormListing
    extends LocalidadFormListingBase
{

    @NotNull
    @Override
    public Action crearLocalidad() {
        return actions().navigate(LocalidadForm.class).callback(LocalidadFormMapping.class);
    }

    public class LocalidadesRow extends LocalidadesRowBase {
        @NotNull
        @Override
        public Action editar() {
            final LocalidadesRow current = getLocalidades().getCurrent();
            final LocalidadForm newForm = forms.initialize(LocalidadForm.class, String.valueOf(current.getId()));
            forms.asUpdate();
            return actions.navigate(newForm).callback(LocalidadFormMapping.class);

        }
    }

    public static class LocalidadFormMapping implements MappingCallback<LocalidadForm, LocalidadFormListing> {
        @Override
        public void onSave(@NotNull LocalidadForm base, @NotNull LocalidadFormListing out) {
            out.getLocalidades().clear();
            out.loadLocalidades();
        }
    }
}
