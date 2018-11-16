package com.mopal.view;

import com.mopal.model.AsistenteAsamblea;
import tekgenesis.form.Action;
import com.mopal.model.AsistenteRetiroPascua;
import org.jetbrains.annotations.NotNull;

/** User class for form: AsistenteRetiroPascuaForm */
public class AsistenteRetiroPascuaForm extends AsistenteRetiroPascuaFormBase {
    //~ Methods ..................................................................................................................

    @Override
    public void load() {
        super.load();
        if(isDefined(AsistenteRetiroPascuaFormBase.Field.EVENTO) && isDefined(AsistenteRetiroPascuaFormBase.Field.PERSONA)) setHidePersonasReleacionadas(false);
    }

    /** Invoked to find an entity instance */
    @Override @NotNull public AsistenteRetiroPascua find() {
        return super.find();
    }

    /** Invoked when creating a form instance */
    @Override @NotNull public Action create() {
        final AsistenteAsamblea asistenteasistenteAsamblea = AsistenteAsamblea.create(getEvento().getId(), getPersona().getId());
        asistenteasistenteAsamblea.setObservaciones(getObservaciones());
        asistenteasistenteAsamblea.persist();
        return actions().getDefault();
    }

    /** Invoked when button(addPersonasRelacionadas) is clicked */
    @Override @NotNull public Action addPersonaRelacionada() {
        final PersonaRelacionadaAsambleaForm personaRelacionadaAsamblea = forms.initialize(PersonaRelacionadaAsambleaForm.class);
        personaRelacionadaAsamblea.setIdEvento(getEvento().getId());
        personaRelacionadaAsamblea.setAsistenteResponsable(getPersona());
        personaRelacionadaAsamblea.loadPersonasRelacionadas();
        return actions().navigate(personaRelacionadaAsamblea);
    }
}
