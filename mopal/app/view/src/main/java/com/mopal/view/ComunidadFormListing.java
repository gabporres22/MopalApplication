package com.mopal.view;


import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;
import tekgenesis.form.MappingCallback;

/** User class for form: ComunidadFormListing */
public class ComunidadFormListing
    extends ComunidadFormListingBase
{

    @NotNull
    @Override
    public Action addComunidad() {
        return actions().navigate(ComunidadForm.class).callback(ComunidadFormMapping.class);
    }

    public class ComunidadesRow extends ComunidadesRowBase {
        @NotNull
        @Override
        public Action editarComunidad() {
            final ComunidadesRow current = getComunidades().getCurrent();
            final ComunidadForm newForm = forms.initialize(ComunidadForm.class, String.valueOf(current.getId()));
            forms.asUpdate();
            return actions.navigate(newForm).callback(ComunidadFormMapping.class);
        }
    }
    
    public static class ComunidadFormMapping implements MappingCallback<ComunidadForm, ComunidadFormListing> {
        @Override
        public void onSave(@NotNull ComunidadForm base, @NotNull ComunidadFormListing out) {
            out.getComunidades().clear();
            out.loadComunidades();
        }
    }
}
