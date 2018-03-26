package com.mopal.view;

import com.mopal.model.Persona;
import tekgenesis.form.Action;
import org.jetbrains.annotations.NotNull;
import tekgenesis.form.MappingCallback;

import static com.mopal.view.PersonaAsistenciaRapidaFormBase.Field.BUSCAR_PERSONA_SEARCH_BOX;

/** User class for form: PersonaAsistenciaRapidaForm */
public class PersonaAsistenciaRapidaForm extends PersonaAsistenciaRapidaFormBase {

    //~ Methods ..................................................................................................................

    @NotNull
    @Override
    public Persona find() {
        final Persona persona = super.find();
        setDescripcion(persona.getNombre() + " " + persona.getApellido());
        return persona;
    }

    /** Invoked when button(editarPersona) is clicked */
    @Override @NotNull public Action editarPersona() {
        if(getId() == null)
            return actions().getError().withMessage("Se debe buscar a una persona primero");

        final PersonaForm newForm = forms.initialize(PersonaForm.class, String.valueOf(getId()));
        forms.asUpdate();
        return actions.navigate(newForm).callback(PersonaAsistenciaRapidaFormMapping.class);
    }

    public static class PersonaAsistenciaRapidaFormMapping implements MappingCallback<PersonaForm, PersonaAsistenciaRapidaForm> {
        @Override
        public void onSave(@NotNull PersonaForm base, @NotNull PersonaAsistenciaRapidaForm out) {
        }
    }
}
