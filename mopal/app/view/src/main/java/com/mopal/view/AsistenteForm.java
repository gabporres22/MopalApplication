package com.mopal.view;

import com.mopal.model.Asistente;
import com.mopal.model.g.AsistenteBase;
import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;

/** User class for form: AsistenteForm */
public class AsistenteForm extends AsistenteFormBase {

    //~ Methods ..................................................................................................................

    @NotNull
    @Override
    public Action create() {
        final AsistenteWidget asistente = getAsistente();
        final Asistente asistenteObj = Asistente.create();
        asistente.copyTo(asistenteObj);
        asistenteObj.persist();
        setId(asistenteObj.getId());
        return actions().getDefault();
    }

    @NotNull
    @Override
    public Asistente populate() {
        final Asistente asistente = find();
        getAsistente().populate(asistente);
        return asistente;
    }

    @NotNull
    @Override
    public Action update() {
        final Asistente asistente = find();
        getAsistente().copyTo(asistente);
        asistente.update();
        return actions().getDefault();
    }

    @NotNull
    @Override
    public Asistente find() {
        return super.find();
    }
}
