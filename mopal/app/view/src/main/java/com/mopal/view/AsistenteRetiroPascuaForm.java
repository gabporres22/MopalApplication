package com.mopal.view;

import tekgenesis.form.Action;
import com.mopal.model.AsistenteRetiroPascua;
import org.jetbrains.annotations.NotNull;

/** User class for form: AsistenteRetiroPascuaForm */
public class AsistenteRetiroPascuaForm extends AsistenteRetiroPascuaFormBase {
    //~ Methods ..................................................................................................................

    /** Invoked when creating a form instance */
    @Override @NotNull public Action create() {
        final AsistenteRetiroPascua asistenteRetiroPascua = AsistenteRetiroPascua.create(getEvento().getId(), getPersona().getId());
        asistenteRetiroPascua.persist();
        return actions().getDefault();
    }

    /** Invoked to find an entity instance */
    @Override @NotNull public AsistenteRetiroPascua find() {
        return super.find();
    }
}
