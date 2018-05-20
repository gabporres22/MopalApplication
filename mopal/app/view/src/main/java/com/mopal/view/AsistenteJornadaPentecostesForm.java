package com.mopal.view;

import tekgenesis.form.Action;
import com.mopal.model.AsistenteJornadaPentecostes;
import org.jetbrains.annotations.NotNull;
import tekgenesis.form.MappingCallback;

/** User class for form: AsistenteJornadaPentecostesForm */
public class AsistenteJornadaPentecostesForm extends AsistenteJornadaPentecostesFormBase {
    //~ Methods ..................................................................................................................


    @Override
    public void load() {
        super.load();
        if(isDefined(Field.EVENTO) && isDefined(Field.PERSONA)) setHidePersonasReleacionadas(false);
    }

    /** Invoked when creating a form instance */
    @Override @NotNull public Action create() {
        final AsistenteJornadaPentecostes asistenteJornadaPentecostes = AsistenteJornadaPentecostes.create(getEvento().getId(), getPersona().getId());
        asistenteJornadaPentecostes.setMontoContribucion(getMontoContribucion());
        asistenteJornadaPentecostes.setObservaciones(getObservaciones());
        asistenteJornadaPentecostes.persist();
        return actions().getDefault();
    }

    /** Invoked to find an entity instance */
    @Override @NotNull public AsistenteJornadaPentecostes find() {
        return super.find();
    }

    @NotNull
    @Override
    public Action addPersonaRelacionada() {
        final PersonaRelacionadaJornadaPentecostesForm personaRelacionadaJornadaPentecostesForm = forms.initialize(PersonaRelacionadaJornadaPentecostesForm.class);
        personaRelacionadaJornadaPentecostesForm.setIdEvento(getEvento().getId());
        personaRelacionadaJornadaPentecostesForm.setAsistenteResponsable(getPersona());
        personaRelacionadaJornadaPentecostesForm.loadPersonasRelacionadas();
        return actions().navigate(personaRelacionadaJornadaPentecostesForm);
    }
}
