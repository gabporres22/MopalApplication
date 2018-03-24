package com.mopal.view;

import com.mopal.core.NivelHelper;

/** User class for form: PersonaForm */
public class PersonaForm
    extends PersonaFormBase
{
    @Override
    public void load() {
        super.load();
        setNivelNinguno(NivelHelper.getNivelNinguno());
    }
}
