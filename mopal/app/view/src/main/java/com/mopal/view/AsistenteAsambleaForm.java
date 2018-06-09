package com.mopal.view;

import tekgenesis.form.Action;
import org.jetbrains.annotations.NotNull;
import com.mopal.model.AsistenteAsamblea;

/** User class for form: AsistenteAsambleaForm */
public class AsistenteAsambleaForm extends AsistenteAsambleaFormBase {

    //~ Methods ..................................................................................................................

    @Override
    public void load() {
        super.load();
        if(isDefined(Field.EVENTO) && isDefined(Field.PERSONA)) setHidePersonasReleacionadas(false);
    }

    /** Invoked to find an entity instance */
    @Override @NotNull public AsistenteAsamblea find() {
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
