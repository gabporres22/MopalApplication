package com.mopal.view;

import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;

import static tekgenesis.common.core.DateOnly.current;

/** User class for form: AsistenteForm */
public class AsistenteForm extends AsistenteFormBase {
    @NotNull
    @Override
    public Action updateEdad() {
        setEdadValue(String.valueOf(current().yearsFrom(getFechaNacimiento())) + " años");
        return actions().getDefault();
    }

    //~ Methods ..................................................................................................................


}
