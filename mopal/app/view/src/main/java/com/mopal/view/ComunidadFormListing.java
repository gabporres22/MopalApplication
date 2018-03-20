package com.mopal.view;


import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;

/** User class for form: ComunidadFormListing */
public class ComunidadFormListing
    extends ComunidadFormListingBase
{

    @NotNull
    @Override
    public Action addComunidad() {
        return actions().navigate(ComunidadForm.class);
    }

    public class ComunidadesRow extends ComunidadesRowBase {
    }
}
