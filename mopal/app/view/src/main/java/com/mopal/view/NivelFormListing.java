package com.mopal.view;

import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;
import tekgenesis.form.MappingCallback;

/** User class for form: NivelFormListing */
public class NivelFormListing extends NivelFormListingBase {
    @NotNull
    @Override
    public Action crearNivel() {
        final NivelForm newForm = forms.initialize(NivelForm.class);

        if(getNiveles().size() > 0) {
            newForm.setOrden(getNiveles().get(getNiveles().size() - 1).getOrden() + 1);
        } else{
            newForm.setOrden(0);
        }

        return actions().navigate(newForm).callback(NivelFormMapping.class);
    }

    //~ Inner Classes ............................................................................................................

    public class NivelesRow extends NivelesRowBase {
        @NotNull
        @Override
        public Action editar() {
            final NivelesRow current = getNiveles().getCurrent();
            final NivelForm newForm = forms.initialize(NivelForm.class, String.valueOf(current.getId()));
            forms.asUpdate();
            return actions.navigate(newForm).callback(NivelFormMapping.class);
        }
    }

    public static class NivelFormMapping implements MappingCallback<NivelForm, NivelFormListing> {
        @Override
        public void onSave(@NotNull NivelForm base, @NotNull NivelFormListing out) {
            out.getNiveles().clear();
            out.loadNiveles();
        }
    }
}
