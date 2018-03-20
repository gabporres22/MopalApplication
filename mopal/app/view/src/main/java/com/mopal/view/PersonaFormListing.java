package com.mopal.view;


import com.mopal.model.Persona;
import org.jetbrains.annotations.NotNull;
import tekgenesis.common.core.DateOnly;
import tekgenesis.form.Action;

/** User class for form: PersonaFormListing */
public class PersonaFormListing
    extends PersonaFormListingBase
{

    @NotNull
    @Override
    public Action addPersona() {
        return actions().navigate(PersonaForm.class);
    }

    public class PersonasRow extends PersonasRowBase {
        @Override
        public void populate(@NotNull Persona persona) {
            super.populate(persona);
            setEdad(DateOnly.current().yearsFrom(persona.getFechaNacimiento()));
            setComunidad(persona.getComunidad().getDescripcion() + " " + persona.getComunidad().getLocalidad());
        }
    }
}
